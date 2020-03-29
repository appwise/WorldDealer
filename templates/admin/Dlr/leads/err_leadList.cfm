<!---
Created by Sigma6, Inc.
Copyright (c) 1998 Sigma6, Inc.
All Rights Reserved.  Used By Permission.

Sigma6, interactive media, Detroit/NYC
conceive : construct : connect
www.sigma6.com   webmaster@sigma6.com   info@sigma6.com

Last updated: <Jul 30, 1998>

Tim Taylor for sigma6, interactive media, Detroit
ttaylor@sigma6.com   www.sigma6.com    www.s6313.com
conceive : construct : connect

Sigma6, s6, and the Sigma6 logos are registered trademarks.
All other trademarks and servicemarks are the property of
their respective owners.
--->
<!--- $Id: err_leadList.cfm,v 1.3 1999/11/24 22:16:38 lswanson Exp $ --->

<!---
err_leadList.cfm - check for valid options to list leads
--->

<!--- check for type of leads to report on --->
<CFIF NOT IsDefined("leadType")>
	<CFSET caller.isError = TRUE>
	<CFSET caller.errorString = "error: leadType undefined">
	<CFEXIT>
</CFIF>

<!--- check for report coverage --->
<CFIF NOT IsDefined("reportCoverage")>
	<CFSET caller.isError = TRUE>
	<CFSET caller.errorString = "error: determining dealer coverage in lead reporting">
	<CFEXIT>
</CFIF>

<!--- check for dealerID when reporting on single dealer --->
<CFIF reportCoverage EQ "single">
	<CFIF DealerCode EQ "">
		<CFSET caller.isError = TRUE>
		<CFSET caller.errorString = "error: missing DealerCode">
		<CFEXIT>
	</CFIF>
</CFIF>

<!--- check for account RowID when reporting on all dealers in a specific account --->
<CFIF reportCoverage EQ "account">
	<CFIF IsDefined("accountRowID")>
		<CFIF accountRowID EQ "">
			<CFSET caller.isError = TRUE>
			<CFSET caller.errorString = "error: accountRowID empty">
			<CFEXIT>
		</CFIF>
	<CFELSE>
		<CFSET caller.isError = TRUE>
		<CFSET caller.errorString = "error: accountRowID undefined">
		<CFEXIT>
	</CFIF>
</CFIF>

<!--- if start row specified, make sure it's cool --->
<CFIF IsDefined("startRow")>
	<CFIF startRow LTE 0>
		<CFSET caller.isError = TRUE>
		<CFSET caller.errorString = "error: startRow <= 0">
		<CFEXIT>
	</CFIF>
</CFIF>


<!--- FIXME: must make sure people aren't seeing lead info that they shouldn't
have access to --->
