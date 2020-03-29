<!---
maperror.cfm - a module to display an error to the user that mapping didn't work
   attributes:
       errorString - string describing the error that occured
	   dealerCode - dealer code
--->
<CFPARAM NAME="attributes.errorString">
<CFPARAM NAME="attributes.dealerCode">

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
    <!-- ----------------------------------------------------------- -->
    <!--       Created by sigma6, Detroit       -->
    <!--         Copyright (c) 1997, 1998, 1999 sigma6.              -->
    <!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->

    <!-- ----------------------------------------------------------- -->
    <!--    Howard Levine for sigma6, interactive media, Detroit     -->
    <!--    hlevine@sigma6.com   www.sigma6.com    www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
	<!--- $Id: maperror.cfm,v 1.5 1999/11/29 15:44:32 lswanson Exp $ --->

<HEAD>
	<TITLE>WorldDealer | Dealer Administration</TITLE>
	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>

<body>
<br><br><br><br><br>
	<div align="center">
	<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
		<TR>
			<TD>&nbsp;<p></TD>
		</TR>
		<TR ALIGN="center">
			<TD ALIGN="CENTER"><h3><font face="Arial,Helvetica">Dealer Administration - Create a New Web</font></h3></TD>
		</TR>
		<TR ALIGN="center">
			<TD ALIGN="CENTER">
				<FONT FACE="Arial,Helvetica">
					<B>An error occurred while creating your custom maps.</B>
					<BR><BR>
				</font>
			</td>
		</TR>
		<TR ALIGN="center">
			<TD ALIGN="CENTER">
				<FONT FACE="Arial,Helvetica">
				<CFOUTPUT>#attributes.errorString#</CFOUTPUT>
				</font>
			</td>
		</TR>
		<TR>
			<TD>&nbsp;<p></TD>
		</TR>
		<TR>
			<TD ALIGN="CENTER">
				<CFOUTPUT><A HREF="webnew.cfm?dlrcode=#attributes.dealerCode#"></CFOUTPUT><IMG SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/back_nav.jpg" BORDER="0" ALT="Back"></A>
			</TD>
		</TR>
		<TR>
			<TD>&nbsp;<p></TD>
		</TR>
	</TABLE>
</BODY>
</HTML>