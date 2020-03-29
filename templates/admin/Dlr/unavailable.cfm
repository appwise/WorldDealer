<CFINCLUDE template="security.cfm">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

   <!-- ----------------------------------------------------------- -->
   <!--   Created by Sigma6, Inc.              -->
   <!--     Copyright (c) 1998, 1999 Sigma6, Inc.                   -->
   <!--         All Rights Reserved.  Used By Permission.           -->
   <!-- ----------------------------------------------------------- -->
   <!-- ----------------------------------------------------------- -->
   <!--           Sigma6, interactive media, Detroit/NYC            -->
   <!--               conceive : construct : connect                -->
   <!--   www.sigma6.com   webmaster@sigma6.com   info@sigma6.com   -->
   <!--                                                             -->
   <!--   Last updated: Friday, April 10, 1998                      -->
   <!-- ----------------------------------------------------------- -->
   <!--     Howard Levine for sigma6, interactive media, Detroit    -->
   <!--    hlevine@sigma6.com   www.sigma6.com    www.s6313.com     -->
   <!--               conceive : construct : connect                -->
   <!-- ----------------------------------------------------------- -->

   <!-- ----------------------------------------------------------- -->
   <!-- Sigma6, s6, and the Sigma6 logos are registered trademarks. -->
   <!-- All other trademarks and servicemarks are the property of   -->
   <!-- their respective owners.                                    -->
   <!-- ----------------------------------------------------------- -->
	<!--- $Id: unavailable.cfm,v 1.5 1999/11/29 15:44:33 lswanson Exp $ --->


<CFQUERY name="GetConflictName" datasource="#gDSN#">
SELECT DealershipName
FROM Dealers
WHERE DealerCode = '#URL.dlrcodeIN#';
</CFQUERY>

<CFIF #URL.DLRCode# IS NOT 'new'>
	<CFQUERY name="GetDLRName" datasource="#gDSN#">
	SELECT DealershipName
	FROM Dealers
	WHERE DealerCode = '#URL.DlrCode#';
	</CFQUERY>
</CFIF>


<HTML>
<HEAD>
	<TITLE>WorldDealer | Create a New Web</TITLE>
	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>
<CFABORT>
<body>
<br><br><br><br><br>

<div align="center">
<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
<TR><TD>&nbsp;</TD></TR>
<TR ALIGN="center">
	<TD ALIGN="middle"><h3><font face="Arial,Helvetica">Dealer Administration - Create a New Web</font></h3></TD>
</TR>
<TR ALIGN="center">
	<TD><FONT FACE="Arial,Helvetica"><CFOUTPUT>
	Sorry.  The Dealercode you have chosen, <b>#URL.DLRCodeIN#</b>,
	<br>
	is already being used by <b>#GetConflictName.DealershipName#</b>.</CFOUTPUT></FONT>
	</TD>
</TR>
<TR><TD>&nbsp;</TD></TR>
<TR ALIGN="Center">
	<TD><FONT FACE="Arial,Helvetica"><CFOUTPUT>
	<CFIF #URL.DlrCode# IS NOT 'new'>
		The following Dealercode: <b>#URL.DLRCode#</b>,
		<br>
		for Dealership <b>#GetDLRName.Dealershipname#</b>,
		<br>
		was NOT changed.
		<p>
		The changes you entered for this dealership were discarded.
	<CFELSE>
		The information you entered for the New Dealership has been discarded.
	</CFIF>
	</CFOUTPUT></FONT>
	</TD>
</TR>
<TR><TD>&nbsp;</TD></TR>
<FORM action="redirect.cfm" method="post">
<TR align="center">
	<TD>
	<FONT FACE="Arial,Helvetica">
		<A HREF="JavaScript:history.back()"><IMG
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/back.jpg" BORDER=0 ALT="Back"></A>
		<BR><BR>
	<INPUT TYPE="Image"
		SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg"
		Border="0"
		NAME="BackToMain"
		VALUE="Back To Main Menu">
	</FONT>
	</TD>
</TR>
<TR><TD>&nbsp;</TD></TR>
</TABLE>
</div>

</BODY>
</HTML>
			
	