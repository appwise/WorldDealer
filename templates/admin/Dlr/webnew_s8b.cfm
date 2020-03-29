<CFINCLUDE template="security.cfm">
    <!-- ----------------------------------------------------------- -->
    <!--                Created by sigma6, Detroit                   -->
    <!--         Copyright (c) 1997, 1998, 1999 sigma6.              -->
    <!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->

    <!-- ----------------------------------------------------------- -->
    <!--     John Turner for sigma6, interactive media, Detroit      -->
    <!--    jturner@sigma6.com   www.sigma6.com    www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
	<!--- $Id: webnew_s8b.cfm,v 1.9 1999/11/29 15:30:59 lswanson Exp $ --->
	<!--- Offers --->

<HEAD>

        <TITLE>WorldDealer | Create a New Web</TITLE>

    <CFIF (ParameterExists(URL.dlrcode)) AND (ParameterExists(URL.Offer))>
    	<CFSET g_DealerCode = #URL.dlrcode#>
        <CFSET EditMode = TRUE>
        <CFSET NewMode = FALSE>
        <CFSET SaveMode = FALSE>
		<CFSET CancelMode = FALSE>
		<CFSET ConfirmMode = FALSE>
		<CFSET g_offerID= #URL.offer#>
	<CFELSE>
        <CFSET g_DealerCode = "">
        <CFSET NewMode = TRUE>
        <CFSET EditMode = FALSE>
        <CFSET SaveMode = FALSE>
		<CFSET CancelMode = FALSE>
    </CFIF>
	  
	<CFIF ParameterExists(Form.btnSaveS8B.X)>
    	<CFSET SaveMode = TRUE>
        <CFSET g_DealerCode = #Form.DealerCode#>
	</CFIF>

    <CFIF ParameterExists(Form.btnCancel.X)>
		<CFSET CancelMode = TRUE>
		<CFSET g_dealerCode=#Form.DealerCode#>
    </CFIF>
		
	<CFIF ParameterExists(Form.btnNext.X)>
		<CFSET g_dealerCode=#Form.DealerCode#>
		<CFSET NewMode=FALSE>
		<CFSET EditMode=FALSE>
		<CFSET SaveMode=FALSE>
		<CFSET ConfirmMode=TRUE>
		<CFSET g_OfferID = #Form.OfferID#>
	</CFIF>

	<CFIF ParameterExists(URL.new)>
		<CFSET EditMode = FALSE>
		<CFSET NewMode = TRUE>
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
			WHERE DealerCode='#g_DealerCode#';
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
	</CFIF>
	
	
	<CFIF SaveMode>
		<CFQUERY name="updateoffer" datasource="#gDSN#">
		UPDATE Offers
		SET ExpirationDate=#Form.Expiration#,
			CarCutID=#FORM.CarCut#
		WHERE OfferID=#Form.Offer#
		</CFQUERY>

		<CFIF ParameterExists(Form.new)>
			<CFLOCATION url="webnew_s8c.cfm?dlrcode=#g_DealerCode#&offer=#form.offer#&new=yes">
		<CFELSE>
			<CFLOCATION url="webnew_s8c.cfm?dlrcode=#g_DealerCode#&offer=#form.offer#">
		</CFIF>
	</CFIF>
	
		
	<CFIF (EditMode) OR (ConfirmMode) OR (NewMode)>
		<CFQUERY NAME="getOffer" DATASOURCE="#gDSN#">
	   		SELECT  Offers.CarCutID as q_carCutID,
					Offers.Description as CutText,
					Offers.ExpirationDate as q_ExpirationDate,
					Offers.ModelID as q_modelID
			FROM 	DealerWebs 
					INNER JOIN DealerOffers ON DealerWebs.DealerWebID = DealerOffers.DealerWebID
					INNER JOIN Offers ON DealerOffers.OfferID = Offers.OfferID
			WHERE 	DealerWebs.DealerCode = '#g_DealerCode#' AND
					Offers.OfferID=#g_offerID#
		</CFQUERY>
		
		<!--- <cfset tempModelID = #getOffer.q_modelID#> --->
		<cfoutput>
		<!--- enhanced this query, so it looks in the right dir (q_Make) for carcuts --->
		<CFQUERY name="getCarCuts" datasource="#gDSN#">
			SELECT 	CarCutID as q_carCutID,
					Models.Make as q_Make
			FROM 	CarCutKey INNER JOIN Models ON CarCutKey.ModelID = Models.ModelID
			WHERE 	CarCutKey.ModelID = #getOffer.q_modelID#
		</CFQUERY>
		</cfoutput>
	</CFIF>			
	
	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>

<body>
<br><br><br><br><br>

<CFIF ConFirmMode>
	
	<div align="center">
		<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
    	    <TR ALIGN="center">
    	            <TD ALIGN="middle"><h3><font face="Arial,Helvetica">Dealer Administration - Create a New Web</font></h3></TD>
  	      </TR>
			<TR ALIGN=CENTER><TD><FONT FACE="Arial,Helveticva"><b>Confirm Entry</b>
				<p>
				The following is about to be saved in the database.<br>
				Please confirm the information below is correct.</FONT></TD></TR>
			<TR><TD>&nbsp;</TD></TR>
			<CFOUTPUT>
			<TR ALIGN=CENTER><TD><FONT FACE="arial,helvetica"><b>Expiration Date: </b>#DateFormat(Form.Expiration,"mmmm d, yyyy")#</FONT></TD></TR>
			<TR><TD>&nbsp;</TD></TR>
			<TR ALIGN=CENTER><TD><FONT FACE="arial,helvetica"><b>Carcut:</b>
			<br>
			<IMG SRC="#application.RELATIVE_PATH#/images/vehicles/#getCarCuts.q_Make#/#getoffer.q_modelID#_#form.carcut#.jpg">
			</FONT>
			</TD></TR>
			<TR><TD>&nbsp;</TD></TR>
			<TR><TD><BLOCKQUOTE><FONT FACE="arial,helvetica">#Getoffer.CutText#</FONT></BLOCKQUOTE></td></tr>
			<FORM action="webnew_s8b.cfm" method="post">
			<TR align="center"><TD>
			<INPUT type="hidden" name="dealercode" value="#g_DealerCode#">
   	         <INPUT TYPE="hidden" NAME="Expiration" VALUE="#form.expiration#">
			 <Input type="hidden" name="carcut" value="#Form.carcut#">
			 <INPUT type="hidden" name="offer" value="#g_offerID#">
				<CFIF ParameterExists(Form.new)>
					<INPUT type="hidden" NAME="new" value="1">
				</CFIF>
			</CFOUTPUT>
   	         <INPUT TYPE="hidden" NAME="NextStep" VALUE="webnew_s8b.cfm">
   	             &nbsp;&nbsp;
   	         <INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg" BORDER="0" NAME="btnCancel" VALUE="Cancel">
   	             &nbsp;&nbsp;
   	         <INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/saveandcontinue_nav.jpg" BORDER="0" NAME="btnSaveS8B" VALUE="Save and Continue">
   	             </FORM>
   	         <p>
   	                 <FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
   	                         <INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg"
			Border="0"
			NAME="BackToMain"
			VALUE="Back To Main Menu">

   	                     </FORM></TD>
   	     </TR>
	</TABLE>

	</div>
			
<CFELSE> <!--- EditMode ---->
	<div align="center">
	<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
   	     <TR ALIGN="center">
	                <TD ALIGN="middle"><h3><font face="Arial,Helvetica">Dealer Administration - Create a New Web</font></h3></TD>
   	     </TR>
			<TR><TD>&nbsp;</TD></TR>
		     <TR ALIGN="center">
   	             <TD ALIGN="middle"><font face="Arial,Helvetica">Enter the following information.  Required fields are bolded.</font></TD>
   	     </TR>
   	     <TR><TD>&nbsp;<p></TD></TR>
   	     <TR>
   	         <TD>
	                  <FORM NAME="StepEightB" ACTION="webnew_s8b.cfm" METHOD="post">
					  <TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0 WIDTH="100%">
 				<TR ALIGN=CENTER><TD><FONT FACE="arial,helvetica">
					<b>In the space below, enter the Expiration Date in the form mm/dd/yyyy.</b><p>
					</FONT></TD></TR>
				<INPUT type="hidden" name="expiration_date" value="You must enter an expiration date in the form mm/dd/yyyy.">
				 <CFIF EditMode>
				 	<TR ALIGN=CENTER>
				 		<CFOUTPUT query="getoffer">
				 		<TD><FONT FACE="arial,helvetica">
							<INPUT type="text" name="expiration" maxsize="10" value="#DateFormat(q_expirationDate,'mm/dd/yyyy')#">
				 		</CFOUTPUT>
						</FONT>
						</TD>
					</TR>
				<CFELSE>
					<TR ALIGN=CENTER>
					<CFOUTPUT>
						<TD><FONT FACE="arial,helvetica">
							<INPUT type="text" name="expiration" maxsize="10" value="#DateFormat(DateAdd("m",1,Now()),'mm/dd/yyyy')#">
							</FONT>
						</TD>
					</CFOUTPUT>
					</TR>
				</CFIF>
				<TR><TD>&nbsp;</TD></TR>
				<TR><TD>&nbsp;</TD></TR>
				<TR ALIGN=CENTER>
					<TD><FONT FACE="arial,helvetica">Select a carcut</FONT></TD>
				</TR>
				<TR><TD>&nbsp;</TD></TR>
				<TR ALIGN=CENTER>
					<TD>
					<FONT FACE="arial,helvetica">
					<CFSET #counter# = 1>
					<CFLOOP query="getcarcuts">
					<CFOUTPUT>
					<CFIF EditMode>
						Carcut #counter#: <INPUT type="radio" name="carcut" value="#q_carcutID#" <CFIF #q_carcutID# EQ #getoffer.q_carcutID#>CHECKED</CFIF>>&nbsp;&nbsp;<IMG SRC="#application.RELATIVE_PATH#/images/vehicles/#q_Make#/#getoffer.q_modelID#_#q_carcutID#.jpg" align="middle"><p>
					<CFELSE>
						Carcut #counter#: <INPUT type="radio" name="carcut" value="#q_carcutID#" <CFIF #q_carcutID# EQ '1'>CHECKED</CFIF>>&nbsp;&nbsp;<IMG SRC="#application.RELATIVE_PATH#/images/vehicles/#q_Make#/#getoffer.q_modelID#_#q_carcutID#.jpg" align="middle"><p>
					</CFIF>
					</CFOUTPUT>
					<CFSET #counter# = #counter# + 1>
					</CFLOOP>
					</FONT>
					</TD>
				</TR>
				<TR><TD>&nbsp;</TD></TR>
				  <TR ALIGN="center">
   	         <TD>
   	     <CFOUTPUT>
				<CFIF ParameterExists(URL.new)>
					<INPUT type="hidden" NAME="new" value="1">
				</CFIF>
           	 <INPUT TYPE="hidden" NAME="DealerCode" VALUE=#g_DealerCode#>
			<INPUT type="hidden" NAME="offerID" value="#URL.offer#">
    	            </CFOUTPUT>
       	     <INPUT TYPE="hidden" NAME="NextStep" VALUE="webnew_s8c.cfm">
       	         &nbsp;&nbsp;
       	     <INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg" BORDER="0" NAME="btnCancel" VALUE="Cancel">
  	              &nbsp;&nbsp;
   	         <INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next_nav.jpg" BORDER="0" NAME="btnNext" VALUE="Next">
	                </FORM>
   	         <p>
   	                 <FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
   	                         <INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg"
			Border="0"
			NAME="BackToMain"
			VALUE="Back To Main Menu">

   	                     </FORM></TD>
						</TR></TABLE>
				</TD>		
   	     </TR>
</TABLE>

</div>

</CFIF>  <!--- CFIF ConfirmMode --->

</BODY>
</HTML>
