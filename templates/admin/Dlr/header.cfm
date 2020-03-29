<!---
Created by Sigma6, Inc.
Copyright (c) 1998 Sigma6, Inc.
All Rights Reserved.  Used By Permission.

Sigma6, interactive media, Detroit/NYC
conceive : construct : connect
www.sigma6.com   webmaster@sigma6.com   info@sigma6.com

Last updated: <Jul 15, 1998>

Tim Taylor for sigma6, interactive media, Detroit
ttaylor@sigma6.com   www.sigma6.com    www.s6313.com
conceive : construct : connect

Sigma6, s6, and the Sigma6 logos are registered trademarks.
All other trademarks and servicemarks are the property of
their respective owners.
--->
<!--- $Id: header.cfm,v 1.6 1999/12/15 23:00:11 lswanson Exp $ --->

<!---
header.cfm - header for all admin screens
pre: windowTitle is defined
pre: screenTitle is defined
--->

<CFIF IsDefined("attributes.windowTitle")>
	<CFSET windowTitle = attributes.windowTitle>
<CFELSE>
	<CFSET windowTitle = "Default Window Title">
</CFIF>

<CFIF IsDefined("attributes.screenTitle")>
	<CFSET screenTitle = attributes.screenTitle>
<CFELSE>
	<CFSET screenTitle = "Default Screen Title">
</CFIF>

<HEAD>
	<TITLE><CFOUTPUT>#windowTitle#</CFOUTPUT></TITLE>
	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>
<body>
<br><br><br><br><br>
	<div align="center">
	<TABLE CELLPADDING=5 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
		<TR>
			<TD>&nbsp;<p></TD>
		</TR>
		<TR ALIGN="center">
			<!--- display wizard title and subtitle --->
			<TD ALIGN="center"><h3><CFOUTPUT>#screenTitle#</CFOUTPUT></h3></TD>
		</TR>