<!--- $Id: security0921.cfm,v 1.3 1999/11/29 16:34:05 lswanson Exp $ --->

<!--- SECURITY.CFM --->


<CFIF ISDEFINED("URL.sessionuse")>
    <CFSET #COOKIE.sessionUser#=URL.sessionuse>
</CFIF>   



<CFIF ((NOT ISDEFINED("COOKIE.Session")))>
 	<CFLOCATION URL="index.cfm"> 
<!--- <CFOUTPUT>HERE</CFOUTPUT><CFABORT> --->

<CFELSE>
	<CFQUERY NAME="Login" datasource="#gDSN#">
        SELECT RowID,
			   AccountType,
			   AccountKey
		FROM Accounts
		WHERE RowID=#Cookie.sessionUser#;
	 </CFQUERY>

	<CFIF Login.AccountType EQ 'AA'>
		<!--- All Access (Sysadmin) --->
		<CFSET AccessLevel = application.SYSADMIN_ACCESS>
	<CFELSEIF Login.AccountType EQ 'AE'>
		<!--- Account Exec --->
		<CFSET AccessLevel = application.ACCOUNT_EXECUTIVE_ACCESS>
	<CFELSEIF Login.AccountType EQ 'AC'>
		<!--- Account Coordinator --->
		<CFSET AccessLevel = application.ACCOUNT_COORDINATOR_ACCESS>
	<CFELSEIF Login.AccountType EQ 'DE'>
		<!--- Dealer Access --->
		<CFSET AccessLevel = application.DEALER_ACCESS>
		<CFSET dlrcode = Login.AccountKey>
	</CFIF>



	<CFSET #variables.AccessLevel# = #AccessLevel# & '-' & #Login.AccountKey#>
	<!--- #AccessLevel# in the form "Type - Code"  i.e. "DE-990979"  --->


	<CFIF ISDEFINED("COOKIE.session")>
<!--- Checks for time and user but not domain... --->
	<CFSET EXPIRED = #NOW()# - #CREATETIMESPAN(0,2,0,0)#>

	<CFQUERY NAME="CheckID" datasource="#gDSN#">
				SELECT 	SessionID, UserID, LastAction, ActionCode
				FROM 	AccountSecurity
				WHERE 	UserID = #COOKIE.sessionUser# AND
				        LastAction
							BETWEEN #CreateODBCDateTime(EXPIRED)# and
									#CreateODBCDateTime(Now())#
				ORDER BY ActionCode, LastAction DESC
	</CFQUERY>
	
	<CFSET RECORDCOUNT = 0>

	<CFLOOP QUERY="CheckID">
		<CFSET RECORDCOUNT = RECORDCOUNT + 1>
	</CFLOOP>
	
	<CFIF RECORDCOUNT EQ 0> <!---whoops, no record...back to login screen.--->
		<CFLOCATION URL="index.cfm">
	</CFIF>


	<CFIF isDefined("dlrcode")>

		<CFSET THISSESSION = -1> 

		<CFLOOP QUERY="CheckID">
			<CFIF (CHECKID.ActionCode EQ DLRCODE)>
			<CFSET THISSESSION = CHECKID.SESSIONID>	
			<CFBREAK>
		</cfif>	
		</CFLOOP>

	<!---if matching session not found, make a new entry in the log--->

		<CFIF THISSESSION eq -1>

			<CFSET RightNow = CreateODBCDateTime(Now())>
	
		 	<CFQUERY Name="Insert" datasource="#gDSN#">

				INSERT 	INTO AccountSecurity(UserID,
											LastAction,
											ActionCode)
						VALUES (#COOKIE.sessionUser#,
								#RightNow# ,
								'#dlrcode#')
			</cfquery>
		
			<cfquery name="GetSelf"
       	  	datasource="#gDSN#">
				SELECT 	SessionID
				FROM 	AccountSecurity
				WHERE 	UserID = #Login.RowID# AND
					LastAction = #RightNow# AND
					ActionCode = '#dlrcode#'
			</cfquery>
	
			<cfcookie name="session"
  	        value="#GetSelf.SessionID#">
		 

		
		
		<CFELSE>  <!---re-use old session--->


			<CFIF COOKIE.SESSION NEQ THISSESSION>
				<CFCOOKIE NAME="session"
   		       VALUE="#ThisSession#">
			</CFIF>	

			<CFQUERY NAME="FindOldSecurity" datasource="#gDSN#">
						SELECT 	SessionID, UserID, LastAction, ActionCode
						FROM 	AccountSecurity
						WHERE 	SessionID = #ThisSession#
			</CFQUERY>

			<CFIF (Trim(CHECKID.ActionCode) EQ "")>
				<CFSET NewActionCode = #dlrcode#>
			<CFELSE>
				<CFSET NewActionCode = #FindOldSecurity.ActionCode#>
			</cfif>
	
			<CFQUERY NAME="UpdateSecurity" datasource="#gDSN#">
				UPDATE AccountSecurity
				SET	UserID = #FindOldSecurity.UserID#,
					LastAction = #CreateODBCDateTime(Now())#,
					ActionCode = '#NewActionCode#'
				WHERE SessionID = #ThisSession#
			</CFQUERY>	
		</cfif>

</cfif>

<CFELSE>
	<CFLOCATION URL="index.cfm"> 
</CFIF>

	<!---	<CFSET #variables.AccessLevel# = #AccessLevel# & '-' & #Login.AccountKey#>
 #AccessLevel# in the form "Type - Code"  i.e. "DE-990979"  --->
	
	<CFSET CLIENT.FORDAccess = #VARIABLES.ACCESSLEVEL#>

<!--- make sure cookies are there and proper --->

	<CFIF NOT isDefined("COOKIE.FORDAccess")>

		<cfcookie name="FORDAccess"
	          value="#variables.AccessLevel#">

	<CFELSEIF COOKIE.FORDAccess neq variables.AccessLevel>

		<cfcookie name="FORDAccess"
	          value="#variables.AccessLevel#">
			  

	
	</cfif>

</CFIF>


<!---makes sure no dealars has access to data they shouldn't (and others cannot try to access nonexistent data)
     through changing the "dlrcode" parameter in the URL...only dealer level enforced at this time---> 
<CFIF isDefined("URL.dlrcode")>
	<CFIF #LEFT(ACCESSLEVEL,1)# LTE application.DEALER_ACCESS>  <!---dealer?--->
		<CFIF URL.dlrcode NEQ Login.AccountKey>
			<cflocation url="index2.cfm">
		</CFIF>
	<CFELSE> <!---everybody else...make sure that there is a delaer with the given DealerCode,
	              in case users try to change the URL in the address--->
		<cfquery name="CheckIfDealerExists"
 		        datasource="#gDSN#">
				 SELECT DealerCode
				 FROM Dealers
				 WHERE DealerCode = '#URL.dlrcode#'
		</cfquery>
		<CFSET DealerCount = 0>
		<cfloop query="CheckIfDealerExists">
			<CFSET DealerCount = DealerCount + 1>
		</cfloop>
	
		<CFIF DealerCount EQ 0>
			<cflocation url="index2.cfm">
		</cfif>
	</cfif>
</cfif>






<!---basic enforcing of level restrictions...redirects to front if access not allowed--->

<CFIF ISDEFINED("Variables.PageAccess")>
	<CFIF #LEFT(ACCESSLEVEL,1)# LT PAGEACCESS>
		<!--- Not enough access --->
 	<CFLOCATION URL="index.cfm"> 
 <!--- 	<CFOUTPUT>HERE2</CFOUTPUT><CFABORT> --->
	</CFIF>
</CFIF>



<!---enforce step-skipping...webfind2.cfm is "step 0"--->

<CFIF ISDEFINED("Variables.WebVerifyStep")>  <!---in verify section?--->

	<CFIF #LEFT(ACCESSLEVEL,1)# LTE application.DEALER_ACCESS>       <!---no-dealer areas--->

		<CFIF ParameterExists(Form.btnBack.X)>   <!---check if hit back button--->
			<CFIF Variables.WebVerifyStep eq 3>   
				<cflocation url="webvrfy.cfm?dlrcode=#dlrcode#"> 
			</CFIF>
		<CFELSE><!---didn't hit back button--->
			<CFIF Variables.WebVerifyStep eq 0>  
				<cflocation url="webvrfy.cfm?dlrcode=#RemoveChars(AccessLevel,1,2)#"> 
			<CFELSEIF Variables.WebVerifyStep eq 2>
				<cflocation url="webvrfy_s3.cfm?dlrcode=#dlrcode#"> 
			</CFIF>
		</CFIF>
	</cfif>

	<CFIF #LEFT(ACCESSLEVEL,1)# LT #application.SYSADMIN_ACCESS#> <!---restrict everyone but administrators--->
		<CFIF ParameterExists(Form.btnBack.X)>
			<CFIF Variables.WebVerifyStep eq 6>
				<cflocation url="webvrfy_s3.cfm?dlrcode=#dlrcode#"> 
			</CFIF>
		<CFELSE>
			<CFIF Variables.WebVerifyStep eq 4>
				<cflocation url="webvrfy_s6.cfm?dlrcode=#dlrcode#"> 
			<CFELSEIF Variables.WebVerifyStep eq 5>
				<cflocation url="webvrfy_s6.cfm?dlrcode=#dlrcode#"> 
			</CFIF>	
		</CFIF>
	</CFIF>

</cfif>

<!---modify area...in case dealers try to sneak in by modifying URL
     this just bounces them back to main menu if they don't have access--->
<CFIF ISDEFINED("Variables.WebNewStep")>



	<CFIF #LEFT(ACCESSLEVEL,1)# LTE #application.DEALER_ACCESS#>

		<CFIF Variables.WebNewStep eq 0>
			<cflocation url="index2.cfm"> 
		<CFELSEIF Variables.WebNewStep eq 2>
			<cflocation url="index2.cfm"> 
		</CFIF>

	</CFIF>

	<CFIF #LEFT(ACCESSLEVEL,1)# LT #application.SYSADMIN_ACCESS#>

		<CFIF Variables.WebNewStep eq 4>
			<cflocation url="index2.cfm"> 
		<CFELSEIF Variables.WebNewStep eq 5>
			<cflocation url="index2.cfm"> 
		</CFIF>	

	</CFIF>
</cfif>