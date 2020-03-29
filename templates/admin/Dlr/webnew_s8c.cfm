<CFINCLUDE template="security.cfm">
    <!-- ----------------------------------------------------------- -->
    <!--       Created by sigma6, Detroit       -->
    <!--         Copyright (c) 1997, 1998, 1999 sigma6.              -->
    <!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->

    <!-- ----------------------------------------------------------- -->
    <!--     John Turner for sigma6, interactive media, Detroit      -->
    <!--    jturner@sigma6.com   www.sigma6.com    www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
	<!--- $Id: webnew_s8c.cfm,v 1.7 1999/11/24 22:54:20 lswanson Exp $ --->
	<!--- Offers --->



    <CFIF (ParameterExists(URL.dlrcode)) AND (ParameterExists(URL.Offer))>
           <CFSET g_DealerCode = #URL.dlrcode#>
           <CFSET EditMode = TRUE>
           <CFSET NewMode = FALSE>
           <CFSET SaveMode = FALSE>
		   <CFSET CancelMode = FALSE>
		   <CFSET g_offerID= #URL.offer#>
        <CFELSE>
           <CFSET g_DealerCode = "">
           <CFSET NewMode = TRUE>
           <CFSET EditMode = FALSE>
           <CFSET SaveMode = FALSE>
		   <CFSET CancelMode = FALSE>
     </CFIF>
	  
	  <CFIF ParameterExists(URL.new)>
	  	<CFSET g_DealerCode=#URL.dlrcode#>
		<CFSET g_offerID = #URL.offer#>
		<CFSET EditMode = FALSE>
		<CFSET NewMode = TRUE>
	 </CFIF>
       
	  <CFIF ParameterExists(FORM.new)>
	  	<CFSET g_DealerCode=#FORM.dealercode#>
		<CFSET g_offerID = #FORM.OfferID#>
		<CFSET NewMode = TRUE>
		<CFSET EditMode = FALSE>
	</CFIF>

    <CFIF ParameterExists(Form.btnCancel.X)>
           <CFSET CancelMode = TRUE>
		   <CFSET g_dealerCode=#Form.DealerCode#>
        </CFIF>
		
	<CFIF ParameterExists(Form.btnNext.X)>
		<CFSET g_dealerCode=#Form.DealerCode#>
		<CFSET g_OfferID = #Form.OfferID#>
		<!--- In case CFABORT doesn't work --->
		<!--- Temporary patch, remind me to fix this later. -HML  ---->
		<CFSET CancelMode = FALSE>
		<CFSET NewMode = FALSE>
		<CFSET EditMode = FALSE>
		<CFSET SaveMode = FALSE>
		<CFSET why_does_it_not_work = TRUE>
		<CFINCLUDE template="di_template2.cfm">
		<CFABORT>
	</CFIF>

		
	<CFIF CancelMode>
		<CFIF ParameterExists (Form.OfferID)>
			<CFSET g_offerID = #Form.OfferID#>
		</CFIF>

		<CFIF ParameterExists (Form.Offer)>
			<CFSET g_offerID =#form.offer#>
		</CFIF>

		<CFIF ParameterExists(FORM.new)>
		<!--- Delete NEW offer from Database --->
			<CFQUERY name="getDealerWebID" datasource="#gDSN#">
			SELECT DealerWebID
			FROM DealerWebs
			WHERE DealerCode='#g_dealercode#';
			</CFQUERY>
	
			<CFQUERY name="deleteDealerOffer" datasource="#gDSN#">
			DELETE FROM DealerOffers
			WHERE OfferID=#g_offerID# AND
			DealerWebID=#GetDealerWebID.DealerWebID#;
			</CFQUERY>

			<CFQUERY name="deleteOffer" datasource="#gDSN#">
			DELETE FROM Offers
       		WHERE OfferID=#g_offerID#;
			</CFQUERY>
		</CFIF>
           <CFLOCATION URL="webvrfy_s8.cfm?dlrcode=#Form.DealerCode#">
	</CFIF> <!--- CFIF CancelMode --->
	

<CFIF (EditMode) AND (NOT (IsDefined("why_does_it_not_work")))>
<HEAD>
	<TITLE>WorldDealer | Create a New Web</TITLE>
	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>
<body>
<br><br><br><br><br>
<CFQUERY name="GetID" datasource="#gDSN#">
	SELECT OfferDisclaimers.TemplateID as q_TemplateID
	FROM Offers, OfferDisclaimers
	WHERE Offers.OfferID = #g_offerID#
	AND OfferDisclaimers.DisclaimerID = Offers.DisclaimerID;
</CFQUERY>

<div align="center">
<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
<TR ALIGN="center">
	<TD ALIGN="middle">
		<h3><font face="Arial,Helvetica">
			Dealer Administration - Create a New Web
		</font></h3>
	</TD>
</TR>
<TR><TD>&nbsp;</TD></TR>
<TR>
	<TD>
	<TABLE BORDER=1 ALIGN=CENTER VALIGN=TOP>
	<TR>
		<TD COLSPAN=2 BGCOLOR=CCCCCC ALIGN=CENTER>
			<FONT FACE="Arial,Helvetica">
			<br>
			Please choose a Disclaimer Template:
			<br><br>
			</FONT>
			<FONT FACE="Arial,Helvetica" COLOR="##ff0000">
				<b>Customizable text appears in Red.</b>
			</FONT>
		</TD>
	</TR>
	<FORM action="webnew_s8c.cfm" method="post">
	<TR>
		<TD ALIGN=CENTER VALIGN=MIDDLE>
			<INPUT type="radio" name="templateID" value="1" <CFIF #getID.q_templateID# IS '1'> CHECKED </CFIF>>
		</TD>
		<TD ALIGN=LEFT>
			<FONT FACE="Arial,Helvetica">
				<b>MSRP:</b>
			<br>
				MSRP. Title and taxes extra.
			</FONT>
		</TD>
	</TR>
	<TR>
		<TD ALIGN="center" valign="middle">
			<input type="Radio" name="templateID" value="0" <CFIF #getID.q_templateID# IS '0'> CHECKED</CFIF>>
		</TD>
		<TD align="left">
			<FONT FACE="Arial,Helvetica">
				<b>Custom:</b>
			<br>
				Enter a custom disclaimer.
			</FONT>
		</TD>
	</TR>
	<TR>
		<TD COLSPAN=2 ALIGN=center>
			<BR><BR>
				<CFOUTPUT>
					<INPUT TYPE="hidden" NAME="DealerCode" VALUE=#g_DealerCode#>
					<INPUT type="hidden" NAME="offerID" value="#g_offerID#">
				</CFOUTPUT>
				<INPUT TYPE="hidden" NAME="NextStep" VALUE="webnew_s9.cfm">
				<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg" BORDER="0" NAME="btnCancel" VALUE="Cancel">
				&nbsp;&nbsp;
				<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next_nav.jpg" BORDER="0" NAME="btnNext" VALUE="Next">
			</FORM>
			<p>
			<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
				<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg" Border="0" NAME="BackToMain" VALUE="Back To Main Menu">
			</FORM>
		</TD>
	</TR>
	</TABLE>
	</TD>		
</TR>
</TABLE>
</div>
</BODY>
</HTML>
</CFIF>  <!--- CFIF Editmode --->

<CFIF (NewMode) AND (NOT (IsDefined("why_does_it_not_work")))>
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
		<h3><font face="Arial,Helvetica">
			Dealer Administration - Create a New Web
		</font></h3>
	</TD>
</TR>
<TR>
	<TD>&nbsp;</TD>
</TR>
<TR>
	<TD>
	<TABLE BORDER=1 ALIGN=CENTER VALIGN=TOP>
	<TR>
		<TD COLSPAN=2 BGCOLOR=CCCCCC ALIGN=CENTER>
			<FONT FACE="Arial,Helvetica">
			<br>
				Please choose a Disclaimer Template:
			<br><br>
			</FONT>
			<FONT FACE="Arial,Helvetica" COLOR="##ff0000">
				<b>Customizable text appears in Red.</b>
			</FONT>
		</TD>
	</TR>
<FORM action="webnew_s8c.cfm" method="post">
		<TR>
		<TD ALIGN=CENTER VALIGN=MIDDLE>
			<INPUT type="radio" name="templateID" value="1" CHECKED>
		</TD>
		<TD ALIGN=LEFT>
			<FONT FACE="Arial,Helvetica">
				<b>MSRP:</b>
			<br>
				MSRP. Title and taxes extra.
			</FONT>
		</TD>
	</TR>
	<TR>
		<TD ALIGN="center" valign="middle">
			<input type="Radio" name="templateID" value="0">
		</TD>
		<TD align="left">
			<FONT FACE="Arial,Helvetica">
				<b>Custom:</b>
			<br>
				Enter a custom disclaimer.
			</FONT>
		</TD>
	</TR>
	<TR>
		<TD COLSPAN=2 ALIGN=center>
			<BR><BR>
				<CFOUTPUT>
					<INPUT TYPE="hidden" NAME="DealerCode" VALUE=#g_DealerCode#>
					<INPUT type="hidden" NAME="offerID" value="#g_offerID#">
				</CFOUTPUT>
				<INPUT TYPE="hidden" NAME="NextStep" VALUE="webnew_s9.cfm">
				<INPUT type="hidden" name="new" value="1">
				<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg" BORDER="0" NAME="btnCancel" VALUE="Cancel">
				&nbsp;&nbsp;
				<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next_nav.jpg" BORDER="0" NAME="btnNext" VALUE="Next">
			</FORM>
			<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
				<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg" Border="0" NAME="BackToMain" VALUE="Back To Main Menu">
			</FORM>
		</TD>
	</TR>
	</TABLE>
	</TD>		
</TR>
</TABLE>
</div>
</BODY>
</HTML>
</CFIF>
<div align="center">

</div>