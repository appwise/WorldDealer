<!---
Created by Sigma6, Inc.
Copyright (c) 1998 Sigma6, Inc.
All Rights Reserved.  Used By Permission.

Sigma6, interactive media, Detroit/NYC
conceive : construct : connect
www.sigma6.com   webmaster@sigma6.com   info@sigma6.com

Last updated: <Jul 31, 1998>

Tim Taylor for sigma6, interactive media, Detroit
ttaylor@sigma6.com   www.sigma6.com    www.s6313.com
conceive : construct : connect

Sigma6, s6, and the Sigma6 logos are registered trademarks.
All other trademarks and servicemarks are the property of
their respective owners.
--->
<!--- $Id: err_leadDetail.cfm,v 1.3 1999/11/24 22:16:38 lswanson Exp $ --->

<!---
err_leadDetail.cfm - test for valid input
pre: Form.leadid is defined
pre: From.leadtype is defined
--->

<!--- user must choose a lead to detail --->
<CFIF NOT IsDefined("Form.leadID")>
	<CFSET caller.isError = TRUE>
	<CFSET caller.errorString = "Please select a lead to view.">
	<CFEXIT>
</CFIF>