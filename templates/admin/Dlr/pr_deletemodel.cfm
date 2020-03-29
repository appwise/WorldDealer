<CFSET PageAccess = 1>
<CFINCLUDE template="security.cfm">

<CFIF IsDefined("Form.btnMake.X")>
	<CFQUERY NAME="getModelYear" datasource="#gDSN#">
	SELECT DISTINCT ModelName,Year
	FROM UsedVehiclesModels
	WHERE UsedVehiclesModels.Make='#Form.Make#';
	ORDER BY ModelName
	</cfquery>
	
	<CFSET #MakeMode#="false">
	<CFSET #ModelYearMode#="true">
	<CFSET #ConfirmMode#="false">
	<CFSET #DoneMode#="false">
	
<CFELSEIF IsDefined("Form.btnModelYear.X")>
	<CFSET #MakeMode#="false">
	<CFSET #ModelYearMode#="false">
	<CFSET #ConfirmMode#="true">
	<CFSET #DoneMode#="false">

<CFELSEIF IsDefined("Form.btnConfirm.X")>

	<!----- delete the info from the database----->
	<CFQUERY Name="DeleteMakeModelYear" datasource="#gDSN#">
	DELETE FROM UsedVehiclesModels
	WHERE Make = '#Form.Make#' AND
	ModelName = '#Form.ModelName#' AND
	Year = #Form.Year#
	</cfquery>

	<CFSET #MakeMode#="false">
	<CFSET #ModelYearMode#="false">
	<CFSET #ConfirmMode#="false">
	<CFSET #DoneMode#="true">

<CFELSE>
	<CFQUERY NAME="getMakes" datasource="#gDSN#">
	SELECT DISTINCT Make
	FROM UsedVehiclesModels
	</cfquery>

	<CFSET #MakeMode#="true">
	<CFSET #ModelYearMode#="false">
	<CFSET #ConfirmMode#="false">
	<CFSET #DoneMode#="false">

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
	<!--- $Id: pr_deletemodel.cfm,v 1.6 1999/11/29 15:44:33 lswanson Exp $ --->

<HEAD>

<TITLE>WorldDealer | Delete A Make/Model/Year</TITLE>


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
	<TD ALIGN="middle"><h3><FONT FACE="Arial,Helvetica">Dealer Administration - Delete a Pre-Owned Model</FONT></h3></TD>
</TR>

<TR ALIGN="center">
	<TD ALIGN="middle"><h4><font face="Arial,Helvetica">Choose a vehicle make</font></h4></TD>
</TR>

<TR ALIGN="center">
	<TD ALIGN="middle"><FONT FACE="Arial,Helvetica">Choose the make of the vehicle you wish to delete from the list below.</FONT></TD>
</TR>

<TR><TD>&nbsp;<p></TD></TR>

<TR>
	<TD ALIGN="CENTER">
	<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0 WIDTH="100%">
	<TR><TD COLSPAN=3>&nbsp;<p></TD></TR>
	
	<TR>
	<FORM NAME="Find1" ACTION="pr_deletemodel.cfm" METHOD="post">
		<TD ALIGN="right"><b><font face="Arial,Helvetica">Make:</font></b></TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<TD><SELECT name="Make">
		<OPTION VALUE="" SELECTED>
		<CFOUTPUT QUERY="getMakes">
		<OPTION VALUE="#Make#">#Make#
		</CFOUTPUT>
		</SELECT></TD>
	</TR>

	<TR><TD COLSPAN="3">&nbsp;<p></TD></TR>
	<TR ALIGN=CENTER>
		<TD COLSPAN="3" ALIGN=CENTER>
			<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next_nav.jpg" Border="0" NAME="btnMake" VALUE="Confirm">&nbsp;&nbsp;</TD>
		</td>
	</TR>
	<INPUT TYPE="Hidden" Name="Make_required" Value="You must select a vehicle Make from the list">
	</FORM>
	</TABLE>
	</TD>
</TR>
<TR ALIGN="center">
	<TD>
	<p>
	<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
	
<!-----Second time through, choose a Model----->
<CFELSEIF #ModelYearMode# IS 'true'>
<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=420 BGCOLOR="FFFFFF">
<TR><TD>&nbsp;<p></TD></TR>
<TR ALIGN="center">
	<TD ALIGN="center"><h3><FONT FACE="Arial,Helvetica">Dealer Administration - Delete a Model</FONT></h3></TD>
</TR>

<TR ALIGN="center">
	<TD ALIGN="center"><h4><font face="Arial,Helvetica">Choose a vehicle model and year</font></h4></TD>
</TR>

<TR ALIGN="center">
	<TD ALIGN="center"><FONT FACE="Arial,Helvetica">Choose the model and year of the vehicle you wish to delete from the list below.</FONT></TD>
</TR>

<TR><TD>&nbsp;<p></TD></TR>

<TR>
	<TD>
	<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0 WIDTH="100%">
	<TR><TD COLSPAN=3>&nbsp;<p></TD></TR>
	
	<FORM NAME="Find1" ACTION="pr_deletemodel.cfm" METHOD="post">

	<TR ALIGN=center>
		<TD COLSPAN=3></TD>
	</TR>

	<TR><TD COLSPAN=3>&nbsp;<p></TD></TR>

	<TR>
	<FORM NAME="Find1" ACTION="pr_modeladmin.cfm" METHOD="post">
		<TD ALIGN="right"><b><font face="Arial,Helvetica">Model/Year:</font></b></TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<TD><SELECT name="ModelYear">
		<OPTION VALUE="" SELECTED>
		<CFOUTPUT QUERY="getModelYear">
		<OPTION VALUE="#ModelName#,#Year#">#ModelName# - #Year#
		</CFOUTPUT>
		</SELECT></TD>
	</TR>
	<TR><TD COLSPAN="3">&nbsp;<p></TD></TR>
	<TR>
		<TD ALIGN=CENTER COLSPAN="3">
			<A HREF="javascript:history.go(-1);"><IMG SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/back_nav.jpg" Border="0" NAME="backout" VALUE="Back"></a>
			&nbsp;&nbsp;&nbsp;
			<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next_nav.jpg" Border="0" NAME="btnModelYear" VALUE="Confirm">
			<BR>
			<A HREF="pr_deletemodel.cfm"><IMG SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg" Border="0"></a><BR><BR>
		</TD>
	</TR>
	<INPUT TYPE="Hidden" Name="ModelYear_required" Value="You must select a model name & year from the list.">
	<INPUT TYPE="Hidden" Name="Make" Value="<CFOUTPUT>#Form.Make#</CFOUTPUT>">
	</FORM>
	</TABLE>
	</TD>
</TR>
<TR ALIGN="center">
	<TD>
	<p>
	<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
	
<!-----Third time through, confirm choices----->
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
	<b>permanently</b> delete the <CFOUTPUT>#ListGetAt(Form.ModelYear,2)# #ListGetAt(Form.ModelYear,1)#</CFOUTPUT> from the database.<p></FONT></blockquote></TD></TR>

<TR>
	<TD>
	<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0 WIDTH="100%">
	<TR><TD COLSPAN=3>&nbsp;<p></TD></TR>
	
	<TR ALIGN=center>
		<TD ALIGN="right"><b><font face="Arial,Helvetica">Make:</FONT></B></TD><TD ALIGN="RIGHT"><font face="Arial,Helvetica"><CFOUTPUT>#Form.Make#</CFOUTPUT></FONT></td>
		<TD WIDTH="50">&nbsp;</td>
	</TR>
	<TR ALIGN=center>
		<TD ALIGN="right"><b><font face="Arial,Helvetica">Model Name:</FONT></B></TD><TD ALIGN="RIGHT"><font face="Arial,Helvetica"><CFOUTPUT>#ListGetAt(Form.ModelYear,1)#</CFOUTPUT></FONT></td>
		<TD WIDTH="50">&nbsp;</td>
	</TR>
	
	<TR>
	<FORM NAME="Find1" ACTION="pr_deletemodel.cfm" METHOD="post">
		<TD ALIGN="right"><b><font face="Arial,Helvetica">Year:</font></b></TD>
		<TD ALIGN="right"><font face="Arial,Helvetica">
			<CFOUTPUT>#ListGetAt(Form.ModelYear,2)#</CFOUTPUT><TD WIDTH="50">&nbsp;</td></TR>

	<TR><TD COLSPAN=3>&nbsp;<p></TD></TR>
	<TR>
		<TD ALIGN=CENTER COLSPAN="3">
			<A HREF="javascript:history.go(-1);"><IMG SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/back_nav.jpg" Border="0" NAME="backout" VALUE="Back"></a>
			&nbsp;&nbsp;&nbsp;
			<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/delete.gif" Border="0" NAME="btnConfirm" VALUE="Confirm">
			<BR>
			<A HREF="pr_deletemodel.cfm"><IMG SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg" Border="0"></a>
		</TD>
	</TR>
	<INPUT TYPE="Hidden" Name="Make" Value="<CFOUTPUT>#Form.Make#</CFOUTPUT>">
	<INPUT TYPE="Hidden" Name="ModelName" Value="<CFOUTPUT>#ListGetAt(Form.ModelYear,1)#</CFOUTPUT>">
	<INPUT TYPE="Hidden" Name="Year" Value="<CFOUTPUT>#ListGetAt(Form.ModelYear,2)#</CFOUTPUT>">
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

<!-----Fifth time through, all done, display info we just inserted----->
<CFELSEIF #DoneMode# IS 'true'>
<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=420 BGCOLOR="FFFFFF">
<TR><TD>&nbsp;<p></TD></TR>
<TR ALIGN="center">
	<TD ALIGN="middle"><h3><FONT FACE="Arial,Helvetica">Dealer Administration - Make/Model/Year Information Deleted</FONT></h3></TD>
</TR>

<TR ALIGN="center">
	<TD ALIGN="middle"><h4><font face="Arial,Helvetica">The Make/Model/Year information below has been deleted:</font></h4></TD>
</TR>

<TR><TD>&nbsp;<p></TD></TR>

<TR>
	<TD>
	<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0 WIDTH="100%">
	<TR><TD COLSPAN=3>&nbsp;<p></TD></TR>
	
	<TR ALIGN=center>
		<TD ALIGN="right"><b><font face="Arial,Helvetica">Make:</FONT></B></TD><TD COLSPAN="2" ALIGN="RIGHT"><font face="Arial,Helvetica"><CFOUTPUT>#Form.Make#</CFOUTPUT></FONT></td>
		<TD WIDTH="50">&nbsp;</td>
	</TR>
	<TR ALIGN=center>
		<TD ALIGN="right"><b><font face="Arial,Helvetica">Model Name:</FONT></B></TD><TD COLSPAN="2" ALIGN="RIGHT"><font face="Arial,Helvetica"><CFOUTPUT>#Form.ModelName#</CFOUTPUT></FONT></td>
		<TD WIDTH="50">&nbsp;</td>
	</TR>
	
	<TR>
	<FORM NAME="Find1" ACTION="pr_deletemodel.cfm" METHOD="post">
		<TD ALIGN="right"><b><font face="Arial,Helvetica">Year:</font></b></TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<TD ALIGN="RIGHT"><FONT FACE="Arial,Helvetica">
			<CFOUTPUT>#Form.Year#</CFOUTPUT></FONT></TD>
			<TD WIDTH="50">&nbsp;</td>
	</TR>
	<TR><TD COLSPAN=4>&nbsp;<p></TD></TR>
	</FORM>
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


