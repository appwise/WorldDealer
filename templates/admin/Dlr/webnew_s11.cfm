<CFSET webnewstep = 11>
<CFINCLUDE template="security.cfm">

<!--- DSF: added 021899 --->
<CFSET maxNumOfBanners = 15>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
    <!-- ----------------------------------------------------------- -->
    <!--               Created by sigma6, Detroit                    -->
    <!--         Copyright (c) 1997, 1998, 1999 sigma6.              -->
    <!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->

    <!-- ----------------------------------------------------------- -->
    <!--     Howard Levine for sigma6, interactive media, Detroit    -->
    <!--    hlevine@sigma6.com   www.sigma6.com    www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
	<!--- $Id: webnew_s11.cfm,v 1.10 2000/06/15 15:35:45 lswanson Exp $ --->
	<!--- Promotional Banners --->
	
	<!--- Set Mode Flags --->
	<CFSET EditMode = FALSE>
	<CFSET NewMode = FALSE>
	<CFSET SaveMode = FALSE>
	<CFSET DeleteMode = FALSE>
	<CFSET KillMode = FALSE>
	<CFSET ModifyMode = FALSE>
	<CFSET NextMode = FALSE>
	<CFSET ConfirmMode = FALSE>

	<CFIF IsDefined("Form.btnCancel.X")>
		<CFLOCATION URL="webvrfy_s11.cfm?dlrcode=#Form.DealerCode#">
	</CFIF>

	<CFIF IsDefined("URL.dlrcode")>
		<CFSET g_DealerCode = URL.dlrcode>
		<CFIF IsDefined("URL.tmpID")>
			<CFSET ConfirmMode = TRUE>
		<CFELSE>
			<CFSET EditMode = TRUE>		
		</CFIF>
	<CFELSEIF IsDefined("Form.DealerCode")>
		<CFSET g_DealerCode = Form.DealerCode>
	<CFELSE>
		<CFSET g_DealerCode = "">
	</CFIF>
        
	<CFIF ParameterExists(Form.btnSave.X)>
		<CFSET SaveMode = TRUE>
	</CFIF>

	<CFIF ParameterExists(Form.btnModify.X)>
		<CFSET ModifyMode = TRUE>
	</CFIF>
		
	<CFIF ParameterExists(Form.BtnAdd.X)>
		<CFSET NewMode = TRUE>
	</CFIF>
		
	<CFIF ParameterExists(Form.BtnDelete.X)>
		<CFSET DeleteMode = TRUE>
	</CFIF>
		
	<CFIF ParameterExists(Form.BtnKill.X)>
		<CFSET KillMode = TRUE>
	</CFIF>
		
	<CFIF ParameterExists(Form.btnNext.X)>
		<CFSET NextMode = TRUE>
	</CFIF>
		

	<!--- Run queries, depending on mode you're in --->			
	<CFIF EditMode>
		<CFQUERY name="getBanners" datasource="#gDSN#">
		SELECT
			Banners.FileLocation,
			SpecialPromotions.ExpirationDate,
			Banners.BannerID as q_BannerID,
			Banners.LinkYesNo,
			SpecialPromotions.SpecPromoID
		FROM
			Banners,
			DealerBanners,
			SpecialPromotions
		WHERE
			DealerWebID = (SELECT DealerWebID FROM DealerWebs WHERE DealerCODE = '#g_DealerCode#') 
			AND	status = '1'
			AND	DealerBanners.bannerid=Banners.bannerid
			AND	SpecialPromotions.SpecPromoID=Banners.specpromoid;
		</CFQUERY>
	</CFIF>

	<CFIF ModifyMode OR IsDefined("Form.ModifyFlag")>
		<CFQUERY name="getBanner" datasource="#gDSN#">
 		SELECT
			SpecialPromotions.ExpirationDate,
			SpecialPromotions.Description as q_SpecPromoDescription,
			Banners.Description AS q_BannerDescription,
			Banners.SpecPromoID as q_SpecPromoID,
			Banners.LinkYesNo,
			Banners.BannerID,
			Banners.BannerType,
			Banners.FontName,
			Banners.XCord,
			Banners.YCord,
			Banners.FontSize,
			Banners.FontStyle,
			Banners.FontColor
		FROM
			Banners,
			DealerBanners,
			SpecialPromotions
		WHERE
			DealerWebID = (SELECT DealerWebID FROM DealerWebs WHERE DealerCODE = '#g_DealerCode#') 
			AND status = '1'
			AND DealerBanners.bannerid=Banners.bannerid
			AND SpecialPromotions.SpecPromoID=Banners.specpromoid
			AND Banners.SpecPromoID = #form.SpecPromoID#;
		</CFQUERY>
	</CFIF>

	<CFIF DeleteMode>
		<CFQUERY name="GetBanner" datasource="#gDSN#">
		SELECT
			SpecialPromotions.ExpirationDate,
			SpecialPromotions.Description as q_SpecPromoDescription
		FROM
			SpecialPromotions
		WHERE
			SpecPromoID = #form.SpecPromoID#;
		</CFQUERY>
	</CFIF>
		
	<CFIF SaveMode>
		<CFIF IsDefined("Form.ModifyFlag")>
			<CFQUERY NAME="updPromo" datasource="#gDSN#">
            UPDATE SpecialPromotions
			SET
				Description = '#Form.SpecPromoDescription#',
				ExpirationDate = #CreateODBCDate(Form.ExpirationDate)#
			WHERE
				SpecPromoID = #Form.SpecPromoID#
			</CFQUERY>
			
			<CFQUERY name="updBanners" datasource="#gDSN#">
			UPDATE Banners
			SET
				Description = '#Form.title#',
				LinkYesNo = '#FORM.LinkYesNo#',
				BannerType = #Form.BannerType#,
				FontName = '#Form.FontName#',
				XCord = '#Form.XCord#',
				YCord = '#Form.YCord#',
				FontSize = #Form.FontSize#,
				FontStyle = '#Form.FontStyle#',
				FontColor = '#Form.FontColor#'
			WHERE
				BannerID = #Form.BannerID#;
			</CFQUERY>
			<CFSET #variables.specpromoid# = #form.specpromoid#>
		</CFIF>
			
		<CFIF IsDefined("Form.NewFlag")>
			<CFQUERY name="GetArttempID" datasource="#gDSN#">
			SELECT
				ArtTempID,
				DealerWebID
			FROM
				DealerWebs 
			WHERE
				DealerCode = '#g_dealercode#';
			</CFQUERY>
					
			<CFQUERY NAME="addSpecPromo" datasource="#gDSN#">
			INSERT INTO SpecialPromotions (
				ArtTempID,
				Description,
				ExpirationDate
				)
			VALUES (
				#GetArtTempID.ArtTempID#,
				'#Form.SpecPromoDescription#',
				#CreateODBCDate(Form.ExpirationDate)#);
			</CFQUERY>
					
			<CFQUERY name="GetSpecPromoID" datasource="#gDSN#">
			SELECT
				MAX(SpecPromoID) AS New_Record
			FROM
				SpecialPromotions;
			</CFQUERY>
			<CFSET #variables.specpromoid# = #getSpecPromoID.new_record#>

			<CFQUERY name="addBanner" datasource="#gDSN#">
			INSERT INTO Banners (
				Description,
				URLLink,
				FileLocation,
				SpecPromoID,
				Status,
				LinkYesNo,
				BannerType,
				FontName,
				XCord,
				YCord,
				FontSize,
				FontStyle,
				FontColor
				)
			VALUES (
				'#Form.title#',
				'SomeURL',
				'http://#g_host#/templates/#getarttempid.arttempid#/of_#getarttempid.arttempid#_index.cfm',
				#GetSpecPromoID.New_Record#,
				'1',
				'#FORM.LinkYesNo#',
				#Form.BannerType#,
				'#Form.FontName#',
				'#Form.XCord#',
				'#Form.YCord#',
				#Form.FontSize#,
				'#Form.FontStyle#',
				'#Form.FontColor#'
				);
			</CFQUERY>
	
			<CFQUERY name="getBannerID" datasource="#gDSN#">
			SELECT
				MAX(BannerID) as New_record
			FROM
				Banners;
			</CFQUERY>
					
			<CFQUERY name="addDealerBanners" datasource="#gDSN#">
			INSERT INTO DealerBanners (
				DealerWebID,
				BannerID
				)
			VALUES (
				#getartTempID.DealerWebID#,
				#getBannerID.new_record#
				);
			</CFQUERY>
					
			<CFQUERY name="addDealerSpclPromo" datasource="#gDSN#">
			INSERT INTO DealerSpecialPromotions (
				DealerWebID,
				SpecPromoID
				)
			VALUES (
				#GetArtTempID.DealerWebID#,
				#getSpecPromoID.New_Record#
				);
			</CFQUERY>
		</CFIF>
				
		<!--- RENAME TEMP BANNER WITH CORRECT NAME SCHEME --->
		<CFFILE ACTION="COPY"
        		SOURCE="#g_rootdir#\images\banner\temp_#form.tmpid#_adbanner_hea.gif"
        		DESTINATION="#g_rootdir#\images\banner\#g_dealercode#_#variables.specpromoid#_adbanner_hea.gif">
		<CFLOCATION url="webvrfy_s11.cfm?dlrcode=#g_dealercode#">
	</CFIF>
	
	<CFIF KillMode>
		<CFQUERY name="KillBanner" datasource="#gDSN#">
		UPDATE Banners
		SET
			Status = '0'
		WHERE
			SpecPromoID = #form.SpecPromoID#;
		</CFQUERY>
		<CFLOCATION url="webvrfy_s11.cfm?dlrcode=#g_dealercode#">
	</CFIF>

<!---------------------------------------  EDITMODE  -------------------------------------------------------->
<CFIF EditMode>
<HEAD>
	<TITLE>WorldDealer | Create a New Web</TITLE>
	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>
		
<body>
<br><br><br><br><br>
<div align="center">
<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
<TR>
	<TD ALIGN="center">
		<h3><font face="Arial,Helvetica">
			Dealer Administration - Create a New Web
		</font></h3>
	</TD>
</TR>
<TR ALIGN="center">
	<TD ALIGN="middle">
		<h4><font face="Arial,Helvetica">
			Banner Maintenance
		</font></h4>
	</TD>
</TR>
<FORM NAME="StepEleven" ACTION="webnew_s11.cfm" METHOD="post">
<CFIF #GetBanners.RecordCount# IS NOT '0'>
<TR>
	<TD ALIGN="center">
		<font face="Arial,Helvetica">
			Please select the Special Promotion Banner you wish to Modify
		<BR><BR>
		</FONT>
	</TD>
</TR>
<FORM action="webnew_s11.cfm" method="post">
<TR ALIGN="Center">
	<TD>
	<TABLE BORDER=0>
	<CFOUTPUT query="getBanners">
	<TR>
		<TD align="center" valign="middle">
			<INPUT type="radio" name="SpecPromoID" value="#specpromoid#"<CFIF #getBanners.CurrentRow# EQ 1>CHECKED</CFIF>>
		</TD>
		<TD ALIGN="center">
			<FONT SIZE=2 FACE="arial,helvetica">
				Expires on: #DateFormat(ExpirationDate,"mmmm d, yyyy")#
			<br>
			<IMG SRC="#application.RELATIVE_PATH#/images/banner/#g_dealercode#_#specpromoid#_adbanner_hea.gif">
			</FONT>
		</TD>
	</TR>
	<TR>
		<TD>&nbsp;</TD>
	</TR>
	</CFOUTPUT>
	</TABLE>
	</TD>
</TR>
<CFELSE>
<TR align=center>
	<TD>
		<FONT Face="arial,Helvetica">
			There are currently NO Special Promotion Banners Associated with this
			Dealership.  Click the 'Modify' button to make changes.
		</FONT>
	</TD>
</TR>
<TR>
	<TD>&nbsp;</TD>
</TR>
</CFIF>
<INPUT TYPE="hidden" name="dealercode" value="<CFOUTPUT>#g_dealercode#</CFOUTPUT>">
<CFIF #getBanners.RecordCount# IS NOT 0>
<TR align="center">
	<TD>
		<INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/deletebanner.jpg"
			BORDER="0"
			name="BtnDelete"
			value="Delete Promotion">
		&nbsp;&nbsp;
		<INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/modifybanner.jpg"
			BORDER="0"
			name="BtnModify"
			value="Modify Promotion">
	</TD>
</TR>
</CFIF>
<TR>
	<TD>&nbsp;&nbsp;&nbsp;</TD>
</TR>
<TR align="center">
	<TD>
		<INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg"
			BORDER="0"
			NAME="btnCancel"
			VALUE="Cancel">
		&nbsp;&nbsp;
		<INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/addbanner.jpg"
			BORDER="0"
			name="BtnAdd"
			value="Add Promotion">
	</TD>
</TR>
</FORM>
<TR>
<TD>&nbsp;&nbsp;&nbsp;</TD>
</TR>
<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
<TR>
	<TD>&nbsp;&nbsp;&nbsp;</TD>
</TR>
<TR ALIGN=CENTER>
	<TD>
		<INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg"
			Border="0"
			NAME="BackToMain"
			VALUE="Back To Main Menu">
	</TD>
</TR>
</FORM>
<TR>
	<TD>&nbsp;</TD>
</TR>
</TABLE>

</div>
</BODY>
</HTML>
<CFABORT>
</CFIF>
	
	
<!---------------------------------------  DELETEMODE  -------------------------------------------------------->	
<CFIF DeleteMode>
<HEAD>
	<TITLE>WorldDealer | Create a New Web</TITLE>
	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>
		
<body>
<br><br><br><br><br>
<div align="center">
<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
<TR>
	<TD ALIGN="center">
		<h3><font face="Arial,Helvetica">
			Dealer Administration - Create a New Web
		</font></h3>
	</TD>
</TR>
<TR>
	<TD ALIGN="center">
		<h4><font face="Arial,Helvetica">
			Banner Maintenance
		</font></h4>
	</TD>
</TR>
<FORM NAME="StepNine" ACTION="webnew_s11.cfm" METHOD="post">
<TR align="center">
	<TD>
		<FONT Face="arial,Helvetica">
			You are about to permanently Delete the following Banner.  Are you
			sure you wish to proceed?
		</FONT>
	</TD>
</TR>
<TR>
<TD>&nbsp;&nbsp;&nbsp;</TD>
</TR>
<TR align="center">
	<TD>
	<TABLE BORDER=0>
	<CFOUTPUT query="GetBanner">
		<TR align="center">
			<TD>
				<IMG SRC="#application.RELATIVE_PATH#/images/banner/#Trim(g_dealercode)#_#specPromoID#_adbanner_hea.gif">
				<br>
				<FONT SIZE=2 FACE="arial,helvetica">
					#q_SpecPromoDescription#
				</FONT>
			</TD>
		</TR>
		<TR Align="center">
			<TD>
				<FONT SIZE=2 FACE="arial,helvetica">
					Expires: #DateFormat(ExpirationDate, "mmmm d, yyyy")#
				</FONT>
			</TD>
		</TR>
	</CFOUTPUT>
	</TABLE>
	</TD>
</TR>	
<TR>
	<TD>&nbsp;&nbsp;&nbsp;</TD>
</TR>
<INPUT type="hidden" name="SpecPromoID" value="<CFOUTPUT>#form.SpecPromoID#</CFOUTPUT>">
<INPUT type="hidden" name="dealercode" value="<CFOUTPUT>#g_dealercode#</CFOUTPUT>">
<TR align="center">
	<TD>
		<INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg"
			BORDER="0"
			NAME="btnCancel"
			VALUE="Cancel">
		&nbsp;&nbsp;
		<INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/deletebanner.jpg"
			BORDER="0"
			name="BtnKill"
			value="Delete Banner">
	</TD>
</TR>
</FORM>
<TR>
	<TD>&nbsp;&nbsp;&nbsp;</TD>
</TR>
<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
<TR align="center">
	<TD>
		<INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg"
			Border="0"
			NAME="BackToMain"
			VALUE="Back To Main Menu">
	</TD>
</TR>
</FORM>
<TR>
	<TD>&nbsp;</TD>
</TR>
</TABLE>

</div>
</BODY>
</HTML>
<CFABORT>
</CFIF>

<!---------------------------------------  NEXTMODE  -------------------------------------------------------->
<!--- FONT attributes --->
<CFIF NextMode>
<!-- Modify Existing Banner OR Add New Banner -->
<HEAD>
	<TITLE>WorldDealer | Create a New Web</TITLE>
	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>

<body>
<br><br><br><br><br>
<div align="center">
<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
<TR>
	<TD ALIGN="center">
		<h3><font face="Arial,Helvetica">
			Dealer Administration - Create a New Web
		</font></h3>
	</TD>
</TR>
<TR ALIGN="center">
	<TD ALIGN="middle">
		<h4><font face="Arial,Helvetica">
			Banner Maintenance
		</font></h4>
	</TD>
</TR>
<TR>
	<TD>&nbsp;</TD>
</TR>
<TR align="center">
	<TD>
		<FONT Face="Arial,Helvetica">
			Select from the list of style attributes below
		</FONT>
	</TD>
</TR>
<TR>
	<TD>&nbsp;</TD>
</TR>
<!--- Linda, 5/6/99: This was causing problems: g_host on the colo is montana.sigma6.net & the file isn't there.
<FORM ACTION="<CFOUTPUT>http://#g_host##application.RELATIVE_PATH#/templates/admin/dlr/banner_redirect.cfm</CFOUTPUT>" method="post"> --->
<FORM ACTION="banner_redirect.cfm" method="post">
<TR ALIGN="CENTER">
	<TD>
	<TABLE BORDER=0>
	<CFOUTPUT>	
	<TR VALIGN="Top">
		<TD>
			<FONT Face="Arial,Helvetica">
				Horizontal Alignment
			</FONT>
		</TD>
		<TD>
			<FONT FACE="Arial,Helvetica">
				<CFIF IsDefined("Form.ModifyFlag")>
					<CFSET XCord = #getBanner.xcord#>
				<CFELSE>
					<CFSET XCord = "Center">
				</CFIF>
			
				<SELECT name="xcord">
					<OPTION value="Center" 
						<CFIF #XCord# EQ "Center">SELECTED</CFIF>>Center
					<OPTION value="20"
						<CFIF #XCord# EQ "20">SELECTED</CFIF>>Left
				</SELECT>
			</FONT>
		</TD>
	</TR>
	<TR>
		<TD COLSPAN=2>&nbsp;</TD>
	</TR>
	<TR VALIGN="Top">
		<TD>
			<FONT FACE="Arial,Helvetica">
				Vertical Alignment
			</FONT>
		</TD>
		<TD>
			<FONT FACE="Arial,Helvetica">
				<CFIF IsDefined("Form.ModifyFlag")>
					<CFSET YCord = #getBanner.ycord#>
				<CFELSE>
					<CFSET YCord = "Middle">
				</CFIF>
			
				<SELECT name="ycord">
					<OPTION value="Middle" 
						<CFIF #YCord# EQ "Middle">SELECTED</CFIF>>Middle
					<OPTION value="3"
						<CFIF #YCord# EQ "3">SELECTED</CFIF>>Top
				</SELECT>
			</FONT>
		</TD>
	</TR>
	<TR>
		<TD COLSPAN=2>&nbsp;</TD>
	</TR>
	<TR valign="Top">
		<TD>
			<FONT FACE="Arial,Helvetica">
				Font Size
			</FONT>
		</TD>
		<TD>
			<FONT FACE="Arial,Helvetica">
				<CFIF IsDefined("Form.ModifyFlag")>
					<CFSET FontSize = #getBanner.FontSize#>
				<CFELSE>
					<CFSET FontSize = "24">
				</CFIF>
			
				<SELECT name="size">
				<CFLOOP index="num" from="16" to="28" step="2">
					<OPTION value = #num# <CFIF #FontSize# EQ #num#>SELECTED</cfif>>#num#
				</CFLOOP>
				</SELECT>
			</FONT>
		</TD>
	</TR>
	<TR>
		<TD COLSPAN=2>&nbsp;</TD>
	</TR>
	<TR valign="top">
		<TD>
			<FONT Face="Arial,Helvetica">
				Font Style
			</FONT>
		</TD>
		<TD>
			<FONT FACE="Arial,Helvetica">
				<CFIF IsDefined("Form.ModifyFlag")>
					<CFSET FontName = "#getBanner.FontName#">
				<CFELSE>
					<CFSET FontName = "Arial,Helvetica">
				</CFIF>

				<SELECT name="FontName">
					<OPTION VALUE="Arial,Helvetica"
						<CFIF #FontName# EQ "Arial,Helvetica">SELECTED</cfif>>Plain
					<OPTION VALUE="Arial,Helvetica Bold"
						<CFIF #FontName# EQ "Arial,Helvetica Bold">SELECTED</cfif>>Bold
				</SELECT>
				<INPUT TYPE="hidden" NAME="style" VALUE="plain">
			</FONT>
		</TD>
	</TR>
	<TR>
		<TD COLSPAN=2>&nbsp;</TD>
	</TR>
	<TR valign="top">
		<TD>
			<FONT Face="Arial,Helvetica">
				Color
			</FONT>
		</TD>
		<TD>
			<CFIF IsDefined("Form.ModifyFlag")>
				<CFSET FontColor = #getBanner.FontColor#>
			<CFELSE>
				<CFSET FontColor = "Black">
			</CFIF>
		
			<FONT FACE="Arial,Helvetica">
				<SELECT NAME="color">
					<OPTION VALUE="black" <CFIF #FontColor# EQ "black">selected</cfif>>Black
					<OPTION VALUE="white" <CFIF #FontColor# EQ "white">selected</cfif>>White
					<OPTION VALUE="blue" <CFIF #FontColor# EQ "blue">selected</cfif>>Blue
					<OPTION VALUE="cyan" <CFIF #FontColor# EQ "cyan">selected</cfif>>Cyan
					<OPTION VALUE="darkGray" <CFIF #FontColor# EQ "darkGray">selected</cfif>>DarkGray
					<OPTION VALUE="gray" <CFIF #FontColor# EQ "gray">selected</cfif>>Gray
					<OPTION VALUE="green" <CFIF #FontColor# EQ "green">selected</cfif>>Green
					<OPTION VALUE="lightGray" <CFIF #FontColor# EQ "lightGray">selected</cfif>>LightGray
					<OPTION VALUE="magenta" <CFIF #FontColor# EQ "magenta">selected</cfif>>Magenta
					<OPTION VALUE="orange" <CFIF #FontColor# EQ "orange">selected</cfif>>Orange
					<OPTION VALUE="pink" <CFIF #FontColor# EQ "pink">selected</cfif>>Pink
					<OPTION VALUE="red" <CFIF #FontColor# EQ "red">selected</cfif>>Red
					<OPTION VALUE="yellow" <CFIF #FontColor# EQ "yellow">selected</cfif>>Yellow
				</SELECT>
			</FONT>
		</TD>
	</TR>
	</CFOUTPUT>	
	</TABLE>
	</TD>
</TR>
<TR>
	<TD>&nbsp;</TD>
</TR>
<TR>
	<TD>&nbsp;&nbsp;&nbsp;</TD>
</TR>
<TR ALIGN="center">
	<TD>
		<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/showbanner.jpg"
			BORDER="0"
			value="Show Banner"
			name="btnShow">
	</TD>
</TR>
<CFOUTPUT>
<!--- Linda, 5/6/99: This was causing problems: g_host on the colo is montana.sigma6.net & the file isn't there.
<INPUT type="hidden" name="location" value="http://#g_host##application.RELATIVE_PATH#/templates/admin/dlr/webnew_s11.cfm?dlrcode=#g_dealercode#<CFIF IsDefined("Form.ModifyFlag")>&modifyflag=1&bannerid=#form.bannerID#&specpromoid=#form.specpromoid#<CFELSEIF IsDefined("Form.NewFlag")>&newflag=1</CFIF>&expirationdate=#URLEncodedFormat(form.expirationdate)#&title=#URLEncodedFormat(title)#&BannerType=#form.BannerType#"> --->
<INPUT type="hidden" name="location" value="webnew_s11.cfm?dlrcode=#g_dealercode#<CFIF IsDefined("Form.ModifyFlag")>&modifyflag=1&bannerid=#form.bannerID#&specpromoid=#form.specpromoid#<CFELSEIF IsDefined("Form.NewFlag")>&newflag=1</CFIF>&expirationdate=#URLEncodedFormat(form.expirationdate)#&title=#URLEncodedFormat(title)#&BannerType=#form.BannerType#">
<INPUT type="hidden" name="inputfilename" value="f_blank#form.bannertype#_adbanner_hea.gif">
<INPUT type="hidden" name="textstring" value="#title#">
<INPUT type="hidden" name="FORDAccess" value="#AccessLevel#">
</cfoutput>
</FORM>
<TR>
	<TD>&nbsp;</TD>
</TR>
<FORM action="<CFOUTPUT>webvrfy_s11.cfm?dlrcode=#g_dealercode#</CFOUTPUT>" method="post">
<TR align="center">
	<TD>
		<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg"
			BORDER="0"
			value="Cancel"
			name="btnCancel">
	</TD>
</TR>
</FORM>
<TR>
	<TD>&nbsp;</TD>
</TR>
<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
<TR align="center">
	<TD>
		<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg"
			Border="0"
			NAME="BackToMain"
			VALUE="Back To Main Menu">
	</TD>
</TR>
</FORM>
<TR>
	<TD>&nbsp;</TD>
</TR>
</TABLE>

</div>
</BODY>
</HTML>
<CFABORT>
</CFIF>

<!---------------------------------------------------- CONFIRMMODE ------------------------------------------->
<CFIF ConfirmMode>
		<CFSET tmp = URL.tmpid>
		
		<CFIF IsDefined("URL.ModifyFlag")>
			<CFQUERY name="getBanner" datasource="#gDSN#">
			SELECT
				SpecialPromotions.ExpirationDate,
				SpecialPromotions.Description as q_SpecPromoDescription,
				Banners.Description AS q_BannerDescription,
				Banners.SpecPromoID as q_SpecPromoID,
				Banners.LinkYesNo,
				Banners.BannerID
			FROM
				Banners,DealerBanners,SpecialPromotions
			WHERE
				DealerWebID = (SELECT DealerWebID FROM DealerWebs WHERE DealerCODE = '#g_DealerCode#') 
				AND status = '1'
				AND DealerBanners.bannerid=Banners.bannerid
				AND SpecialPromotions.SpecPromoID=Banners.specpromoid
				AND Banners.SpecPromoID = #URL.SpecPromoID#;
			</CFQUERY>
		</CFIF>

<HEAD>
	<TITLE>WorldDealer | Create a New Web</TITLE>
	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>
<body>
<br><br><br><br><br>
<div align="center">
<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
<TR>
	<TD ALIGN="center">
		<h3><font face="Arial,Helvetica">
			Dealer Administration - Create a New Web
		</font></h3>
	</TD>
</TR>
<TR>
	<TD ALIGN="center">
		<h4><font face="Arial,Helvetica">
			Banner Maintenance
		</font></h4>
	</TD>
</TR>
<FORM NAME="StepEleven" ACTION="<CFOUTPUT>#g_relpath#/templates/admin/dlr/webnew_s11.cfm</CFOUTPUT>" METHOD="post">
<TR>
	<TD>&nbsp;</TD>
</TR>
<TR align="center">
	<TD>
		<FONT Face="Arial,Helvetica">
			<b>In the space below, enter the text of your Special Promotion</b>
		</FONT>
	</TD>
</TR>
<TR align="center">
	<TD>
	<CFIF IsDefined("URL.ModifyFlag")>
		<CFOUTPUT query="GetBanner">
			<TEXTAREA name="specpromodescription" cols="35" rows="10" wrap="PHYSICAL">#q_SpecPromoDescription#</TEXTAREA>
		</CFOUTPUT>
	<CFELSE>
		<TEXTAREA name="specpromodescription" cols="35" rows="10" wrap="PHYSICAL">Enter your Special Promotion</TEXTAREA>
	</CFIF>
	</TD>
</TR>
<TR>
	<TD>&nbsp;</TD>
</TR>
<TR align="center">
	<TD>
		<FONT Face="Arial,Helvetica">
			<b>Would you like this banner to be linked to a Special Promotion page
			containing the text entered above?</b>
		</FONT>
	</TD>
</TR>
<TR>
	<TD ALIGN=CENTER>
		<FONT FACE="arial,helvetica">
		<CFIF IsDefined("getBanner.LinkYesNo")>
			<cfset LinkYN = #getBanner.LinkYesNo#>
		<CFELSE>
			<cfset LinkYN = "N">
		</CFIF>
		<CFOUTPUT>
		Yes <INPUT TYPE="radio" NAME="LinkYesNo" VALUE="Y" <CFIF #LinkYN# EQ "Y">CHECKED</CFIF>>
		&nbsp;&nbsp;
		No <INPUT TYPE="radio" NAME="LinkYesNo" VALUE="N" <CFIF #LinkYN# EQ "N">CHECKED</CFIF>>
		</cfoutput>
		</FONT>
	</TD>
</TR>
<TR>
	<TD>&nbsp;</TD>
</TR>
<TR ALIGN="center">
	<TD>
		<FONT FACE="Arial,Helvetica">
			The following Banner will be saved in the database.
		</FONT>
	</TD>
</TR>
<TR>
	<TD>&nbsp;&nbsp;&nbsp;</TD>
</TR>
<TR align="center">
	<TD>
	<!--- Fix this later --->
		<IMG SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/banner/temp_<CFOUTPUT>#url.tmpid#</CFOUTPUT>_adbanner_hea.gif">
		<BR>
		<FONT FACE="Arial,Helvetica">
			<CFOUTPUT>#Replace(url.title,"~"," ","ALL")#</CFOUTPUT>
		</FONT>
	</TD>
</TR>
<TR>
	<TD>&nbsp;</TD>
</TR>
<CFOUTPUT>
<INPUT type="hidden" name="dealercode" value="#g_dealercode#">
<INPUT type="hidden" name="title" value="#Replace(URL.title,'~',' ','ALL')#">
<INPUT type="hidden" name="tmpid" value="#URL.tmpid#">
<INPUT type="hidden" name="ExpirationDate" value="#URL.ExpirationDate#">
<INPUT type="hidden" name="BannerType" value="#URL.BannerType#"> 
<INPUT type="hidden" name="FontName" value="#URL.FontName#"> 
<INPUT type="hidden" name="XCord" value="#URL.XCord#"> 
<INPUT type="hidden" name="YCord" value="#URL.YCord#"> 
<INPUT type="hidden" name="FontSize" value="#URL.FontSize#"> 
<INPUT type="hidden" name="FontStyle" value="#URL.FontStyle#"> 
<INPUT type="hidden" name="FontColor" value="#URL.FontColor#"> 

<INPUT TYPE="hidden" NAME="NextStep" VALUE="webvrfy_s11.cfm">
<CFIF IsDefined("URL.ModifyFlag")>
	<INPUT type="hidden" name="ModifyFlag" value="1">
	<INPUT type="hidden" name="BannerID" value="#URL.BannerID#">
	<INPUT type="hidden" name="SpecPromoID" value="#URL.SpecPromoID#">
<CFELSE>
	<INPUT type="hidden" name="NewFlag" value="1">
</CFIF>
</cfoutput>
<TR align="center">
	<TD>
		<INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg"
			BORDER="0"
			NAME="btnCancel"
			VALUE="Cancel">
		&nbsp;&nbsp;
		<INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next_nav.jpg"
			BORDER="0"
			NAME="btnSave"
			VALUE="Save Banner">
	</TD>
</TR>
</FORM>
<TR>
	<TD>&nbsp;&nbsp;&nbsp;</TD>
</TR>
<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">	
<TR align="center">
	<TD>
		<INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg"
			Border="0"
			NAME="BackToMain"
			VALUE="Back To Main Menu">
	</TD>
</TR>
</FORM>
<TR>
	<TD>&nbsp;</TD>
</TR>
</TABLE>

</div>
</BODY>
</HTML>
<CFABORT>
</CFIF>
	
	
<!---------------------------------------  NEWMODE or MODIFYMODE  ------------------------------------------->
<!--- Banner Title, Expiration Date, select Banner Template --->
<CFIF ModifyMode>
	<CFQUERY name="GetBannerID" datasource="#gDSN#">
		SELECT BannerID
		FROM Banners
		WHERE SpecPromoID = #form.SpecPromoID#;
	</CFQUERY>
</CFIF>

<HEAD>
	<TITLE>WorldDealer | Create a New Web</TITLE>
	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>

<body>
<br><br><br><br><br>
<div align="center">
<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
<TR>
	<TD ALIGN="center">
		<h3><font face="Arial,Helvetica">
			Dealer Administration - Create a New Web
		</font></h3>
	</TD>
</TR>
<TR ALIGN="center">
	<TD>
		<h4><font face="Arial,Helvetica">
			Banner Maintenance
		</font></h4>
	</TD>
</TR>
<FORM NAME="StepEleven" ACTION="<CFOUTPUT>#g_relpath#/templates/admin/dlr/webnew_s11.cfm</CFOUTPUT>" METHOD="post">
<TR ALIGN="center">
	<TD>
		<FONT FACE="Arial,Helvetica">
			Enter the following information. Required fields are bolded.
		</FONT>
	</TD>
</TR>
<TR>
	<TD>&nbsp;&nbsp;&nbsp;</TD>
</TR>
<TR align="center">
	<TD>
		<FONT FACE="arial,helvetica">
			<b>Banner Title</b>
		</FONT>
	</TD>
</TR>
<TR align="center">
	<TD>
	<FONT FACE="arial,helvetica">
	<CFIF ModifyMode>
		<CFOUTPUT query="getBanner"> 
			<INPUT type="text" name="title" value="#q_BannerDescription#" size=36 maxlength=36>
		</CFOUTPUT>
	<CFELSE>
		<INPUT type="text" name="title"  size=36 maxlength=36 value="Enter Banner Title">
	</CFIF>
	</FONT>
	</TD>
</TR>
<TR>
	<TD>&nbsp;&nbsp;&nbsp;</TD>
</TR>
<TR align="center">
	<TD>
		<FONT FACE="arial,helvetica">
			<b>Expiration Date</b>
		</FONT>
	</TD>
</TR>
<TR align="center">
	<TD width=80%>
	<FONT FACE="arial,helvetica">
	<CFIF ModifyMode>
		<CFOUTPUT query="getBanner">
			<INPUT type="text" name="expirationdate" value="#DateFormat(ExpirationDate,'mm/dd/yyyy')#" size="10" maxlength="10">
		</CFOUTPUT>
	<CFELSE>
		<INPUT type="text" name="expirationdate" value="<CFOUTPUT>#DateFormat(DateAdd("m", 1, Now()), 'mm/dd/yyyy')#</CFOUTPUT>" size="10" maxlength="10">
	</CFIF>
	</FONT>
	</TD>
</TR>
<TR>
	<TD>&nbsp;&nbsp;</TD>
</TR>
<TR>
	<TD ALIGN="center">
		<FONT FACE="Arial,Helvetica">
			<b>Select a Banner Template</b>
		</FONT>
	</TD>
</TR>
<TR align="center">
	<TD>
	<TABLE BORDER=0>
		<!--- Linda, 2-9-99: consolidated 140 lines of hard code --->
		<!--- DSF: added maxNumOfBanners var at top 021899 --->
		<CFLOOP index="num" from="1" to="#maxNumOfBanners#">
			<TR align="center">
				<CFOUTPUT>
				<TD valign="middle">
					<INPUT type="radio" name="bannertype" value="#num#" 
						<CFIF ModifyMode>
							<CFIF #num# EQ #getBanner.BannerType#>
								CHECKED
							</CFIF>
						<CFELSEIF #num# EQ 1>
							CHECKED
						</cfif>>
				</TD>
				<TD>
					<IMG SRC="#application.RELATIVE_PATH#/images/blank_banners/f_blank#num#_adbanner_hea.gif">
				</TD>
				</cfoutput>
			</TR>
			<TR>
				<TD COLSPAN=2>&nbsp;</TD>
			</TR>
		</cfloop>
	</TABLE>
	</TD>
</TR>
<TR>
	<TD>&nbsp;</TD>
</TR>
<INPUT type="hidden" name="dealercode" value="<CFOUTPUT>#g_dealercode#</CFOUTPUT>">
<CFIF ModifyMode>
	<INPUT type="hidden" name="bannerid" value="<CFOUTPUT>#getbannerID.BannerID#</CFOUTPUT>">
	<INPUT type="hidden" name="specpromoid" value="<CFOUTPUT>#getbanner.q_SpecPromoID#</CFOUTPUT>">
</CFIF>
<TR align="center">
	<TD><INPUT TYPE="hidden" NAME="nextstep" VALUE="webvrfy_s12.cfm">
	<CFIF ModifyMode>
		<INPUT type="hidden" name="modifyflag" value="1">
	</CFIF>
	<CFIF NewMode>
		<INPUT type="hidden" name="newflag" value="1">
	</CFIF>
	<INPUT TYPE="Image"
		SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg"
		BORDER="0"
		NAME="btnCancel"
		VALUE="Cancel">
	&nbsp;&nbsp;
	<INPUT TYPE="Image"
		SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next_nav.jpg"
		BORDER="0"
		NAME="btnNext"
		VALUE="Next">
	</TD>
</TR>
</FORM>
<TR>
	<TD>&nbsp;&nbsp;&nbsp;</TD>
</TR>
<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
<TR align="center">
	<TD>	
		<INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg"
			Border="0"
			NAME="BackToMain"
			VALUE="Back To Main Menu">
	</TD>
</TR>
</FORM>
<TR>
	<TD>&nbsp;</TD>
</TR>
</TABLE>

</div>
</BODY>
</HTML>