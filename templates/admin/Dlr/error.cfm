<CFSETTING ENABLECFOUTPUTONLY="YES">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<!---
Created by Sigma6, Inc.
Copyright (c) 1998 Sigma6, Inc.
All Rights Reserved.  Used By Permission.

Sigma6, interactive media, Detroit/NYC
conceive : construct : connect
www.sigma6.com   webmaster@sigma6.com   info@sigma6.com

Last updated: <Aug 13, 1998>

Tim Taylor for sigma6, interactive media, Detroit
ttaylor@sigma6.com   www.sigma6.com    www.s6313.com
conceive : construct : connect

Sigma6, s6, and the Sigma6 logos are registered trademarks.
All other trademarks and servicemarks are the property of
their respective owners.
--->
<!--- $Id: error.cfm,v 1.3 1999/11/29 16:34:04 lswanson Exp $ --->

<!---
error.cfm - module for displaying an error screen
    attributes:
	    errorString - the error string to display
		windowTitle - title of browser window
		screenTitle - title of the screen
--->
<CFSETTING ENABLECFOUTPUTONLY="NO">

<!--- required attributes --->
<CFPARAM NAME="attributes.errorString">

<!--- optional attributes --->
<CFPARAM NAME="attributes.windowTitle" DEFAULT="Error">
<CFPARAM NAME="attributes.screenTitle" DEFAULT="Error">


<!--- header.cfm sets up a table already --->
<CFMODULE template="header.cfm"
		windowTitle="#attributes.windowTitle#"
		screenTitle="#attributes.screenTitle#">
		<TR ALIGN="center">
			<TD><FONT FACE="arial,helvetica"><CFOUTPUT>#attributes.errorString#</CFOUTPUT></FONT></TD>
		</TR>
		<TR>
			<TD>&nbsp;</TD>
		</TR>
		<TR ALIGN="center">
			<TD>
			<A HREF="#"
					OnMouseOver="self.status='Back';return true"
					OnMouseOut="self.status='';return true"
					OnClick="history.go(-1);return false"><IMG
					SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/back_nav.jpg"
					Border="0"
					ALT="Back"></A></TD>
		</TR>
		<TR>
			<TD>&nbsp;</TD>
		</TR>

	<!--- footer.htm closes out all tags header.cfm opened --->
	<CFMODULE template="footer.cfm" isRedirectable=FALSE>
</HTML>
