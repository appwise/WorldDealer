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
	<!--- $Id: accexec_del_main.cfm,v 1.4 2000/05/18 23:53:07 lswanson Exp $ --->
		
<CFQUERY NAME="DeleteAE1" datasource="#gDSN#">
	SELECT FirstName, LastName, EMail
	FROM   AccountExecs
	WHERE  AEID = #URL.AccountExec#
</CFQUERY>

<div align="center">

<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0>
	<TR>
		<TD>&nbsp;<p></TD>
	</TR>
	<TR ALIGN="center">
		<TD ALIGN="middle"><h3><font face="Arial,Helvetica">Account Executive Maintenance</font></h3></TD>
	</TR>
	<TR>
		<TD>
			<CFFORM ACTION="accexec_del_save.cfm" METHOD="POST">
			<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0 WIDTH="90%">
				<TR>
					<TD align="middle"><font face="Arial, Helvetica">
						<CFOUTPUT QUERY="DeleteAE1">
							Are you sure you want to delete <b>#FirstName# #LastName#</b> From the Account Executive List?
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
				<INPUT TYPE="HIDDEN" NAME="AccountExec" VALUE="#URL.AccountExec#">
				<INPUT TYPE="image" SRC="#application.RELATIVE_PATH#/images/admin/deletebutton.gif" NAME="DELETE" VALUE="DELETE" BORDER="0">
			</CFOUTPUT>
			</CFFORM>
			<FORM ACTION="accexec.cfm" METHOD="POST">
				<INPUT TYPE="image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel.gif" NAME="CANCEL" VALUE="CANCEL" border="0">
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