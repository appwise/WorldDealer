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
	<!--- $Id: loadAC_s4.cfm,v 1.5 1999/11/29 15:34:11 lswanson Exp $ --->

<HEAD>

        <TITLE>WorldDealer | Maintain Account Coordinator List</TITLE>
		
<CFQUERY NAME="DeleteAC1" datasource="#gDSN#">
	SELECT FirstName, LastName, EMail
	FROM   AccountCoordinators
	WHERE  ACID = #URL.AccountCoordinator#
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
	<TR>
		<TD>
			<CFFORM ACTION="loadAC_s4a.cfm" METHOD="POST">
			<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0 WIDTH="90%">
				<TR>
					<TD align="middle"><font face="Arial, Helvetica">
						<CFOUTPUT QUERY="DeleteAC1">
							Are you sure you want to delete <b>#FirstName# #LastName#</b> From the Account Coordinator List?
						</CFOUTPUT></font>
					</TD>
				</TR>
				<TR>
					<TD>&nbsp;</TD>
				</TR>
			</TABLE>
		</TD>
	</TR>
	<TR ALIGN="center">
		<TD>
			<CFOUTPUT>
				<INPUT TYPE="HIDDEN" NAME="AccountCoordinator" VALUE="#URL.AccountCoordinator#">
				<INPUT TYPE="image" SRC="#application.RELATIVE_PATH#/images/admin/delete.gif" NAME="DELETE" VALUE="DELETE" BORDER="0">
			</CFOUTPUT>
			</CFFORM>
			<FORM ACTION="loadAC.cfm" METHOD="POST">
				<INPUT TYPE="IMAGE" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg" NAME="CANCEL" VALUE="CANCEL" BORDER="0">
			</FORM>
		</TD>
	</TR>
	<TR>
		<TD>
			&nbsp;
		</TD>
	</TR>
</TABLE>


</div>
</BODY>
</HTML>