<CFINCLUDE template="security.cfm">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

    <!-- ----------------------------------------------------------- -->
    <!--                 Created by sigma6, Detroit                  -->
    <!--            Copyright (c) 1997, 1998, 1999 sigma6.           -->
    <!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->

    <!-- ----------------------------------------------------------- -->
    <!--    Howard Levine for sigma6, interactive media, Detroit     -->
    <!--    hlevine@sigma6.com   www.sigma6.com    www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
	<!--- $Id: di_template3.cfm,v 1.6 1999/11/29 15:33:22 lswanson Exp $ --->



<CFSET g_dealercode = #form.dealercode#>
<CFSET g_offerID = #FORM.OfferID#>

<CFIF ParameterExists (FORM.BtnCancel.X)>
	<CFIF ParameterExists(FORM.new)>
	<!--- Delete record from Database --->
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

<CFELSE>

	<HTML>

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
		<TD ALIGN="middle"><h3><font face="Arial,Helvetica">Dealer Administration - Create a New Web</font></h3></TD>
	</TR>
	<TR ALIGN=CENTER><TD><FONT FACE="Arial,Helveticva"><b>Confirm Entry</b>
	<p>
	The following is about to be saved in the database.<br>
	Please confirm the information below is correct</FONT></TD></TR>
	<TR><TD>&nbsp;</TD></TR>
	<TR><TD ALIGN=CENTER>
		<TABLE BORDER=0 WIDTH=90%>
		<TR><TD ALIGN=CENTER><FONT
	 	FACE="Arial,Helvetica"><b>The following disclaimer will be displayed:</b><br>&nbsp;</FONT></TD></TR>
	 	<FORM action="di_formproc_final.cfm" ENABLECAB="no" method="post">
		<TR><TD><CFINCLUDE template="di_formproc_#form.templateid#.cfm"></TD></TR>
		<TR><TD>&nbsp;</TD></TR>
		<TR ALIGN="center">
			<TD>
			<FONT FACE="arial,helvetica">
			<CFOUTPUT>
			<CFIF ParameterExists(form.new)>
				<INPUT type="hidden" NAME="new" value="1">
			</CFIF>
			<INPUT TYPE="hidden" NAME="DealerCode" VALUE=#g_DealerCode#>
			<INPUT type="hidden" NAME="offerID" value="#g_offerID#">
			</CFOUTPUT>
			<INPUT TYPE="hidden" NAME="NextStep" VALUE="di_formproc_final.cfm">
			&nbsp;&nbsp;
			<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg" BORDER="0" NAME="btnCancel" VALUE="Cancel">
			&nbsp;&nbsp;
			<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/save_nav.jpg" BORDER="0" NAME="btnSave" VALUE="Save">
			</FORM>
			<p>
			<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
			<INPUT TYPE="Image"
				SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg"
				Border="0"
				NAME="BackToMain"
				VALUE="Back To Main Menu">
			</FORM></FONT></TD>
		</TR></TABLE>
	</TD>		
	</TR>
	</TABLE>

	
	</div>
</CFIF>
