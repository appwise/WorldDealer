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
<!--- $Id: modelAdmin_edit.cfm,v 1.3 1999/11/29 15:44:32 lswanson Exp $ --->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>

<HEAD>
	<CFSET PageAccess = 1>
	<CFINCLUDE template="security.cfm">

	<TITLE>WorldDealer | Maintain Models</TITLE>
	<!--- so the background doesn't repeat --->
  	<link rel=stylesheet href="admin.css" type="text/css">

	<CFSET #EditMode#="false">
	<CFSET #DoneMode#="false">

	<CFIF IsDefined("Form.btnSave.X")>
		<CFSET #DoneMode#="true">
		<CFSET modelID = #Form.modelID#>

		<!----- update existing model data----->
		<cfquery name="updModel" datasource="#gDSN#">
			UPDATE 	Models
			SET		Description = '#Form.Description#',
					ModelName = '#Form.ModelName#',
					GlamourCopy = '#Form.GlamourCopy#',
					Features = '#Form.Features#',
					VehicleType = '#Form.VehicleType#',
					Make = #Form.Make#,
					Year = '#Form.Year#'
			WHERE	ModelID = #Form.ModelID#
		</cfquery>
	<CFELSE>
		<CFSET #EditMode#="true">
		<CFSET modelID = #URL.modelID#>
	</cfif>

	<!--- get what's in the db now --->
	<cfquery name="getModel" DATASOURCE="#gDSN#">
		SELECT 	*
		FROM	Models
		WHERE	modelID = #modelID#
	</cfquery>
</HEAD>

<body>
<br><br><br><br><br>
<div align="center">

<!-----First time through, edit model data ----->
<CFIF #EditMode# IS 'true'>
<TABLE BORDER=0 CELLPADDING=5 CELLSPACING=0 BGCOLOR="FFFFFF">
<TR ALIGN="center">
	<td>
		<h3><br>Model Administration - Edit Model Information</h3>
	</TD>
</TR>
<!--- 
<TR ALIGN="center">
	<td><h4></h4></TD>
</TR>
 --->
<cfoutput>
<tr>
	<td>
		<FORM NAME="StepOne" ACTION="modelAdmin_edit.cfm" METHOD="post">
		<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=5 WIDTH="100%">
		<TR>
			<TD>
				<b>Model:</b>
			</TD>
			<td>
				<INPUT type="text" name="Description" size="35" maxlength="35" value="#getModel.Description#">
				<INPUT type="hidden" name="Description_required" value="Please enter a model name.">	
			</td>
		</TR>
		<TR>
			<TD>
				<b>Make Number:</b>
			</TD>
			<td>
				#getModel.Make#
				<INPUT type="hidden" name="make" value="#getModel.make#">	
			</td>
		</TR>
		<TR>
			<td>
				<b>Model Number:</b>
			</td>
			<td>
				#getModel.modelID#
				<INPUT type="hidden" name="modelID" value="#getModel.modelID#">
			</td>	
		</TR>
		<TR>
			<td>
				<b>Model Code:</b>
			</TD>
			<td>
				<INPUT type="text" name="ModelName" size="35" maxlength="10" value="#getModel.ModelName#">
				<INPUT type="hidden" name="ModelName_required" value="Please enter a unique model abbreviation code.">
			</td>
		</TR>
		<TR>
			<td>
				<b>Vehicle Type:</b>
			</TD>
			<td>
				<SELECT name="VehicleType">
				<OPTION VALUE=""<CFIF #getModel.VehicleType# IS ""> SELECTED</cfif>>Please Select
				<OPTION VALUE="c"<CFIF #getModel.VehicleType# IS "c"> SELECTED</cfif>>Car
				<OPTION VALUE="s"<CFIF #getModel.VehicleType# IS "s"> SELECTED</cfif>>Sports Utility Vehicle
				<OPTION VALUE="t"<CFIF #getModel.VehicleType# IS "t"> SELECTED</cfif>>Truck
				<OPTION VALUE="v"<CFIF #getModel.VehicleType# IS "v"> SELECTED</cfif>>Van
				</SELECT>
				<INPUT type="hidden" name="VehicleType_required" value="Please select a vehicle type.">
			</td>
		</TR>
		<TR>
			<td valign="top">
				<b>Glamour Copy:</b>
			</TD>
			<td>
				<textarea name="GlamourCopy" cols="35" rows="10" wrap="PHYSICAL">#getModel.GlamourCopy#</textarea>
			</td>
		</TR>
		<TR>
			<td valign="top">
				<b>Features:</b>
			</TD>
			<td>
				<textarea name="Features" cols="35" rows="10" wrap="PHYSICAL">#getModel.Features#</textarea>
			</td>
		</TR>
		<TR>
			<td>
				<b>Year of Copy:</b>
			</TD>
			<td>
				<INPUT type="text" name="Year" size="35" maxlength="4" value="#getModel.Year#">
				<INPUT type="hidden" name="Year_required" value="Please enter the year that the Glamour Copy and Features apply to.">
			</td>
		</TR>
		<!--- Save button --->		
		<TR align="center">
			<TD colspan="2">
				<BR>
				<INPUT TYPE="Image" 
					SRC="#application.RELATIVE_PATH#/images/admin/save_nav.jpg" 
					NAME="btnSave" 
					VALUE="Save"
					WIDTH="40"
					HEIGHT="20"
					Border="0">
			</td>
		</TR>
		</table>
		</FORM>
	</td>
</tr>
</cfoutput>
<tr align="center">
	<td>
		<!--- Cancel button --->
		<FORM ACTION="modelAdmin.cfm?makeNumber=<cfoutput>#getModel.make#</cfoutput>" METHOD="POST">
		<INPUT TYPE="image" 
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg" 
			NAME="Cancel" 
			VALUE="Cancel" 
			WIDTH="50"
			HEIGHT="20"
			BORDER="0">
		</FORM>
	
		<!--- Back to Main Menu button --->			
		<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
		<INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg"
			NAME="BackToMain"
			VALUE="Back To Main Menu"
			WIDTH="121"
			HEIGHT="20"
			Border="0">
		</form>
	</td>
</tr>
</TABLE>

<!-----Second time through, all done----->
<CFELSEIF #DoneMode# IS 'true'>

<TABLE BORDER=0 CELLPADDING=5 CELLSPACING=0 WIDTH=520 BGCOLOR="FFFFFF">
<TR ALIGN="center">
	<td>
		<h3><br>Model Administration - Edit Model Information</h3>
	</TD>
</TR>

<TR ALIGN="center">
	<td><h4>The model information has been updated.</h4></TD>
</TR>

<TR>
	<TD>
	<TABLE CELLSPACING=0 CELLPADDING=5 BORDER=0 WIDTH="100%">
	<cfoutput>
	<TR>
		<TD>
			<b>Model:</b>
		</TD>
		<TD>
			#getModel.Description#
		</TD>
	</TR>
	<TR>
		<TD valign="top">
			<b>Make Number:</b>
		</TD>
		<TD>
			#getModel.make#
		</TD>
	</TR>
	<TR>
		<TD valign="top">
			<b>Model Number:</b>
		</TD>
		<TD>
			#getModel.modelID#
		</TD>
	</TR>
	<TR>
		<TD>
			<b>Model Code:</b>
		</TD>
		<TD>
			#getModel.ModelName#
		</TD>
	</TR>
	<TR>
		<TD valign="top">
			<b>Vehicle Type:</b>
		</TD>
		<TD>
			#getModel.VehicleType#
		</TD>
	</TR>
	<TR>
		<TD valign="top">
			<b>Glamour Copy:</b>
		</TD>
		<TD>
			#getModel.GlamourCopy#
		</TD>
	</TR>
	<TR>
		<TD valign="top">
			<b>Features Copy:</b>
		</TD>
		<TD>
			#getModel.Features#
		</TD>
	</TR>
	<TR>
		<TD valign="top">
			<b>Year of Copy:</b>
		</TD>
		<TD>
			#getModel.year#
		</TD>
	</TR>
	</cfoutput>

	</TABLE>
	</TD>
</TR>

<TR ALIGN="center">
	<TD>
		<br><br>
		<!--- Add/Modify/Delete button --->
		<FORM NAME="f_Back" ACTION="modelAdmin.cfm?makeNumber=<cfoutput>#getModel.make#</cfoutput>" METHOD="post">
		<INPUT TYPE="Image" 
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/addmodifydelete_nav.jpg" 
			NAME="Model" 
			VALUE="Maintain Models" 
			WIDTH="132"
			HEIGHT="20"
			Border="0">
		</FORM>
		<br><br>
		<!--- Back to Main Menu button --->
		<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
		<INPUT TYPE="Image" 
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg" 
			NAME="BackToMain" 
			VALUE="Back To Main Menu" 
			Border="0">
		</FORM>
	</TD>
</TR>
</TABLE>
</cfif>

</div>
</BODY>
</HTML>