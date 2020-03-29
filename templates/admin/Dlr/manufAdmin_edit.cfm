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
<!--- $Id: manufAdmin_edit.cfm,v 1.2 1999/11/24 22:54:10 lswanson Exp $ --->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>


<HEAD>
	<CFSET PageAccess = 1>
	<CFINCLUDE template="security.cfm">

	<TITLE>WorldDealer | Maintain Manufacturers</TITLE>
	<!--- so the background doesn't repeat --->
  	<link rel=stylesheet href="admin.css" type="text/css">

	<CFSET #EditMode#="false">
	<CFSET #DoneMode#="false">

	<CFIF IsDefined("Form.btnSave.X")>
		<CFSET #DoneMode#="true">
		<CFSET MakeNumber = #Form.MakeNumber#>

		<!----- update existing manuf data----->
		<CFQUERY NAME="updMake" DATASOURCE="#gDSN#">
			UPDATE 	Makes
			SET		MakeName = '#Form.MakeName#',
					WebAddr = '#Form.WebAddr#',
					ManufAdv = '#Form.ManufAdv#',
					LeasevsBuy = '#Form.LeasevsBuy#'
			WHERE	MakeNumber = #MakeNumber#
		</CFQUERY>
	<CFELSE>
		<CFSET #EditMode#="true">
		<CFSET MakeNumber = #URL.MakeNumber#>
	</cfif>

	<!--- get updated Make record --->
	<cfquery name="getMake" DATASOURCE="#gDSN#">
		SELECT 	*
		FROM	Makes
		WHERE	MakeNumber = #MakeNumber#
	</cfquery>
</HEAD>

<body>
<br><br><br><br><br>
<div align="center">

<!-----First time through, edit Manuf data ----->
<CFIF #EditMode# IS 'true'>
	<TABLE BORDER=0 CELLPADDING=5 CELLSPACING=0 WIDTH=520 BGCOLOR="FFFFFF">
	<TR ALIGN="center">
		<td>
			<h3><br>Dealer Administration - Edit Manufacturer Information</h3>
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
			<FORM NAME="StepOne" ACTION="manufAdmin_edit.cfm" METHOD="post">
			<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=5>
			<TR>
				<td>
					<b>Manufacturer:</b>
				</td>
				<td>
					<INPUT type="text" name="MakeName" size="40" maxlength="50" value="#getMake.MakeName#">
					<INPUT type="hidden" name="MakeName_required" value="Please enter a manufacturer name.">	
				</td>	
			</TR>
			<TR>
				<td>
					<b>Make Number:</b>
				</td>
				<td>
					#getMake.MakeNumber#
					<INPUT type="hidden" name="MakeNumber" value="#getMake.MakeNumber#">
				</td>	
			</TR>
			<TR>
				<td>
					<b>Web Address:</b>
				</td>
				<td>
					<INPUT type="text" name="WebAddr" size="40" maxlength="50" value="#getMake.WebAddr#">
					<INPUT type="hidden" name="WebAddr_required" value="Please enter the manufacturer's web address.">
				</td>	
			</TR>
			<TR>
				<TD valign="top">
					<b>Manufacturer's<br>Advantage:</b>
				</td>
				<td>
					<textarea name="ManufAdv" cols="40" rows="10" wrap="PHYSICAL">#getMake.ManufAdv#</textarea>
				</td>	
			</TR>
			<TR>
				<TD valign="top">
					<b>Lease vs. Buy:</b>
				</td>
				<td>
					<textarea name="LeasevsBuy" cols="40" rows="10" wrap="PHYSICAL">#getMake.LeasevsBuy#</textarea>
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
			</form>
		</td>
	</tr>
	</TABLE>

<!-----Second time through, all done----->
<CFELSEIF #DoneMode# IS 'true'>

	<TABLE BORDER=0 CELLPADDING=5 CELLSPACING=0 WIDTH=520 BGCOLOR="FFFFFF">
	<TR ALIGN="center">
		<td>
			<h3><br>Dealer Administration - Manufacturer Information Added</h3>
		</TD>
	</TR>

	<TR ALIGN="center">
		<td>
			<h4>The manufacturer information has been updated.</h4>
		</TD>
	</TR>

	<cfoutput>
	<TR>
		<TD>
			<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=5>
			<TR>
				<TD>
					<b>Manufacturer:</b>
				</TD>
				<TD>
					#getMake.MakeName#
				</TD>
			</TR>
			<TR>
				<TD>
					<b>Make Number:</b>
				</TD>
				<TD>
					#getMake.makenumber#
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

	<TR ALIGN="center">
		<TD>
			<br><br>
			<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
			<!--- Add/Modify/Delete button --->
			<INPUT TYPE="Image" 
				SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/addmodifydelete_nav.jpg" 
				NAME="Manuf" 
				VALUE="Maintain Manufacturers" 
				Border="0">
			<br><br>
			<!--- Back to Main Menu button --->
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