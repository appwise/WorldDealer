<cfset PageAccess = application.account_coordinator_access>
<cfinclude template = "../security.cfm">

<CFQUERY NAME="DeleteAC1" datasource="#gDSN#">
	DELETE FROM AccountCoordinators
	WHERE       ACID = #Form.AccountCoordinator#
</CFQUERY>

<CFQUERY NAME="DeleteAC2" datasource="#gDSN#">
	DELETE FROM Accounts
	WHERE       AccountKey = '#Form.AccountCoordinator#' AND AccountType = 'AC'
</CFQUERY>

<CFLOCATION URL="acccoord.cfm" addtoken="no">