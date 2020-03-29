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
	<!--- $Id: loadDA.cfm,v 1.5 1999/11/29 15:34:12 lswanson Exp $ --->

<HEAD>

        <TITLE>WorldDealer | Maintain Dealer Administrator List</TITLE>


	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>


<CFQUERY NAME="getDAs" datasource="#gDSN#">
	SELECT  LoginID,
		    Name,
			RowID,
			AccountKey
	FROM    Accounts
	WHERE   AccountType = 'DE'
	ORDER BY Name, LoginID;
</CFQUERY>

<body>
<br><br><br><br><br>
<div align="center">

<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=520 BGCOLOR="FFFFFF">
	<TR>
		<TD>&nbsp;<p></TD>
	</TR>
	<TR ALIGN="center">
		<TD ALIGN="middle"><h3><FONT FACE="Arial,Helvetica">Dealer Administration<br>Maintain Dealer Administrator List</FONT></h3></TD>
	</TR>
	<TR ALIGN="center">
		<TD ALIGN="middle"><FONT FACE="Arial,Helvetica">Choose a Dealer Administrator to Edit or Delete, or select Add Dealer Administrator to add a Dealer Web Site Administrator.</FONT></TD>
	</TR>
	<TR>
		<TD>&nbsp;<p></TD>
	</TR>
	<TR>
		<TD>
			<CFFORM NAME="FormOne" ACTION="loadDA_s2.cfm" ENABLECAB="Yes">
			<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0 WIDTH="90%">
				<TR>
					<TD ALIGN="right"><b><font face="Arial,Helvetica">Dealer<br>Administrator</font></b></TD>
					<TD>&nbsp;&nbsp;&nbsp;</TD>
					<TD><SELECT NAME="DealerAdministrator">
						<OPTION VALUE="">
						<CFOUTPUT QUERY="getDAs">
						<CFIF Name IS NOT " ">
							<OPTION VALUE="#RowID#">#Name# (#AccountKey#)
						</CFIF>
						</CFOUTPUT>
						</SELECT>
						<INPUT TYPE="hidden" NAME="DealerAdministrator_required">
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
			<form name="adddainfo" action="loadDA_s3.cfm" method="post">
				<input type="image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/adddlradmin.gif" border="0" name="SaveDAInfo" value="Add Dealer Admin">
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