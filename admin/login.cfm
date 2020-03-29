<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: login.cfm,v $">
                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 11, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->            
            <!---$Id: login.cfm,v 1.22 2000/06/20 15:55:58 lswanson Exp $--->

<!---First, check to make sure they're coming from the index.cfm form.  If not, send them there. --->
<cfif not isdefined("form.username")>
	<cflocation url="index.cfm">
</cfif>

<!--- Get Username, Password, PermissionLevel, etc. --->
<cfquery name="Login" datasource="#gDSN#">
	SELECT	RowID,
			Password,
			PermissionLevel,
			AccountKey,
			Name
	FROM	Accounts
	WHERE	LoginID='#FORM.username#'
 </cfquery> 

<!--- Check for valid Username --->
<cfif #login.recordcount# eq 0>
	<cflocation url="err_username.cfm">
</cfif>

<!--- Check for valid Password --->
<cfif #login.password# neq #form.password#>
	 <cflocation url="err_password.cfm">
<cfelse>
	<!--- set variables for inserting a new record into AccountSecurity --->
	<cfif #login.PermissionLevel# eq application.dealer_access>
		<cfset ActionCode = login.accountkey>
		<cfset Dealercode = login.accountkey>
	<cfelse>
		<cfset ActionCode = login.name>
		<cfset Dealercode = "">
	</cfif>

	<cfquery name="Insert" datasource="#gDSN#">
		INSERT INTO AccountSecurity(
				UserID,
				LastAction,
				ActionCode,
				CFID,
				Dealercode)
		VALUES (#Login.RowID#,
				#createodbcdatetime(now())#,
				'#ActionCode#',
				#CLIENT.CFID#,
				'#Dealercode#')
	</cfquery>

	<!--- linda, 2/10/2000: java session management --->
	<CFX_JAVA class="COM.worlddealer.cfx.SessionManager" action="setProperty"
		sessionID="#URL.sessionid#" name="userID" value="#Login.RowID#">
	 
	<CFLOCATION URL="home/index.cfm" addtoken="no">
</cfif>

<cfmodule template="/util/DumpDebug.cfm" text="end   $RCSfile: login.cfm,v $">
