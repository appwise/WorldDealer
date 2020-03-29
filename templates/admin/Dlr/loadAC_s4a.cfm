<CFSET PageAccess = 3>
<CFINCLUDE template="security.cfm">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>

    <!-- ----------------------------------------------------------- -->
    <!--       Created by sigma6, Detroit       -->
    <!--         Copyright (c) 1997, 1998, 1999 sigma6.              -->
    <!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->

    <!-- ----------------------------------------------------------- -->
    <!--     John Turner for sigma6, interactive media, Detroit      -->
    <!--    jturner@sigma6.com   www.sigma6.com    www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
	<!--- $Id: loadAC_s4a.cfm,v 1.5 1999/11/29 15:34:11 lswanson Exp $ --->

<HEAD>

        <TITLE>WorldDealer | Maintain Account Coordinator List</TITLE>
		
<CFQUERY NAME="DeleteAC1" datasource="#gDSN#">
	DELETE FROM AccountCoordinators
	WHERE       ACID = #Form.AccountCoordinator#
</CFQUERY>

<CFQUERY NAME="DeleteAC2" datasource="#gDSN#">
	DELETE FROM Accounts
	WHERE       AccountKey = '#Form.AccountCoordinator#' AND AccountType = 'AC'
</CFQUERY>
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
		<TD ALIGN="middle"><h3><font face="Arial,Helvetica">Account Coordinator Maintenance</font></h3></TD>
	</TR>
	<TR ALIGN="center">
		<TD ALIGN="middle"><font face="Arial,Helvetica">Processing Complete</font></TD>
	</TR>
	<TR>
		<TD>&nbsp;<p></TD>
	</TR>
	<FORM NAME="Form1" ACTION="loadflow.cfm" METHOD="POST">
	<TR ALIGN="center">
		<TD>
			<INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg"
			Border="0"
			NAME="BackToMain"
			VALUE="Back To Main Menu">
			</FORM>
		</TD>
	</TR>
</TABLE>


</div>
</BODY>
</HTML>