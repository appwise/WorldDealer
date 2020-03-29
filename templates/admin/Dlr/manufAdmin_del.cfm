<!-- ----------------------------------------------------------- -->
<!--       Created by sigma6, Detroit       -->
<!--         Copyright (c) 1997, 1998, 1999 sigma6.              -->
<!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
<!--               conceive : construct : connect                -->
<!-- ----------------------------------------------------------- -->

<!-- ----------------------------------------------------------- -->
<!--     Linda Swanson for sigma6, interactive media, Detroit    -->
<!--    lswanson@sigma6.com   www.sigma6.com    www.s6313.com    -->
<!--               conceive : construct : connect                -->
<!-- ----------------------------------------------------------- -->
<!--- $Id: manufAdmin_del.cfm,v 1.3 1999/11/29 15:44:31 lswanson Exp $ --->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>

<HEAD>
	<CFSET PageAccess = 1>
	<CFINCLUDE template="security.cfm">

	<TITLE>WorldDealer | Maintain Manufacturers</TITLE>

	<!--- so the background doesn't repeat --->
 	<link rel=stylesheet href="admin.css" type="text/css">

	<CFSET #DelMode#="false">
	<CFSET #DoneMode#="false">

	<CFIF IsDefined("Form.btnConfirm.X")>
		<CFSET #DoneMode#="true">
		<CFSET MakeNumber = #Form.MakeNumber#>
		
		<!--- delete the manuf from the database --->
		<CFQUERY NAME="delMake" DATASOURCE="#gDSN#">
			DELETE 
			FROM Makes
			WHERE MakeNumber = #MakeNumber#
		</CFQUERY>
	<CFELSE>
		<CFSET #DelMode#="true">
		<CFSET MakeNumber = #URL.MakeNumber#>

		<!--- get the make that we want to delete --->
		<cfquery name="getMake" DATASOURCE="#gDSN#">
			SELECT 	*
			FROM	Makes
			WHERE MakeNumber = #MakeNumber#
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
			<h3><br>Manufacturer Administration - Delete Manufacturer</h3>
		</TD>
	</TR>

	<TR ALIGN="center">
		<td>
			<h4>Are you sure you want to delete this manufacturer?</h4>
		</TD>
	</TR>
	
	<FORM NAME="StepOne" ACTION="manufAdmin_del.cfm" METHOD="post">
	<cfoutput>
	<tr>
		<td>
			<table border="0" cellpadding="5" cellspacing="0">
			<TR>
				<TD>
					<b>Manufacturer:</b>
				</TD>
				<TD>
					#getMake.MakeName#
					<INPUT type="hidden" name="MakeName" value="#getMake.MakeName#">
				</TD>
			</TR>
			<TR>
				<TD>
					<b>Make Number:</b>
				</TD>
				<TD>
					#getMake.MakeNumber#
					<INPUT type="hidden" name="MakeNumber" value="#getMake.MakeNumber#">
				</TD>
			</TR>
			<TR>
				<TD>
					<b>Web Address:</b>
				</TD>
				<TD>
					#getMake.WebAddr#
				</TD>
			</TR>
			<TR>
				<TD valign="top">
					<b>Manufacturer's<br>Advantage:</b>
				</TD>
				<TD>
					#getMake.ManufAdv#
				</TD>
			</TR>
			<TR>
				<TD valign="top">
					<b>Lease vs. Buy:</b>
				</TD>
				<TD>
					#getMake.LeasevsBuy#
				</TD>
			</TR>
			</table>
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

			<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
			<!--- Cancel button --->
			<INPUT TYPE="Image"
				SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/Cancel.jpg"
				NAME="Manuf"
				VALUE="Cancel"
				WIDTH="50"
				HEIGHT="20"
				Border="0">
			<br><br>
			<!--- Back to Main Menu button --->
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
			<h3><br>Manufacturer Administration - Delete Manufacturer</h3>
		</TD>
	</TR>
	<TR ALIGN="center">
		<td>
			<h4>The manufacturer, <cfoutput>#Form.MakeName#</cfoutput>, has been deleted.</h4>
		</TD>
	</TR>
	<TR ALIGN="center">
		<TD>
			<br>
			<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
			<!--- Add/Modify/Delete button --->
			<INPUT TYPE="Image" 
				SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/addmodifydelete_nav.jpg" 
				NAME="Manuf" 
				VALUE="Maintain Manufacturers" 
				WIDTH="132"
				HEIGHT="20"
				Border="0">
			<br><br>
			<!--- Back to Main Menu button --->
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