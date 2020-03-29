<CFINCLUDE template="security.cfm"> 
<CFSETTING ENABLECFOUTPUTONLY="YES">
<!---
Created by Sigma6, Inc.
Copyright (c) 1998 Sigma6, Inc.
All Rights Reserved.  Used By Permission.

Sigma6, interactive media, Detroit/NYC
conceive : construct : connect
www.sigma6.com   webmaster@sigma6.com   info@sigma6.com

Last updated: <Aug 12, 1998>

Tim Taylor for sigma6, interactive media, Detroit
ttaylor@sigma6.com   www.sigma6.com    www.s6313.com
conceive : construct : connect

Sigma6, s6, and the Sigma6 logos are registered trademarks.
All other trademarks and servicemarks are the property of
their respective owners.
--->
<!--- $Id: genexe.cfm,v 1.5 1999/11/24 22:54:05 lswanson Exp $ --->

<!---
genexe.cfm - a module to display an interstitial page while generating logos and maps
attributes:
    windowTitle - title for the browser window
	screenTitle - title (or heading) in the body
	nextStep - URL to redirect to when image generation is complete
	uniqueID - string to prepend on logo and banner filenames to make them unique
	displayName - string to display on logos
--->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>

<HEAD>

	<!--- required attributes --->
	<CFPARAM NAME="attributes.uniqueID">
	<CFPARAM NAME="attributes.nextStep">
	<CFPARAM NAME="attributes.displayName">

	<!--- optional attributes --->
	<CFPARAM NAME="attributes.windowTitle" DEFAULT="Default Window Title">
	<CFPARAM NAME="attributes.screenTitle" DEFAULT="Default Screen Title">

	<!--- spit out the page --->
	<CFSETTING ENABLECFOUTPUTONLY="NO">

	<TITLE><CFOUTPUT>#attributes.windowTitle#</CFOUTPUT></TITLE>

	<SCRIPT LANGUAGE="JavaScript">
	<!--
	function submitevent() { parent.document.myform.submit(); }
	//-->
	</SCRIPT>
	
	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>
<BODY OnLoad="submitevent();">
<br><br><br><br><br>
	<div align="center">
	<TABLE CELLPADDING=5 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
		<TR>
			<TD>&nbsp;<p></TD>
		</TR>
		<TR ALIGN="center">
			<!--- display wizard title and subtitle --->
			<TD ALIGN="center">
				<h3><CFOUTPUT>#attributes.screenTitle#</CFOUTPUT></h3>
			</TD>
		</TR>
		
		<TR>
			<TD>&nbsp;</TD>
		</TR>
		<TR>
			<TD ALIGN="center">
				Please Wait While Your <B>Custom Logos</B> are created.<BR>
				This may take a minute, please be patient.<BR><BR>
				<I><B>Do not hit the stop button on your browser!</B></I>
			</TD>
		</TR>
		<TR>
			<TD ALIGN=CENTER>
				<IMG SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/wheelfw.gif" BORDER=0 AlT="Please be patient.">
			</TD>
		</TR>
		<TR>
			<TD>&nbsp;</TD>
		</TR>
		<TR>
			<TD>&nbsp;</TD>
		</TR>
		<CFMODULE TEMPLATE="footer.cfm" isRedirectable=FALSE>			
		<!--- </TABLE> footer closes out the table --->
		</div>
		
		<FORM NAME="myform" action="genexe_redirect.cfm" method="post">
			<INPUT TYPE="hidden" NAME="nextStep" VALUE="<CFOUTPUT>#attributes.nextStep#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="uniqueID" VALUE="<CFOUTPUT>#attributes.uniqueID#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="displayName" VALUE="<CFOUTPUT>#attributes.displayName#</CFOUTPUT>">
		</FORM>
		<p>

	</BODY>
</HTML>
