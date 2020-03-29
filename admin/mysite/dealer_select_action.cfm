                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <February 10, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: dealer_select_action.cfm,v 1.3 2000/03/03 17:54:25 jkrauss Exp $ --->
<!--- My Site: Select Another Dealer --->

<cfset PageAccess = application.dealer_access>
<cfinclude template = "../security.cfm">

<!--- After a Collection, AC, AE, or AA has selected another dealer, update the AccountSecurity table,
so that we can always know which dealership they want to edit. --->

<cfquery name="getSessionID" datasource="#gDSN#">
	SELECT	SessionID
	FROM	AccountSecurity
	WHERE	UserID = #getUserInfo.RowID#
	ORDER BY SessionID DESC
</cfquery>

<cfquery name="updLastDlrSelected" datasource="#gDSN#">
	UPDATE	AccountSecurity
	SET		Dealercode = '#form.dealer#'
	WHERE	SessionID = #getSessionID.SessionID#
</cfquery>

<cfif form.mode eq "Leads">
	<cflocation url="#application.RELATIVE_PATH#/admin/reports/leads.cfm?dealer=#form.dealer#" addtoken="no">
<cfelseif form.mode eq "MySite">
	<cflocation url="#application.RELATIVE_PATH#/admin/mysite/myinfo.cfm" addtoken="no">
<cfelseif form.mode eq "Account">
	<cfif parameterexists(form.delete.x)>
		<cflocation url="#application.RELATIVE_PATH#/admin/account/dealers_del_rusure.cfm" addtoken="no">
	<cfelse>
		<cflocation url="#application.RELATIVE_PATH#/admin/mysite/myinfo.cfm" addtoken="no">
	</cfif>
</cfif>