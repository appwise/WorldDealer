<CFSET webverifystep = 11>
<CFINCLUDE template="security.cfm">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

    <!-- ----------------------------------------------------------- -->
    <!--       Created by sigma6, Detroit       -->
    <!--         Copyright (c) 1997, 1998, 1999 sigma6.              -->
    <!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->

    <!-- ----------------------------------------------------------- -->
    <!--     Howard Levine for sigma6, interactive media, Detroit    -->
    <!--    hlevine@sigma6.com   www.sigma6.com    www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
	<!--- $Id: webvrfy_s11.cfm,v 1.6 1999/11/29 15:31:00 lswanson Exp $ --->
	<!--- Promotional Banners --->

<HTML>
<HEAD>
	<TITLE>WorldDealer | Create a New Web</TITLE>

	<CFIF ParameterExists(Form.btnBack.X)>
		<!--- If it's a collection, skip s10, s9, s8 & return to s7 --->
		<CFIF ParameterExists(URL.dlrcode) AND Mid(URL.dlrcode, 6,4) EQ '0000'>
	    	<CFLOCATION URL="webvrfy_s7.cfm?dlrcode=#Form.DealerCode#">
		<cfelse>
			<CFLOCATION url="webvrfy_s10.cfm?dlrcode=#form.dealercode#">
		</cfif>
	</CFIF>
	
    <CFIF ParameterExists(Form.btnNext.X)>
       <CFLOCATION URL="#Form.NextStep#?dlrcode=#Form.DealerCode#">
        </CFIF>
        
        <CFIF ParameterExists(Form.btnModify.X)>
           <CFLOCATION URL="webnew_s11.cfm?dlrcode=#Form.DealerCode#">
    <CFELSE>
       <CFIF ParameterExists(URL.dlrcode)>
          <CFSET VerifyMode = TRUE>
          <CFSET g_DealerCode = #URL.dlrcode#>
       <CFELSE>
          <CFSET VerifyMode = FALSE>
       </CFIF>
    </CFIF>

	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>

<body>
<br><br><br><br><br>

<CFIF VerifyMode>

  <CFQUERY name="getBanners" datasource="#gDSN#">
 	SELECT	SpecialPromotions.ExpirationDate,
			DealerSpecialPromotions.SpecPromoID
	FROM	Banners,DealerBanners,SpecialPromotions,DealerSpecialPromotions
	WHERE DealerSpecialPromotions.DealerWebID = (SELECT DealerWebID FROM DealerWebs WHERE DealerCODE = '#g_DealerCode#') 
	AND		status = '1'
	AND		DealerBanners.bannerid=Banners.bannerid
	AND		SpecialPromotions.SpecPromoID=Banners.specpromoid
	AND 	DealerSpecialPromotions.SpecPromoID = SpecialPromotions.SpecPromoID;
  </CFQUERY>


<div align="center">
<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
<TR>
	<TD ALIGN="center">
		<h3><font face="Arial,Helvetica">
			Maintain Your Web Site
		</font></h3>
	</TD>
</TR>
<TR>
	<TD ALIGN="center">
		<h4><font face="Arial,Helvetica">
			Banners and Special Promotions
		</font></h4>
	</TD>
</TR>
<CFIF #getBanners.recordcount# IS NOT 0>
<TR>
	<TD ALIGN="center">
		<font face="Arial,Helvetica">
			The following Special Promotion Banners are currently associated with
			this Dealership.  Click the 'Modify' button to make changes.
		</font>
	</TD>
</TR>
<TR ALIGN="center">
	<TD>
		<FONT FACE="Arial,Helvetica" SIZE="-1">
			<I>If new Banner does not display properly, try clicking
			the <b>Reload</b> button on your browser.</I>
		</FONT>
	</TD>
</TR>
<TR><TD>&nbsp;<p></TD></TR>
<CFOUTPUT query="getBanners">
<TR>
	<TD ALIGN="center">
		<font face="Arial,Helvetica">
			Expires on: #DateFormat(ExpirationDate,"mmmm d, yyyy")#
		<br>
		<IMG SRC="#application.RELATIVE_PATH#/images/banner/#g_dealercode#_#SpecPromoID#_adbanner_hea.gif">
		</FONT>
	</TD>
</TR>
<TR><TD>&nbsp;</TD></TR>
</CFOUTPUT>
<CFELSE>
<TR align=center>
	<TD>
		<FONT Face="arial,Helvetica">
			There are currently NO Special Promotion Banners Associated with this
			Dealership.  Click the 'Modify' button to make changes.
		</FONT>
	</TD>
</TR>
</CFIF>
<TR><TD>&nbsp;</TD></TR>
<TR align="center">
	<TD>
		<FORM name="webvrfy11" action="webvrfy_s11.cfm?dlrcode=<CFOUTPUT>#g_DealerCode#</CFOUTPUT>" method="post">
			<CFOUTPUT>
				<INPUT type="hidden" name="DealerCode" value="#g_dealercode#">
			</CFOUTPUT>
			<CFIF #Left(AccessLevel,1)# EQ #application.SYSADMIN_ACCESS#>
				<INPUT type="hidden" name="NextStep" value="webvrfy_s12.cfm">
			<CFELSE>
				<INPUT type="hidden" name="NextStep" value="webvrfy_s12d.cfm">
			</CFIF>
			<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/back_nav.jpg"
				BORDER="0"
				NAME="btnBack"
				VALUE="Back">
			&nbsp;&nbsp;
			<INPUT TYPE="Image"
				SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/addmodifydelete_nav.jpg"
				BORDER="0"
				NAME="btnModify"
				VALUE="Modify">
			&nbsp;&nbsp;
			<INPUT TYPE="Image"
				SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next_nav.jpg"
				BORDER="0"
				NAME="btnNext"
				VALUE="Next">
		</FORM>
		<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">		
			<INPUT TYPE="Image"
				SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg"
				Border="0"
				NAME="BackToMain"
				VALUE="Back To Main Menu">
		</FORM>
	</TD>
</TR>
</TABLE>

</div>

</BODY>
</HTML>
</CFIF>