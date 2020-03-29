<CFSET PageAccess = 2>
<CFINCLUDE template="security.cfm">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>

    <!-- ----------------------------------------------------------- -->
    <!--                 Created by sigma6, Detroit                  -->
    <!--         Copyright (c) 1997, 1998, 1999 sigma6.              -->
    <!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->

    <!-- ----------------------------------------------------------- -->
    <!--     Howard Levine for sigma6, interactive media, Detroit    -->
    <!--    hlevine@sigma6.com   www.sigma6.com    www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
	<!--- $Id: nationaloffers.cfm,v 1.10 1999/12/15 23:01:55 lswanson Exp $ --->

<HEAD>

<TITLE>WorldDealer | Maintain Offers</TITLE>
<!--- <CFQUERY NAME="getAEDealerCode" DATASOURCE="#gDSN#">
	SELECT DISTINCT DealerCode as q_DealerCode
	FROM Dealers
	WHERE AEID = #RemoveChars(AccessLevel,1,2)#
</cfquery>
 --->
<!--- These lines check if the user is returning from the di_form_x.cfm pages --->
<!--- <CFIF #IsDefined("Variables.Dealercode")#>
	--- do nothing ---
<CFELSEIF NOT #IsDefined("Form.Dealercode")#>
	<CFSET variables.DealerCode = getAEDealerCode.q_DealerCode>
<CFELSE>
	<CFSET variables.dealercode = #form.dealercode#>
</CFIF>
 --->
 
 <!--- linda, 11/16/99: first, do any processing that doesn't require a page being loaded.
 Redirects get processed 1st, get em outta the way with a minimum of checks.
 Then purely query-based processing (adds, updates, deletes), so that when they're done, 
 they fall thru to the default ChooseOfferMode & will display the listing of offers, 
 without having to call nationaloffer.cfm again. --->
 
 <!--- if Cancel on ChooseOfferMode page, return to Make/Region selection page --->
<CFIF #IsDefined("form.btnCancelMake.X")#>
	<CFLOCATION url="offerMakes.cfm?MakeNumber=#URL.MakeNumber#">
</CFIF>
<!--- if Cancel on other pages, return to ChooseOfferMode page --->
<CFIF #IsDefined("form.btnCancelOffer.X")#>
	<CFLOCATION url="nationaloffers.cfm?MakeNumber=#URL.MakeNumber#&RegionID=#URL.RegionID#">
</CFIF>

<!--- User is at the end of adding or modifying an offer.  Clicked "Save National Offer" button. --->
<CFIF #IsDefined("form.btnSave.X")#>
	<CFIF #IsDefined("Form.new")#>
		<!--- insert a new offer for every Region that was selected --->
		<cfloop index="RegionIndex" list="#form.Regions#" delimiters="," >
			<!--- Do an INSERT --->
			<!--- insert the disclaimer 1st, cuz we need the DisclaimerID for the Offers --->
			<CFQUERY name="InsertOfferDisclaimers" datasource="#gDSN#">
				INSERT INTO OfferDisclaimers (TemplateID)
				VALUES (#Form.TemplateID#)
			</CFQUERY>

			<CFQUERY name="getDisclaimerID" datasource="#gDSN#">
				SELECT	Max(DisclaimerID) as DisclaimerID
				FROM 	OfferDisclaimers;
			</CFQUERY>

			<CFIF #Form.TemplateID# EQ 0>
				<CFSET Disclaimer_Text = #Replace(Form.Disclaimer_Body,Chr(13),"<BR>","ALL")#>
				<!--- Custom Disclaimer --->
				<CFQUERY name="InsCustomDisclaimer" datasource="#gDSN#">
					INSERT INTO CustomDisclaimers 
								(DisclaimerID,
								DisclaimerText)
					VALUES 		(#getDisclaimerID.DisclaimerID#,
								'#Disclaimer_Text#');
				</CFQUERY>
			</CFIF>

			<!--- now insert the Offer --->
			<!--- determine offer type & region --->
			<cfif #RegionIndex# EQ 0>
				<CFSET selectedOfferType = 1>
			<cfelse>
				<CFSET selectedOfferType = 5>
			</cfif>
			
			<CFQUERY name="InsertOffers" datasource="#gDSN#">
				INSERT INTO Offers (OfferTypeID,
									Name,
									Description,
									ExpirationDate,
									CarCutID,
									DisclaimerID,
									ModelID,
									RegionID)
							VALUES (#selectedOfferType#,
									'#form.Offer_Name#',
									'#form.Offer_Body#',
									#CreateODBCDate(form.expiration)#,
									#form.carcut#,
									#getDisclaimerID.DisclaimerID#,
									#form.ModelID#,
									#RegionIndex#)
			</CFQUERY>
		</cfloop>
	<CFELSE>
		<!--- Do an UPDATE on an Existing Offer--->
		<!--- LINDA:  need to determine offer type here & update correct #. --->
		<CFQUERY name="UpdateOffers" datasource="#gDSN#">
			UPDATE	Offers
			SET 	Name = '#form.Offer_Name#',
					Description = '#Form.Offer_Body#',
					ExpirationDate = #CreateODBCDate(Form.Expiration)#,
					CarCutID = #form.CarCut#,
					ModelID = #form.ModelID#
			WHERE 	OfferID = #form.OfferID#
		</CFQUERY>
		
		<CFQUERY name="getDisclaimerID" datasource="#gDSN#">
			SELECT 	DisclaimerID
			FROM 	Offers
			WHERE 	OfferID = #form.OfferID#;
		</CFQUERY>
		
		<!--- Update the disclaimer --->
		<CFQUERY name="updateOfferDisclaimers" datasource="#gDSN#">
			UPDATE	OfferDisclaimers
			SET		TemplateID = #Form.TemplateID#
			WHERE	DisclaimerID = #getDisclaimerID.DisclaimerID#
		</CFQUERY>
		
		<CFIF #Form.TemplateID# EQ 0>
			<!--- First Check if this Custom Disclaimer Exists, so we know whether to insert or update --->
			<CFQUERY name="CheckDisclaimer" datasource="#gDSN#">
				SELECT 	DisclaimerID
				FROM 	CustomDisclaimers
				WHERE 	DisclaimerID = #getDisclaimerID.disclaimerID#;
			</CFQUERY>
			
			<CFSET Disclaimer_Text = #Replace(Form.Disclaimer_Body,Chr(13),"<BR>","ALL")#>

			<CFIF #CheckDisclaimer.RecordCount# EQ 0>
				<CFQUERY name="InsCustomDisclaimer" datasource="#gDSN#">
					INSERT INTO CustomDisclaimers 
								(DisclaimerText, 
								DisclaimerID)
					VALUES 		('#Disclaimer_Text#', 
								#getDisclaimerID.disclaimerID#);
				</CFQUERY>
			<CFELSE>
				<CFQUERY name="UpdCustomDisclaimer" datasource="#gDSN#">
					UPDATE 	CustomDisclaimers
					SET 	DisclaimerText = '#Disclaimer_Text#'
					WHERE 	DisclaimerID = #getDisclaimerID.disclaimerID#;
				</CFQUERY>
			</CFIF>
		</CFIF>
	</CFIF>
	<!--- & then it'll just continue through & be in ChooseOfferMode; no need to loop through again & call nationaloffers.cfm --->
</cfif>

<!--- user has confirmed the deletion.  Mark the offer as Expired today.  Never actually delete. --->
<CFIF #IsDefined("Form.ConfirmDelete.X")#>
	<CFQUERY name="DeleteOffer" datasource="#gDSN#">
		UPDATE	Offers
		SET 	ExpirationDate = #CreateODBCDate(Now())#
		WHERE 	OfferID = #form.OfferID#
	</CFQUERY>
	<!--- & then it'll just continue through & be in ChooseOfferMode; no need to loop through again & call nationaloffers.cfm --->
</CFIF>	 

<!--- Determine the Mode it's in --->
<!--- linda, 11/16/99: Modes are trimmed down to events that display a page.  
Events that just cause processing are listed above, so that when they're done, 
they'll fall into the default ChooseOfferMode & will display the listing of offers. --->
<CFSET ChooseOfferMode = FALSE>
<CFSET NewMode = FALSE>
<CFSET ModifyMode = FALSE>
<CFSET CustDisclMode = FALSE>
<CFSET CarCutMode = FALSE>
<CFSET DeleteMode = FALSE>

<CFIF #IsDefined("Form.btnNew.X")#>	<!--- Add New Offer button on ChooseOfferMode page  --->
	<CFSET NewMode = TRUE>
<CFELSEIF #IsDefined("Form.btnModify.X")#>  <!--- Modify Offer button on ChooseOfferMode page --->
	<CFSET ModifyMode = TRUE>
<CFELSEIF #IsDefined("Form.btnNext.X")#>
	<cfif #form.TemplateID# EQ 1>
		<!--- Standard MSRP, no additional disclaimer info req'd.  continue on to CarCuts --->
		<CFSET CarCutMode = TRUE>
	<cfelse>
		<!--- Custom disclaimer or disclaimer templates, where you can enter %, $ amts, dates, etc. --->
		<CFSET CustDisclMode = TRUE>
	</cfif>
<CFELSEIF #IsDefined("Form.btnSaveDiscl.X")#>  <!--- done with custom disclaimer, ready to continue with carcut. --->
	<CFSET CarCutMode = TRUE>
<CFELSEIF #IsDefined("Form.btnDelete.X")#>  <!--- Delete Offer button on Add/Modify/Delete page --->
	<CFSET DeleteMode = TRUE>
<CFELSE>
	<CFSET ChooseOfferMode = TRUE>
</CFIF>

<!--- proceed with mode-specific queries --->
<CFIF ChooseOfferMode>
	<!--- First iteration - List of offers to add/modify/delete --->
	<!--- linda, 11/11/99: if RegionID is selected, show region, & hone right in on the offers with that region.
	if RegionID is 0, it's national, so we have to find offers indirectly by make & model --->
	<cfoutput>
	<CFQUERY name="getOffers" datasource="#gDSN#">
		SELECT	Makes.MakeName, 
				<CFIF #URL.RegionID# NEQ 0>
				MakeRegions.RegionName,
				</cfif>
				Offers.OfferID,
				Offers.Name, 
				Models.Description, 
				Offers.ExpirationDate
		FROM 	(Offers 
				INNER JOIN Models ON Offers.ModelID = Models.ModelID) 
				INNER JOIN Makes ON Models.Make = Makes.MakeNumber
				<CFIF #URL.RegionID# NEQ 0>
				INNER JOIN MakeRegions ON Offers.RegionID = MakeRegions.RegionID
		WHERE 	Offers.RegionID = #URL.RegionID#
		<cfelse>
		WHERE 	Makes.MakeNumber = #URL.MakeNumber# AND Offers.OfferTypeID = 1
		</cfif>
				<!--- linda, 12/15/99: theresa doesn't want to see expired/"deleted" offers --->
				AND Offers.ExpirationDate > #CreateODBCDate(DateFormat(Now(), "mm/dd/yyyy"))#
		ORDER BY Models.Description, Offers.ExpirationDate
	</cfquery>
	</cfoutput>
</CFIF>

<CFIF NewMode>
	<!--- listing of Make regions for checkboxes. --->
	<cfquery name="getRegions" datasource="#gDSN#">
		SELECT	RegionID,
				RegionName
		FROM	MakeRegions
		WHERE	MakeNumber = #URL.MakeNumber#
		ORDER BY RegionName
	</cfquery>
</cfif>

<CFIF NewMode OR ModifyMode>
	<!--- listing of model names for the drop-down. --->
	<CFQUERY name="GetModels" datasource="#gDSN#">
		SELECT	ModelID,
				Description
		FROM 	Models
		WHERE	Make = #URL.MakeNumber#
		ORDER BY Models.Description
	</CFQUERY>
</cfif>

<CFIF ModifyMode>
	<CFQUERY NAME="getNationalOffer" DATASOURCE="#gDSN#">
		SELECT 	Offers.OfferID,
				Offers.ModelID, 
				Offers.Name, 
				Offers.Description, 
				Offers.ExpirationDate, 
				OfferDisclaimers.TemplateID
		FROM 	Offers INNER JOIN OfferDisclaimers ON Offers.DisclaimerID = OfferDisclaimers.DisclaimerID
		WHERE 	OfferID = #form.OfferID#;
	</CFQUERY>
</CFIF>

<CFIF CarCutMode>
	<CFIF NOT #IsDefined("Form.new")#>  
		<!--- Existing Offer --->
		<CFQUERY name="GetOffer" datasource="#gDSN#">
			SELECT	CarcutID
			FROM	Offers
			WHERE	Offers.OfferID = #form.OfferID#;
		</CFQUERY>
	</CFIF>
	
	<!--- LINDA: enhanced this query, so it looks in the right dir (Make) for carcuts --->
	<CFQUERY name="getCarCuts" datasource="#gDSN#">
		SELECT	CarCutKey.CarCutID,
			   	Models.Make
		FROM 	CarCutKey INNER JOIN Models ON CarCutKey.ModelID = Models.ModelID
		WHERE 	CarCutKey.ModelID = #form.ModelID#;
	</CFQUERY>
</cfif>

<CFIF DeleteMode>
	<CFQUERY name="GetOffer" datasource="#gDSN#">
		SELECT 	Models.Description as ModelDescription,
				Offers.Name,
				Offers.Description as OfferDescription,
				Offers.ExpirationDate,
				Offers.DisclaimerID,
				OfferDisclaimers.TemplateID
		FROM 	Offers,
			 	OfferDisclaimers,
			 	Models
		WHERE 	Offers.OfferID = #form.OfferID#
		AND 	Offers.ModelID = Models.ModelID
		AND 	Offers.DisclaimerID = OfferDisclaimers.DisclaimerID;
	</CFQUERY>
</cfif>

<!--- these happen for every mode, to display in the page heading --->
<cfquery name="getMakeName" datasource="#gDSN#">
	SELECT	MakeName 
	FROM 	Makes
	WHERE	MakeNumber = #URL.MakeNumber#
</cfquery>
	
<cfquery name="getRegionName" datasource="#gDSN#">
	SELECT	RegionName
	FROM 	MakeRegions
	WHERE	RegionID = #URL.RegionID#
</cfquery>

<!--- so the background doesn't repeat --->
<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>

<BODY>
<!--- this page heading is common to all modes --->
<br><br><br><br><br>
<div align="center">
<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
<TR ALIGN="center">
	<TD>
		<h3>
		<br>Maintain Offers
		<br><cfoutput>#getMakeName.MakeName# <cfif #URL.RegionID# EQ 0>National<cfelse>#getRegionName.RegionName#</cfif></cfoutput>
		</h3>
	</TD>
</TR>

<CFIF ChooseOfferMode>
	<!--- "Select an Offer" --->
	<cfoutput>
	<FORM  ACTION="nationaloffers.cfm?MakeNumber=#URL.MakeNumber#&RegionID=#URL.RegionID#" METHOD="post">
	</cfoutput>
	<CFIF #getOffers.recordCount# IS NOT '0'>
		<TR ALIGN="center">
			<TD>Please select the Offer you wish to Modify</TD>
        </TR>
		<TR ALIGN="center">
			<TD>
				<br>
				<TABLE BORDER=0 CELLPADDING=0 CELLSPACING=10>
				<TR>
					<TD>&nbsp;</TD>
					<TD><b>Model</b></TD>
					<TD><b>Offer Name</b></TD>
					<TD><b>Expires</b></TD>
				</TR>
				<CFOUTPUT query="getOffers">
				<TR>
					<TD>
						<INPUT type="radio"
							name="offerID"
							value="#OfferID#"
							<CFIF #getOffers.CurrentRow# EQ 1>CHECKED</CFIF>>
					</TD>
					<TD>#Description#</TD>
					<TD>#Name#</TD>
					<TD>#DateFormat(ExpirationDate,"mm/dd/yyyy")#</TD>
				</TR>
				</CFOUTPUT>
				</TABLE>
			</TD>
		</TR>
	<CFELSE>
		<TR ALIGN="CENTER">
			<TD>
				<cfoutput>
				There are currently NO <b>#getMakeName.MakeName# <cfif #URL.RegionID# EQ 0>National<cfelse>#getRegionName.RegionName#</cfif></b> offers available.
				</cfoutput>
			</TD>
		</TR>
	</CFIF>
		
	<CFIF #getOffers.RecordCount# IS NOT '0'>
		<TR align=center>
			<TD>
				<br>
				<INPUT TYPE="Image"
					SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/modifyoffer.jpg"
					Border="0"
					NAME="btnModify"
					VALUE="Modify Offer">
				&nbsp;&nbsp;
				<INPUT TYPE="Image"
					SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/deletenationaloffer.jpg"
					Border="0"
					name="btnDelete"
					VALUE="Delete Offer">
			</TD>
		</TR>
	</CFIF>
	<TR align=center>
		<TD>
			<br>
			<INPUT TYPE="Image"
				SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg"
				BORDER="0"
				NAME="btnCancelMake"
				VALUE="Cancel">
			&nbsp;&nbsp;
			<INPUT TYPE="Image"
				SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/addoffer.jpg"
				Border="0"
				NAME="btnNew"
				VALUE="Add New Offer">
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
</CFIF>

<CFIF NewMode OR ModifyMode>
	<!--- Enter Model, Offer Name, Offer Description, Expiration Date, OfferDisclaimers --->
	<TR>
		<TD ALIGN=CENTER>
			<br>
			<cfoutput>
			<FORM  ACTION="nationaloffers.cfm?MakeNumber=#URL.MakeNumber#&RegionID=#URL.RegionID#" METHOD="post">
			</cfoutput>
			<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0>
				<cfoutput>
				<CFIF NewMode>
					<TR align=center>
						<TD>
							<b>Which Regions does this offer apply to?</b>
						</TD>
					</TR>
					<tr align="center">
						<td>
							<input type="checkbox" name="Regions" value="0"<cfif #URL.RegionID# EQ 0> CHECKED</cfif>>National
							<cfloop query = "getRegions">
								<input type="checkbox" name="Regions" value="#regionID#"<cfif #URL.RegionID# EQ #regionID#> CHECKED</cfif>>#RegionName#
							</cfloop>
							<INPUT TYPE="hidden" NAME="Regions_required" VALUE="Please select at least one Region that this offer applies to.">
						</td>
					</tr>
				</cfif>
				<TR align=center>
					<TD>
						<br>
						<b>Select a Model</b>
					</TD>
				</TR>
				<TR ALIGN=center>
					<TD>
						<SELECT name="modelID">
						<cfloop query="getModels">
							<OPTION value="#ModelID#"<CFIF ModifyMode><CFIF #getNationalOffer.ModelID# IS ModelID> SELECTED</CFIF></CFIF>>#getmodels.Description#</OPTION>
						</cfloop>
						</SELECT>
					</TD>
				</TR>
				<TR ALIGN=center>
					<TD>
						<br>
						<b>Offer Name</b>
					</TD>
				</TR>
				<TR ALIGN=center>
					<TD>
						<INPUT type="text"
							name="offer_name"
							size="35"
							maxlength="35"
							value=<CFIF ModifyMode>"#GetNationalOffer.Name#"<cfelse>"Offer Name"</cfif>>
					</TD>
				</TR>
				<TR ALIGN=center>
					<TD>
						<br>
						<b>Offer Description</b>
					</TD>
				</TR>
				<TR ALIGN=center>
					<TD>
						<!----- CAREFUL!!!! Maxlength in the DB is only 255 ----->
						<!--- linda, 11/17/99: changed Description field in db to be a Text/Memo field.  so it's limitless now. --->
						<textarea name="offer_body"
							cols="35"
							rows="10"
							wrap="PHYSICAL"><CFIF ModifyMode>#getNationalOffer.Description#<cfelse>Enter Offer Here</cfif></textarea>
					</TD>
				</TR>
				<TR ALIGN=CENTER>
					<TD>
						<br>
						<b>Expiration Date</b> (mm/dd/yyyy)
					</TD>
				</TR>
				<TR ALIGN=CENTER>
					<TD>
						<INPUT type="text"
							name="expiration"
							maxlength="10"
							<CFIF ModifyMode>
							value="#DateFormat(getNationalOffer.ExpirationDate,'mm/dd/yyyy')#"
							<cfelse>
							value="#DateFormat(DateAdd("m",1,Now()),'mm/dd/yyyy')#"
							</cfif>>
						<INPUT type="hidden" name="expiration_date" value="You must enter an expiration date in the form mm/dd/yyyy">
					</TD>
				</TR>
				<TR align="center">
					<TD>
						<br>
						<b>Please choose a Disclaimer Template</b>
					</TD>
				</TR>
				<TR>
					<TD>
						<TABLE BORDER=1 ALIGN=CENTER VALIGN=TOP>
						<TR>
							<TD ALIGN=CENTER VALIGN=MIDDLE>
								<INPUT type="radio" name="templateID" value="1" <CFIF NewMode>CHECKED<cfelseif ModifyMode AND #getNationalOffer.TemplateID# IS '1'>CHECKED</CFIF>>
							</TD>
							<TD ALIGN=LEFT>
								<b>MSRP:</b>
								<br>
								MSRP. Title and taxes extra.
							</TD>
						</TR>
						<TR>
							<TD ALIGN="center" valign="middle">
								<input type="Radio" name="templateID" value="0" <CFIF ModifyMode><cfif #getNationalOffer.TemplateID# IS '0'>CHECKED</CFIF></cfif>>
							</TD>
							<TD align="left">
								<b>Custom:</b>
								<br>
								Enter a custom disclaimer.
							</TD>
						</TR>
						</TABLE>
					</TD>
				</TR>
			</TABLE>
		</TD>
	</TR>
	<CFIF NewMode>
		<INPUT type="hidden" name="new" value="1">
	<CFELSE> <!--- existing offer --->
		<INPUT type="hidden" NAME="offerID" value="#form.offerID#">
	</CFIF>
	</cfoutput>
	<TR ALIGN="center">
		<TD>
			<br>
			<INPUT TYPE="Image"
				SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg"
				BORDER="0"
				NAME="btnCancelOffer"
				VALUE="Cancel">
			&nbsp;&nbsp;
			<INPUT TYPE="Image"
				SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next_nav.jpg"
				BORDER="0"
				NAME="btnNext"
				VALUE="Next">
			</FORM>
			<p>
			<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
			<INPUT TYPE="Image"
				SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg"
				Border="0"
				NAME="BackToMain"
				VALUE="Back To Main Menu">
			</FORM>
		</TD>
	</TR>
</CFIF>

<CFIF CustDisclMode>
	<!--- Customize Disclaimer --->
	<INPUT type="hidden" name="ModelID" value="#Form.ModelID#">
	<INPUT type="hidden" name="offer_name" value="#form.Offer_name#">
	<INPUT type="hidden" name="offer_body" value="#form.offer_body#">
	<INPUT type="hidden" name="expiration" value="#form.expiration#">
	<INPUT type="hidden" name="templateid" value="#form.templateid#">
	<CFIF ParameterExists(form.new)>
		<INPUT type="hidden" NAME="new" value="#form.new#">
		<INPUT type="hidden" name="Regions" value="#Form.Regions#">
	<CFELSE> <!--- existing offer --->
		<INPUT type="hidden" NAME="offerID" value="#form.offerID#">
	</CFIF>
	<CFSET variables.national_offer = TRUE>
	<CFINCLUDE template="di_form_#FORM.TemplateID#.cfm">
</CFIF>

<CFIF CarCutMode>
	<!--- Choose CarCut --->
	<TR>
		<TD>
			<br>
			<cfoutput>
			<FORM  ACTION="nationaloffers.cfm?MakeNumber=#URL.MakeNumber#&RegionID=#URL.RegionID#" METHOD="post">
			</cfoutput>
			<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0 WIDTH="100%">
			<TR ALIGN=CENTER>
				<TD>
					<b>Select a Carcut</b>
				</TD>
			</TR>
			<TR ALIGN=CENTER>
				<TD>
					<br>
					<!--- Display all the Carcuts for the selected model --->
					<CFSET #counter# = 1>
					<CFLOOP query="getCarCuts">
						<CFOUTPUT>
						Carcut #counter#: 
						<INPUT type="radio"
							name="carcut"
							value="#carcutID#"
							<CFIF #IsDefined("Form.New")#>
								<CFIF #carcutID# EQ '1'>CHECKED</CFIF>
							<CFELSE>
								<CFIF #carcutID# EQ #getoffer.carcutID#>CHECKED</CFIF>
							</CFIF>>
						&nbsp;&nbsp;
						<IMG
							SRC="#application.RELATIVE_PATH#/images/vehicles/#Make#/#form.modelID#_#carcutID#.jpg"
							align="middle">
						<p>
						</CFOUTPUT>
						<CFSET #counter# = #counter# + 1>
					</CFLOOP>
				</TD>
			</TR>
			<TR ALIGN="center">
				<TD>
					<br>
	   	     		<CFOUTPUT>
					<CFIF ParameterExists(form.new)>
						<INPUT type="hidden" NAME="new" value="#form.new#">
						<INPUT type="hidden" name="Regions" value="#Form.Regions#">
					<CFELSE> <!--- existing offer --->
						<INPUT type="hidden" NAME="offerID" value="#form.offerID#">
					</CFIF>
					<INPUT type="hidden" name="ModelID" value="#Form.ModelID#">
					<INPUT type="hidden" name="offer_name" value="#form.Offer_name#">
					<INPUT type="hidden" name="offer_body" value="#form.offer_body#">
					<INPUT type="hidden" name="expiration" value="#form.expiration#">
					<INPUT type="hidden" name="templateid" value="#form.templateid#">
					<CFIF ParameterExists(form.disclaimer_body)>
						<INPUT type="hidden" name="disclaimer_body" value="#form.disclaimer_body#">
					</cfif>
					</CFOUTPUT>
	       	     	<INPUT TYPE="Image" 
						SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg" 
						BORDER="0" 
						NAME="btnCancelOffer" 
						VALUE="Cancel">
					&nbsp;&nbsp;
					<INPUT TYPE="Image"
						SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/savenationaloffer.jpg"
						Border="0"
						NAME="btnSave"
						VALUE="Save National Offer">
					</FORM>
   	         		<p>
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
		</TD>		
	</TR>
</CFIF>


<!--- Display a summary of offer info, allowing user to confirm deletion or cancel out. --->
<CFIF DeleteMode>
	<TR ALIGN="center">
		<TD>
			<br>
			"Deleting" will just change the Expiration Date to today.
			<br>
			Are you sure you wish to proceed?
		</TD>
	</TR>
	<TR BGCOLOR="ffffff" align="center">
		<TD>
			<br>
			<TABLE BORDER=0 WIDTH="90%">
			<CFOUTPUT query="GetOffer">
			<TR>
				<TD><b>Model:</b></TD>
				<TD>#ModelDescription#</td>
			</TR>
			<TR>
				<TD><b>Offer Name:</b></TD>
				<TD>#Name#</TD>
			</TR>
			<TR>
				<TD><b>Offer Description:</b></TD>
				<TD>#OfferDescription#</TD>
			</TR>
			<TR>
				<TD><b>Expiration Date:</b></TD>
				<TD>#DateFormat(expirationDate, "mmmm d, yyyy")#</TD>
			</TR>
			<TR>
				<TD><b>Disclaimer:</b></TD>
				<TD>
					<!--- linda, 11/15/99: this needs to be db-driven, not file-content-driven in the future!! --->
					<CFIF #getoffer.DisclaimerID# IS NOT "">
						<CFSET #variables.ID# = #getOffer.DisclaimerID#>
						<CFINCLUDE template="../../../includes/disclaimers/#getoffer.templateid#.cfm">
					</CFIF>
				</TD>
			</TR>
			</TABLE>
		</TD>
	</TR>
	<TR><TD>&nbsp;</TD></TR>
	<FORM Action="nationaloffers.cfm?MakeNumber=#URL.MakeNumber#&RegionID=#URL.RegionID#" method="post">
	<INPUT type="hidden" name="offerID" value="#form.offerID#">
	</cfoutput>
	<TR ALIGN="center">
		<TD>
			<INPUT TYPE="Image"
				SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg"
				BORDER="0"
				NAME="btnCancelOffer"
				VALUE="Cancel">
			&nbsp;&nbsp;
			<INPUT TYPE="Image"
				SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/deletenationaloffer.jpg"
				Border="0"
				name="ConfirmDelete"
				value="Delete National Offer">
		</TD>
	</TR>
	</FORM>
	<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
	<TR align="center">
		<TD>
			<br>
			<INPUT TYPE="Image"
				SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg"
				Border="0"
				NAME="BackToMain"
				VALUE="Back To Main Menu">
   	   	</TD>
	</TR>
	</FORM>
</CFIF>

</TABLE>
</div>
</BODY>
</HTML>