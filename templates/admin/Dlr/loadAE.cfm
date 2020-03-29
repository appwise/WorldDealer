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
	<!--- $Id: loadAE.cfm,v 1.6 1999/11/29 15:34:11 lswanson Exp $ --->

<HEAD>

        <TITLE>WorldDealer | Maintain Account Executives List</TITLE>


	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

<CFQUERY NAME="getAEs" datasource="#gDSN#">
	SELECT AEID, FirstName, LastName, EMail
	FROM AccountExecs
	ORDER BY LastName, FirstName
</CFQUERY>

</HEAD>

<body>
<br><br><br><br><br>
<div align="center">

<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=520 BGCOLOR="FFFFFF">
	<TR>
		<TD>&nbsp;<p></TD>
	</TR>
	<TR ALIGN="center">
		<TD ALIGN="middle"><h3><FONT FACE="Arial,Helvetica">Dealer Administration<br>Maintain Account Executives List</FONT></h3></TD>
	</TR>
	<TR ALIGN="center">
		<TD ALIGN="middle"><FONT FACE="Arial,Helvetica">Select an Account Executive to Modify or Delete, or select Add Account Exec to add an Account Executive. Required fields are bolded.</FONT></TD>
	</TR>
	<TR>
		<TD>&nbsp;<p></TD>
	</TR>
	<TR>
		<TD>
			<CFFORM NAME="FormOne" ACTION="loadAE_s2.cfm" ENABLECAB="Yes">
			<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0 WIDTH="90%">
				<TR>
					<TD ALIGN="right"><b><font face="Arial,Helvetica">Account<br>Executives</font></b></TD>
					<TD>&nbsp;&nbsp;&nbsp;</TD>
					<TD><SELECT NAME="AccountExec">
						<OPTION VALUE="">
						<CFOUTPUT QUERY="getAEs">
						<CFIF LastName IS NOT " ">
							<CFSET tmp_Name =Trim(#LastName#) & ', ' & Trim(#FirstName#)>
							<OPTION VALUE="#AEID#">#tmp_Name#
							<CFSET tmp_Name="">
						</CFIF>
						</CFOUTPUT>
						</SELECT>
						<INPUT TYPE="hidden" NAME="AccountExec_required">
					</TD>
				</TR>
			</TABLE>
		</TD>
	</TR>
	<TR>
		<TD>&nbsp;</TD>
	</TR>
	<TR ALIGN="center">
		<TD>
			<INPUT TYPE="image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/modify_nav.jpg" VALUE="EDIT" NAME="EDIT" BORDER="0">
			&nbsp;&nbsp;&nbsp;
			<input type="image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/delete.gif" value="DELETE" name="DELETE" BORDER="0">
			<P>
			</CFFORM>
			<form name="addaeinfo" action="loadAE_s3.cfm" method="post">
				<input type="image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/addaccountexec.jpg" border="0" name="SaveAEInfo" value="Add Account Exec">
			</form>
			<p>
			<form name="f_Back" action="loadflow.cfm" method="post">
				<INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg"
			Border="0"
			NAME="BackToMain"
			VALUE="Back To Main Menu">
			</form>
		</TD>
	</TR>
</TABLE>


</div>
</BODY>
</HTML>