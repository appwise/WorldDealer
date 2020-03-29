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
	<!--- $Id: acccoord_edit_save.cfm,v 1.4 2000/05/18 23:53:07 lswanson Exp $ --->

<CFQUERY NAME="CheckLoginID" datasource="#gDSN#">
	SELECT Count(LoginID) As NumOfLogins
	FROM   Accounts
	WHERE  LoginID = '#Form.LoginID#'
</CFQUERY>

<CFIF CheckLoginID.NumOfLogins LTE 1>
	<CFQUERY NAME="SameRowID" datasource="#gDSN#">
		SELECT RowID
		FROM   Accounts
		WHERE  LoginID = '#Form.LoginID#'
		AND	AccountType = 'AC';
	</CFQUERY>
	<CFIF (#Form.RowID# EQ #SameRowID.RowID#) OR (CheckLoginID.NumOfLogins EQ 0)>
		<CFQUERY NAME="updAC1" datasource="#gDSN#">
			UPDATE AccountCoordinators
			SET    FirstName = '#Form.FirstName#',
				   LastName = '#Form.LastName#',
				   EMail = '#Form.EMail#'
			WHERE  ACID = #Form.ACID#
		</CFQUERY>
		<CFSET tmp_Name = Trim(#Form.LastName#) & ', ' & Trim(#Form.FirstName#)>
		<CFQUERY NAME="updAC2" datasource="#gDSN#">
			UPDATE Accounts
			SET    LoginID = '#Form.LoginID#',
				   Password = '#Form.Password#',
				   AccountType = 'AC',
				   PermissionLevel = 1,
				   Name = '#Variables.tmp_Name#'
			WHERE  AccountKey = '#Form.ACID#' AND AccountType = 'AC'
		</CFQUERY>
	</CFIF>
</CFIF>

<div align="center">

<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0>
	<TR>
		<TD>&nbsp;<p></TD>
	</TR>
	<TR ALIGN="center">
		<TD ALIGN="middle"><h3><font face="Arial,Helvetica">Account Coordinators Maintenance</font></h3></TD>
	</TR>
	<TR ALIGN="center">
		<CFIF CheckLoginID.NumOfLogins EQ 1>
			<CFIF #Form.RowID# EQ #SameRowID.RowID#>
				<CFLOCATION URL="acccoord.cfm">
			<CFELSE>
				<TD ALIGN="middle"><font face="Arial, Helvetica">Sorry, somebody else already has chosen that Login ID. Please go back and pick another one.</font></TD>
			</CFIF>
		<CFELSEIF CheckLoginID.NumOfLogins EQ 0>
				<CFLOCATION URL="acccoord.cfm">
		<CFELSE>
			<TD ALIGN="middle"><font face="Arial, Helvetica">Sorry, somebody else already has chosen that Login ID. Please go back and pick another one.</font></TD>
		</CFIF>
	</TR>
	<TR>
		<TD>&nbsp;<p></TD>
	</TR>
	<FORM NAME="Form1" ACTION="acccoord.cfm" METHOD="POST">
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