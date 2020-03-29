<CFINCLUDE template="security.cfm">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>

    <!-- ----------------------------------------------------------- -->
    <!--                Created by sigma6, Detroit                   -->
    <!--         Copyright (c) 1997, 1998, 1999 sigma6.              -->
    <!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->

    <!-- ----------------------------------------------------------- -->
    <!--    Howard Levine for sigma6, interactive media, Detroit     -->
    <!--    hlevine@sigma6.com   www.sigma6.com    www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
	<!--- $Id: offermaint.cfm,v 1.6 1999/11/29 15:44:32 lswanson Exp $ --->

<HEAD>
	<TITLE>WorldDealer | Offers Reporting</TITLE>
	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>

<body>
<br><br><br><br><br>


<CFIF #IsDefined("Form.BtnNext.X")#>
	<CFSET DisplayMode = TRUE>
<CFELSE>
	<CFSET DisplayMode = FALSE>
</CFIF>

<CFIF DisplayMode> 
	
	<CFIF #Form.SortBy# EQ 'P'> 
		<CFLOCATION url="offermodels.cfm">
	</CFIF>
	
	<CFIF #form.SortBy# EQ 'dlr'>
		<CFLOCATION URL="offerdealer.cfm">
	</CFIF>
	
	<CFIF #Form.SortBY# EQ 'T'>
		<CFLOCATION url="offerType.cfm">
	</CFIF>
</CFIF>

	

<CFIF NOT DisplayMode> 
	<div align="center">
	<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
	<TR ALIGN="center">
		<TD ALIGN="middle"><h3><FONT FACE="Arial,Helvetica">
		Dealer Administration<br>Offers Reporting</FONT></h3></TD>
	</TR>
	<TR><TD>&nbsp;<p></TD></TR>
	<FORM ACTION="offermaint.cfm" method="post">
	<TR ALIGN="center">
		<TD><FONT FACE="Arial,Helvetica">Sort Offers By:&nbsp;&nbsp;<SELECT name="SortBy">
		<!--- <OPTION value=""></OPTION> --->
		<OPTION value="P">Product (Model)</OPTION>
		<OPTION value="T">Offer Type</OPTION>
		<OPTION value="dlr">Dealer</OPTION>
		<!--- <OPTION value="DMG">DMG</OPTION> --->
		</SELECT>
		<INPUT TYPE="hidden" NAME="sortby_required">
		<BR><BR>
		<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next_nav.jpg" Border="0" name="BtnNext" value="Next"></FONT>
		</TD>
	</TR>
	</FORM>
	<FORM NAME="f_Back" Action="redirect.cfm" method="post">
	<TR><TD>&nbsp;</TD></TR>
	<TR ALIGN="center">
		<TD>
		<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
		<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg" Border="0" NAME="BackToMain" VALUE="Back To Main Menu"></FORM></TD>
	</TR>
	</TABLE>
	
	</div>
</CFIF> 

</BODY>
</HTML>