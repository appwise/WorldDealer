<CFINCLUDE template="security.cfm">
    <!-- ----------------------------------------------------------- -->
    <!--                 Created by sigma6, Detroit                  -->
    <!--         Copyright (c) 1997, 1998, 1999 sigma6.              -->
    <!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->

    <!-- ----------------------------------------------------------- -->
    <!--     John Turner for sigma6, interactive media, Detroit      -->
    <!--    jturner@sigma6.com   www.sigma6.com    www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
	<!--- $Id: webnew_s8a.cfm,v 1.14 1999/12/07 21:50:25 lswanson Exp $ --->
	<!--- Custom (Dealer) Offers --->

<HEAD>

	<TITLE>WorldDealer | Create a New Web</TITLE>

	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

    <CFIF ParameterExists(Form.btnCancel.X)>
        <CFLOCATION URL="webvrfy_s8.cfm?dlrcode=#Form.DealerCode#">
    </CFIF>
		
    <CFSET NewMode = FALSE>
	<CFSET EditMode = FALSE>
	<CFSET ConfirmMode = FALSE>
    <CFSET SaveMode = FALSE>
    
	<CFIF (ParameterExists(URL.dlrcode)) AND (ParameterExists(URL.Offer))>
        <!--- <CFSET g_DealerCode = #URL.dlrcode#> --->
        <CFSET EditMode = TRUE>
    <CFELSE>
        <CFSET NewMode = TRUE>
    </CFIF>
        
	<CFIF ParameterExists(Form.btnNext.X)>
		<CFSET ConfirmMode=TRUE>
	</CFIF>
	
    <CFIF ParameterExists(Form.btnSave.X)>
        <!--- <CFSET g_DealerCode = #Form.DealerCode#> --->
        <CFSET SaveMode = TRUE>
    </CFIF>

	<CFIF (ParameterExists(Form.BtnCancel.X)) OR (ParameterExists(Form.BtnSave.X)) OR (ParameterExists(Form.BtnNext.X))>
		<CFSET g_DealerCode="#FORM.DealerCode#">
	<CFELSE>
       	<CFSET g_DealerCode = "#URL.DlrCode#">
	</CFIF>

<CFIF EditMode>
	<CFQUERY NAME="getDLROffer" datasource="#gDSN#">
	   		SELECT 	Offers.Name as q_offerName,
					Offers.Description as q_offerDescription,
					Offers.ModelID as q_ModelID,
					Offers.OfferTypeID as q_OfferTypeID,
					Offertypes.Description as q_offertype
			FROM 	DealerWebs 
					INNER JOIN DealerOffers ON DealerWebs.DealerWebID = DealerOffers.DealerWebID
					INNER JOIN Offers ON DealerOffers.OfferID = Offers.OfferID
					INNER JOIN OfferTypes ON Offers.OfferTypeID = OfferTypes.OfferTypeID
			WHERE 	DealerWebs.DealerCode = '#g_DealerCode#' AND
					Offers.OfferID = #URL.offer#;
    </CFQUERY>
	<CFSET TheOfferType = #GetDLROffer.q_OfferTypeID#>
<CFELSE>
	<!--- Need this variable so NewMode doesn't look for a query which doesn't exist.  See line 217 --->
	<CFSET TheOfferType = 2>	
</CFIF>

<CFIF SaveMode>
	<CFIF ParameterExists(Form.Offer)>
		<!--- Update Offer --->
		<CFQUERY name="updateoffer" datasource="#gDSN#">
		UPDATE Offers
		SET Name='#FORM.offer_Name#',
			Description='#Form.offer_Body#',
			ModelID=#form.modelid#
		WHERE OfferID=#Form.Offer#;
		</CFQUERY>
		
		<CFLOCATION url="webnew_s8b.cfm?offer=#form.offer#&dlrcode=#g_dealercode#">
	<CFELSE>
		<!--- New Offer --->
		<CFQUERY name="newoffer" datasource="#gDSN#">
		INSERT INTO Offers (Name,
							Description,
							OfferTypeID,
							ModelID)
		VALUES ('#FORM.offer_name#',
				'#Form.offer_Body#',
				2,
				#form.modelid#);
		</CFQUERY>

		<CFQUERY name="getofferID" datasource="#gDSN#">
		SELECT Max(OfferID) as new_record
		FROM Offers;
		</CFQUERY>

		<CFQUERY name="getDealerWebID" datasource="#gDSN#">
		SELECT DealerWebID
		FROM DealerWebs
		WHERE DealerCode='#g_dealercode#';
		</CFQUERY>
		
		<CFQUERY name="newdealeroffer" datasource="#gDSN#">
		INSERT INTO DealerOffers (DealerWebID, OfferID)
		VALUES (#getDealerWebID.dealerWebID#, #getofferID.new_record#);
		</CFQUERY> 
		
		<CFLOCATION url="webnew_s8b.cfm?offer=#getofferID.new_record#&dlrcode=#g_dealercode#&new=yes">
	</CFIF>	
</CFIF>

</HEAD>

<body>
<br><br><br><br><br>
<CFOUTPUT>
<div align="center">

<CFIF ConfirmMode>

	<CFQUERY name="getOneModel" datasource="#gDSN#">
	SELECT Description as q_modelname
	FROM Models
	WHERE ModelID=#form.modelid#;
	</CFQUERY>
	
	<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
	<TR ALIGN="center">
    	<TD ALIGN="middle">
			<h3>Dealer Administration - Create a New Web</h3>
		</TD>
	</TR>
	<TR ALIGN=CENTER>
		<TD>
			<b>Confirm Entry</b>
			<p>
			The following is about to be saved in the database.<br>
			Please confirm that the information below is correct.
		</TD>
	</TR>
	<TR><TD>&nbsp;</TD></TR>
	<TR ALIGN=CENTER>
		<TD>
			<b>Offer Name</b>
		</TD>
	</TR>
	<TR ALIGN=CENTER>
		<TD>
			#FORM.offer_Name#
		</TD>
	</TR>
	<TR><TD>&nbsp;</TD></TR>
	<TR ALIGN=CENTER>
		<TD>
			<b>Offer Description</b>
		</TD>
	</TR>
	<!--- linda, 12/7/99: it's a text field now, not a varchar, so no limit on length
	<CFSET temp=#Replace(FORM.Offer_Body,Chr(13),"<BR>","ALL")#>
	--- linda, 11/9/99: this is needed for IE, who treats LF differently than NS.
	If it's close to 255, but has LF's in it, it may or may not catch it, but then it'll generate error. ---
	<CFSET temp=#Replace(temp,Chr(10),"","ALL")#>
	 --->	
 	<TR align="center">
		<TD>
			#Form.Offer_Body#
		</TD>
	</TR>
	<!--- linda, 10/18/99: warning, so user can change text if > 255 characters --->
	<!--- linda, 12/7/99: it's a text field now, not a varchar, so no limit on length	
	<cfif Len(#Form.offer_body#) GT 255>
		<tr>
			<td>
				<br><b><font color="red">WARNING!</font>  The Offer Description is too long and will be truncated to 255 characters as follows:</b>
				<br><br>#Left(temp, 255)#
				<br><br>unless you click the <b>Back</b> button on your browser to revise the text.
			</td>
		</tr>
	</cfif>
	--->
	<TR><TD>&nbsp;</TD></TR>
	<TR ALIGN=CENTER>
		<TD>
			<b>Model:&nbsp;&nbsp;#getOneModel.q_modelname#</b>
		</TD>
	</TR>
	<TR><TD>&nbsp;</TD></TR>
	<FORM action="webnew_s8a.cfm" method="post">
	<TR align="center">
		<TD>
   	        <INPUT TYPE="hidden" NAME="DealerCode" VALUE=#g_DealerCode#>
			<input TYPE="hidden" name="offer_name" value="#Form.offer_name#">
			<!--- linda, 10/18/99: truncate Offer Description to 255, so it goes into database varchar field of 255. --->
			<!--- linda, 12/7/99: it's a text field now, not a varchar, so no limit on length
			<Input type="hidden" name="offer_body" value="#Left(temp, 255)#">
			--->
			<Input type="hidden" name="offer_body" value="#Form.Offer_Body#">
			<input type="hidden" name="modelid" value="#Form.modelid#">
			<CFIF ParameterExists (Form.Offer)>
			 	<INPUT type="hidden" name="offer" value="#FORM.Offer#">
			</CFIF>
   	        <INPUT TYPE="hidden" NAME="NextStep" VALUE="webnew_s8b.cfm">
   	       	&nbsp;&nbsp;
   	        <INPUT TYPE="Image" SRC="#application.RELATIVE_PATH#/images/admin/cancel_nav.jpg" BORDER="0" NAME="btnCancel" VALUE="Cancel">
   	    	&nbsp;&nbsp;
   	        <INPUT TYPE="Image" SRC="#application.RELATIVE_PATH#/images/admin/next_nav.jpg" BORDER="0" NAME="btnSave" VALUE="Next">
   	        </FORM>
   	        <p>
			<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
   	        <INPUT TYPE="Image"
				SRC="#application.RELATIVE_PATH#/images/admin/backtomain_nav.jpg"
				Border="0"
				NAME="BackToMain"
				VALUE="Back To Main Menu">
			</FORM>
		</TD>
   	</TR>
	</TABLE>
						
<CFELSE>  <!--- NOT ConfirmMode --->

	<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
    <TR ALIGN="center">
    	<TD ALIGN="middle">
			<h3>Dealer Administration - Create a New Web</h3>
		</TD>
  	</TR>
	<TR><TD>&nbsp;</TD></TR>

	<!--- If they're trying to edit a national/regional offer, give them error message that they're not allowed to. --->
	<CFIF #TheOfferType# IS NOT 2>  <!--- Not a Dealer (Custom) offer --->
		<TR ALIGN="Center">
			<TD>
				Sorry, the Offer you selected is a #GetDLROffer.q_OfferType# Offer.  
				This offer may only be edited by an Account Coordinator.<p>
				Click the <b>Cancel</b> button below to try again.
			</TD>
		</TR>
		<TR><TD>&nbsp;</TD></TR>
		<FORM NAME="StepEightA" ACTION="webnew_s8a.cfm" METHOD="post">
	<CFELSE>  <!--- It IS a Dealer (Custom) Offer --->
		<TR ALIGN="center">
			<TD ALIGN="middle">
				Enter the following information.  Required fields are bolded.
			</TD>
		</TR>
		<TR><TD>&nbsp;<p></TD></TR>
		<TR>
			<TD>
				<FORM NAME="StepEightA" ACTION="webnew_s8a.cfm" METHOD="post">
				<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0 WIDTH="100%">
				<TR><TD>&nbsp;<p></TD></TR>
				
				<!--- Name of Offer --->
				<TR ALIGN=CENTER>
					<TD>
						<b>In the space below, enter the name of the offer</b><p>
					</TD>
				</TR>
				<TR align=center>
					<TD>
						<INPUT type="text"
							name="offer_name"
							size="35"
							maxlength="35" 
							value="<cfif EditMode>#getdlroffer.q_offerName#<cfelse>Offer Name</cfif>">
						<INPUT TYPE="hidden" NAME="offer_name_required" VALUE="Offer Name Required">
					</TD>
				</TR>
				<TR><TD>&nbsp;</TD></TR>
				
				<!--- Text of Offer --->
				<TR ALIGN=center>
					<TD>
						<b>In the space below, enter the offer.  The offer will appear on your website exactly as typed.</b><p>
					</TD>
				</TR>
				
   	            <TR ALIGN=center>
                   	<TD>
						<!--- CAREFUL!!!! Maxlength in the DB is only 255 --->
						<!--- linda, 10/18/99: handled now.  displaying warning in ConfirmMode & truncating before inserting into db --->
						<!--- linda, 12/7/99: it's a text field now, not a varchar, so no limit on length
						<CFSET temp=#Replace(getDLROffer.q_OfferDescription,"<BR>",Chr(13),"ALL")#>
						--->
						<textarea name="offer_body"
							cols="40"
							rows="10"
							wrap="PHYSICAL"><cfif EditMode>#getDLROffer.q_OfferDescription#<cfelse>Enter Offer Here</cfif></textarea>
               	        <INPUT TYPE="hidden" NAME="offer_body_required" VALUE="Offer Information Required">
					</TD>
				</TR>
				<TR><TD>&nbsp;<p></TD></TR>
				
				<!--- Model drop-downs --->
				<TR align=center>
					<TD>
						<b>Select a Model</b>
					</TD>
				</TR>
				<TR>
					<TD align="center">
				 		<!--- get Makes for dealership --->	
						<CFQUERY NAME="getDlrMakes" DATASOURCE="#gDSN#">
							SELECT 	Makes.MakeNumber,
									MakeName
							FROM 	Makes INNER JOIN DealerFranchise ON Makes.MakeNumber = DealerFranchise.MakeNumber
							WHERE	DealerFranchise.DF_Number = #Val(Mid(g_dealercode, 11, 3))#
						</cfquery>

						<!--- Drop-down box of MakeName & all models under that make --->
				   	    <SELECT NAME="modelid">
						<CFLOOP query="getDlrMakes">
							<OPTION VALUE=""><B>#UCase(MakeName)#</b> 
							<OPTION VALUE=""><B>------------------</b> 
							<!--- get all vehicles for the make we're on --->
							<CFQUERY NAME="getvehiclelist" DATASOURCE="#gDSN#">
								SELECT	description,
	    		    					VehicleType,
										modelid
								FROM	models
								Where   Make = #getDlrMakes.MakeNumber#
								ORDER BY VehicleType, description ASC
							</CFQUERY>
					
							<CFSET prevcartype=" ">
				
							<!--- get all vehicles for the make we're on --->
							<CFLOOP QUERY="getvehiclelist">
								<!--- If new vehicle type, do white space, vehicle type, underline --->
								<CFIF #prevcartype# IS NOT #VehicleType#>
					    			<CFSET prevcartype=#VehicleType#>
									<OPTION VALUE="">
									<cfswitch expression="#VehicleType#">
										<cfcase value="c"><OPTION VALUE="">Cars</cfcase>
										<cfcase value="s"><OPTION VALUE="">Sport Utility Vehicles</cfcase>									
										<cfcase value="t"><OPTION VALUE="">Trucks</cfcase>									
										<cfcase value="v"><OPTION VALUE="">Vans</cfcase>									
									</cfswitch>
    								<OPTION VALUE="">--------------------
  			    				</cfif>
			    				<OPTION VALUE="#modelid#" <CFIF editmode><CFIF #getDlrOffer.q_modelID# EQ #getvehiclelist.modelid#>SELECTED</CFIF></cfif>>#description#					
							</CFLOOP>
							<OPTION VALUE="">
						</CFLOOP>
						</SELECT>
						<INPUT TYPE="hidden" NAME="modelid_required" value="<A HREF='Javascript:history.back();'>Please select your vehicle model.</A>">
					</TD>
 				</TR>
				<TR><TD>&nbsp;<p></TD></TR>
				</TABLE>
			</TD>
       	 </TR>
	</CFIF>   <!--- /CFIF OfferType IS "Dealer" --->
	<CFIF ParameterExists(URL.Offer)>
		<INPUT type="hidden" name="offer" value="#URL.Offer#">
	</CFIF>
	<TR ALIGN="center">
		<TD>
			<INPUT TYPE="hidden" NAME="DealerCode" VALUE=#g_DealerCode#>
			<INPUT TYPE="hidden" NAME="NextStep" VALUE="webnew_s8b.cfm">
			<INPUT TYPE="Image" SRC="#application.RELATIVE_PATH#/images/admin/cancel_nav.jpg" BORDER="0" NAME="btnCancel" VALUE="Cancel">
			<CFIF #TheOfferType# EQ 2>  <!--- Dealer Offer, allow user to edit it. --->
				&nbsp;&nbsp;
				<INPUT TYPE="Image" SRC="#application.RELATIVE_PATH#/images/admin/next_nav.jpg" BORDER="0" NAME="btnNext" VALUE="Next">
			</CFIF>
			</FORM>
			<p>
			<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
			<INPUT TYPE="Image" SRC="#application.RELATIVE_PATH#/images/admin/backtomain_nav.jpg" Border="0" NAME="BackToMain" VALUE="Back To Main Menu">
			</FORM>
		</TD>
	</TR>
	</TABLE>
</CFIF> <!--- CFIF ConfirmMode --->
</cfoutput>
</div>
</BODY>
</HTML>