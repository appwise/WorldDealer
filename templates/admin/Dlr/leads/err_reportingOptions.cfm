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
<!--- $Id: err_reportingOptions.cfm,v 1.4 1999/11/24 22:16:38 lswanson Exp $ --->

<!---
err_reportingOptions.cfm - error checking module to verify lead reporting options
--->

<!--- FIXME:
check that:
   - if user is dealer, they have a dealership id
   - if user is account coord or exec, they have a valid account id
   - if moreOptions, then ((coverage IS single) AND (user is NOT dealer))
        OR ((coverage is account) AND (user is GOD))
--->

<CFIF FromTemplate EQ "dsp_reportingOptions">
	<CFIF IsDefined("Form.buttonDealersInState.X")>
		<CFIF Form.stateAbbr EQ "">
			<CFSET caller.isError = TRUE>
			<CFSET caller.errorString = "Please select a state from the list.">
			<CFEXIT>
		</CFIF>
	<CFELSEIF IsDefined("Form.buttonDealersInZipCode.X")>
		<CFIF Form.ZipCode EQ "">
			<CFSET caller.isError = TRUE>
			<CFSET caller.errorString = "Please enter a valid zip code.">
			<CFEXIT>
		</CFIF>
	</CFIF>
</CFIF>
