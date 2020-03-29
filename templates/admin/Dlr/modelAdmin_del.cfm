<!-- ----------------------------------------------------------- -->
<!--            Created by sigma6, Detroit                       -->
<!--         Copyright (c) 1997, 1998, 1999 sigma6.              -->
<!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
<!--               conceive : construct : connect                -->
<!-- ----------------------------------------------------------- -->

<!-- ----------------------------------------------------------- -->
<!--     Linda Swanson for sigma6, interactive media, Detroit    -->
<!--    lswanson@sigma6.com   www.sigma6.com    www.s6313.com    -->
<!--               conceive : construct : connect                -->
<!-- ----------------------------------------------------------- -->
<!--- $Id: modelAdmin_del.cfm,v 1.3 1999/11/29 15:44:32 lswanson Exp $ --->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>

<HEAD>
	<CFSET PageAccess = 1>
	<CFINCLUDE template="security.cfm">

	<TITLE>WorldDealer | Maintain Models</TITLE>

	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

	<CFSET #DelMode#="false">
	<CFSET #DoneMode#="false">

	<CFIF IsDefined("Form.btnConfirm.X")>
		<CFSET #DoneMode#="true">
		<CFSET modelID = #Form.modelID#>
		
		<!--- delete the manuf from the database --->
		<CFQUERY NAME="delModel" DATASOURCE="#gDSN#">
			DELETE 
			FROM 	Models
			WHERE 	modelID = #modelID#
		</CFQUERY>
	<CFELSE>
		<CFSET #DelMode#="true">
		<CFSET modelID = #URL.modelID#>

		<!--- get the Model that we want to delete --->
		<cfquery name="getModel" DATASOURCE="#gDSN#">
			SELECT 	*
			FROM	Models
			WHERE 	modelID = #modelID#
		</cfquery>
	</cfif>
</HEAD>


<body>
<br><br><br><br><br>
<div align="center">

<!--- First time through, display Manuf data to be deleted --->
<CFIF #DelMode# IS 'true'>
	<TABLE BORDER=0 CELLPADDING=5 CELLSPACING=0 WIDTH=520 BGCOLOR="FFFFFF">
	<TR ALIGN="center">
		<td>
			<h3><br>Model Administration - Delete Model</h3>
		</TD>
	</TR>

	<TR ALIGN="center">
		<td>
			<h4>Are you sure you want to delete this Model?</h4>
		</TD>
	</TR>
	
	<FORM NAME="StepOne" ACTION="modelAdmin_del.cfm" METHOD="post">
	<cfoutput>
	<tr>
		<td>
			<table border="0" cellpadding="5" cellspacing="0">
			<TR>
				<TD>
					<b>Model:</b>
				</TD>
				<TD>
					#getModel.Description#
					<INPUT type="hidden" name="Description" value="#getModel.Description#">
				</TD>
			</TR>
			<TR>
				<TD valign="top">
					<b>Make Number:</b>
				</TD>
				<TD>
					#getModel.make#
					<INPUT type="hidden" name="Make" value="#getModel.Make#">
				</TD>
			</TR>
			<TR>
				<TD valign="top">
					<b>Model Number:</b>
				</TD>
				<TD>
					#getModel.modelID#
					<INPUT type="hidden" name="modelID" value="#getModel.modelID#">
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
					<b>Features:</b>
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
			</TABLE>
		</td>
	</tr>
	</cfoutput>
	<TR align="center">
		<TD>
			<BR>
			<!--- Confirm button --->		
			<INPUT TYPE="Image" 
				SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/confirm_nav.jpg" 
				NAME="btnConfirm" 
				VALUE="Confirm" 
				WIDTH="66"
				HEIGHT="20"
				Border="0">
			</FORM>

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
			</FORM>
		</td>
	</tr>
	</table>
	
<!--- Second time through, all done --->
<CFELSEIF #DoneMode# IS 'true'>
	<TABLE BORDER=0 CELLPADDING=5 CELLSPACING=0 WIDTH=520 BGCOLOR="FFFFFF">
	<TR ALIGN="center">
		<td>
			<h3><br>Model Administration - Delete Model</h3>
		</TD>
	</TR>
	<TR ALIGN="center">
		<td>
			<h4>The Model, <cfoutput>#Form.Description#</cfoutput>, has been deleted.</h4>
		</TD>
	</TR>
	<TR ALIGN="center">
		<TD>
			<br>
			<!--- Add/Modify/Delete button --->
			<FORM NAME="BacktoModels" ACTION="modelAdmin.cfm?makeNumber=<cfoutput>#Form.make#</cfoutput>" METHOD="post">
			<INPUT TYPE="Image" 
				SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/addmodifydelete_nav.jpg" 
				NAME="Model" 
				VALUE="Maintain Models" 
				WIDTH="132"
				HEIGHT="20"
				Border="0">
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
			</FORM>
		</TD>
	</TR>
	</TABLE>
</cfif>

</div>
</BODY>
</HTML>