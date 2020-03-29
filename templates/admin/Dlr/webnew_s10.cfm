<CFSET webnewstep = 10>
<CFINCLUDE template="security.cfm">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
    <!-- ----------------------------------------------------------- -->
    <!--                Created by sigma6, Detroit                   -->
    <!--         Copyright (c) 1997, 1998, 1999 sigma6.              -->
    <!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->

    <!-- ----------------------------------------------------------- -->
    <!--      Tim Taylor for sigma6, interactive media, Detroit      -->
    <!--    ttaylor@sigma6.com   www.sigma6.com    www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
	<!--- $Id: webnew_s10.cfm,v 1.10 1999/11/24 22:54:17 lswanson Exp $ --->
	<!--- Coupon Maintenance --->


	
<!--- LINDA: debugging imagegen 
theDebugger on = 1 
theDebugger Off = 0
--->
<CFSET theDebugger=0>
	
	<!--- user hit Cancel from anywhere within this page --->
	<CFIF ParameterExists(Form.btnCancel.X)>
		<CFSET CancelMode = TRUE>
		<CFIF #IsDefined("Form.dealerCode")#>
			<CFLOCATION URL="webvrfy_s10.cfm?dlrcode=#Form.dealerCode#">
		<CFELSE>
			<CFLOCATION URL="webvrfy_s10.cfm?dlrcode=#URL.dlrcode#">
		</CFIF>
	</CFIF>
	
	<!--- assign the dealer code1 --->
	<CFIF ParameterExists(URL.dlrcode)>
		<CFSET g_dealerCode = #URL.dlrcode#>
	<CFELSEIF IsDefined("Form.dealerCode")>
		<CFSET g_dealerCode = #form.dealerCode#>
	<CFELSE>
		<CFSET g_dealerCode = "">
	</CFIF>
	
	<!--- Set all the Modes --------------------------------------------------------------------------------->
	<!--- XXX: use a state variable instead --->
	<CFSET NewMode = FALSE>
	<CFSET ModifyMode = FALSE>
	<CFSET EditMode = FALSE>
	<CFSET SaveMode = FALSE>
	<CFSET DeleteMode = FALSE>
	<CFSET KillMode = FALSE>
	<CFSET ConfirmMode = FALSE>
	<CFSET NextMode = FALSE>
	<CFSET GenerateMode = FALSE>

	<!--- Adding a new coupon for the 1st time --->   
	<CFIF ParameterExists(Form.BtnAdd.X)>
		<CFSET NewMode = TRUE>
	</CFIF>
		
	<CFIF ParameterExists(Form.btnModify.X)>
		<CFSET ModifyMode = TRUE>
	</CFIF>
		
	<CFIF (ParameterExists(URL.dlrcode)) AND (NOT ParameterExists (URL.step)) AND (NOT ParameterExists (URL.confirm))>
		<CFSET EditMode = TRUE>
	</CFIF>
	
	<CFIF ParameterExists(Form.btnSave.X)>
		<CFSET SaveMode = TRUE>
	</CFIF>
		
	<CFIF ParameterExists(Form.BtnDelete.X)>
		<CFSET DeleteMode = TRUE>
	</CFIF>
		
	<CFIF ParameterExists(Form.BtnKill.X)>
		<CFSET KillMode = TRUE>
	</CFIF>
	
	<CFIF #IsDefined("URL.confirm")#>
		<CFSET ConfirmMode = TRUE>
	</CFIF>
		
	<CFIF ParameterExists(Form.btnNext.X)>
		<CFSET NextMode = TRUE>
	</CFIF>
		
	<CFIF ParameterExists(URL.step)>
		<CFSET GenerateMode = TRUE>
	</CFIF>

	
<!--- SAVEMODE --------------------------------------------------------------------------------------------->
<CFIF SaveMode>
	<!--- Replace CR's with <BR>'s --->
	<CFSET #final_text# = #Replace(#form.Description#, Chr(13), "<BR>", "ALL")#>
	<!--- Add Title Before Description --->
	<CFSET #final_text# = #form.couponTitle# & "<P>" & #final_text#>
		
	<CFQUERY name="getDealerWebID" datasource="#gDSN#">
	SELECT
		DealerWebID
	FROM
		DealerWebs
	WHERE
		dealerCode='#g_dealerCode#';
	</CFQUERY>
		
	<CFQUERY name="getCouponID" datasource="#gDSN#">
		SELECT 	CouponTypeID
		FROM 	CouponTypes
		WHERE 	CouponType='#coupontype#'
	</cfquery>
	
	<CFIF ParameterExists(Form.ModifyFlag)>
		<CFQUERY NAME="updCoupon" datasource="#gDSN#">
        UPDATE
			VirtualCoupons
		SET
			Description = '#final_text#',
			CouponTypeID = #getCouponID.coupontypeID#,
			ExpirationDate = #CreateODBCDate(Form.ExpirationDate)#
		WHERE
			VirtualCouponID = #form.CouponID#;
		</CFQUERY>
		<CFSET q_couponID = #form.CouponID#>
	</CFIF>
		
	<CFIF ParameterExists(Form.NewFlag)>
		<CFQUERY NAME="addCoupon" datasource="#gDSN#">
		INSERT INTO VirtualCoupons (
			Description,
			DealerWebID,
			Status,
			CouponTypeID,
			ExpirationDate
			)
		VALUES (
			'#final_text#',
			#getDealerWebID.DealerWebID#,
			'A',
			#getCouponID.coupontypeID#,
			#CreateODBCDate(Form.ExpirationDate)#
			)
		</CFQUERY>
				
		<CFQUERY name="GetNewCoupon" datasource="#gDSN#">
		SELECT
			MAX(VirtualCouponID) as New_Record
		FROM
			VirtualCoupons;
		</CFQUERY>
		<CFSET q_CouponID = #getNewCoupon.New_Record#>
	</CFIF>
	
	<!--- RENAME TEMP COUPON WITH CORRECT NAME SCHEME --->
	<CFQUERY NAME="getTemplates" datasource="#gDSN#">
		SELECT	TemplateLocation
	    FROM	ArtTemplates
	</CFQUERY>

	<CFLOOP query="getTemplates">
		<CFIF #theDebugger# EQ 1>
			<cfoutput>
			<P>&nbsp;</P>
			TEST line 173, loop: #TemplateLocation#<BR>
			</cfoutput>
		</CFIF>	

		<CFFILE action="rename"
			SOURCE="#g_rootdir#\images\coupons\temp_#TemplateLocation#_#form.tmpid#_coupon.gif"
			DESTINATION="#g_rootdir#\images\coupons\#g_dealerCode#_#TemplateLocation#_#q_CouponID#_coupon.gif">
	</CFLOOP>
	<CFLOCATION url="webvrfy_s10.cfm?dlrcode=#g_dealerCode#">
</CFIF>
	
<!--- KILLMODE --------------------------------------------------------------------------------------------->
<CFIF KillMode>
	<CFQUERY name="KillCoupon" datasource="#gDSN#">
	UPDATE
		VirtualCoupons
	SET
		Status = 'I'
	WHERE
		VirtualCouponID = #form.CouponID#;
	</CFQUERY>
	<CFLOCATION url="webvrfy_s10.cfm?dlrcode=#g_dealerCode#">
</CFIF>


<!--- user chose to add a new coupon or modify an existing coupon -------------------------------------------->
<CFIF NewMode OR ModifyMode>
	<!--- get ArtTempID to bring up correct template type. DealerWebs.ArtTempID = ArtTemplates.TemplateLocation --->
	<CFQUERY name="getDlrArtTemp" datasource="#gDSN#">
		SELECT 	ArtTempID 
		FROM 	DealerWebs
		WHERE 	DealerCode = '#g_dealerCode#'
	</CFQUERY>

	<CFIF ModifyMode>
		<CFQUERY NAME="getCoupon" datasource="#gDSN#">
		SELECT	VirtualCouponID,
				Description,
				CouponTypeID,
				ExpirationDate
		FROM 	VirtualCoupons
		WHERE	VirtualCouponID = #Form.CouponID#;
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
		<h3><font face="Arial, Helvetica">
			Dealer Administration - Create a New Web
		</font></h3>
	</TD>
</TR>
<TR>
	<TD ALIGN="center">
		<h4><font face="Arial, Helvetica">
			Coupon Maintenance
		</font></h4>
	</TD>
</TR>
<FORM NAME="StepTen" ACTION="webnew_s10.cfm" METHOD="post">
<TR ALIGN="center">
	<TD>
		<FONT FACE="Arial, Helvetica">
			Enter the following information. Required fields are bolded.
		</FONT>
	</TD>
</TR>
<TR>
	<TD>&nbsp;&nbsp;&nbsp;</TD>
</TR>
<TR align="center">
	<TD>
		<FONT FACE="arial, helvetica">
			<b>Coupon Title</b>
		</FONT>
	</TD>
</TR>
<TR align="center">
	<TD>
		<FONT FACE="arial, helvetica">
		<CFIF ModifyMode>
			<CFLOOP query="getCoupon">
				<CFSET section_break = #Find("<P>", Description, 1)#>
				<CFSET couponTitle = #Left(Description, (section_break-1))#>
				<CFSET couponTitle = #Replace(couponTitle, "<BR>", "~", "ALL")#>
<CFIF #theDebugger# EQ 1>
	<cfoutput>
		<P>&nbsp;</P>
		TEST line 434, Description: #Description#.  couponTitle: #couponTitle#.<BR>
	</cfoutput>
</CFIF>	
			
				<INPUT type="text" name="couponTitle" value="<CFOUTPUT>#couponTitle#</CFOUTPUT>" size=12 maxlength="36">
			</CFLOOP>
		<CFELSE>
			<INPUT type="text" name="couponTitle" size=12 value="Coupon Title"  maxlength="36">
		</CFIF>
		<INPUT TYPE="hidden" name="couponTitle_required" value="Please enter the Coupon Title, as it should appear on the coupon.">
		</FONT>
	</TD>
</TR>
<TR>
	<TD>&nbsp;&nbsp;</TD>
</TR>
<TR align="center">
	<TD>
		<FONT Face="Arial, Helvetica">
			<b>Select a Coupon Type</b>
		</FONT>
	</TD>
</TR>
<TR>
	<TD>&nbsp;</TD>
</TR>
<TR align="center">
	<TD>
	<TABLE BORDER=0>
	<CFQUERY name="getCouponTypes" datasource="#gDSN#">
		SELECT 	CouponTypeID, 
				CouponType
		FROM 	CouponTypes
		ORDER BY CouponTypeID
	</cfquery>
	
	<!--- Loop through all coupon types --->
	<cfloop query="getCouponTypes">
		<CFOUTPUT>
		<TR>
			<TD align="center" valign="middle">
				<INPUT type="radio" name="coupontype" value="#CouponType#" 
					<CFIF ModifyMode>
						<CFIF #getCoupon.CouponTypeID# EQ #CouponTypeID#>CHECKED</cfif>
					<CFELSE>
						<CFIF #CouponTypeID# EQ 1>CHECKED</cfif>
					</cfif>>
			</TD>
			<TD>
				<IMG SRC="#application.RELATIVE_PATH#/images/blank_coupons/f_#getDlrArtTemp.ArtTempID#_#CouponType#_coupon_blank.gif" alt="#CouponType#">
			</TD>
		</TR>
		</cfoutput>
		<TR>
			<TD colspan=2>&nbsp;</TD>
		</TR>
	</cfloop>
 	</TABLE>
	</TD>
</TR>
<TR>
	<TD>&nbsp;</TD>
</TR>
<INPUT type="hidden" name="dealerCode" value="<CFOUTPUT>#g_dealerCode#</CFOUTPUT>">
<INPUT type="hidden" name="TemplateLocation" value="<CFOUTPUT>#getDlrArtTemp.ArtTempID#</CFOUTPUT>">
<CFIF ModifyMode>
	<INPUT type="hidden" name="couponid" value="<CFOUTPUT>#form.CouponID#</CFOUTPUT>">
</cfif>
<TR align="center">
	<TD>
		<INPUT TYPE="hidden" NAME="NextStep" VALUE="webvrfy_s11.cfm">
		<!--- Adding a new coupon for the 1st time --->
		<CFIF NewMode>
			<INPUT type="hidden" name="newflag" value="1">
		<CFELSEIF ModifyMode>
			<INPUT type="hidden" name="modifyflag" value="1">
		</CFIF>
		<INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next_nav.jpg"
			BORDER="0"
			NAME="btnNext"
			VALUE="Next">
		</form>
		<FORM NAME="StepTen" ACTION="webnew_s10.cfm" METHOD="post">
		<INPUT type="hidden" name="dealerCode" value="<CFOUTPUT>#g_dealerCode#</CFOUTPUT>">
		<INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg"
			BORDER="0"
			NAME="btnCancel"
			VALUE="Cancel">
		</form>
	</TD>
</TR>
<TR>
	<TD>&nbsp;&nbsp;&nbsp;</TD>
</TR>
<TR align="center">
<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
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
</CFIF>

<!--- user clicked add/modify/delete -------------------------------------------------------------->
<CFIF EditMode>
	<CFQUERY name="getCoupons" datasource="#gDSN#">
		SELECT
			Description,
			VirtualCouponID,
			CouponTypeID,
			ExpirationDate
  		FROM
			VirtualCoupons
  		WHERE
			Status='A'
			AND DealerWebID IN (SELECT DealerWebID FROM DealerWebs WHERE dealerCode = '#g_dealerCode#');
	</CFQUERY>

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
		<h3><font face="Arial, Helvetica">
			Dealer Administration - Create a New Web
		</font></h3>
	</TD>
</TR>
<TR>
	<TD ALIGN="center">
		<h4><font face="Arial, Helvetica">
			Coupon Maintenance
		</font></h4>
	</TD>
</TR>
<FORM NAME="StepTen" ACTION="webnew_s10.cfm" METHOD="post">
<CFIF #GetCoupons.RecordCount# IS NOT '0'>
	<TR>
		<TD ALIGN="center">
			<font face="Arial, Helvetica">
				Please select the Coupon you wish to Modify
			<p>&nbsp;
			</FONT>
		</TD>
	</TR>
	<TR>
		<TD ALIGN="center">
		<TABLE BORDER=0 CELLSPACING=3 CELLPADDING=0 WIDTH="80%">
		<CFLOOP query="getCoupons">
			<CFSET section_break = #Find("<P>", Description, 1)#>
			<CFSET how_long = #Len(Description)#>
			<CFSET title = #Left(Description, (section_break-1))#>
			<!--- LINDA: wouldn't how_long bump it off the end of the string, if you're starting in the middle of the string???? --->
			<CFSET coupon_text = #Mid(Description, (section_break + 3), how_long)#>
<CFIF #theDebugger# EQ 1>
	<cfoutput>
		<P>&nbsp;</P>
		TEST line 270, Description: #Description#.  how_long: #how_long#.  title: #title#.  coupon_text: #coupon_text#<BR>
	</cfoutput>
</CFIF>	
			<TR>
				<TD ALIGN="center" valign="middle">
					<INPUT type="radio"
						name="CouponID"
						value="<CFOUTPUT>#VirtualCouponID#</CFOUTPUT>"
						<CFIF #getCoupons.CurrentRow# EQ 1>CHECKED</CFIF>>
				</TD>
				<TD ALIGN="center" BGCOLOR=cccccc>
					<FONT Face="Arial, Helvetica">
						<h3><CFOUTPUT>#title#</CFOUTPUT></h3>
					<p>
						<CFOUTPUT>#coupon_text#</CFOUTPUT>
					<BR><BR>
					</FONT>
				</TD>
			</TR>
		</CFLOOP>
		</TABLE>
		</TD>
	</TR>
<CFELSE>
	<TR align="center">
		<TD>
			<FONT Face="Arial, Helvetica">
				There are currently NO Coupons Associated with this Dealership.
			</FONT>
		</TD>
	</TR>
</CFIF>
<TR>
	<TD>&nbsp;</TD>
</TR>
<INPUT TYPE="hidden" name="dealerCode" value="<CFOUTPUT>#g_dealerCode#</CFOUTPUT>">
<CFIF #getCoupons.RecordCount# IS NOT 0>
	<TR>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
	</TR>
	<TR align="center">
		<TD>
			<FONT SIZE=2 FACE="arial, helvetica">
				<INPUT TYPE="Image"
					SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/deletecoupon.jpg"
					BORDER="0"
					name="BtnDelete"
					value="Delete Coupon">
				&nbsp;&nbsp;&nbsp;
				<INPUT TYPE="Image"
					SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/modifycoupon.jpg"
					BORDER="0"
					name="BtnModify"
					value="Modify Coupon">
			</FONT>
		</TD>
	</TR>
</CFIF>
<TR>
	<TD>&nbsp;&nbsp;&nbsp;</TD>
</TR>
<TR align="center">
	<TD>
		<FONT SIZE=2 FACE="arial, helvetica">
			<INPUT TYPE="Image"
				SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg"
				BORDER="0"
				NAME="btnCancel"
				VALUE="Cancel">
			&nbsp;&nbsp;&nbsp;
			<INPUT TYPE="Image"
				SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/addcoupon.jpg"
				BORDER="0"
				name="BtnAdd"
				value="Add Coupon">
		</FONT>
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
<P ALIGN=CENTER>

</div>
</BODY>
</CFIF>

<!--- user chose to delete a coupon, confirm the deletion ---------------------------------------------------->
<CFIF DeleteMode>
	<CFQUERY NAME="GetCoupon" datasource="#gDSN#">
		SELECT
			VirtualCoupons.Description,
 			VirtualCoupons.DealerWebID,
			VirtualCoupons.VirtualCouponID,
			DealerWebs.ArtTempID,
			DealerWebs.dealerCode
		FROM
			VirtualCoupons,
			DealerWebs
		WHERE
			VirtualCouponID = #Form.CouponID#
			AND VirtualCoupons.DealerWebID = DealerWebs.DealerWebID;
	</CFQUERY>

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
		<h3><font face="Arial, Helvetica">
			Dealer Administration - Create a New Web
		</font></h3>
	</TD>
</TR>
<TR>
	<TD ALIGN="center">
		<h4><font face="Arial, Helvetica">
			Coupon Maintenance
		</font></h4>
	</TD>
</TR>
<FORM NAME="StepNine" ACTION="webnew_s10.cfm" METHOD="post">
<TR align="center">
	<TD>
		<FONT Face="arial, Helvetica">
			You are about to permanently Delete the following Coupon.  Are you
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
	<CFOUTPUT query="getCoupon">
	<TR align="center">
		<TD>
			<FONT FACE="arial, helvetica">
				<IMG SRC="#application.RELATIVE_PATH#/images/coupons/#Trim(dealerCode)#_#artTempID#_#VirtualCouponID#_coupon.gif">
			<br>
				#description#
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
<INPUT type="hidden" name="CouponID" value="<CFOUTPUT>#form.CouponID#</CFOUTPUT>">
<INPUT type="hidden" name="dealerCode" value="<CFOUTPUT>#g_dealerCode#</CFOUTPUT>">
<TR align="center">
	<TD>
		<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg"
			BORDER="0"
			NAME="btnCancel"
			VALUE="Cancel">
		&nbsp;&nbsp;&nbsp;
		<INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/deletecoupon.jpg"
			BORDER="0"
			name="BtnKill"
			value="Delete Coupon">
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
</CFIF>

<!--- next step after entering a title and choosing a coupon type ---------------------------------------------->
<CFIF NextMode>
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
		<h3><font face="Arial, Helvetica">
			Dealer Administration - Create a New Web
		</font></h3>
	</TD>
</TR>
<TR>
	<TD ALIGN="center">
		<h4><font face="Arial, Helvetica">
			Coupon Maintenance
		</font></h4>
	</TD>
</TR>
<TR>
	<TD>&nbsp;</TD>
</TR>
<TR align="center">
	<TD>
		<FONT Face="Arial, Helvetica">
			Select from the list of style attributes below
		</FONT>
	</TD>
</TR>
<TR>
	<TD>&nbsp;</TD>
</TR>
<!--- because there's URL.step, it goes into GenerateMode --->
<FORM ACTION="<CFOUTPUT>#g_relpath#/templates/admin/dlr/webnew_s10.cfm?step=0&dlrcode=#g_dealerCode#</CFOUTPUT>" method="post">
<INPUT type="hidden" name="couponTitle" value="<CFOUTPUT>#form.couponTitle#</CFOUTPUT>">
<INPUT type="hidden" name="coupontype" value="<CFOUTPUT>#form.coupontype#</CFOUTPUT>">
<CFIF IsDefined("Form.ModifyFlag")>
	<INPUT TYPE="hidden" NAME="ModifyFlag" VALUE="1">
	<INPUT TYPE="hidden" NAME="couponid" VALUE="<CFOUTPUT>#form.couponID#</CFOUTPUT>">
<CFELSEIF IsDefined("FORM.NewFlag")>
	<INPUT TYPE="hidden" NAME="NewFlag" VALUE="<CFOUTPUT>#Form.NewFlag#</CFOUTPUT>">
</CFIF>
<TR ALIGN="CENTER">
	<TD>
	<TABLE BORDER=0>
	<TR VALIGN="Top">
		<TD>
			<FONT Face="Arial, Helvetica">
			Horizontal Alignment
			</FONT>
		</TD>
		<TD>
			<FONT FACE="Arial, Helvetica">
				<SELECT name="xcord">
					<OPTION value="Center" SELECTED>Center
					<OPTION value="20">Left
				</SELECT>
			</FONT>
		</TD>
	</TR>
	<TR>
		<TD COLSPAN=2>&nbsp;</TD>
	</TR>
	<TR VALIGN="Top">
		<TD>
			<FONT FACE="Arial, Helvetica">
				Vertical Alignment
			</FONT>
		</TD>
		<TD>
			<FONT FACE="Arial, Helvetica">
				<SELECT NAME="ycord">
					<OPTION value="Middle" SELECTED>Middle
					<OPTION value="20">Top
				</SELECT>
			</FONT>
		</TD>
	</TR>
	<TR>
		<TD COLSPAN=2>&nbsp;</TD>
	</TR>
	<TR valign="Top">
		<TD>
			<FONT FACE="Arial, Helvetica">
				Font Size
			</FONT>
		</TD>
		<TD>
			<FONT FACE="Arial, Helvetica">
				<SELECT name="size">
					<OPTION>8
					<OPTION>9
					<OPTION>10
					<OPTION>11
					<OPTION>12
					<OPTION>14
					<OPTION>16
					<OPTION>18
					<OPTION>20
					<OPTION>22
					<OPTION SELECTED>24
					<OPTION>26
					<OPTION>28
					<OPTION>36
				</SELECT>
			</FONT>
		</TD>
	</TR>
	<TR>
		<TD COLSPAN=2>&nbsp;</TD>
	</TR>
	<TR valign="top">
		<TD>
			<FONT Face="Arial, Helvetica">
				Font Style
			</FONT>
		</TD>
		<TD>
			<FONT FACE="Arial, Helvetica">
				<SELECT name="fontname">
					<OPTION SELECTED VALUE="Arial,Helvetica">Plain
					<OPTION VALUE="Arial,Helvetica Bold">Bold
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
			<FONT Face="Arial, Helvetica">
				Color
			</FONT>
		</TD>
		<TD>
			<FONT FACE="Arial, Helvetica">
				<SELECT NAME="color">
					<OPTION selected VALUE="black">Black
					<OPTION VALUE="white">White
					<OPTION VALUE="blue">Blue
					<OPTION VALUE="cyan">Cyan
					<OPTION VALUE="darkGray">DarkGray
					<OPTION VALUE="gray">Gray
					<OPTION VALUE="green">Green
					<OPTION VALUE="lightGray">LightGray
					<OPTION VALUE="magenta">Magenta
					<OPTION VALUE="orange">Orange
					<OPTION VALUE="pink">Pink
					<OPTION VALUE="red">Red
					<OPTION VALUE="yellow">Yellow
				</SELECT>
			</FONT>
		</TD>
	</TR>
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
		<INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg"
			BORDER="0"
			value="Cancel"
			name="btnCancel">
		&nbsp;&nbsp;&nbsp;
		<INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next_nav.jpg"
			BORDER="0"
			value="Show Coupon"
			name="btnShow">
	</TD>
</TR>
</FORM>
<TR>
	<TD>&nbsp;</TD>
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
</CFIF>

<!--- generate coupon images ----------------------------------------------------------------------------------->
<CFIF GenerateMode>
<HEAD>
	<TITLE>WorldDealer Administration | Create a Web</TITLE>
	<SCRIPT LANGUAGE="JavaScript">
		<!--
			function submitevent() { parent.document.myform.submit(); } 
		//-->
	</SCRIPT>
	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>
		
<BODY OnLoad="submitevent();">
<br><br><br><br><br>

<div align="center">
<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
<FORM ACTION="coupon_redirect.cfm?dlrcode=<CFOUTPUT>#g_dealerCode#</CFOUTPUT>" method="post" name="myform">
<CFIF isDefined("Form.modifyFlag")>
	<INPUT TYPE="hidden" NAME="modifyFlag" VALUE="1">
	<INPUT TYPE="hidden" NAME="couponID" VALUE="<CFOUTPUT>#Form.couponID#</CFOUTPUT>">
<CFELSEIF isDefined("Form.newFlag")>
	<INPUT TYPE="hidden" NAME="newFlag" VALUE="1">
</CFIF>
<INPUT TYPE="hidden" NAME="couponType" VALUE="<CFOUTPUT>#form.couponType#</CFOUTPUT>">
<INPUT TYPE="hidden" name="textstring" value="<CFOUTPUT>#URLEncodedFormat(Form.couponTitle)#</CFOUTPUT>">
<INPUT type="hidden" name="fontname" value="Arial,Helvetica">
<INPUT type="hidden" name="xcord" value="<CFOUTPUT>#Form.xcord#</CFOUTPUT>">
<INPUT type="hidden" name="ycord" value="<CFOUTPUT>#Form.ycord#</CFOUTPUT>">
<INPUT type="hidden" name="size" value="<CFOUTPUT>#Form.size#</CFOUTPUT>">
<INPUT type="hidden" name="style" value="<CFOUTPUT>#Form.style#</CFOUTPUT>">
<INPUT type="hidden" name="color" value="<CFOUTPUT>#Form.color#</CFOUTPUT>">
</FORM>

<div align="center">
<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=520 BGCOLOR="FFFFFF">
<TR>
	<TD>&nbsp;<p></TD>
</TR>
<TR>
	<TD ALIGN="center">
		<h3><FONT FACE="Arial, Helvetica">
			Dealer Administration - Create New Web
		</FONT></h3>
	</TD>
</TR>
<TR>
	<TD ALIGN="center">
		<h4><font face="Arial, Helvetica">
			Coupons Maintenance
		</font></h4>
	</TD>
</TR>
<TR>
	<TD>&nbsp;</TD>
</TR>
<TR>
	<TD ALIGN="center">
		<FONT FACE="Arial, Helvetica">
			Please Wait While Your Custom Coupons are Created.
		<BR>
			This may take a minute, please be patient.
		<BR><BR>
			<I><B>Do not hit the stop button on your browser!</B></I>
		</FONT>
	</TD>
</TR>
<TR>
	<TD ALIGN=CENTER>
		<IMG SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/wheelfw.gif"
			BORDER=0
			AlT="Please be patient.">
	</TD>
</TR>
<TR>
	<TD>&nbsp;</TD>
</TR>

<!--- </TABLE> footer closes out the table --->
</div>
</BODY>
</CFIF>

<!-------------------------------------------------------------------------------------------------------------
	after coupons generated, confirm saving modified or new coupon to the database.
	Variables must be passed in the URL.
--------------------------------------------------------------------------------------------------------------->
<CFIF ConfirmMode>
	<CFQUERY name="getDlrArtTemp" datasource="#gDSN#">
		SELECT	ArtTempID 
		FROM	DealerWebs
		WHERE	dealerCode = '#g_dealerCode#';
	</CFQUERY>

	<CFIF IsDefined("URL.ModifyFlag")>
		<CFQUERY name="getCoupon" datasource="#gDSN#">
			SELECT 	Description,
					ExpirationDate
			FROM 	VirtualCoupons
			WHERE 	VirtualCouponID = #URL.CouponID#
		</CFQUERY>
		<CFSET section_break = #Find("<P>", getCoupon.Description, 1)#>
		<CFSET how_long = #Len(GetCoupon.Description)#>
		<CFSET title = #Left(GetCoupon.Description, (section_break-1))#>
		<!--- LINDA: wouldn't how_long bump it off the end of the string, if you're starting in the middle of the string???? --->		
		<CFSET coupon_text = #Mid(GetCoupon.Description, (section_break + 3), how_long)#>
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
<TR ALIGN="center">
	<TD ALIGN="middle">
		<h3><font face="Arial, Helvetica">
			Dealer Administration - Create a New Web
		</font></h3>
	</TD>
</TR>
<TR ALIGN="center">
	<TD ALIGN="middle">
		<h4><font face="Arial, Helvetica">
			Coupon Maintenance
		</font></h4>
	</TD>
</TR>
<FORM NAME="StepTen" ACTION="webnew_s10.cfm" METHOD="post">
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
		<CFIF IsDefined("URL.Modifyflag")>
			<CFOUTPUT query="getCoupon">
				<INPUT type="text" name="expirationdate" value="#DateFormat(ExpirationDate,'mm/dd/yyyy')#" size="10" maxlength="10">
			</CFOUTPUT>
		<CFELSE>
			<INPUT type="text" name="expirationdate" value="<CFOUTPUT>#DateFormat(DateAdd("m", 1, Now()), 'mm/dd/yyyy')#</CFOUTPUT>" size="10" maxlength="10">
		</CFIF>
		</FONT>
	</TD>
</TR>
<TR>
	<TD>&nbsp;&nbsp;&nbsp;</TD>
</TR>
<TR align="center">
	<TD>
		<FONT FACE="arial, helvetica">
			<b>Description</b>
		</FONT>
	</TD>
</TR>
<TR align="center">
	<TD width=80%>
		<FONT  FACE="arial, helvetica">
		<CFIF IsDefined("URL.Modifyflag")>
			<!--- Remove <BR> tags and re-format --->
			<CFSET Mod_coupon_text = #Replace(coupon_text, "<BR>", Chr(13), "ALL")#>
			<TEXTAREA name="description"
						cols="30"
						rows="10"
						wrap="PHYSICAL"><CFOUTPUT>#mod_coupon_text#</CFOUTPUT></TEXTAREA>
		<CFELSE>
			<TEXTAREA name="description"
				cols="30"
				rows="10"
				wrap="PHYSICAL">Coupon Description</TEXTAREA>
		</CFIF>
		</FONT>
	</TD>
</TR>
<TR>
	<TD>&nbsp;</TD>
</TR>
<TR ALIGN="center">
	<TD>
		<FONT FACE="Arial, Helvetica">
			The following Coupon will be saved in the database.
		</FONT>
	</TD>
</TR>
<TR>
	<TD>&nbsp;&nbsp;&nbsp;</TD>
</TR>
<TR align="center">
	<TD>
		<CFOUTPUT query="getDlrArtTemp">
			<IMG SRC="#application.RELATIVE_PATH#/images/coupons/temp_#ArtTempID#_#url.tmpid#_coupon.gif">
			<br>
			<FONT FACE="Arial, Helvetica">
				#Replace(URL.couponTitle, "~", "<BR>", "ALL")#
			</FONT>
		</CFOUTPUT>
	</TD>
</TR>
<TR>
	<TD>&nbsp;</TD>
</TR>
<FORM action="webnew_s10.cfm" method="post">
	<INPUT type="hidden" name="dealerCode" value="<CFOUTPUT>#g_dealerCode#</CFOUTPUT>">
	<INPUT type="hidden" name="couponTitle" value="<CFOUTPUT>#Replace(URL.couponTitle, "~", "<BR>", "ALL")#</CFOUTPUT>">
	<INPUT type="hidden" name="tmpid" value="<CFOUTPUT>#URL.tmpid#</CFOUTPUT>">
	<INPUT TYPE="hidden" NAME="NextStep" VALUE="webvrfy_s11.cfm">
	<INPUT type="hidden" name="coupontype" value="<CFOUTPUT>#URL.coupontype#</CFOUTPUT>">
	<CFIF ParameterExists(URL.ModifyFlag)>
		<INPUT type="hidden" name="ModifyFlag" value="1">
		<INPUT type="hidden" name="CouponID" value="<CFOUTPUT>#URL.CouponID#</CFOUTPUT>">
	<CFELSE>
		<INPUT type="hidden" name="NewFlag" value="1">
	</CFIF>
<TR align="center">
	<TD>
		<INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg"
			BORDER="0"
			NAME="btnCancel"
			VALUE="Cancel">
		&nbsp;&nbsp;
		<INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/savecoupon.jpg"
			BORDER="0"
			NAME="btnSave"
			VALUE="Save Coupon">
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
</CFIF>

</HTML>