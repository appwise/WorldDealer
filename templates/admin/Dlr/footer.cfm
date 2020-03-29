<!---
Created by Sigma6, Inc.
Copyright (c) 1998 Sigma6, Inc.
All Rights Reserved.  Used By Permission.

Sigma6, interactive media, Detroit/NYC
conceive : construct : connect
www.sigma6.com   webmaster@sigma6.com   info@sigma6.com

Last updated: <Jul 8, 1998>

Tim Taylor for sigma6, interactive media, Detroit
ttaylor@sigma6.com   www.sigma6.com    www.s6313.com
conceive : construct : connect

Sigma6, s6, and the Sigma6 logos are registered trademarks.
All other trademarks and servicemarks are the property of
their respective owners.
--->
<!--- $Id: footer.cfm,v 1.4 1999/11/29 16:34:04 lswanson Exp $ --->

<!---
footer.cfm - footer common to all admin screens
pre: header.cfm was already run
--->
<CFIF IsDefined("attributes.isRedirectable")>
	<CFSET isRedirectable = attributes.isRedirectable>
	<TR ALIGN="center">
		<TD>
			<FORM NAME="f_Back" ACTION="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/templates/admin/dlr/redirect.cfm" METHOD="post">
			<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg" Border="0" NAME="BackToMain" VALUE="Back To Main Menu">
			</FORM>
		</TD>
	</TR>
<CFELSE>
	<CFSET isRedirectable = FALSE>
</CFIF>
</TABLE>
</div>
</BODY>