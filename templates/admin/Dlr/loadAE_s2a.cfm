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
	<!--- $Id: loadAE_s2a.cfm,v 1.5 1999/11/29 15:34:11 lswanson Exp $ --->

<HEAD>

        <TITLE>WorldDealer | Maintain Account Executives List</TITLE>
		
<CFQUERY NAME="CheckLoginID" datasource="#gDSN#">
	SELECT Count(LoginID) As NumOfLogins
	FROM   Accounts
	WHERE  LoginID = '#Form.LoginID#'
	AND	AccountType = 'AE';
</CFQUERY>

<CFIF CheckLoginID.NumOfLogins LTE 1>
	<CFQUERY NAME="SameRowID" datasource="#gDSN#">
		SELECT RowID
		FROM   Accounts
		WHERE  LoginID = '#Form.LoginID#'
	</CFQUERY>
	<CFIF (#Form.RowID# EQ #SameRowID.RowID#) OR (CheckLoginID.NumOfLogins EQ 0)>
		<CFQUERY NAME="updAE1" datasource="#gDSN#">
			UPDATE AccountExecs
			SET    FirstName = '#Form.FirstName#',
				   LastName = '#Form.LastName#',
				   EMail = '#Form.EMail#'
			WHERE  AEID = #Form.AEID#
		</CFQUERY>
		<CFSET tmp_Name = Trim(#Form.LastName#) & ', ' & Trim(#Form.FirstName#)>
		<CFQUERY NAME="updAE2" datasource="#gDSN#">
			UPDATE Accounts
			SET    LoginID = '#Form.LoginID#',
				   Password = '#Form.Password#',
				   AccountType = 'AE',
				   PermissionLevel = 2,
				   Name = '#Variables.tmp_Name#'
			WHERE  AccountKey = '#Form.AEID#' AND AccountType = 'AE'
		</CFQUERY>
	</CFIF>
</CFIF>

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
		<TD ALIGN="middle"><h3><font face="Arial,Helvetica">Account Executive Maintenance</font></h3></TD>
	</TR>
	<TR ALIGN="center">
		<CFIF CheckLoginID.NumOfLogins EQ 1>
			<CFIF #Form.RowID# EQ #SameRowID.RowID#>
				<TD ALIGN="middle"><font face="Arial,Helvetica">Processing Complete</font></TD>
			<CFELSE>
				<TD ALIGN="middle"><font face="Arial, Helvetica">Sorry, somebody else already has chosen that Login ID. Please go back and pick another one.</font></TD>
			</CFIF>
		<CFELSEIF CheckLoginID.NumOfLogins EQ 0>
			<TD ALIGN="middle"><font face="Arial, Helvetica">Processing Complete</font></TD>
		<CFELSE>
			<TD ALIGN="middle"><font face="Arial, Helvetica">Sorry, somebody else already has chosen that Login ID. Please go back and pick another one.</font></TD>
		</CFIF>
	</TR>
	<TR>
		<TD>&nbsp;<p></TD>
	</TR>
	<FORM NAME="Form1" ACTION="loadflow.cfm" METHOD="POST">
	<TR ALIGN="center">
		<TD>
			<A HREF="Javascript:history.back();"><IMG SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/back.jpg" BORDER=0 ALT="Back"></A>
			<BR>
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