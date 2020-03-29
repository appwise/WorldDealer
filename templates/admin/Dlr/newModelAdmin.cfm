<!-- ----------------------------------------------------------- -->
<!--               Created by sigma6, Detroit                    -->
<!--         Copyright (c) 1997, 1998, 1999 sigma6.              -->
<!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
<!--               conceive : construct : connect                -->
<!-- ----------------------------------------------------------- -->

<!-- ----------------------------------------------------------- -->
<!--     Linda Swanson for sigma6, interactive media, Detroit    -->
<!--    lswanson@sigma6.com   www.sigma6.com    www.s6313.com    -->
<!--               conceive : construct : connect                -->
<!-- ----------------------------------------------------------- -->
<!--- $Id: newModelAdmin.cfm,v 1.3 1999/11/29 15:44:32 lswanson Exp $ --->


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>

<HEAD>

<CFSET PageAccess = 1>
<CFINCLUDE template="security.cfm">

<CFSET #MakeMode#="false">
<CFSET #ModelMode#="false">
<CFSET #DoneMode#="false">


<CFIF IsDefined("Form.btnMake.X")>
	<CFSET #ModelMode#="true">
	
<CFELSEIF IsDefined("Form.btnModelName.X")>
	<CFSET #DoneMode#="true">

	<CFQUERY Name="checkexistinginfo" datasource="#gDSN#">
		SELECT 	Make, Description
		FROM 	Models
		WHERE	Make = #Form.MakeNumber#
		AND		Description = '#Form.Description#'
	</cfquery>

	<!--- update existing model data --->
	<CFIF checkexistinginfo.RecordCount>
		<cfquery name="updModel" datasource="#gDSN#">
			UPDATE 	Models
			SET		ModelName = '#Form.ModelName#',
					GlamourCopy = '#Form.GlamourCopy#',
					Features = '#Form.Features#',
					VehicleType = '#Form.VehicleType#'
			WHERE	Make = #Form.MakeNumber#
			AND		Description = '#Form.Description#'
		</cfquery>
	<CFELSE>
		<!--- stick the info into the database --->
		<CFQUERY Name="PutMakeModelYear" datasource="#gDSN#">
			INSERT INTO Models (Description,
						ModelName,
						GlamourCopy,
						Features,
						VehicleType,
						Make)
			VALUES		('#Form.Description#',
						'#Form.ModelName#',
						'#Form.GlamourCopy#',
						'#Form.Features#',
						'#Form.VehicleType#',
						#Form.MakeNumber#)
		</cfquery>
	</CFIF>

	<!--- whether it's new or updated, get what's in the db now to display at end. --->
	<cfquery name="getModel" DATASOURCE="#gDSN#">
		SELECT 	*
		FROM	Models
		WHERE	Make = #Form.MakeNumber#
		AND		Description = '#Form.Description#'
	</cfquery>


<CFELSE>
	<!--- First time through, get list of Makes to choose from --->
	<CFSET #MakeMode#="true">

	<CFQUERY NAME="getMakes" datasource="#gDSN#">
	SELECT DISTINCT MakeNumber, MakeName
	FROM Makes
	ORDER BY MakeName
	</cfquery>

</cfif>


	<TITLE>WorldDealer | Add A New Model</TITLE>
	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>

<body>
<br><br><br><br><br>
<div align="center">

<!--- First time through, choose a Make --->
<CFIF #MakeMode# IS 'true'>
<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=520 BGCOLOR="FFFFFF">
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
	<FORM NAME="Find1" ACTION="newModelAdmin.cfm" METHOD="post">
		<TD ALIGN="right"><b><font face="Arial,Helvetica">Make:</font></b></TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<TD><SELECT name="MakeNumber">
		<OPTION VALUE="" SELECTED>
		<CFOUTPUT QUERY="getMakes">
		<OPTION VALUE="#MakeNumber#">#MakeName#
		</CFOUTPUT>
		</SELECT></TD>
	</TR>

	<TR><TD COLSPAN="3">&nbsp;<p></TD></TR>
	<TR ALIGN=CENTER>
		<TD COLSPAN="3">
			<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next_nav.jpg" Border="0" NAME="btnMake" VALUE="Confirm">
		</td>
	</TR>
	<INPUT TYPE="Hidden" Name="MakeNumber_required" Value="You must select a vehicle Make from the list">
	</FORM>
	</TABLE>
	</TD>
</TR>
<TR ALIGN="center">
	<TD>
	<p>
	<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
	
<!--- Second time through, enter a New Model & model info --->
<CFELSEIF #ModelMode# IS 'true'>
<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=520 BGCOLOR="FFFFFF">
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

<TR>
	<TD>
	<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=5 WIDTH="100%">
	<TR><TD COLSPAN=3>&nbsp;<p></TD></TR>
	
	<FORM NAME="Find1" ACTION="newModelAdmin.cfm" METHOD="post">

	<TR ALIGN=center>
		<TD COLSPAN=3></TD>
	</TR>

	<TR><TD COLSPAN=3>&nbsp;<p></TD></TR>

	<TR>
		<TD>
			<b>Model:</b>
		</TD>
		<td>
			<INPUT type="text" name="Description" size="35" maxlength="35">
			<INPUT type="hidden" name="Description_required" value="Please enter a model name.">	
		</td>
	</TR>
	<TR>
		<td>
			<b>Model Code:</b>
		</TD>
		<td>
			<INPUT type="text" name="ModelName" size="10" maxlength="10">
			<INPUT type="hidden" name="ModelName_required" value="Please enter a unique model abbreviation code.">
		</td>
	</TR>
	<TR>
		<td valign="top">
			<b>Glamour Copy:</b>
		</TD>
		<td>
			<textarea name="GlamourCopy" cols="40" rows="10" wrap="PHYSICAL"></textarea>
		</td>
	</TR>
	<TR>
		<td valign="top">
			<b>Features:</b>
		</TD>
		<td>
			<textarea name="Features" cols="40" rows="10" wrap="PHYSICAL"></textarea>
		</td>
	</TR>
	<TR>
		<td>
			<b>Vehicle Type:</b>
		</TD>
		<td>
			<INPUT type="text" name="VehicleType" size="1" maxlength="1">
			<INPUT type="hidden" name="VehicleType_required" value="Please enter a vehicle type: c(ar), t(ruck), v(an), s(uv).">	
		</td>
	</TR>
	
	<TR><TD COLSPAN="3">&nbsp;<p></TD></TR>
	<TR>
		<TD ALIGN=CENTER COLSPAN="3">
			<A HREF="javascript:history.go(-1);"><IMG SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/back_nav.jpg" Border="0" NAME="backout" VALUE="Back"></a>
			&nbsp;&nbsp;&nbsp;
			<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next_nav.jpg" Border="0" NAME="btnModelName" VALUE="Confirm">
			<BR><A HREF="newModelAdmin.cfm"><IMG SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg" Border="0"></a><BR><BR>
		</TD>
	</TR>
	<INPUT TYPE="Hidden" Name="ModelName_required" Value="You must enter a vehicle Model Name in the input box.">
	<INPUT TYPE="Hidden" Name="MakeNumber" Value="<CFOUTPUT>#Form.MakeNumber#</CFOUTPUT>">
	</FORM>
	</TABLE>
	</TD>
</TR>
<TR ALIGN="center">
	<TD>
	<p>
	<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
	

<!--- Third time through, all done, display info we just inserted/updated --->
<CFELSEIF #DoneMode# IS 'true'>
<TABLE BORDER=0 CELLPADDING=5 CELLSPACING=0 WIDTH=520 BGCOLOR="FFFFFF">
<TR><TD>&nbsp;<p></TD></TR>
<TR ALIGN="center">
	<TD ALIGN="middle"><h3><FONT FACE="Arial,Helvetica">Dealer Administration - New Model Information Added</FONT></h3></TD>
</TR>

<TR ALIGN="center">
	<TD ALIGN="middle"><h4><font face="Arial,Helvetica">The New Model information below has been added:</font></h4></TD>
</TR>

<TR><TD>&nbsp;<p></TD></TR>

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
		<TD>
			<b>Model Code:</b>
		</TD>
		<TD>
			#getModel.ModelName#
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
			<b>Vehicle Type:</b>
		</TD>
		<TD>
			#getModel.VehicleType#
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
	</cfoutput>

	</TABLE>
	</TD>
</TR>
<TR><TD>&nbsp;<P></TD></TR>

<TR ALIGN="center">
	<TD>
	<p>
	<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
	<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/addnewmodel.jpg" Border="0" NAME="NewModel" VALUE="Add New Model">

</cfif>

	<P>
	<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg" Border="0" NAME="BackToMain" VALUE="Back To Main Menu">
	</FORM></TD>
</TR>
</TABLE>

</div>

</BODY>
</HTML>


