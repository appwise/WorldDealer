<!--- $Id: login.cfm,v 1.5 2000/02/05 00:30:08 lswanson Exp $ --->

<!--- Login.cfm --->
<!---First, check to make sure they're coming from the form--->
<CFIF NOT IsDefined("FORM.username")>
	<CFLOCATION URL="index.cfm">
	<CFABORT>
</CFIF>

<!--- Query the database to see if Username exists--->
<CFQUERY NAME="Check_Result" datasource="#gDSN#">
	SELECT 	COUNT(LoginID) AS User_Exists 
	FROM 	Accounts 
	WHERE 	LoginID='#form.username#';
</cfquery>

<CFIF #Check_Result.User_Exists# IS 0>
	<!--- Username Not found --->
	<CFLOCATION URL="badlogin.htm" addtoken="no"> 
<CFELSE>
	
	<!--- Username was found in Database, Get Username and Password --->
	<CFQUERY NAME="Login" datasource="#gDSN#">
        SELECT RowID,
			   Password,
			   PermissionLevel,
			   AccountKey,
			   AccountType
		FROM Accounts
		WHERE LoginID='#FORM.username#';
	 </CFQUERY>
</CFIF>

<!--- 
<CFIF Login.AccountType EQ 'AA'>
	!--- All Access (Sysadmin) ---
	<CFSET AccessLevel = application.SYSADMIN_ACCESS>
<CFELSEIF Login.AccountType EQ 'AE'>
	!--- Account Exec ---
	<CFSET AccessLevel = application.ACCOUNT_EXECUTIVE_ACCESS>
<CFELSEIF Login.AccountType EQ 'AC'>
	!--- Account Coordinator ---
	<CFSET AccessLevel = application.ACCOUNT_COORDINATOR_ACCESS>
<CFELSEIF Login.AccountType EQ 'DE'>
	!--- Dealer Access ---
	<CFSET AccessLevel = application.DEALER_ACCESS>
<CFELSE>
	<CFLOCATION URL="index.cfm">
</CFIF>
--->
<!--- Linda: PermissionLevel already stores the # value. --->
<!--- 0=DE, 1=AC, 2=AE, 3=AA --->
<CFSET AccessLevel = #Login.PermissionLevel#>
 
<CFIF #login.password# EQ #form.password#>
	<!--- 	<CFSET #variables.AccessLevel# = #AccessLevel# & '-' & #Login.AccountKey#>
	#AccessLevel# in the form "Type - Code"  i.e. "DE-990979"  --->

	<CFIF #LEFT(AccessLevel,1)# LTE application.DEALER_ACCESS>
		<!--- 3/30/99: This is no longer a numeric field: it contains -'s now.
		<CFIF NOT IsNumeric(Left(Login.AccountKey, 1))>
			<cflocation url="baddlr.htm" addtoken="No">
		</cfif> --->
		<CFSET insertAccountKey = Login.AccountKey>
	<CFELSE>
		<CFSET insertAccountKey = 'login'>
	</CFIF>

	<CFSET RightNow = CreateODBCDateTime(Now())>

	<CFQUERY Name="Insert" datasource="#gDSN#">
		INSERT INTO AccountSecurity(UserID,
									LastAction,
									ActionCode,
									CFID)
			VALUES (#Login.RowID#,
					#RightNow#,
					'#insertAccountKey#',
					#CLIENT.CFID#)
	</cfquery>

	<cfquery name="GetSelf" datasource="#gDSN#">
	    SELECT 	SessionID
		FROM 	AccountSecurity
		WHERE 	UserID = #Login.RowID# AND
				LastAction = #RightNow# AND
				ActionCode = '#insertAccountKey#'
	</cfquery>

	<cfcookie name="session"
    	      value="#GetSelf.SessionID#">
		 
	<cfcookie name="sessionUser"
     	      value="#Login.RowID#">

	<cfcookie name="FORDAccess"
    	      value="#variables.AccessLevel#">
		  
	<CFSET CLIENT.WDDEACCESS = #VARIABLES.ACCESSLEVEL#>
	<CFSET CLIENT.SESSION = "#GetSelf.SessionID#">
 	<CFSET CLIENT.SessionUser = "#Login.RowID#">

	<CFINCLUDE template="index2.cfm">
	
<CFELSE>
	<!--- Password was incorrect --->
	 <CFLOCATION URL="invalid.htm" addtoken="no">
</CFIF>
