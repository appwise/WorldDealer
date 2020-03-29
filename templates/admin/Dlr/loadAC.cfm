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
	<!--- $Id: loadAC.cfm,v 1.5 1999/11/29 15:34:10 lswanson Exp $ --->

<HEAD>

        <TITLE>WorldDealer | Maintain Account Coordinators List</TITLE>


	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>

<CFQUERY NAME="getACs" datasource="#gDSN#">
	SELECT ACID as lq_ACID,
	FirstName as lq_ACFirstName,
	LastName as lq_ACLastName,
	EMail as lq_EMail
	FROM AccountCoordinators
	ORDER BY LastName, FirstName
</CFQUERY>

<body>
<br><br><br><br><br>
<div align="center">

<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=520 BGCOLOR="FFFFFF">
	<TR>
		<TD>&nbsp;<p></TD>
	</TR>
	<TR ALIGN="center">
		<TD ALIGN="middle"><h3><FONT FACE="Arial,Helvetica">Dealer Administration<br>Maintain Account Coordinators List</FONT></h3></TD>
	</TR>
	<TR ALIGN="center">
		<TD ALIGN="middle"><FONT FACE="Arial,Helvetica">Select an Account Coordinator to Edit or Delete, or select Add Account Coordinator to add an Account Coordinator. Required fields are bolded.</FONT></TD>
	</TR>
	<TR>
		<TD>&nbsp;<p></TD>
	</TR>
	<TR>
		<TD>
			<CFFORM NAME="FormOne" ACTION="loadAC_s2.cfm" ENABLECAB="Yes">
			<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0 WIDTH="90%">
				<TR>
					<TD ALIGN="right"><b><font face="Arial,Helvetica">Account<br>Coordinators</font></b></TD>
					<TD>&nbsp;&nbsp;&nbsp;</TD>
					<TD><SELECT NAME="AccountCoordinator">
						<OPTION VALUE="">
						<CFOUTPUT QUERY="getACs">
						<CFIF lq_ACLastName IS NOT " ">
							<CFSET tmp_Name=Trim(#lq_ACLastName#) & ', ' & Trim(#lq_ACFirstName#)>
							<OPTION VALUE="#lq_ACID#">#tmp_Name#
							<CFSET tmp_Name="">
						</CFIF>
						</CFOUTPUT>
						</SELECT>
						<INPUT TYPE="hidden" NAME="AccountCoordinator_required">
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
			<form name="addacinfo" action="loadAC_s3.cfm" method="post">
				<input type="image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/addaccountcoor.jpg" border="0" name="SaveACInfo" value="Add Account Exec">
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