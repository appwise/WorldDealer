<CFSET PageAccess = 1>
<CFINCLUDE template="security.cfm">

<CFIF IsDefined("Form.btnMake.X")>
	<CFQUERY NAME="getModels" datasource="#gDSN#">
	SELECT DISTINCT ModelName
	FROM UsedVehiclesModels
	WHERE UsedVehiclesModels.Make='#Form.Make#';
	</cfquery>
	
	<CFSET #MakeMode#="false">
	<CFSET #ModelMode#="true">
	<CFSET #YearMode#="false">
	<CFSET #ConfirmMode#="false">
	<CFSET #DoneMode#="false">
	
<CFELSEIF IsDefined("Form.btnModelName.X")>
	<CFQUERY NAME = "getModelYears" Datasource = "WorldDlr">
	SELECT 	Year
	FROM 	UsedVehiclesModels
	WHERE	Make = '#Form.Make#'
	AND		ModelName = '#Form.ModelName#'
	</cfquery>
	
	<CFSET #MakeMode#="false">
	<CFSET #ModelMode#="false">
	<CFSET #YearMode#="true">
	<CFSET #ConfirmMode#="false">
	<CFSET #DoneMode#="false">

<CFELSEIF IsDefined("Form.btnYear.X")>
	<CFSET #MakeMode#="false">
	<CFSET #ModelMode#="false">
	<CFSET #YearMode#="false">
	<CFSET #ConfirmMode#="true">
	<CFSET #DoneMode#="false">

<CFELSEIF IsDefined("Form.btnConfirm.X")>

	<CFQUERY Name="checkexistinginfo" datasource="#gDSN#">
	SELECT Make,ModelName,Year
	FROM UsedVehiclesModels
	ORDER BY Make
	</cfquery>

	<!----- loop throught the model years & put the info into the database----->
	<CFSET #LowYear#=#Form.Year1#>
		<CFLOOP Query="checkexistinginfo">
			<CFLOOP FROM="#LowYear#" TO="#Form.Year2#" INDEX="counter">
				<CFIF #Form.Make# EQ '#checkexistinginfo.Make#' AND #Form.ModelName# EQ '#checkexistinginfo.ModelName#' AND #Form.Year1# EQ #checkexistinginfo.Year#>
					<!-----do nothing - the info already is in the database------>
				<CFELSE>
					<!----- stick the info into the database----->
					<CFQUERY Name="PutMakeModelYear" datasource="#gDSN#">
					INSERT INTO UsedVehiclesModels (Make, ModelName, Year)
					VALUES('#Form.Make#','#Form.ModelName#',#LowYear#)
					</cfquery>
				</CFIF>
			<!------regardless of whether the make & model is in the database or not, increment the year to keep trying----->
			<CFSET #LowYear#=#LowYear#+1>
			</cfloop>
		</CFLOOP>

	<CFSET #MakeMode#="false">
	<CFSET #ModelMode#="false">
	<CFSET #YearMode#="false">
	<CFSET #ConfirmMode#="false">
	<CFSET #DoneMode#="true">

<CFELSE>
	<CFQUERY NAME="getMakes" datasource="#gDSN#">
	SELECT DISTINCT Make
	FROM UsedVehiclesModels
	ORDER BY Make
	</cfquery>

	<CFSET #MakeMode#="true">
	<CFSET #ModelMode#="false">
	<CFSET #YearMode#="false">
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
	<!--- $Id: pr_modeladmin.cfm,v 1.8 1999/11/29 15:44:33 lswanson Exp $ --->

<HEAD>

<TITLE>WorldDealer | Add A Make/Model/Year</TITLE>


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
	<TD ALIGN="middle"><h3><FONT FACE="Arial,Helvetica">Dealer Administration - Enter Information</FONT></h3></TD>
</TR>

<TR ALIGN="center">
	<TD ALIGN="middle"><h4><font face="Arial,Helvetica">Choose a vehicle make</font></h4></TD>
</TR>

<TR ALIGN="center">
	<TD ALIGN="middle"><FONT FACE="Arial,Helvetica">Choose a make for the vehicle you wish to add from the list below.</FONT></TD>
</TR>

<TR><TD>&nbsp;<p></TD></TR>

<TR>
	<TD ALIGN="CENTER">
	<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0 WIDTH="100%">
	<TR><TD COLSPAN=3>&nbsp;<p></TD></TR>
	
	<TR>
	<FORM NAME="Find1" ACTION="pr_modeladmin.cfm" METHOD="post">
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
		<TD COLSPAN="3">
			<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next_nav.jpg" Border="0" NAME="btnMake" VALUE="Confirm">
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
<CFELSEIF #ModelMode# IS 'true'>
<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=420 BGCOLOR="FFFFFF">
<TR><TD>&nbsp;<p></TD></TR>
<TR ALIGN="center">
	<TD ALIGN="center"><h3><FONT FACE="Arial,Helvetica">Dealer Administration - Enter Information</FONT></h3></TD>
</TR>

<TR ALIGN="center">
	<TD ALIGN="center"><h4><font face="Arial,Helvetica">Enter a vehicle model</font></h4></TD>
</TR>

<TR ALIGN="center">
	<TD ALIGN="center"><FONT FACE="Arial,Helvetica">Enter the model of the vehicle you wish to add below.</FONT></TD>
</TR>

<TR><TD>&nbsp;<p></TD></TR>

<TR>
	<TD>
	<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0 WIDTH="100%">
	<TR><TD COLSPAN=3>&nbsp;<p></TD></TR>
	
	<FORM NAME="Find1" ACTION="pr_modeladmin.cfm" METHOD="post">

	<TR ALIGN=center>
		<TD COLSPAN=3></TD>
	</TR>

	<TR><TD COLSPAN=3>&nbsp;<p></TD></TR>

	<TR>
		<TD ALIGN="right"><b><font face="Arial,Helvetica">Model:</font></b></TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<TD><SELECT name="ModelName">
		<OPTION VALUE="" SELECTED>
		<CFOUTPUT QUERY="getModels">
		<OPTION VALUE="#ModelName#">#ModelName#
		</CFOUTPUT>
		</SELECT></TD>
<!--- 		<TD><INPUT TYPE=text NAME="ModelName" SIZE=25 MAXLENGTH=35 TABINDEX=2></TD> --->
	</TR>
	<TR><TD COLSPAN="3">&nbsp;<p></TD></TR>
	<TR>
		<TD ALIGN=CENTER COLSPAN="3">
			<A HREF="javascript:history.go(-1);"><IMG SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/back_nav.jpg" Border="0" NAME="backout" VALUE="Back"></a>
			&nbsp;&nbsp;&nbsp;
			<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next_nav.jpg" Border="0" NAME="btnModelName" VALUE="Confirm">
			<BR><A HREF="pr_modeladmin.cfm"><IMG SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg" Border="0"></a><BR><BR>
		</TD>
	</TR>
	<INPUT TYPE="Hidden" Name="ModelName_required" Value="You must enter a vehicle Model Name in the input box.">
	<INPUT TYPE="Hidden" Name="Make" Value="<CFOUTPUT>#Form.Make#</CFOUTPUT>">
	</FORM>
	</TABLE>
	</TD>
</TR>
<TR ALIGN="center">
	<TD>
	<p>
	<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
	
<!-----Third time through, choose a Year----->
<CFELSEIF #YearMode# IS 'true'>
<TABLE CELLPADDING=5 CELLSPACING=0 BORDER=0 WIDTH=420 BGCOLOR="FFFFFF">
<TR><TD>&nbsp;</TD></TR>
<TR ALIGN="center">
	<TD ALIGN="center"><h3><FONT FACE="Arial,Helvetica">Dealer Administration - Enter Information</FONT></h3></TD>
</TR>

<TR ALIGN="center">
	<TD ALIGN="center"><h4><font face="Arial,Helvetica">Choose a vehicle year or enter a range of years</font></h4></TD>
</TR>

<TR>
	<TD><FONT FACE="Arial,Helvetica">Choose a range of years for the vehicle you wish to add from the lists below.
	If you're entering only one model year, select from only the first list.</FONT></TD>
</TR>
<TR>
	<TD align="center">
		<CFOUTPUT>
		<b>Years Already Entered:</b><BR>
		<CFLOOP query="getModelYears">
			#year#<BR>
		</cfloop>
		</cfoutput>
	</TD>
</TR>
<TR>
	<TD>
	<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0 WIDTH="100%">
	<TR>
	<FORM NAME="Find1" ACTION="pr_modeladmin.cfm" METHOD="post">
		<TD ALIGN="right"><b><font face="Arial,Helvetica">Year:</font></b></TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<TD><font face="Arial,Helvetica"><SELECT name="year1">
		<OPTION VALUE="" SELECTED>
		<CFLOOP FROM="2000" TO="1950" INDEX="counter" Step="-1">
			<CFOUTPUT><OPTION VALUE="#counter#">#counter#</CFOUTPUT>
		<CFSET #counter#=#counter#-1>
		</CFLOOP>
		</SELECT></FONT></TD>
		<TD><font face="Arial,Helvetica"> through </FONT></TD>
		<TD><font face="Arial,Helvetica"><SELECT name="year2">
		<OPTION VALUE="" SELECTED>
		<CFLOOP FROM="2000" TO="1950" INDEX="counter" Step="-1">
			<CFOUTPUT><OPTION VALUE="#counter#">#counter#</CFOUTPUT>
		<CFSET #counter#=#counter#-1>
		</CFLOOP>

		</SELECT> (optional)</FONT></TD>
	</TR>
	<TR><TD COLSPAN=5>&nbsp;<p></TD></TR>
	<TR>
		<TD ALIGN=CENTER COLSPAN="5">
			<A HREF="javascript:history.go(-1);"><IMG SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/back_nav.jpg" Border="0" NAME="backout" VALUE="Back"></a>
			&nbsp;&nbsp;&nbsp;
			<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next_nav.jpg" Border="0" NAME="btnYear" VALUE="Year">
			<BR><A HREF="pr_modeladmin.cfm"><IMG SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg" Border="0"></a><BR><BR>
		</TD>
	</TR>
	<INPUT TYPE="Hidden" Name="Year1_required" Value="You must select a value in the first year list">
	<INPUT TYPE="Hidden" Name="Make" Value="<CFOUTPUT>#Form.Make#</CFOUTPUT>">
	<CFIF NOT IsDefined("Form.ModelName")>
		<INPUT TYPE="Hidden" Name="ModelName" Value="<CFOUTPUT>#Form.ModelText#</CFOUTPUT>">
	<CFELSE>
		<INPUT TYPE="Hidden" Name="ModelName" Value="<CFOUTPUT>#Form.ModelName#</CFOUTPUT>">
	</cfif>
	</FORM>
	</TABLE>
	</TD>
</TR>
<TR ALIGN="center">
	<TD>
	<p>
	<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">

<!-----Fourth time through, confirm choices----->
<CFELSEIF #ConfirmMode# IS 'true'>
	<CFIF #Form.Year2# IS "">
		<!----in this case, they only entered one year------>
		<CFSET #LowYear#=#Form.Year1#>
		<CFSET #HighYear#=#Form.Year1#>
	<CFELSE>
		<!----do some idiotproofing so it check to see which range of years they want------>
		<CFIF #Form.Year1# LTE #Form.Year2#>
			<CFSET #LowYear#=#Form.Year1#>
			<CFSET #HighYear#=#Form.Year2#>
		<CFELSEIF #Form.Year1# GT #Form.Year2#>
			<CFSET #LowYear#=#Form.Year2#>
			<CFSET #HighYear#=#Form.Year1#>
		</cfif>
	</CFIF>

<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=420 BGCOLOR="FFFFFF">
<TR><TD>&nbsp;<p></TD></TR>
<TR ALIGN="center">
	<TD ALIGN="middle"><h3><FONT FACE="Arial,Helvetica">Dealer Administration - Confirm Information</FONT></h3></TD>
</TR>

<TR ALIGN="center">
	<TD ALIGN="middle"><h4><font face="Arial,Helvetica">Confirm that the information shown below is correct:</font></h4></TD>
</TR>

<TR><TD>&nbsp;<p></TD></TR>

<TR>
	<TD>
	<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0 WIDTH="100%">
	<TR><TD COLSPAN=3>&nbsp;<p></TD></TR>
	
	<TR ALIGN=center>
		<TD ALIGN="right"><b><font face="Arial,Helvetica">Make:</FONT></B></TD><TD ALIGN="RIGHT"><font face="Arial,Helvetica"><CFOUTPUT>#Form.Make#</CFOUTPUT></FONT></td>
		<TD WIDTH="50">&nbsp;</td>
	</TR>
	<TR ALIGN=center>
		<TD ALIGN="right"><b><font face="Arial,Helvetica">Model Name:</FONT></B></TD><TD ALIGN="RIGHT"><font face="Arial,Helvetica"><CFOUTPUT>#Form.ModelName#</CFOUTPUT></FONT></td>
		<TD WIDTH="50">&nbsp;</td>
	</TR>
	
	<TR>
	<FORM NAME="Find1" ACTION="pr_modeladmin.cfm" METHOD="post">
		<TD ALIGN="right"><b><font face="Arial,Helvetica">Year:</font></b></TD>
		<TD ALIGN="right"><font face="Arial,Helvetica">
			<CFOUTPUT>#LowYear#</CFOUTPUT>
		<CFIF #Form.Year2# IS NOT "">through
			<CFOUTPUT>#HighYear#</CFOUTPUT></cfif></FONT></TD>
		<TD WIDTH="50">&nbsp;</td>
	</TR>

	<TR><TD COLSPAN=3>&nbsp;<p></TD></TR>
	<TR>
		<TD ALIGN=CENTER COLSPAN="3">
			<A HREF="javascript:history.go(-1);"><IMG SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/back_nav.jpg" Border="0" NAME="backout" VALUE="Back"></a>
			&nbsp;&nbsp;&nbsp;
			<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/save_nav.jpg" Border="0" NAME="btnConfirm" VALUE="Confirm">
			<BR><A HREF="pr_modeladmin.cfm"><IMG SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg" Border="0"></a><BR><BR>
		</TD>
	</TR>
	<INPUT TYPE="Hidden" Name="Make" Value="<CFOUTPUT>#Form.Make#</CFOUTPUT>">
	<INPUT TYPE="Hidden" Name="ModelName" Value="<CFOUTPUT>#Form.ModelName#</CFOUTPUT>">
	<INPUT TYPE="Hidden" Name="Year1" Value="<CFOUTPUT>#LowYear#</CFOUTPUT>">
	<INPUT TYPE="Hidden" Name="Year2" Value="<CFOUTPUT>#HighYear#</CFOUTPUT>">

	</FORM>
	</TABLE>
	</TD>
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
	<TD ALIGN="middle"><h3><FONT FACE="Arial,Helvetica">Dealer Administration - Make/Model/Year Information Added</FONT></h3></TD>
</TR>

<TR ALIGN="center">
	<TD ALIGN="middle"><h4><font face="Arial,Helvetica">The Make/Model/Year information below has been added:</font></h4></TD>
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
	<FORM NAME="Find1" ACTION="pr_modeladmin.cfm" METHOD="post">
		<TD ALIGN="right"><b><font face="Arial,Helvetica">Year:</font></b></TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<TD ALIGN="RIGHT"><FONT FACE="Arial,Helvetica">
			<CFOUTPUT>#Form.Year1#</CFOUTPUT>
		<CFIF #Form.Year2# NEQ #Form.Year1#>through
			<CFOUTPUT>#Form.Year2#</CFOUTPUT></CFIF></FONT></TD>
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
	<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/addnewmodel.jpg" Border="0" NAME="AddModel" VALUE="Add Model">

</cfif>

	<P>
	<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg" Border="0" NAME="BackToMain" VALUE="Back To Main Menu">
	</FORM></TD>
</TR>
</TABLE>

</div>

</BODY>
</HTML>


