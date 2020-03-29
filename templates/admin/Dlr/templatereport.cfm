<CFSET PageAccess = 1>
<CFINCLUDE template="security.cfm">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>

    <!-- ----------------------------------------------------------- -->
    <!--               Created by sigma6, Detroit                    -->
    <!--         Copyright (c) 1997, 1998, 1999 sigma6.              -->
    <!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->

    <!-- ----------------------------------------------------------- -->
    <!--    Howard Levine for sigma6, interactive media, Detroit     -->
    <!--    hlevine@sigma6.com   www.sigma6.com    www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
	<!--- $Id: templatereport.cfm,v 1.8 1999/11/29 15:44:33 lswanson Exp $ --->
	
<!--- Linda, 5/11/99: FIX ME (ArtTempID -> TemplateLocation) when the reports are overhauled. --->

<HEAD>

        <TITLE>WorldDealer | Template Reporting</TITLE>

	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>


<CFIF IsDefined("URL.DlrCode")>
	<CFSET g_dealercode = #URL.dlrcode#>
<CFELSEIF IsDefined("Form.Dealercode")>
	<CFSET g_dealercode = #form.dealercode#>
</CFIF>

<CFIF (IsDefined ("Form.BtnNext.X")) OR (IsDefined("Form.Current")) OR (IsDefined("URL.jump"))>
	<CFSET DisplayMode = TRUE>
	<CFSET ChooseMode = FALSE>
	<CFSET AllMode = FALSE>
<CFELSE>
	<CFSET DisplayMode = FALSE>
	<CFSET ChooseMode = TRUE>
	<CFSET AllMode = FALSE>
</CFIF>

<CFIF DisplayMode>
	<CFIF IsDefined("Form.Group")>
		<CFIF Form.Group EQ 'All'>
			<CFSET DisplayMode = FALSE>
			<CFSET ChooseMode = FALSE>
			<CFSET AllMode = TRUE>
		</CFIF>
	</CFIF>
</CFIF>

<CFQUERY name="countTheTemplates" datasource="#gDSN#">
	SELECT ArtTempID,
			Description
	FROM ArtTemplates
</CFQUERY>


<CFIF ChooseMode>

	<CFQUERY name="GetTemplates" datasource="#gDSN#">
	SELECT 	ArtTempID,
			TemplateLocation,
			Description
	FROM ArtTemplates
	</CFQUERY>
	
	<CFLOOP FROM=1 TO=#countTheTemplates.recordcount# INDEX="count">
	
		<CFQUERY name="getTemplateStats_#count#" datasource="#gDSN#">
			SELECT DealerWebs.DealerCode as q_DealerCode,
				DealerWebs.ArtTempID as q_ArtTempID,
				DealerWebs.WebStateID as WebStateID,
				WebStates.Description as q_WebState,
				Dealers.DealershipName as q_DealershipName,
				Dealers.DMGID as q_DMGID,
				DMGAdmin.DMG as q_DMGName,
				DMGAdmin.DMGCode as q_DMGCode,
				ArtTemplates.Description as q_ArtTemplate
			FROM Dealers,
				 DealerWebs,
				 ArtTemplates,
				 WebStates,
				 DMGAdmin
			WHERE DealerWebs.WebstateID = WebStates.WebStateID AND
				 Dealers.DMGID = DMGAdmin.ID AND
				 Dealerwebs.DealerCode = Dealers.DealerCode AND
				 DealerWebs.ArtTempID = #count# AND
				 DealerWebs.ArtTempID = ArtTemplates.TemplateLocation
			ORDER BY DealerWebs.WebStateID, Dealers.DealershipName;
		</CFQUERY>
	
		<CFQUERY name="CountTemplateStats_#count#" datasource="#gDSN#">
		SELECT COUNT(ArtTempID) as q_ArtTempID
		FROM DealerWebs
		WHERE ArtTempID = #count#
		</CFQUERY>
	
	</CFLOOP>
	
	<CFQUERY name="GetAllDlrTemplates" datasource="#gDSN#">
		SELECT COUNT (ArtTempID) AS q_Total
		FROM DealerWebs
	</CFQUERY>

	<CFLOOP FROM=1 TO=#countTheTemplates.recordcount# INDEX="count">
		<CFQUERY name="getDMGTemplateStats_#count#" datasource="#gDSN#">
			SELECT DealerMarketingGroups.ArtTempID as q_ArtTempID,
				   ArtTemplates.Description as q_ArtTemplate,
				   DealerMarketingGroups.Description as q_DMGName,
				   DealerMarketingGroups.Name as q_DMGCode,
				   DealerMarketingGroups.WebStateID, 
				   Webstates.Description as q_Webstate
			FROM DealerMarketingGroups,
				 ArtTemplates,
				 WebStates
			WHERE DealerMarketingGroups.ArtTempID = #count# AND
				  DealerMarketingGroups.ArtTempID = ArtTemplates.ArtTempID AND
				  DealerMarketingGroups.WebStateID = WebStates.WebStateID
			ORDER BY DealerMarketingGroups.WebStateID, DealerMarketingGroups.Description;
		</CFQUERY>
	
		<CFQUERY name="CountDMGTemplateStats_#count#" datasource="#gDSN#">
		SELECT COUNT(ArtTempID) as q_ArtTempID
		FROM DealerMarketingGroups
		WHERE ArtTempID = #count#
		</CFQUERY>
	</CFLOOP>	

	<CFQUERY name="GetAllDMGTemplates" datasource="#gDSN#">
	SELECT COUNT (ArtTempID) AS q_Total
	FROM DealerMarketingGroups
	</CFQUERY>
		
	<CFQUERY name="GetTemplateNames" datasource="#gDSN#">
		SELECT ArtTemplates.Description
		FROM ArtTemplates
	</CFQUERY>

	<CFSET ArtTempArray = ArrayNew(1)>
	<CFSET counter=1>
	<CFLOOP query="getTemplateNames">
		<CFSET #ArtTempArray[counter]# = #Description#>
		<CFSET counter=counter+1>
	</CFLOOP>

	<body>
<br><br><br><br><br>

	<div align="center">
	<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=400 BGCOLOR="FFFFFF">
	<TR><TD>&nbsp;<p></TD></TR>
	<TR ALIGN="center">
		<TD ALIGN="middle"><h3><FONT FACE="Arial,Helvetica">
		Dealer/DMG Administration<br>Art Template Reporting</FONT></h3></TD>
	</TR>
	<TR><TD>&nbsp;</td></tr>
	<TR align="center"><TD>
		<TABLE BORDER=1 CELLSPACING=1 CELLPADDING=1 bgcolor="FFFFFF">
		<TR align="center">
  			<TD><FONT FACE="arial,Helvetica"><b>Art Template</b></FONT></TD>
			<TD><FONT FACE="Arial,Helvetica"><b>Dealer Sites</b></FONT></TD>
			<TD><FONT FACE="Arial,Helvetica"><b><b>DMG Sites</b></FONT></TD>	
			<TD><FONT FACE="Arial,Helvetica"><b>Total:</b></FONT></TD>
		</TR>

	 	<CFLOOP FROM=1 TO=#countTheTemplates.recordcount# INDEX="count3">
			 <TR ALIGN="Center">
 				<TD><FONT FACE="Arial,Helvetica"><CFOUTPUT>&nbsp;&nbsp;#ArtTempArray[count3]#&nbsp;&nbsp;</CFOUTPUT></FONT></TD>
				<TD><FONT FACE="Arial,Helvetica"><CFOUTPUT query="CountTemplateStats_#count3#">#q_ArtTempID#</CFOUTPUT></FONT></TD>
				<TD><FONT FACE="Arial,Helvetica"><CFOUTPUT query="CountDMGTemplateStats_#count3#">#q_ArtTempID#</CFOUTPUT></FONT></TD>
				<CFSET temp2 = "countTemplateStats_#count3#.q_ArtTempID">
				<CFSET total=#Evaluate(temp2)#>
				<TD><FONT FACE="Arial,Helvetica"><CFOUTPUT>#total#</CFOUTPUT></FONT></TD>
			</TR>
		</CFLOOP>
		<TR ALIGN="center">
			<TD><FONT FACE="Arial,Helvetica"><b>Total:</b></FONT></TD>
			<TD><FONT FACE="Arial,Helvetica"><CFOUTPUT><b>#GetAllDLRTemplates.q_Total#</b></CFOUTPUT></FONT></TD>
			<TD><FONT FACE="Arial,Helvetica"><CFOUTPUT><b>#GetAllDMGTemplates.q_Total#</b></CFOUTPUT></FONT></TD>
			<TD><FONT FACE="Arial,Helvetica"><CFOUTPUT><b>#Evaluate(GetAllDLRTemplates.q_Total + GetAllDMGTemplates.q_Total)#</b></CFOUTPUT></FONT></TD>
		</TR>
		</TABLE>
	</TD></TR>
	<TR><TD>&nbsp;</TD></TR>
	<TR ALIGN="center">
		<TD ALIGN="middle"><h4><font face="Arial,Helvetica">Choose a criterion:</font></h4></TD>
	</TR>
	<TR align="center"><TD>
		<TABLE BORDER=0 BGCOLOR="FFFFFF">
		 <FORM action="templatereport.cfm" method="post">
		 <TR>
		 	<TD align="left"><FONT FACE="Arial,Helvetica">Show a report of all </FONT></TD>
		 	<TD align="left"><FONT FACE="Arial,Helvetica">
				<SELECT name="mode">
				<OPTION value="both">
				<OPTION value="dealer">Dealers
				<OPTION value="DMG">DMG's
				<OPTION value="both">Both Dealers and DMG's
				</SELECT></FONT>
			</TD>
		</TR>
		<TR>
			<TD align="left"><FONT FACE="Arial,Helvetica">
			 using the </FONT>
			</TD>
			<TD align="left"><FONT FACE="Arial,Helvetica"> 
			 	<SELECT name="ArtTempID">
			 	<OPTION value="all">
			 	<OPTION value="all">All Templates
			 	<CFOUTPUT query="getTemplates">
			 	<OPTION value="#ArtTempID#">#Description#</OPTION>
			 	</CFOUTPUT>
			 	</SELECT>
				</FONT>
			</TD>
		</TR>
		<TR>
			<TD align="left"><FONT FACE="Arial,Helvetica">Art Template.</FONT></TD>
			<TD>&nbsp;</TD>
		</TR>
		<TR><TD COLSPAN=2>&nbsp;</TD></TR>
			<TR ALIGN="CENTER"><TD COLSPAN=2>
			<TABLE BORDER=0 BGCOLOR="FFFFFF">
			<TR ALIGN="LEFT"><TD>
				<FONT FACE="Arial,Helvetica"><INPUT
				type="radio" name="group" value="All" CHECKED>&nbsp;&nbsp;Print all records.
				<BR><INPUT type="radio" name="group" value="10">&nbsp;&nbsp;Print in groups of 10.
			</FONT></TD></TR>
		</TABLE></TD></TR>
		<TR><TD COLSPAN=2>&nbsp;</TD></TR>
		<INPUT type="hidden" name="mode_required" value="Please select Dealers, DMG's or Both.">
			<INPUT type="hidden" name="ArtTempID_required" value="You must select an Art Template.">
		<TR align="center"><TD COLSPAN=2><FONT FACE="Arial,Helvetica"><INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/showreport.jpg" Border="0" name="btnNext" value="Show Report">
		</TD></TR>
		</FORM>
		<TR><TD COLSPAN=2>&nbsp;</TD></TR>
		<FORM action="redirect.cfm" method="post">
		<TR align="center"><TD COLSPAN=2><FONT FACE="Arial,Helvetica"><INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg"
			Border="0"
			NAME="BackToMain"
			VALUE="Back To Main Menu">
		</TD></TR>
		</FORM>
		<TR><TD COLSPAN=2>&nbsp;</TD></TR>
		</TABLE>
	</TD></TR></TABLE>			
</CFIF>



<CFIF DisplayMode>

	<CFIF IsDefined("Form.current")>
		<CFSET variables.current = Form.Current>
	<CFElSE>
		<CFSET variables.current = 1>
	</CFIF>

	<CFIF IsDefined("URL.Jump")>
		<CFSET variables.current = #URL.jump#>
		<CFSET variables.arttempid = URL.arttempid>
		<CFSET variables.mode = URL.mode>
	<CFELSE>
		<CFSET variables.arttempid = form.arttempid>
		<CFSET variables.mode = form.mode>
	</CFIF>



	<CFQUERY name="temp1" datasource="#gDSN#">
	CREATE TABLE ##Temp1
	(q_DealershipName varchar(250),
	q_DealerCode varchar(50),
	g_Webstate varchar(50),
	g_ArtTemplate varchar(50);
	</CFQUERY>

	<CFIF (#Mode# IS 'dealer') OR (#Mode# IS 'both')>

		<CFQUERY name="getDLRTemplates" datasource="#gDSN#">
		SELECT Dealers.DealershipName as q_DealershipName,
			   Dealers.DealerCode as q_DealerCode,
			   DMGAdmin.DMG as q_DMGName,
			   DMGAdmin.DMGCode as q_DMGCode,
			   Webstates.Description as g_WebState,
			   ArtTemplates.Description as g_ArtTemplate
		  	
		FROM Dealers,
			 Webstates,
			 ArtTemplates,
			 DMGAdmin,
			 DealerWebs
			 
		WHERE
			<CFIF #ArtTempID# IS NOT 'all'>
				DealerWebs.ArtTempID = #form.ArtTempID# AND
			</CFIF>
		  	Dealers.DealerCode = DealerWebs.DealerCode AND
		  	Dealers.DMGID = DMGAdmin.ID AND
		  	WebStates.WebstateID = DealerWebs.WebstateID AND
		  	ArtTemplates.ArtTempID = DealerWebs.ArtTempID
		</CFQUERY>
	
		<CFLOOP query="GetDLRTemplates">
			<CFQUERY name="insert" datasource="#gDSN#">
			INSERT INTO ##Temp1
				(q_DealershipName,
				q_DealerCode,
				g_Webstate,
				g_ArtTemplate)
			VALUES ('#GetDLRTemplates.q_DealershipName#',
					'#GetDLRTemplates.q_DealerCode#',
					'#GetDLRTemplates.g_Webstate#',
					'#GetDLRTemplates.g_ArtTemplate#')
			</CFQUERY>
		</CFLOOP>
	</CFIF>
	
	
	<CFIF (#Mode# IS 'DMG') OR (#Mode# IS 'both')>
		<CFQUERY name="getDMGTemplates" datasource="#gDSN#">
		SELECT DMGAdmin.DMG as r_DMGName,
			   DMGAdmin.DMGCode as r_DMGCode,
			   Webstates.Description as g_WebState,
			   ArtTemplates.Description as g_ArtTemplate	
		FROM DMGAdmin,
			 Webstates,
			 ArtTemplates,
			 DealerMarketingGroups	   
		WHERE
		<CFIF #ArtTempID# IS NOT 'all'>
				DealerMarketingGroups.ArtTempID = #form.ArtTempID# AND
		</CFIF>
			  DealerMarketingGroups.Name = DMGAdmin.DMGCode AND
			  WebStates.WebStateID = DealerMarketingGroups.WebStateID AND
			  ArtTemplates.ArtTempID = DealerMarketingGroups.ArtTempID;
		</CFQUERY>
		
		<CFLOOP query="GetDMGTemplates">
			<CFQUERY name="ins2" datasource="#gDSN#">
			INSERT INTO ##Temp1
				(g_ArtTemplate,
				g_Webstate)
			VALUES ('#GetDMGTemplates.g_ArtTemplate#',
					'#GetDMGTemplates.g_Webstate#')
			</CFQUERY>
		</CFLOOP>
	</CFIF>
	
	<CFQUERY name="getall" datasource="#gDSN#">
	SELECT * FROM ##Temp1
	ORDER BY g_ArtTemplate, g_WebState;
	</CFQUERY>

	<CFQUERY name="reset" datasource="#gDSN#">
	DROP TABLE ##Temp1;
	</CFQUERY> 

	
	<body>
<br><br><br><br><br>
	<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=400 BGCOLOR="FFFFFF" ALIGN="CENTER">
	<TR><TD>&nbsp;<p></TD></TR>
	<TR ALIGN="center">
		<TD ALIGN="middle"><h3><FONT FACE="Arial,Helvetica">
		Dealer/DMG Administration<br>Art Template Reporting</FONT></h3></TD>
	</TR>
	</TABLE> 

	<TABLE BORDER=0 BGCOLOR="FFFFFF" CELLPADDING="0" CELLSPACING="0" WIDTH="400" ALIGN="CENTER">
	<CFIF #variables.current# + 9 GT #getall.recordcount#>
		<CFSET end_row = #getall.recordcount#>
	<CFELSE>
		<CFSET end_row = #variables.current# + 9>
	</CFIF>

	<CFLOOP query="getall" startrow="#variables.current#" endrow="#end_row#">
		<CFOUTPUT>
		<TR>
			<TD align="left"><FONT FACE="Arial,Helvetica" size="-1">Record:</FONT></TD>
			<TD align="left"><FONT FACE="Arial,Helvetica" size="-1"><b>#getall.currentrow#</b></FONT></TD>
		</TR>
		<CFIF #q_DealershipName# IS NOT ''>
			<TR>
				<TD align="left"><FONT FACE="Arial,Helvetica" size="-1">Dealership: </FONT></TD>
				<TD ALIGN="left"><FONT FACE="Arial,Helvetica" size="-1"><b>#Trim(q_DealershipName)#</b></FONT></TD>
			</TR>
			<TR>
				<TD align="left"><FONT FACE="Arial,Helvetica" size="-1">Dealer Code: </FONT></TD>
				<TD align="left"><FONT FACE="Arial,Helvetica" size="-1"><b>#Trim(q_DealerCode)#</b></FONT></TD>
			</TR>
			<TR>
				<TD align="left"><FONT FACE="Arial,Helvetica" size="-1">DMG: </FONT></TD>
				<TD align="left"><FONT FACE="Arial,Helvetica" size="-1"><b>#Trim(q_DMGName)# (#Trim(q_DMGCode)#)</b></FONT></TD>
			</TR>
		</CFIF>
		<CFIF #r_DMGName# IS NOT ''>
			<TR>
				<TD align="left"><FONT FACE="Arial,Helvetica size="-1">DMG Site: </FONT></TD>
				<TD align="left"><FONT FACE="Arial,Helvetica" size="-1"><b>#Trim(r_DMGName)# (#Trim(r_DMGCode)#)</b></FONT></TD>
			</TR>
		</CFIF>
		<TR>
			<TD align="left"><FONT FACE="Arial,Helvetica" size="-1">Art Template: </FONT></TD>
			<TD align="left"><FONT FACE="Arial,Helvetica" size="-1"><b>#g_ArtTemplate#</b></FONT></TD>
		</TR>
		<TR>
			<TD align="left"><FONT FACE="Arial,Helvetica" size="-1">Webstate: </FONT></TD>
			<TD align="left"><FONT FACE="Arial,Helvetica" size="-1"><b>#g_Webstate#</b></FONT></TD>
		</TR>
		<TR><TD colspan=2>&nbsp;</TD></TR>	
 		</CFOUTPUT>
	</CFLOOP>

	<TR align="center">
		<TD ALIGN="RIGHT">
		<CFIF (#getall.RecordCount# GT 10) AND (#variables.current# GT 1)>
			<FORM action="templatereport.cfm" method="post">
			<CFOUTPUT>
			<INPUT type="hidden" name="current" value="#Evaluate('variables.current - 10')#">
			<INPUT type="hidden" name="mode" value="#mode#">
			<INPUT type="hidden" name="ArtTempID" value="#ArtTempID#">
			</CFOUTPUT>
			<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/previouspage_nav.jpg" Border="0" name="BtnPrevious" value="Previous Page">&nbsp;&nbsp;&nbsp;
			</FORM>
		</CFIF>
		&nbsp;
		</TD>
		<TD ALIGN="CENTER">
		<CFIF (#variables.current# + 10) LE #getall.recordcount#>
			<FORM Action="templatereport.cfm" method="post">
			<CFOUTPUT>
			<INPUT type="hidden" name="current" value="#Evaluate('variables.current + 10')#">
			<INPUT type="hidden" name="mode" value="#mode#">
			<INPUT type="hidden" name="ArtTempID" value="#ArtTempID#">
			</CFOUTPUT>
			<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/nextpage_nav.jpg" Border="0" name="BtnNext" value="Next Page">
			</FORM>
		</CFIF>
		&nbsp;
		</TD>
	</TR>
	<TR>
		<TD COLSPAN="2" ALIGN="CENTER">
		<FONT FACE="Arial,Helvetica" size="-1">
		<CFLOOP FROM=1 TO=#countTheTemplates.recordcount# STEP=10 INDEX="loopcount">
			<CFOUTPUT>
			<CFIF #variables.current# EQ #loopcount#>
				<CFIF #getall.recordcount# GE #loopcount# + 9>
					<b>#loopcount#-#Evaluate(loopcount + 9)#</b>
				<CFELSE>
					<b>#loopcount#-#getall.recordcount#</b>
				</CFIF>
			<CFELSEIF #loopcount# + 9 LE #getall.recordcount#>
				<A HREF="templatereport.cfm?jump=#loopcount#&mode=#mode#&arttempid=#arttempid#">#loopcount#-#Evaluate(loopcount + 9)#</a>
			<CFELSE>
				<A HREF="templatereport.cfm?jump=#loopcount#&mode=#mode#&arttempid=#arttempid#">#loopcount#-#getall.recordcount#</a>
			</CFIF>
			</CFOUTPUT>
			&nbsp;|&nbsp;
	</CFLOOP></TD>
	</tr>
    <TR ALIGN="center">
		<TD ALIGN=CENTER COLSPAN="2">
            <BR>
            </TD>
	</TR>

    <TR ALIGN="center">
		<TD ALIGN=CENTER COLSPAN="2">
			<A HREF="templatereport.cfm"><IMG NAME="btnCancel" VALUE="Cancel" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/back_nav.jpg" BORDER="0"></a>&nbsp;<INPUT TYPE="image" NAME="Onwiththeshow" VALUE="Next" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next_nav.jpg" BORDER="0">
            <BR><BR>
            </TD>
	</TR>

	<TR ALIGN="center">
		<TD COLSPAN="2"><FONT FACE="arial,helvetica">
			<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
			<INPUT TYPE="image" NAME="BackToMain" VALUE="Back To Main Menu" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg" BORDER="0">&nbsp;&nbsp;&nbsp;
			</FORM></FONT></TD>
	</TR>

</TABLE>
	</FONT>
	<p>
	</div>
	<div align="center">
</CFIF>


<CFIF AllMode>
	<CFIF (#Form.Mode# IS 'dealer') OR (#form.Mode# IS 'both')>

		<CFIF #Form.ArtTempID# IS 'all'>
			<CFLOOP FROM=1 TO=#countTheTemplates.recordcount# INDEX="count">
		<CFELSE>
			<CFSET count = #form.ArtTempID#>
		</CFIF>
	
		<CFQUERY name="getTemplateStats_#count#" datasource="#gDSN#">
			SELECT DealerWebs.DealerCode as q_DealerCode,
					DealerWebs.ArtTempID as q_ArtTempID,
					DealerWebs.WebStateID as WebStateID,
					WebStates.Description as q_WebState,
					Dealers.DealershipName as q_DealershipName,
					Dealers.DMGID as q_DMGID,
					DMGAdmin.DMG as q_DMGName,
					DMGAdmin.DMGCode as q_DMGCode,
					ArtTemplates.Description as q_ArtTemplate
			FROM Dealers,
				 DealerWebs,
				 ArtTemplates,
				 WebStates,
				 DMGAdmin
			WHERE DealerWebs.WebstateID = WebStates.WebStateID AND
				 Dealers.DMGID = DMGAdmin.ID AND
				 Dealerwebs.DealerCode = Dealers.DealerCode AND
				 DealerWebs.ArtTempID = #count# AND
				 DealerWebs.ArtTempID = ArtTemplates.ArtTempID
			ORDER BY DealerWebs.WebStateID, Dealers.DealershipName;
		</CFQUERY>
	
		<CFQUERY name="CountTemplateStats_#count#" datasource="#gDSN#">
		SELECT COUNT(ArtTempID) as q_ArtTempID
		FROM DealerWebs
		WHERE ArtTempID = #count#
		</CFQUERY>

		<CFIF #form.ArtTempID# IS 'all'>
			</CFLOOP>
		</CFIF>
	
		<CFIF #form.ArtTempID# IS 'all'>
			<CFQUERY name="GetAllDlrTemplates" datasource="#gDSN#">
			SELECT COUNT (ArtTempID) AS q_Total
			FROM DealerWebs
			</CFQUERY>
		</CFIF>

	
	</CFIF>  <!--- IF Form.mode EQ Dealer or both --->

	<CFIF (Form.Mode EQ 'DMG') OR (Form.Mode EQ 'both')>
	
		<CFIF #Form.ArtTempID# IS 'all'>
			<CFLOOP FROM=1 TO=#countTheTemplates.recordcount# INDEX="count">
		<CFELSE>
			<CFSET count = #form.ArtTempID#>
		</CFIF>

	<CFQUERY name="getDMGTemplateStats_#count#" datasource="#gDSN#">
			SELECT DealerMarketingGroups.ArtTempID as q_ArtTempID,
				   ArtTemplates.Description as q_ArtTemplate,
				   DealerMarketingGroups.Description as q_DMGName,
				   DealerMarketingGroups.Name as q_DMGCode,
				   DealerMarketingGroups.WebStateID, 
				   Webstates.Description as q_Webstate
			FROM DealerMarketingGroups,
				 ArtTemplates,
				 WebStates
			WHERE DealerMarketingGroups.ArtTempID = #count# AND
				  DealerMarketingGroups.ArtTempID = ArtTemplates.ArtTempID AND
				  DealerMarketingGroups.WebStateID = WebStates.WebStateID
			ORDER BY DealerMarketingGroups.WebStateID, DealerMarketingGroups.Description;
		</CFQUERY>
		
		<CFQUERY name="CountDMGTemplateStats_#count#" datasource="#gDSN#">
		SELECT COUNT(ArtTempID) as q_ArtTempID
		FROM DealerMarketingGroups
		WHERE ArtTempID = #count#
		</CFQUERY>	

		<CFIF #form.ArtTempID# IS 'all'>
			</CFLOOP>
		</CFIF>
		
		<CFIF #form.ArtTempID# IS 'all'>
			<CFQUERY name="GetAllDMGTemplates" datasource="#gDSN#">
			SELECT COUNT (ArtTempID) AS q_Total
			FROM DealerMarketingGroups
			</CFQUERY>
		</CFIF>				   
	</CFIF>  <!--- If Form.mode EQ DMG or both --->

	<CFQUERY name="GetTemplateNames" datasource="#gDSN#">
		SELECT ArtTemplates.Description
		FROM ArtTemplates
	</CFQUERY>

	<CFSET ArtTempArray = ArrayNew(1)>
	<CFSET counter=1>
	<CFLOOP query="getTemplateNames">
		<CFSET #ArtTempArray[counter]# = #Description#>
		<CFSET counter=counter+1>
	</CFLOOP>


	<body>
<br><br><br><br><br>
 	<div align="center">
	<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=400 BGCOLOR="FFFFFF">
	<TR><TD>&nbsp;<p></TD></TR>
	<TR ALIGN="center">
		<TD ALIGN="middle"><h3><FONT FACE="Arial,Helvetica">
		Dealer/DMG Administration<br>Art Template Reporting</FONT></h3></TD>
	</TR>
	<TR>
	<TD ALIGN="CENTER">
  		<TABLE BORDER=1 CELLSPACING=1 CELLPADDING=1 BGCOLOR="FFFFFF">
		<TR align="center">
  			<TD><FONT FACE="arial,Helvetica"><b>&nbsp;&nbsp;Art Template&nbsp;&nbsp;</b></FONT></TD>
			<CFIF (#form.mode# EQ 'dealer') OR (#form.mode# EQ 'both')>
				<TD><FONT FACE="Arial,Helvetica"><b>&nbsp;&nbsp;<b>Dealer Sites</b>&nbsp;&nbsp;</FONT></TD>
			</CFIF>
			<CFIF (#form.mode# EQ 'DMG') OR (#form.mode# EQ 'both')>
				<TD><FONT FACE="Arial,Helvetica"><b>&nbsp;&nbsp;<b>DMG Sites</b>&nbsp;&nbsp;</FONT></TD>
			</CFIF>
			<CFIF #form.mode# EQ 'both'>
				<TD><FONT FACE="Arial,Helvetica"><b>&nbsp;&nbsp;Total:</b>&nbsp;&nbsp;</FONT></TD>
			</CFIF>
		</TR>

		<CFIF #form.ArtTempID# EQ 'all'>
 			<CFLOOP FROM=1 TO=#countTheTemplates.recordcount# INDEX="count3">
		<CFELSE>
			<CFSET #count3# = #form.ArtTempID#> 
		</CFIF>

 		<TR ALIGN="Center">
 			<TD><FONT FACE="Arial,Helvetica"><CFOUTPUT>&nbsp;&nbsp;#ArtTempArray[count3]#&nbsp;&nbsp;</CFOUTPUT></FONT></TD>
			<CFIF (#form.mode# EQ 'dealer') OR (#form.mode# EQ 'both')>
				<TD><FONT FACE="Arial,Helvetica"><CFOUTPUT query="CountTemplateStats_#count3#">#q_ArtTempID#</CFOUTPUT></FONT></TD>
			</CFIF>
			<CFIF (#form.mode# EQ 'DMG') OR (#form.mode# EQ 'both')>
				<TD><FONT FACE="Arial,Helvetica"><CFOUTPUT query="CountDMGTemplateStats_#count3#">#q_ArtTempID#</CFOUTPUT></FONT></TD>
			</CFIF>
			<CFIF #form.Mode# EQ 'both'>
				<CFSET temp2 = "countTemplateStats_#count3#.q_ArtTempID">
				<CFSET total=#Evaluate(temp2)#>
				<TD><FONT FACE="Arial,Helvetica"><CFOUTPUT>#total#</CFOUTPUT></FONT></TD>
			</CFIF>
		</TR>
		<CFIF #form.ArtTempID# EQ 'all'>
			</CFLOOP>
			<TR ALIGN="center">
				<TD><FONT FACE="Arial,Helvetica"><b>Total:</b></FONT></TD>
				<CFIF (#form.Mode# EQ 'dealer') OR (#form.Mode# EQ 'both')>
					<TD><FONT FACE="Arial,Helvetica"><CFOUTPUT><b>#GetAllDLRTemplates.q_Total#</b></CFOUTPUT></FONT></TD>
				</CFIF>
				<CFIF #form.Mode# EQ 'both'>
					<TD><FONT FACE="Arial,Helvetica"><CFOUTPUT><b>#GetAllDLRTemplates.q_Total#</b></CFOUTPUT></FONT></TD>
				</CFIF>
			</CFIF>
			</TABLE>
		</td></tr>
		</TABLE>

		<CFIF (#form.mode# EQ 'dealer') OR (#form.mode# EQ 'both')>
		<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0 BGCOLOR="FFFFFF" WIDTH="400">

		<CFIF #form.ArtTempID# EQ 'all'>
			<CFLOOP FROM=1 TO=#countTheTemplates.recordcount# index=count2>
		<CFELSE>
			<CFSET count2 = #form.ArtTempID#>
		</CFIF>
	
		<CFOUTPUT>
		<TR align="center"><TD COLSPAN=3>
			<FONT FACE="Arial,Helvetica"><b>&nbsp;&nbsp;Dealers using #ArtTempArray[count2]# Art Template:&nbsp;&nbsp;</b></FONT>
		</TD></TR>
		</CFOUTPUT>
		<TR><TD COLSPAN=3>&nbsp;</TD></TR>
		
		<CFOUTPUT query="getTemplateStats_#count2#" group="WebStateID">
		
		<TR align="center"><TD COLSPAN=3><FONT FACE="Arial,Helvetica" SIZE="-1">
		<b>#q_WebState# Dealer Sites:</b></FONT></TD></TR>
		<TR><TD COLSPAN=3>&nbsp;</TD></TR>

		<CFOUTPUT>
		<TR>
			<TD><FONT FACE="Arial,Helvetica" SIZE="-1">Dealership:</FONT></TD>
			<TD>&nbsp;&nbsp;&nbsp;</TD>
			<TD><FONT FACE="Arial,Helvetica" size="-1">#q_DealershipName#</FONT></TD>
		</TR>
		<TR>
			<TD><FONT FACE="Arial,Helvetica" SIZE="-1">Dealer Code:</FONT></TD>
			<TD>&nbsp;&nbsp;&nbsp;</TD>
			<TD><FONT FACE="Arial,Helvetica" SIZE="-1">#Trim(q_Dealercode)#</FONT></TD>
		</TR>
		<TR><TD COLSPAN=3>&nbsp;</TD></TR>
		</CFOUTPUT>
		
		<!--- <TR><TD COLSPAN=3>&nbsp;</TD></TR> --->
		</CFOUTPUT>	

		<CFIF #form.ArtTempID# IS 'all'>
			</CFLOOP>
		</CFIF>		
	 
		</TABLE>					
	</CFIF>  <!--- IF Form.Mode EQ dealer or both --->
	<br><P>
	<CFIF (#form.mode# EQ 'both')>
		<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0 BGCOLOR="FFFFFF" WIDTH="400">

		<CFIF #form.ArtTempID# EQ 'all'>
			<CFLOOP FROM=1 TO=#countTheTemplates.recordcount# index=count2>
		<CFELSE>
			<CFSET count2 = #form.ArtTempID#>
		</CFIF>
	
		<TR><TD>&nbsp;</TD></TR>

		<CFIF #form.ArtTempID# IS 'all'>
			</CFLOOP>
		</CFIF>		
	 
		</TABLE>					

	</CFIF>	  <!--- If form.Mode EQ both --->

	
	</div>
	<FORM action="templatereport.cfm" method="post">
	<TABLE ALIGN="CENTER" BORDER=0 CELLSPACING=0 CELLPADDING=0 BGCOLOR="FFFFFF" WIDTH="400">
	<TR><TD ALIGN="CENTER">
		<BR>
		<FONT FACE="arial,helvetica"><INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/back_nav.jpg" Border="0" value="Back"></FONT>
		<BR>
	</td></tr>
	<TR><TD>&nbsp;</TD></TR>
	<TR ALIGN="center">
		<TD><FONT FACE="arial,helvetica">
			<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
			<INPUT TYPE="image" NAME="BackToMain" VALUE="Back To Main Menu" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg" BORDER="0">&nbsp;&nbsp;&nbsp;
			</FORM></FONT></TD>
	</TR>
	<b></b>
	</TABLE>
	</FORM>
	<div align="center">
</CFIF>


</div>
		
</BODY>
</HTML>