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
<!--- $Id: offermakes.cfm,v 1.5 1999/12/29 15:43:43 lswanson Exp $ --->
<!--- Select Make & Region for Offers --->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>


<HEAD>
	<CFSET PageAccess = 1>
	<CFINCLUDE template="security.cfm">

	<TITLE>WorldDealer | Maintain National and Regional Offers</TITLE>
	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

	<CFIF ParameterExists(Form.Continue.X)>
		<CFLOCATION URL="nationaloffers.cfm?MakeNumber=#form.MakeNumber#&RegionID=#form.RegionID#">
	</CFIF>
	<CFIF ParameterExists(Form.AddRegion.X)>
		<CFLOCATION URL="offerRegions_add.cfm">
	</CFIF>
	<CFIF ParameterExists(Form.ModifyRegion.X)>
		<CFLOCATION URL="offerRegions_edit.cfm?RegionID=#form.RegionID#">
	</CFIF>
	<CFIF ParameterExists(Form.DeleteRegion.X)>
		<CFLOCATION URL="offerRegions_del.cfm?RegionID=#form.RegionID#">
	</CFIF>
	
	<CFQUERY NAME="getMakes" Datasource="#gDSN#">
		SELECT DISTINCT MakeNumber, MakeName
		FROM Makes
		ORDER BY MakeName
	</cfquery>

	<cfif IsDefined("URL.MakeNumber")>
		<cfquery name="getRegions" datasource="#gDSN#">
			SELECT	RegionID,
					RegionName
			FROM	MakeRegions
			WHERE	MakeNumber = #URL.MakeNumber#
			ORDER BY RegionName
		</cfquery>
	</cfif>

	<!--- a little script that goes with the onChange attribute of selected Make in drop-down.--->	
	<SCRIPT LANGUAGE="JavaScript">
	<!--  
	function onMakeChange()
		{
		with(document.forms[0].elements[0])
			selectedMake = options[selectedIndex].value
		
		if (selectedMake > 0)
			location.href = 'offerMakes.cfm?MakeNumber=' + selectedMake;
		else
			// this sets it back to the default.
			location.href = 'offerMakes.cfm';
		}
	//-->
	</SCRIPT> 
	
	
</HEAD>


<body>
<br><br><br><br><br>
<div align="center">

<TABLE BORDER=0 CELLPADDING=5 CELLSPACING=0 WIDTH=410 BGCOLOR="FFFFFF">
<TR ALIGN="center">
	<td>
		<h3><br>Maintain National and Regional Offers</h3>
		<h4>Select a manufacturer from the list.<br><br></h4>
	</TD>
</TR>
<!--- list of existing makes --->
<TR>
	<TD ALIGN="CENTER">
		<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=5>
		<FORM NAME="FindMake" ACTION="offerMakes.cfm" METHOD="post">
		<TR>
			<TD>
				<b>Make:</b>
			</TD>
			<TD><!--- relate(this.selectedIndex); --->
				<SELECT NAME="MakeNumber" onChange="onMakeChange()">
				<OPTION VALUE="0">Select a Make
				<CFOUTPUT QUERY="getMakes">
					<OPTION VALUE="#MakeNumber#"<CFIF IsDefined("URL.MakeNumber")><cfif URL.MakeNumber EQ #MakeNumber#>SELECTED</cfif></cfif>>#MakeName#
				</CFOUTPUT>
				</SELECT>				
			</TD>
		</TR>
		<TR>
			<TD>
				<b>Region:</b>
			</TD>
			<TD>
				<SELECT name="RegionID">
				<cfif IsDefined("URL.MakeNumber")>
					<OPTION VALUE="0" SELECTED>National
					<CFOUTPUT QUERY="getRegions">
						<OPTION VALUE="#RegionID#">#RegionName#
					</CFOUTPUT>
				<cfelse>
					<OPTION VALUE="0" SELECTED>Choose a Make first
				</cfif>
				</SELECT>
			</TD>

			<td>
				<!--- Continue button takes you to Offers page --->
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
				<!--- Modify button: edit existing region --->
				<INPUT TYPE="image" 
					SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/modify_nav.jpg" 
					NAME="ModifyRegion" 
					VALUE="Modify Region" 
					BORDER="0">
				&nbsp;&nbsp;
				<!--- Delete a Region --->
				<input type="image" 
					SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/delete.gif" 
					name="DeleteRegion" 
					value="Delete Region" 
					BORDER="0">
			</td>
		</tr>
		<INPUT TYPE="Hidden" Name="MakeNumber_required" Value="You must select a Manufacturer from the list.">
		</form>
		</TABLE>
	</td>
</tr>
<!--- New button: add a new region --->
<tr align="center">
	<TD>
		<br>
		<form name="addmanuf" action="offerRegions_add.cfm" method="post">
		<input type="image" 
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/new.jpg" 
			name="AddRegion" 
			value="Add Region" 
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