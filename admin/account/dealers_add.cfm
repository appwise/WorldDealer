<cfset PageAccess = application.account_coordinator_access>
<cfinclude template = "../security.cfm">

                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <February 14, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: dealers_add.cfm,v 1.3 2000/03/03 17:54:24 jkrauss Exp $ --->
<!--- Maintain Dealers --->

<!--- After an AC, AE, or AA has clicked "Add", update the AccountSecurity table,
so that it blanks out the previous dealer. --->

<cfquery name="getSessionID" datasource="#gDSN#">
	SELECT	SessionID
	FROM	AccountSecurity
	WHERE	UserID = #getUserInfo.RowID#
	ORDER BY SessionID DESC
</cfquery>

<cfquery name="updLastDlrSelected" datasource="#gDSN#">
	UPDATE	AccountSecurity
	SET		Dealercode = ''
	WHERE	SessionID = #getSessionID.SessionID#
</cfquery>

<cflocation url="../mysite/myinfo.cfm">
