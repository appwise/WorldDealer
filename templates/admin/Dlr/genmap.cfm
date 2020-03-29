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
<!--- $Id: genmap.cfm,v 1.5 1999/11/29 15:36:34 lswanson Exp $ --->

<!---
genmap.cfm - a module to display an interstitial page while generating maps
attributes:
    windowTitle - title for the browser window
	screenTitle - title (or heading) in the body
	nextStep - URL to redirect to when image generation is complete
	dealerCode - dealerCode used to make map filenames unique
--->

<!--- required attributes --->
<CFPARAM NAME="attributes.dealerCode">
<CFPARAM NAME="attributes.nextStep">

<!--- optional attributes --->
<CFPARAM NAME="attributes.windowTitle" DEFAULT="Default Window Title">
<CFPARAM NAME="attributes.screenTitle" DEFAULT="Default Screen Title">

<!--- spit out the page --->
<CFSETTING ENABLECFOUTPUTONLY="NO">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
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
			<TD ALIGN="center"><h3><FONT FACE="Arial,Helvetica"><CFOUTPUT>#attributes.screenTitle#</CFOUTPUT></FONT></h3></TD>
		</TR>
		
		<TR>
			<TD>&nbsp;</TD>
		</TR>
		<TR>
			<TD ALIGN="center"><FONT FACE="Arial,Helvetica">Please wait while your <B>Custom Maps</B> are created.<BR>
			This may take a minute, please be patient.<BR><BR><I><B>Do not hit the Stop button on your browser!</B></I></FONT></TD>
		</TR>
		<TR>
			<TD ALIGN=CENTER><IMG SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/wheelfw.gif" BORDER=0 AlT="Please be patient."></TD>
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
		
		<FORM NAME="myform" ACTION="genmap_redirect.cfm" METHOD="POST">
			<INPUT TYPE="hidden" NAME="dealerCode" VALUE="<CFOUTPUT>#attributes.dealerCode#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="nextStep" VALUE="<CFOUTPUT>#attributes.nextStep#</CFOUTPUT>">
		</FORM>
	</BODY>
</HTML>
