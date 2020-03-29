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
<!--- $Id: manufAdmin_add.cfm,v 1.3 1999/11/29 15:44:31 lswanson Exp $ --->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>

<HEAD>

<CFSET PageAccess = 1>
<CFINCLUDE template="security.cfm">

	<TITLE>WorldDealer | Maintain Manufacturers</TITLE>
	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

	<CFSET #AddMode#="false">
	<CFSET #DoneMode#="false">

	<CFIF IsDefined("Form.btnSave.X")>
		<CFSET #DoneMode#="true">

		<CFQUERY Name="checkexistinginfo" datasource="#gDSN#">
			SELECT MakeName
			FROM Makes
			WHERE MakeName = '#Form.MakeName#'
		</cfquery>

		<!----- update existing manuf data----->
		<CFIF checkexistinginfo.RecordCount>
			<CFQUERY NAME="updMake" DATASOURCE="#gDSN#">
				UPDATE 	Makes
				SET		WebAddr = '#Form.WebAddr#',
						ManufAdv = '#Form.ManufAdv#',
						LeasevsBuy = '#Form.LeasevsBuy#'
				WHERE	MakeName = '#Form.MakeName#'
			</CFQUERY>
		<CFELSE>
			<!----- put the manuf into the database----->
			<!--- Manually increment the MakeNumber --->
			<CFQUERY NAME="findMaxMakeNum" DATASOURCE="#gDSN#">
				SELECT MAX(MakeNumber) as MaxNum
				FROM Makes
			</CFQUERY>

			<CFQUERY NAME="insertMake" DATASOURCE="#gDSN#">
				INSERT INTO Makes (MakeNumber,
							MakeName,
							WebAddr,
							ManufAdv,
							LeasevsBuy)
					VALUES (#findMaxMakeNum.MaxNum# +1,
							'#Form.MakeName#',
							'#Form.WebAddr#',
							'#Form.ManufAdv#',
							'#Form.LeasevsBuy#')
			</CFQUERY>
		</CFIF>	

		<!--- get Make info to display at end. --->
		<cfquery name="getMake" DATASOURCE="#gDSN#">
			SELECT 	*
			FROM	Makes
			WHERE	MakeName = '#Form.MakeName#'
		</cfquery>

	<CFELSE>
		<CFSET #AddMode#="true">
	</cfif>
</HEAD>


<body>
<br><br><br><br><br>
<div align="center">

<!-----First time through, enter Manuf data ----->
<CFIF #AddMode# IS 'true'>
<TABLE BORDER=0 CELLPADDING=5 CELLSPACING=0 WIDTH=520 BGCOLOR="FFFFFF">
<TR ALIGN="center">
	<td>
		<h3><br>Manufacturer Administration - Enter Information</h3>
	</TD>
</TR>

<TR ALIGN="center">
	<td>
		<h4>Enter a New Manufacturer</h4>
	</TD>
</TR>
<tr>
	<td>
		<FORM NAME="StepOne" ACTION="manufAdmin_add.cfm" METHOD="post">
		<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=5 WIDTH="100%">
		<TR>
			<td>
				<b>Manufacturer:</b>
			</td>
			<td>
				<INPUT type="text" name="MakeName" size="40" maxlength="50">
				<INPUT type="hidden" name="MakeName_required" value="Please enter a manufacturer name.">	
			</td>	
		</TR>
		<TR>
			<td>
				<b>Web Address:</b>
			</td>
			<td>
				<INPUT type="text" name="WebAddr" size="40" maxlength="50"<!---  value="www." --->>
				<INPUT type="hidden" name="WebAddr_required" value="Please enter the manufacturer's web address.">
			</td>	
		</TR>
		<TR>
			<TD valign="top">
				<b>Manufacturer's<br>Advantage:</b>
			</td>
			<td>
				<textarea name="ManufAdv" cols="40" rows="20" wrap="PHYSICAL"></textarea>
			</td>	
		</TR>
		<TR>
			<TD valign="top">
				<b>Lease vs. Buy:</b>
			</td>
			<td>
				<textarea name="LeasevsBuy" cols="40" rows="20" wrap="PHYSICAL"></textarea>
			</td>	
		</TR>

		<!--- Next button --->		
		<TR align="center">
			<TD colspan="2">
				<BR>
				<INPUT TYPE="Image" 
				SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/Save_nav.jpg" 
				NAME="btnSave" 
				VALUE="Save" 
				Border="0">
			</td>
		</TR>
		</FORM>
		</table>
	</td>
</tr>

<TR ALIGN="center">
	<TD>
		<p>
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
			Border="0">

		</FORM>
	</TD>
</TR>
</TABLE>
	
<!-----Second time through, all done----->
<CFELSEIF #DoneMode# IS 'true'>

<TABLE BORDER=0 CELLPADDING=5 CELLSPACING=0 WIDTH=520 BGCOLOR="FFFFFF">
<TR ALIGN="center">
	<td colspan="2">
		<h3><br>Dealer Administration - Manufacturer Information Added</h3>
	</TD>
</TR>

<TR ALIGN="center">
	<td colspan="2">
		<h4>The manufacturer information has been added.</h4>
	</TD>
</TR>

<cfoutput>
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
</cfoutput>

<TR ALIGN="center">
	<TD colspan="2">
		<br><br>
		<!--- Add/Modify/Delete button --->
		<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
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