<CFSET PageAccess = 1>
<CFINCLUDE template="security.cfm">

<CFSET #MakeMode#="false">
<CFSET #ConfirmMode#="false">
<CFSET #DoneMode#="false">

<CFIF IsDefined("Form.btnMake.X")>
	<CFSET #ModelYearMode#="true">
	
	<CFQUERY NAME="getMake" datasource="#gDSN#">
	SELECT DISTINCT MakeName
	FROM Makes
	</cfquery>
	
	

<CFELSEIF IsDefined("Form.btnConfirm.X")>

	<!----- delete the info from the database----->
	<CFQUERY Name="DeleteMake" datasource="#gDSN#">
	DELETE FROM Makes
	WHERE MakeName = '#Form.Make#'
	</cfquery>

	<CFSET #DoneMode#="true">

<CFELSE>
	<CFQUERY NAME="getMakes" datasource="#gDSN#">
	SELECT DISTINCT MakeName
	FROM Makes
	</cfquery>

	<CFSET #MakeMode#="true">

</cfif>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>

    <!-- ----------------------------------------------------------- -->
    <!--       Created by sigma6, Detroit       -->
    <!--         Copyright (c) 1997, 1998, 1999 sigma6.              -->
    <!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->

    <!-- ----------------------------------------------------------- -->
    <!--     William VanLoo for sigma6, interactive media, Detroit   -->
    <!--    wdvanloo@sigma6.com   www.sigma6.com    www.s6313.com    -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->

	<!--- $Id: deletemanuf.cfm,v 1.2 1999/11/24 22:54:03 lswanson Exp $ --->

<HEAD>

<TITLE>WorldDealer | Delete A Manufacturer</TITLE>


	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>

<body>
<br><br><br><br><br>
<div align="center">

<!-----First time through, choose a Make----->
<CFIF #MakeMode# IS 'true'>
<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=420 BGCOLOR="FFFFFF">
<TR><TD>&nbsp;<p></TD></TR>
<TR ALIGN="center">
	<TD ALIGN="middle"><h3><FONT FACE="Arial,Helvetica">Dealer Administration - Delete a Manufacturer</FONT></h3></TD>
</TR>

<TR ALIGN="center">
	<TD ALIGN="middle"><h4><font face="Arial,Helvetica">Choose a manufacturer</font></h4></TD>
</TR>

<TR ALIGN="center">
	<TD ALIGN="middle"><FONT FACE="Arial,Helvetica">Choose the manufacturer you wish to delete from the list below.</FONT></TD>
</TR>

<TR><TD>&nbsp;<p></TD></TR>

<TR>
	<TD ALIGN="CENTER">
	<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0 WIDTH="100%">
	<TR><TD COLSPAN=3>&nbsp;<p></TD></TR>
	
	<TR>
	<FORM NAME="Find1" ACTION="deletemanuf.cfm" METHOD="post">
		<TD ALIGN="right"><b><font face="Arial,Helvetica">Manufacturer:</font></b></TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<TD><SELECT name="Make">
		<OPTION VALUE="" SELECTED>
		<CFOUTPUT QUERY="getMakes">
		<OPTION VALUE="#MakeName#">#MakeName#
		</CFOUTPUT>
		</SELECT></TD>
	</TR>

	<TR><TD COLSPAN="3">&nbsp;<p></TD></TR>
	<TR ALIGN=CENTER>
		<TD COLSPAN="3" ALIGN=CENTER>
			<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next_nav.jpg" Border="0" NAME="btnMake" VALUE="Confirm">&nbsp;&nbsp;</TD>
		</td>
	</TR>
	<INPUT TYPE="Hidden" Name="Make_required" Value="You must select a manufacturer from the list.">
	</FORM>
	</TABLE>
	</TD>
</TR>
<TR ALIGN="center">
	<TD>
	<p>
	<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
	
<!-----Second time through, confirm choices----->
<CFELSEIF #ConfirmMode# IS 'true'>

<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=420 BGCOLOR="FFFFFF">
<TR><TD>&nbsp;<p></TD></TR>
<TR ALIGN="center">
	<TD ALIGN="middle"><h3><FONT FACE="Arial,Helvetica">Dealer Administration - Confirm Information</FONT></h3></TD>
</TR>

<TR ALIGN="center">
	<TD ALIGN="middle"><h4><font face="Arial,Helvetica">Confirm that the information shown below is correct.
	</font></h4></TD>
</TR>

<TR><TD><blockquote><font face="Arial,Helvetica">You are about to
	<b>permanently</b> delete <CFOUTPUT>#Form.Make#</CFOUTPUT> from the database.<p></FONT></blockquote></TD></TR>

<TR>
	<TD>
	<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0 WIDTH="100%">
	<TR><TD COLSPAN=3>&nbsp;<p></TD></TR>
	
	<TR>
	<FORM NAME="Find1" ACTION="deletemanuf.cfm" METHOD="post">
	<TR>
		<TD ALIGN=CENTER COLSPAN="3">
			<A HREF="javascript:history.go(-1);"><IMG SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/back_nav.jpg" Border="0" NAME="backout" VALUE="Back"></a>
			&nbsp;&nbsp;&nbsp;
			<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/delete.gif" Border="0" NAME="btnConfirm" VALUE="Confirm">
			<BR>
			<A HREF="deletemanuf.cfm"><IMG SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg" Border="0"></a>
		</TD>
	</TR>
	<INPUT TYPE="Hidden" Name="Make" Value="<CFOUTPUT>#Form.Make#</CFOUTPUT>">
	</FORM>
	</TABLE>
	</TD>
</TR>
<TR ALIGN="center">
	<TD>&nbsp;</TD>
</TR>
<TR ALIGN="center">
	<TD>
	<p>
	<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">

<!-----Third time through, all done, display info we just deleted----->
<CFELSEIF #DoneMode# IS 'true'>
<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=420 BGCOLOR="FFFFFF">
<TR><TD>&nbsp;<p></TD></TR>
<TR ALIGN="center">
	<TD ALIGN="middle"><h3><FONT FACE="Arial,Helvetica">Dealer Administration - Manufacturer Information Deleted</FONT></h3></TD>
</TR>

<TR ALIGN="center">
	<TD ALIGN="middle"><h4><font face="Arial,Helvetica">The Manufacturer information below has been deleted:</font></h4></TD>
</TR>

<TR><TD>&nbsp;<p></TD></TR>

<TR>
	<TD>
	<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0 WIDTH="100%">
	<TR><TD COLSPAN=3>&nbsp;<p></TD></TR>
	
	<TR ALIGN=center>
		<TD ALIGN="right"><b><font face="Arial,Helvetica">Manufacturer:</FONT></B></TD><TD COLSPAN="2" ALIGN="RIGHT"><font face="Arial,Helvetica"><CFOUTPUT>#Form.Make#</CFOUTPUT></FONT></td>
		<TD WIDTH="50">&nbsp;</td>
	</TR>
	</TABLE>
	</TD>
</TR>
<TR><TD>&nbsp;<P></TD></TR>

<TR ALIGN="center">
	<TD>
	<p>
	<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
	<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/deletemodel.jpg" Border="0" NAME="DeleteModel" VALUE="Delete Model">
</cfif>
	<P>
	<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg" Border="0" NAME="BackToMain" VALUE="Back To Main Menu">
	</FORM></TD>
</TR>
</TABLE>

</div>

</BODY>
</HTML>


