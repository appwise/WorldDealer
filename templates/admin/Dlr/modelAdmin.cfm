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
<!--- $Id: modelAdmin.cfm,v 1.2 1999/11/24 22:54:10 lswanson Exp $ --->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<CFIF ParameterExists(Form.ModifyModel.X)>
	<CFLOCATION URL="modelAdmin_edit.cfm?ModelID=#form.ModelID#">
</CFIF>
<CFIF ParameterExists(Form.DeleteModel.X)>
	<CFLOCATION URL="modelAdmin_del.cfm?ModelID=#form.ModelID#">
</CFIF>

<HTML>


<HEAD>
	<CFSET PageAccess = 1>
	<CFINCLUDE template="security.cfm">

	<TITLE>WorldDealer | Maintain Models</TITLE>
	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

	<CFQUERY NAME="getModels" Datasource="#gDSN#">
		SELECT *
		FROM Models
		WHERE Make = #URL.MakeNumber#
		ORDER BY Description
	</cfquery>
	
	<CFQUERY name="getMake" datasource="#gDSN#">
		SELECT 	MakeName
		FROM	Makes
		WHERE	MakeNumber = #URL.MakeNumber#
	</cfquery>
</HEAD>


<body>
<br><br><br><br><br>
<div align="center">

<TABLE BORDER=0 CELLPADDING=5 CELLSPACING=0 WIDTH=410 BGCOLOR="FFFFFF">
<TR ALIGN="center">
	<td>
		<h3><br>Maintain List of Models</h3>
		<h4>Select a Model from the list to Modify or Delete. <br>
			Select "New" to add a new Model.<br><br></h4>
	</TD>
</TR>
<!--- list of existing models --->
<TR>
	<TD ALIGN="CENTER">
		<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=5 WIDTH="70%">
		<FORM NAME="FindModels" ACTION="modelAdmin.cfm" METHOD="post">
		<TR>
			<TD>
				<b>Make:</b>
			</TD>
			<TD>
				<cfoutput><b>#getMake.MakeName#</b></cfoutput>
			</TD>
		</TR>
		<TR>
			<TD>
				<b>Model:</b>
			</TD>
			<TD>
				<SELECT name="ModelID">
				<OPTION VALUE="" SELECTED>
				<CFOUTPUT QUERY="getModels">
				<OPTION VALUE="#ModelID#">#Description#
				</CFOUTPUT>
				</SELECT>
			</TD>
		</TR>
		<tr>
			<td colspan="2" align="center">
				<br>
				<!--- Modify button: edit existing model --->
				<INPUT TYPE="image" 
					SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/modify_nav.jpg" 
					NAME="ModifyModel" 
					VALUE="Modify Model" 
					BORDER="0">
				&nbsp;&nbsp;
				<!--- Delete a model --->
				<input type="image" 
					SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/delete.gif" 
					name="DeleteModel" 
					value="Delete Model" 
					BORDER="0">
			</td>
		</tr>
		<INPUT TYPE="Hidden" Name="ModelID_required" Value="You must select a Model from the list.">
		</form>
		</TABLE>
	</td>
</tr>
<!--- New button: add a new model --->
<tr align="center">
	<TD>
		<br>
		<form name="addmodel" action="modelAdmin_add.cfm?MakeNumber=<cfoutput>#URL.makeNumber#</cfoutput>" method="post">
		<input type="image" 
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/new.jpg"" 
			name="AddModel" 
			value="Add Model" 
			border="0">
		</form>
	</td>
</tr>
<!--- New Search button: go back to Make screen --->
<tr align="center">
	<td>
		<FORM NAME="editMake" ACTION="redirect.cfm" METHOD="post">
		<INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/newsearch.jpg"
			NAME="Manuf"
			VALUE="Choose Another Make"
			Border="0">
		</form>
	</TD>
</TR>
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