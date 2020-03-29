<CFSET webnewstep = 8>
<CFINCLUDE template="security.cfm">

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>

    <!-- ----------------------------------------------------------- -->
    <!--              Created by sigma6, Detroit                     -->
    <!--         Copyright (c) 1997, 1998, 1999 sigma6.              -->
    <!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->

    <!-- ----------------------------------------------------------- -->
    <!--     John Turner for sigma6, interactive media, Detroit      -->
    <!--    jturner@sigma6.com   www.sigma6.com    www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
	<!--- $Id: webnew_s8.cfm,v 1.8 1999/11/24 22:54:19 lswanson Exp $ --->
	<!--- Offers --->

<HEAD>

	<TITLE>WorldDealer | Create a New Web</TITLE>

	<!--- things that get processed & redirected without looping through this page again --->
    <CFIF ParameterExists(Form.btnCancel.X)>
        <CFLOCATION URL="webvrfy_s8.cfm?dlrcode=#Form.DealerCode#">
    </CFIF>

	<CFIF ParameterExists(Form.btnNew.X)>
		<CFLOCATION URL="webnew_s8aa.cfm?dlrcode=#Form.DealerCode#">
	</CFIF>

    <CFIF ParameterExists(Form.btnModify.X)>
    	<CFSET g_DealerCode = #Form.DealerCode#>
		<CFLOCATION URL="webnew_s8a.cfm?dlrcode=#Form.DealerCode#&offer=#Form.which_offer#">
    </CFIF>

	<!--- KillMode --->
	<CFIF ParameterExists(Form.btnKill.X) OR ParameterExists(Form.btnKillAll.X)>
		<CFSET g_dealercode = #Form.DealerCode#>
		<CFSET g_offerID = #form.offerID#>

		<CFIF IsDefined("Form.btnKillAll.X")>
			<!--- Kill ALL Offers --->
			<!--- Get ALL Offers for this Dealer --->
			<CFQUERY name="getOffers" datasource="#gDSN#">
				SELECT OfferID
				FROM DealerOffers
				WHERE DealerWebID IN (SELECT DealerWebID FROM DealerWebs WHERE DealerCode = '#g_dealercode#');
			</CFQUERY>
		</CFIF>
	    <CFIF IsDefined("Form.btnKillAll.X")> 
			<CFLOOP QUERY="getOffers">
    			<CFIF IsDefined("Form.BtnKillAll.X")>
					<CFSET the_OfferID = #GetOffers.OfferID#>
				<CFELSE>
					<CFSET the_OfferID = #g_OfferID#>
				</CFIF>
				<!--- Check what type of offer this is --->
				<CFQUERY name="getOfferType" datasource="#gDSN#">
					SELECT OffertypeID
					FROM Offers
					WHERE OfferID = #the_offerID#;
				</CFQUERY>
				<CFIF #getOfferType.OfferTypeID# EQ 2> 
					<!--- It's a custom (Dealer Offer), do mark it deleted --->
					<!--- linda, 11/8/99: setting expiration date to 1/1/95 is how it's "deleted" --->
					<CFQUERY name="KillOffer" datasource="#gDSN#">
						UPDATE Offers
						SET ExpirationDate = #CreateODBCDate('1/1/95')#
						WHERE OfferID = #the_offerID#
					</CFQUERY>
				<CFELSE>
					<!--- It's a National Offer so remove the entry in DealerOffers --->
					<CFQUERY name="GetDealerWebID" datasource="#gDSN#">
						SELECT DealerWebID
						FROM DealerWebs
						WHERE DealerCode = '#g_dealercode#';
					</CFQUERY>
					<CFQUERY name="RemoveOffer" datasource="#gDSN#">
						DELETE FROM DealerOffers
						WHERE DealerWebID = #getDealerWebID.DealerWebID# 
						AND OfferID = #the_offerID#;
					</CFQUERY>
				</CFIF>
			</CFLOOP>
	    <CFELSE>
   			<CFIF IsDefined("Form.BtnKillAll.X")>
				<CFSET the_OfferID = #GetOffers.OfferID#>
			<CFELSE>
				<CFSET the_OfferID = #g_OfferID#>
			</CFIF>
			<!--- Check what type of offer this is --->
			<CFQUERY name="getOfferType" datasource="#gDSN#">
				SELECT OffertypeID
				FROM Offers
				WHERE OfferID = #the_offerID#;
			</CFQUERY>
			<CFIF #getOfferType.OfferTypeID# EQ 2> 
				<!--- It's a custom (Dealer Offer), do mark it deleted --->
				<!--- linda, 11/8/99: setting expiration date to 1/1/95 is how it's "deleted" --->
				<CFQUERY name="KillOffer" datasource="#gDSN#">
					UPDATE Offers
					SET ExpirationDate = #CreateODBCDate('1/1/95')#
					WHERE OfferID = #the_offerID#
				</CFQUERY>
			<CFELSE>
				<!--- It's a National Offer so remove the entry in DealerOffers --->
				<CFQUERY name="GetDealerWebID" datasource="#gDSN#">
					SELECT DealerWebID
					FROM DealerWebs
					WHERE DealerCode = '#g_dealercode#';
				</CFQUERY>
				<CFQUERY name="RemoveOffer" datasource="#gDSN#">
					DELETE FROM DealerOffers
					WHERE DealerWebID = #getDealerWebID.DealerWebID# 
					AND OfferID = #the_offerID#;
				</CFQUERY>
			</CFIF>
		</CFIF>
		<CFLOCATION url="webvrfy_s8.cfm?dlrcode=#g_dealercode#">
	</CFIF>
	
	
	<!--- determine the mode --->
	<CFSET NewMode = FALSE>
	<CFSET EditMode = FALSE>
	<CFSET DeleteMode = FALSE>
		
	<CFIF ParameterExists(URL.dlrcode)>
    	<CFSET g_DealerCode = #URL.dlrcode#>
        <CFSET EditMode = TRUE>
	<CFELSE>
        <CFSET g_DealerCode = "">
        <CFSET NewMode = TRUE>
    </CFIF>
        
	<CFIF ParameterExists(Form.btnDelete.X) OR ParameterExists(Form.BtnDeleteAll.X)>
		<CFSET g_dealercode=#FORM.dealercode#>
		<CFSET DeleteMode = TRUE>
	</CFIF>

	<CFIF EditMode>
    	<CFQUERY NAME="getDLROffers" datasource="#gDSN#">
	   		SELECT 	Offers.OfferID as q_offerID,
					Offers.Name as q_offerName,
					Offers.ExpirationDate as q_ExpirationDate,
					Offertypes.Description as q_offertype,
					Models.Description as q_ModelDescription,
					Makes.MakeName
			FROM 	DealerWebs 
					INNER JOIN DealerOffers ON DealerWebs.DealerWebID = DealerOffers.DealerWebID
					INNER JOIN Offers ON DealerOffers.OfferID = Offers.OfferID
					INNER JOIN OfferTypes ON Offers.OfferTypeID = OfferTypes.OfferTypeID
					INNER JOIN Models ON Offers.ModelID = Models.ModelID
					INNER JOIN Makes ON Models.Make = Makes.MakeNumber
			WHERE 	DealerWebs.DealerCode = '#g_DealerCode#' AND
					Offers.ExpirationDate > #CreateODBCDate('1/1/95')#
			ORDER BY Makes.MakeName,
					Models.Description, 
					Offers.ExpirationDate;
    	</CFQUERY>
	</CFIF>

	<CFIF DeleteMode>
		<CFIF NOT IsDefined("Form.BtnDeleteAll.X")>
			<!--- Only One Offer selected for Deletion --->
			<CFQUERY name="getoffer" datasource="#gDSN#">
				SELECT 	Offers.Name as q_offerName,
						Offers.Description as q_offerDescription,
						Offers.ExpirationDate as q_ExpirationDate,
						Offertypes.Description as q_offertype,
						Models.Description as q_ModelDescription
				FROM 	DealerWebs 
						INNER JOIN DealerOffers ON DealerWebs.DealerWebID = DealerOffers.DealerWebID
						INNER JOIN Offers ON DealerOffers.OfferID = Offers.OfferID
						INNER JOIN OfferTypes ON Offers.OfferTypeID = OfferTypes.OfferTypeID
						INNER JOIN Models ON Offers.ModelID = Models.ModelID
				WHERE 	DealerWebs.DealerCode = '#g_DealerCode#' AND
						Offers.OfferID=#FORM.Which_offer#
	    	 </CFQUERY>
		</cfif>
	</cfif>


	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>

<body>
<br><br><br><br><br>

<div align="center">
<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=500 BGCOLOR="FFFFFF">
	<TR ALIGN="center">
    	<TD ALIGN="middle">
			<h3><font face="Arial,Helvetica">Dealer Administration - Offers</font></h3>
		</TD>
    </TR>
	<FORM NAME="StepEight" ACTION="webnew_s8.cfm" METHOD="post">
<CFIF EditMode>
		<CFIF #getDLROffers.RecordCount# IS NOT '0'>
	        <TR ALIGN="center">
    	            <TD ALIGN="middle"><font face="Arial,Helvetica">Please select the Offer you wish to Modify</FONT></TD>
        	</TR>
    	   	 <TR><TD>&nbsp;<p></TD></TR>
			 <TR><TD>
			 <TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2>
				<!---  This line screws up if you hit the "Cancel Button"  
					<INPUT type="hidden" name="which_offer_required" value="You must select an offer to modify.">
				--->
					<TR><TD>&nbsp;</TD>
						<TD><FONT FACE="arial,helvetica"><b>Make</b></FONT></TD>
						<TD><FONT FACE="arial,helvetica"><b>Model</b></FONT></TD>
						<TD><FONT FACE="arial,helvetica"><b>Offer Name</b></FONT></TD>
						<TD><FONT FACE="arial,helvetica"><b>Offer Type</b></FONT></TD>
						<TD><FONT FACE="arial,helvetica"><b>Expiration Date</b></FONT></TD>
					</TR>
					<CFOUTPUT query="getDLRoffers">
					<TR>
						<TD><FONT FACE="arial,helvetica"><INPUT type="radio" name="which_offer" value="#q_offerID#" <CFIF #getDLROffers.CurrentRow# EQ 1>CHECKED</CFIF>></FONT></TD>
						<TD><FONT FACE="Arial,Helvetica">#MakeName#</FONT></TD>
						<TD><FONT FACE="Arial,Helvetica">#q_modelDescription#</FONT></TD>
						<TD><FONT FACE="Arial,Helvetica">#q_offername#</FONT></TD>
						<TD><FONT FACE="Arial,Helvetica">#q_offertype#</FONT></td>
						<TD><FONT FACE="Arial,Helvetica">#DateFormat(q_expirationdate,"mm/dd/yyyy")# </FONT></TD>
					</TR>
					</CFOUTPUT>
					</TABLE>
						</FONT></TD></TR>
						
		<CFELSE>
			<TR ALIGN="CENTER">
				<TD><FONT FACE="Arial,Helvetica">There are currently NO Offers associated with this Dealership.</TD>
			</TR>
		</CFIF>
		
		<CFIF #getDLROffers.RecordCount# IS NOT '0'>
			<TR><TD>&nbsp;</TD></TR>
			<TR align=center><TD><INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/modifyoffer.jpg" BORDER="0" NAME="btnModify" VALUE="Modify Offer">&nbsp;&nbsp;&nbsp;<INPUT
			TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/deleteoffer.jpg" BORDER="0" name="btnDelete" VALUE="Delete Offer">&nbsp;&nbsp;&nbsp;<INPUT
			TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/deletealloffers.gif" BORDER="0" name="btnDeleteAll" VALUE="Delete All Offers"></TD></TR>
		</CFIF>
		<TR><TD>&nbsp;</TD></TR>
		<TR align=center>
			<TD>
				<CFOUTPUT>
        	    <INPUT TYPE="hidden" NAME="DealerCode" VALUE=#g_DealerCode#>
                </CFOUTPUT>
            	<INPUT TYPE="hidden" NAME="NextStep" VALUE="webnew_s9.cfm">
                &nbsp;&nbsp;
	            <INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg" BORDER="0" NAME="btnCancel" VALUE="Cancel">
                &nbsp;&nbsp;
				<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/addoffer.jpg" BORDER="0" NAME="btnNew" VALUE="Add New Offer">
				</FORM>
				<p>
		        <FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
                <INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg" Border="0" NAME="BackToMain" VALUE="Back To Main Menu">
				</FORM>
			</TD>
		</TR>
</CFIF>


<CFIF DeleteMode>
	<CFIF NOT IsDefined("Form.BtnDeleteAll.X")>
		<!--- Only One Offer selected for Deletion --->
		<TR><TD ALIGN=CENTER><FONT FACE="Arial,Helvetica"><b>You about about to permanently delete the following offer.<p>
		Are you sure?</b></TD></TR>
		<TR><TD>&nbsp;</TD></TR>
		<CFOUTPUT query="getoffer">
		<TR><TD><FONT FACE="arial,helvetica"><b>Offer Name:</b> #q_offerName#<p>
		<b>Offer Text:</b> #q_offerDescription#<p>
		<b>Type:</b> #q_offertype#<p>
		<b>Model:</b> #q_ModelDescription#<p>
		<b>Expiration Date:</b> #DateFormat(q_expirationDate,"mm/dd/yyyy")#
		</FONT></TD></TR>
		</CFOUTPUT>

	<CFELSE>
		<!--- DELETE ALL OFFERS --->
		<TR><TD ALIGN="CENTER"><FONT FACE="Arial,Helvetica"><b>You are about to permanently delete</b> </FONT><FONT
			FACE="Arial,Helvetica" COLOR="#ff0000"><b>ALL</b></FONT><FONT FACE="Arial,Helvetica"> <b>offers associated with this Dealership.<p>
			Are you sure?</b></TD></TR>
	</CFIF>
	
	<TR><TD>&nbsp;</TD></TR>
	<TR><TD align="center"><FORM action="webnew_s8.cfm" method="post">
	<CFOUTPUT><INPUT type="hidden" name="dealercode" value="#g_dealercode#">
			  <INPUT type="hidden" name="offerID" value="#form.which_offer#"></CFOUTPUT>
	<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg" BORDER="0" NAME="btnCancel" VALUE="Cancel">&nbsp;&nbsp;&nbsp;
	<CFIF IsDefined("Form.BtnDelete.X")>
		<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/deleteoffer.jpg" BORDER="0" name="btnKill" value="Delete Offer">
	<CFELSEIF IsDefined("Form.BtnDeleteAll.X")>
		<INPUT type="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/deletealloffers.gif" BORDER="0" name="btnKillAll" value="Delete All Offers">
	</CFIF>
	</FORM>
	</TD></TR>
</CFIF>

</TABLE>
</div>
</BODY>
</HTML>