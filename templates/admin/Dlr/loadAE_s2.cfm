<CFSET PageAccess = 3>
<CFINCLUDE template="security.cfm">
<CFIF ParameterExists(Form.DELETE.X)>
	<CFLOCATION URL="loadAE_s4.cfm?AccountExec=#Form.AccountExec#">
</CFIF>
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
	<!--- $Id: loadAE_s2.cfm,v 1.6 1999/11/29 15:34:11 lswanson Exp $ --->

<HEAD>

        <TITLE>WorldDealer | Maintain Account Executives List</TITLE>

<CFQUERY NAME="EditAE1" datasource="#gDSN#">
	SELECT FirstName, LastName, EMail, AEID
	FROM   AccountExecs
	WHERE  AEID = #Form.AccountExec#
</CFQUERY>

<CFQUERY NAME="EditAE2" datasource="#gDSN#">
	SELECT LoginID, Password, RowID
	FROM   Accounts
	WHERE  AccountKey = '#EditAE1.AEID#'
	AND	AccountType = 'AE';
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
		<TD ALIGN="middle"><h3><font face="Arial,Helvetica">Account Executive Maintenance</font></h3></TD>
	</TR>
	<TR ALIGN="center">
		<TD ALIGN="middle"><FONT FACE="Arial,Helvetica">Use the fields provided to make changes to an Account Executive.  Required fields are bolded.</font></td>
	</TR>
	<TR>
		<TD>&nbsp;<p></TD>
	</TR>
	<TR>
		<TD>
			<CFFORM NAME="EditInfo" ACTION="loadAE_s2a.cfm" ENABLECAB="Yes">
				<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0 WIDTH="90%">
					<TR>
						<TD ALIGN="right"><b><font face="Arial,Helvetica">First Name</font></b></TD>
						<TD>&nbsp;&nbsp;&nbsp;</TD>
						<TD>
							<CFOUTPUT QUERY="EditAE1">
								<INPUT TYPE=text NAME="FirstName" SIZE=30 MAXLENGTH=15 VALUE="#FirstName#">
							</CFOUTPUT>
							<INPUT TYPE="hidden" NAME="FirstName_required" VALUE="A name must be entered in the First Name field">
						</TD>
					</TR>
					<TR>
						<TD ALIGN="right"><b><font face="Arial, Helvetica">Last Name</font></b></TD>
						<TD>&nbsp;&nbsp;&nbsp;</TD>
						<TD>
							<CFOUTPUT QUERY="EditAE1">
								<INPUT TYPE=text NAME="LastName" SIZE="30" MAXLENGTH="30" VALUE="#LastName#">
							</CFOUTPUT>
							<INPUT TYPE="hidden" NAME="LastName_required" VALUE="A name must be entered in the Last Name field">
						</TD>
					</TR>
					<TR>
						<TD ALIGN="right"><font face="Arial, Helvetica">E-Mail</font></TD>
						<TD>&nbsp;&nbsp;&nbsp;</TD>
						<TD>
							<CFOUTPUT QUERY="EditAE1">
								<INPUT TYPE=text NAME="Email" SIZE="30" MAXLENGTH="30" VALUE="#EMail#">
							</CFOUTPUT>
						</TD>
					</TR>
					<TR>
						<TD ALIGN="right"><b><font face="Arial, Helvetica">Login ID</font></b></TD>
						<TD>&nbsp;&nbsp;&nbsp;</TD>
						<TD>
							<CFOUTPUT QUERY="EditAE2">
								<INPUT TYPE=text NAME="LoginID" SIZE="30" MAXLENGTH="15" VALUE="#LoginID#">
							</CFOUTPUT>
							<input type="hidden" name="loginid_required" value="You must enter a loginID">
						</TD>
					</TR>
					<TR>
						<TD ALIGN="right"><b><font face="Arial, Helvetica">Password</font></b></TD>
						<TD>&nbsp;&nbsp;&nbsp;</TD>
						<TD>
							<CFOUTPUT QUERY="EditAE2">
								<INPUT TYPE=text NAME="Password" SIZE="30" MAXLENGTH="15" VALUE="#Password#">
								<input type="hidden" name="password_required" value="You must enter a password">
							</CFOUTPUT>
						</TD>
					</TR>
					<TR>
						<TD>&nbsp;<p></TD>
					</TR>
				</TABLE>
			</TD>
		</TR>
		<TR ALIGN="center">
			<TD>
				<A HREF="#" OnClick="JavaScript:document.EditInfo.reset();"><IMG SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/reset_nav.jpg" Border="0" NAME="Reset" value="Reset"></a>
				&nbsp;&nbsp;&nbsp;<INPUT TYPE="image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/save_nav.jpg" NAME="SAVE" VALUE="SAVE" BORDER="0">
				<CFOUTPUT QUERY="EditAE1">
					<INPUT TYPE="hidden" NAME="AEID" VALUE="#AEID#">
				</CFOUTPUT>
				<CFOUTPUT QUERY="EditAE2">
					<INPUT TYPE="hidden" NAME="RowID" VALUE="#RowID#">
				</CFOUTPUT>
				</CFFORM>
				<FORM NAME="cancel" action="loadAE.cfm" method="post">
					&nbsp;&nbsp;&nbsp;<INPUT TYPE="image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg" NAME="CANCEL" VALUE="CANCEL" BORDER="0">
				</FORM>
		</TD>
	</TR>
</TABLE>


</div>
</BODY>
</HTML>