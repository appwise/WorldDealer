    <!-- ----------------------------------------------------------- -->
    <!--               Created by sigma6, Detroit                    -->
    <!--         Copyright (c) 1997, 1998, 1999 sigma6.              -->
    <!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->

    <!-- ----------------------------------------------------------- -->
    <!--     John Turner for sigma6, interactive media, Detroit      -->
    <!--    jturner@sigma6.com   www.sigma6.com    www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
	<!--- $Id: security.cfm,v 1.10 2000/02/05 00:30:08 lswanson Exp $ --->
	<!--- SECURITY.CFM --->

	<!--- linda, 11/19/99: for some reason, security.cfm doesn't like datasource="#gDSN#" on queries.  
	Had to change them back to datasource="WorldDlr". --->

<!---
	Take existing cookie and/or client variables
	session, sessionuser and WDDEaccess
	and convert them to the global variables.xxx
--->
<CFIF IsDefined("COOKIE.Session")>
	<CFSET variables.session = COOKIE.session>
	<CFSET CLIENT.session = COOKIE.session>
<CFELSEIF IsDefined("CLIENT.session")>
	<CFSET variables.session = CLIENT.session>
	<CFCOOKIE NAME="session" VALUE="#CLIENT.session#">
</CFIF>
<CFIF IsDefined("COOKIE.SessionUser")>
	<CFSET variables.SessionUser = COOKIE.SessionUser>
	<CFSET CLIENT.SessionUser = COOKIE.SessionUser>
<CFELSEIF IsDefined("CLIENT.SessionUser")>
	<CFSET variables.SessionUser = CLIENT.SessionUser>
	<CFCOOKIE NAME="SessionUser" VALUE="#CLIENT.SessionUser#">
</CFIF>
<CFIF IsDefined("COOKIE.WDDEAccess")>
	<CFSET variables.WDDEAccess = COOKIE.WDDEAccess>
	<CFSET CLIENT.WDDEAccess = COOKIE.WDDEAccess>
<CFELSEIF IsDefined("CLIENT.WDDEAccess")>
	<CFSET variables.WDDEAccess = CLIENT.WDDEAccess>
	<CFCOOKIE NAME="FORDAccess" VALUE="#CLIENT.WDDEAccess#">
</CFIF>
<!---
	If the Session or SessionUser variable gets lost (ala imagegen),
	Check against the latest entry in AccountSecurity tied to the user's CFID
--->
<CFIF ((NOT IsDefined("variables.Session")) OR (NOT IsDefined("variables.SessionUser"))) AND IsDefined("CLIENT.CFID")>
	<CFQUERY NAME="lastresort" datasource="WorldDlr" MAXROWS=1>
		SELECT SessionID
		FROM AccountSecurity
		WHERE AccountSecurity.CFID = #CLIENT.CFID#
		ORDER BY AccountSecurity.SessionID DESC
	</CFQUERY>
	<!--- Make sure record count is not zero so lastresort2 doesn't bomb --->
	<CFIF lastresort.RecordCount eq 0>
		<CFLOCATION URL="index.cfm"> <!--- if no record, send them to login --->
	<CFELSE> <!--- otherwise, select the entire record with the sessionid from lastresort, and set vars --->
		<CFQUERY NAME="lastresort2" datasource="WorldDlr">
			SELECT *
			FROM AccountSecurity
			WHERE SessionID = #lastresort.SessionID#
		</CFQUERY>
		<CFSET variables.Session = lastresort2.SessionID>
		<CFSET variables.SessionUser = lastresort2.UserID>
	</CFIF>
</CFIF>

<CFIF NOT ISDEFINED("variables.Session")>
	<CFLOCATION URL="index.cfm">
<CFELSE>
	<CFQUERY NAME="Login" datasource="WorldDlr">
        SELECT RowID,
			   Password,
			   PermissionLevel,
			   AccountKey,
			   AccountType
		FROM Accounts
		WHERE RowID=#variables.SessionUser#;
	 </CFQUERY>
<!--- 
	<CFIF Login.AccountType EQ 'AA'>
		--- All Access (Sysadmin) ---
		<CFSET AccessLevel = application.SYSADMIN_ACCESS>
	<CFELSEIF Login.AccountType EQ 'AE'>
		--- Account Exec ---
		<CFSET AccessLevel = application.ACCOUNT_EXECUTIVE_ACCESS>
	<CFELSEIF Login.AccountType EQ 'AC'>
		--- Account Coordinator ---
		<CFSET AccessLevel = application.ACCOUNT_COORDINATOR_ACCESS>
	<CFELSEIF Login.AccountType EQ 'DE'>
		--- Dealer Access ---
		<CFSET AccessLevel = application.DEALER_ACCESS>
		<CFSET dlrcode = Login.AccountKey>
	</CFIF>
 --->
	<CFIF Login.AccountType EQ 'DE'>
		<CFSET dlrcode = Login.AccountKey>
	</CFIF>

	<!--- Linda: PermissionLevel already stores the # value. --->
	<!--- 0=DE, 1=AC, 2=AE, 3=AA --->
	<CFSET AccessLevel = #Login.PermissionLevel#>
	
	<!--- #AccessLevel# in the form "PermissionLevel-AccountKey" i.e. "0-0001-0001-001-00-1234567890" or "3-1", "2-4", etc. --->
	<CFSET AccessLevel = #AccessLevel# & '-' & #Login.AccountKey#>	
	<CFSET #variables.AccessLevel# = #AccessLevel#>
	<CFSET #CLIENT.AccessLevel# = #AccessLevel#>
	
	<CFIF ISDEFINED("variables.session")>
	<!--- Checks for time and user but not domain... --->
		<CFSET EXPIRED = #NOW()# - #CREATETIMESPAN(0,2,0,0)#>

		<CFQUERY NAME="CheckID" datasource="WorldDlr">
				SELECT 	SessionID, UserID, LastAction, ActionCode
				FROM 	AccountSecurity
				WHERE 	UserID = #variables.sessionUser# AND
				        LastAction
							BETWEEN #CreateODBCDateTime(EXPIRED)# and
									#CreateODBCDateTime(Now())#
				ORDER BY ActionCode, LastAction DESC
		</CFQUERY>
	
		<CFSET RECORDCOUNT = 0>

<!--- linda 9/15/99: unnec. looping.  query already keeps track of RecordCount		
		<CFLOOP QUERY="CheckID">
			<CFSET RECORDCOUNT = RECORDCOUNT + 1>
		</CFLOOP>
 --->	
		<CFIF #CheckID.RecordCount# EQ 0> <!---whoops, no record...back to login screen.--->
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
			 	<CFQUERY Name="Insert" datasource="WorldDlr">
					INSERT INTO AccountSecurity(UserID,
											LastAction,
											ActionCode)
						VALUES (#variables.sessionUser#,
								#RightNow#,
								'#dlrcode#')
				</cfquery>
		
				<cfquery name="GetSelf" datasource="WorldDlr">
				SELECT 	SessionID
				FROM 	AccountSecurity
				WHERE 	UserID = #Login.RowID# AND
					LastAction = #RightNow# AND
					ActionCode = '#dlrcode#'
				</cfquery>
	
				<cfcookie name="session" value="#GetSelf.SessionID#">
				<CFSET CLIENT.Session = #GetSelf.SessionID#>
				<CFSET variables.Session = #GetSelf.SessionID#>
		
			<CFELSE>  <!---re-use old session--->
				<CFIF variables.SESSION NEQ THISSESSION>
					<CFCOOKIE NAME="session" VALUE="#ThisSession#">
					<CFSET CLIENT.Session = #ThisSession#>
					<CFSET variables.Session = #ThisSession#>
				</CFIF>	

				<CFQUERY NAME="FindOldSecurity" datasource="WorldDlr">
						SELECT 	SessionID, UserID, LastAction, ActionCode
						FROM 	AccountSecurity
						WHERE 	SessionID = #ThisSession#
				</CFQUERY>

				<CFIF (Trim(CHECKID.ActionCode) EQ "")>
					<CFSET NewActionCode = #dlrcode#>
				<CFELSE>
					<CFSET NewActionCode = #FindOldSecurity.ActionCode#>
				</cfif>
	
				<CFQUERY NAME="UpdateSecurity" datasource="WorldDlr">
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
	
	<CFSET CLIENT.WDDEACCESS = #VARIABLES.ACCESSLEVEL#>

	<!--- make sure cookies are there and proper --->

	<CFIF NOT isDefined("COOKIE.WDDEAccess") OR NOT IsDefined("CLIENT.WDDEAccess")>

		<cfcookie name="FORDAccess" value="#variables.AccessLevel#">
		<CFSET CLIENT.WDDEAccess = #variables.AccessLevel#>

	<CFELSEIF COOKIE.WDDEAccess neq variables.AccessLevel OR CLIENT.WDDEAccess neq variables.AccessLevel>

		<cfcookie name="FORDAccess"
	          value="#variables.AccessLevel#">
		<CFSET CLIENT.WDDEAcess = #variables.AccessLevel#>

	</cfif>

</CFIF>


<!---makes sure no dealers have access to data they shouldn't (and others cannot try to access nonexistent data)
     through changing the "dlrcode" parameter in the URL...only dealer level enforced at this time---> 
<CFIF isDefined("URL.dlrcode")>
	<CFIF #LEFT(ACCESSLEVEL,1)# EQ application.DEALER_ACCESS>  <!---dealer?--->
		<CFIF URL.dlrcode NEQ Login.AccountKey>
			<cflocation url="index2.cfm">
		</CFIF>
	<CFELSE> <!---everybody else...make sure that there is a dealer with the given DealerCode,
	              in case users try to change the URL in the address--->
		<cfquery name="CheckIfDealerExists"
 		        datasource="WorldDlr">
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
	</CFIF>
</CFIF>

<!--- enforce step-skipping based on security...webfind2.cfm is "step 0"--->
<!--- FYI: other step-skipping for collections: everyone skips it, no matter what security level: --->
<!--- within webvrfy_s?.cfm, skip s3, s6b, s8, s9, s10 --->

<CFIF ISDEFINED("Variables.WebVerifyStep")>  <!---in verify section?--->

	<!--- Never allow dealers access to s2 (email address) --->
	<CFIF #LEFT(ACCESSLEVEL,1)# EQ application.DEALER_ACCESS>
		<CFIF ParameterExists(Form.btnBack.X)>
			<!--- if they're on 3 & hit back, skip s2 & return to webvrfy.cfm --->
			<!--- Note, 5/17/99: for collections, have to detour from 6 to webvrfy, because if it goes thru the
			loop again, it'll point to 3, then get caught in the "user manually entered 3, detour to 4" code  --->
			<!--- 8/20/99: take away template choice (step 4) for dealerships, per Messner --->
			<CFIF (Variables.WebVerifyStep eq 3) OR 
				  (Variables.WebVerifyStep eq 6 AND Mid(URL.dlrcode, 6, 4) EQ '0000')>
				<cflocation url="webvrfy.cfm?dlrcode=#dlrcode#"> 
			</cfif>
		<CFELSE><!--- hit Next button --->
			<CFIF Variables.WebVerifyStep eq 0>  
				<cflocation url="webvrfy.cfm?dlrcode=#RemoveChars(AccessLevel,1,2)#">
			<!--- if they'd normally be on 2, skip it & detour to 3 (if collection, detour to 6)--->
			<!--- Note, 5/17/99: have to fwd to 6 for collections, because if it goes thru the loop again, 
			it'll point to 3, then get caught in the "user manually entered 3, detour to 4" code  --->
			<!--- 8/20/99: take away template choice (step 4) for dealerships, per Messner --->
			<CFELSEIF Variables.WebVerifyStep eq 2>
				<CFIF Mid(URL.dlrcode, 6, 4) EQ '0000'>
					<cflocation url="webvrfy_s6.cfm?dlrcode=#dlrcode#">
				<CFELSE>
					<cflocation url="webvrfy_s3.cfm?dlrcode=#dlrcode#">
				</CFIF>
			</CFIF>
		</CFIF>
	</cfif>
	
	<!--- Never allow dealers access to s4 (art template choice) --->
	<!--- 8/20/99: take away template choice (step 4) for dealerships, per Messner --->
	<CFIF #LEFT(ACCESSLEVEL,1)# EQ application.DEALER_ACCESS>
		<CFIF ParameterExists(Form.btnBack.X)>
			<!--- if they're on 6 & hit back, skip s4&5 & return to s3.cfm --->
			<!--- Note, 5/17/99: for collections, have to detour from 6 to webvrfy, because if it goes thru the
			loop again, it'll point to 3, then get caught in the "user manually entered 3, detour to 4" code  --->
			<CFIF (Variables.WebVerifyStep eq 6)>
				<CFIF Mid(URL.dlrcode, 6, 4) EQ '0000'>
					<cflocation url="webvrfy.cfm?dlrcode=#dlrcode#">
				<cfelse>
					<cflocation url="webvrfy_s3.cfm?dlrcode=#dlrcode#">
				</cfif>
			</cfif>
		<CFELSE><!--- hit Next button --->
			<!--- if they'd normally be on 4, skip it & detour to 6 (both dealers & collections skip step 4 & 5 --->
			<CFIF Variables.WebVerifyStep eq 4>
				<cflocation url="webvrfy_s6.cfm?dlrcode=#dlrcode#">
			</CFIF>
		</CFIF>
	</cfif>
	
	<!--- don't allow anyone except sysadmin access to s5 (url) --->
	<CFIF #LEFT(ACCESSLEVEL,1)# LT #application.SYSADMIN_ACCESS#> <!---restrict everyone but administrators--->
		<CFIF ParameterExists(Form.btnBack.X)>
			<!--- if they're on 6 & hit back, skip s5 & return to s3 --->
			<CFIF Variables.WebVerifyStep eq 6>
				<cflocation url="webvrfy_s4.cfm?dlrcode=#dlrcode#"> 
			</CFIF>
		<CFELSE><!--- btnNext --->
			<!--- if they'd normally be on 5, skip it & detour to s6 --->
			<CFIF Variables.WebVerifyStep eq 5>
				<cflocation url="webvrfy_s6.cfm?dlrcode=#dlrcode#">
			</CFIF>	
		</CFIF>
	</CFIF>
	
	<!--- in case users try to modify URL, this just bounces them to the next valid step for collections --->
	<!--- If it's a collection, skip 3 -> 6; skip 8,9,10 -> 11 --->
	<CFIF ISDEFINED("URL.dlrcode")>
		<CFIF Mid(URL.dlrcode, 6, 4) EQ '0000'>
			<CFIF ParameterExists(Form.btnBack.X) OR ParameterExists(Form.btnNext.X)>
			<!--- this is covered in webvrfy_s2,4,7,11 --->
			<CFELSE>		
				<CFSWITCH expression="#Variables.WebVerifyStep#">
					<cfcase value="3">
					   	<CFLOCATION URL="webvrfy_s6.cfm?dlrcode=#dlrcode#">
					</cfcase>
					<cfcase value="8,9,10">
				   		<CFLOCATION URL="webvrfy_s11.cfm?dlrcode=#dlrcode#">
					</cfcase>
				</CFSWITCH>
			</CFIF>
		</CFIF>
	</CFIF>
</cfif>

<!---modify area...in case dealers try to sneak in by modifying URL
     this just bounces them back to main menu if they don't have access--->
<CFIF ISDEFINED("Variables.WebNewStep")>

	<CFIF #LEFT(ACCESSLEVEL,1)# EQ #application.DEALER_ACCESS#>

		<CFIF (Variables.WebNewStep EQ 0) OR 
			  (Variables.WebNewStep EQ 2)>
			<cflocation url="index2.cfm"> 
		</CFIF>
	</CFIF>

	<CFIF #LEFT(ACCESSLEVEL,1)# LT #application.SYSADMIN_ACCESS#>

		<!--- only allow SYSADMIN to change URL --->
		<CFIF Variables.WebNewStep EQ 5>
			<cflocation url="index2.cfm"> 
		</CFIF>	
	</CFIF>
</cfif>