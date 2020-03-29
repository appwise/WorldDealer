<!-- ----------------------------------------------------------- -->
<!--             Created by sigma6, Detroit                      -->
<!--         Copyright (c) 1997, 1998, 1999 sigma6.              -->
<!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
<!--               conceive : construct : connect                -->
<!-- ----------------------------------------------------------- -->

<!-- ----------------------------------------------------------- -->
<!--     Linda Swanson for sigma6, interactive media, Detroit    -->
<!--    lswanson@sigma6.com   www.sigma6.com    www.s6313.com    -->
<!--               conceive : construct : connect                -->
<!-- ----------------------------------------------------------- -->
<!--- $Id: manufAdmin.cfm,v 1.3 1999/11/24 22:54:09 lswanson Exp $ --->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<CFIF ParameterExists(Form.Continue.X)>
	<CFLOCATION URL="modelAdmin.cfm?MakeNumber=#form.MakeNumber#">
</CFIF>
<CFIF ParameterExists(Form.AddManufacturer.X)>
	<CFLOCATION URL="manufAdmin_add.cfm">
</CFIF>
<CFIF ParameterExists(Form.ModifyManufacturer.X)>
	<CFLOCATION URL="manufAdmin_edit.cfm?MakeNumber=#form.MakeNumber#">
</CFIF>
<CFIF ParameterExists(Form.DeleteManufacturer.X)>
	<CFLOCATION URL="manufAdmin_del.cfm?MakeNumber=#form.MakeNumber#">
</CFIF>

<HTML>


<HEAD>
	<CFSET PageAccess = 1>
	<CFINCLUDE template="security.cfm">

	<TITLE>WorldDealer | Maintain Makes and Models</TITLE>
	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

	<CFQUERY NAME="getMakes" Datasource="#gDSN#">
		SELECT DISTINCT MakeNumber, MakeName
		FROM Makes
		ORDER BY MakeName
	</cfquery>
</HEAD>


<body>
<br><br><br><br><br>
<div align="center">

<TABLE BORDER=0 CELLPADDING=5 CELLSPACING=0 WIDTH=410 BGCOLOR="FFFFFF">
<TR ALIGN="center">
	<td>
		<h3><br>Maintain List of Manufacturers</h3>
		<h4>Select a manufacturer from the list or click "New" to add a new manufacturer.<br><br></h4>
	</TD>
</TR>
<!--- list of existing makes --->
<TR>
	<TD ALIGN="CENTER">
		<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=5>
		<FORM NAME="FindMake" ACTION="ManufAdmin.cfm" METHOD="post">
		<TR>
			<TD>
				<b>Make:</b>
			</TD>
			<TD>
				<SELECT name="MakeNumber">
				<OPTION VALUE="" SELECTED>
				<CFOUTPUT QUERY="getMakes">
				<OPTION VALUE="#MakeNumber#">#MakeName#
				</CFOUTPUT>
				</SELECT>
			</TD>
			<td>
				<!--- Continue button takes you to model drop-down page --->
				<INPUT TYPE="Image" 
					SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/continue_nav.jpg" 
					NAME="Continue" 
					VALUE="Continue"
					Border="0">
			</td>
		</TR>
		<tr>
			<td colspan="3" align="center">
				<br>
				<!--- Modify button: edit existing make --->
				<INPUT TYPE="image" 
					SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/modify_nav.jpg" 
					NAME="ModifyManufacturer" 
					VALUE="Modify Manufacturer" 
					BORDER="0">
				&nbsp;&nbsp;
				<!--- Delete a make --->
				<input type="image" 
					SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/delete.gif" 
					name="DeleteManufacturer" 
					value="Delete Manufacturer" 
					BORDER="0">
			</td>
		</tr>
		<INPUT TYPE="Hidden" Name="MakeNumber_required" Value="You must select a Manufacturer from the list.">
		</form>
		</TABLE>
	</td>
</tr>
<!--- New button: add a new make --->
<tr align="center">
	<TD>
		<br>
		<form name="addmanuf" action="manufAdmin_add.cfm" method="post">
		<input type="image" 
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/new.jpg" 
			name="AddManufacturer" 
			value="Add Manufacturer" 
			border="0">
		</form>
	</td>
</tr>
<!--- Back to Main Menu button --->
<tr align="center">
	<td>
		<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
		<INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg"
			NAME="BackToMain"
			VALUE="Back To Main Menu"
			Border="0">
		</form>
	</TD>
</TR>
</table>

</div>
</BODY>
</HTML>