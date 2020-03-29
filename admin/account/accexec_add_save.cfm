<cfset PageAccess = application.account_coordinator_access>
<cfinclude template = "../security.cfm">

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
	<!--- $Id: accexec_add_save.cfm,v 1.4 2000/05/18 23:53:07 lswanson Exp $ --->

<CFQUERY NAME="CheckLoginID" datasource="#gDSN#">
	SELECT Count(LoginID) As NumOfLogins
	FROM   Accounts
	WHERE  LoginID = '#Form.LoginID#'
	AND	AccountType = 'AE';
</CFQUERY>

<CFIF CheckLoginID.NumOfLogins EQ 0>
		
	<CFQUERY NAME="AddAE1" datasource="#gDSN#">
		INSERT INTO AccountExecs (FirstName, LastName, EMail)
		VALUES ('#Form.FirstName#', '#Form.LastName#', '#Form.EMail#')
	</CFQUERY>

	<CFQUERY NAME="QueryAE1" datasource="#gDSN#">
		SELECT AEID
		FROM   AccountExecs
		WHERE  FirstName = '#Form.FirstName#' AND LastName = '#Form.LastName#' AND EMail = '#Form.EMail#'
	</CFQUERY>

	<CFSET tmp_Name = Trim(#Form.LastName#) & ', ' & Trim(#Form.FirstName#)>

	<CFQUERY NAME="AddAE2" datasource="#gDSN#">
		INSERT INTO Accounts (LoginID, Password, AccountKey, AccountType, PermissionLevel, Name)
		VALUES ('#Form.LoginID#', '#Form.Password#', '#QueryAE1.AEID#', 'AE', 2, '#Variables.tmp_Name#')
	</CFQUERY>

</CFIF>

<div align="center">

<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0>
	<TR>
		<TD>&nbsp;<p></TD>
	</TR>
	<TR ALIGN="center">
		<TD ALIGN="middle"><h3><font face="Arial,Helvetica">Account Executive Maintenance</font></h3></TD>
	</TR>
	<TR ALIGN="center">
		<CFIF CheckLoginID.NumOfLogins EQ 0>
			<CFLOCATION URL="accexec.cfm">
		<CFELSE>
			<TD ALIGN="middle"><font face="Arial, Helvetica">Sorry, somebody else already has chosen that Login ID. Please go back and pick another one</font></TD>
		</CFIF>
	</TR>
	<TR>
		<TD>&nbsp;<p></TD>
	</TR>
	<FORM NAME="Form1" ACTION="accexec.cfm" METHOD="POST">
	<TR ALIGN="center">
		<TD>
		<INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/back.gif"
			Border="0"
			NAME="BackToMain"
			VALUE="Back To Main Menu">
			</FORM>
		</TD>
	</TR>
</TABLE>

</div>