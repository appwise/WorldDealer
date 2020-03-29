                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 14, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!--- Save the Added or Modified Incentive --->
						  
<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: incentives_save.cfm,v $">

<cfset PageAccess = application.account_coordinator_access>
<cfinclude template = "../security.cfm">

<cfif #isdefined("form.OfferID")#>  
	<cfset editmode = true>
<cfelse>
	<cfset editmode = false>
</cfif>

<cfif editmode>
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
<cfelse>
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
			INSERT INTO Offers (
					OfferTypeID,
					Name,
					Description,
					ExpirationDate,
					CarCutID,
					DisclaimerID,
					ModelID,
					RegionID)
			VALUES	(#selectedOfferType#,
					'#form.Offer_Name#',
					'#form.Offer_Body#',
					#CreateODBCDate(form.expiration)#,
					#form.carcut#,
					#getDisclaimerID.DisclaimerID#,
					#form.ModelID#,
					#RegionIndex#)
		</CFQUERY>
	</cfloop>
</cfif>

<CFLOCATION URL="incentives.cfm?MakeNumber=#url.MakeNumber#&RegionID=#url.RegionID#" addtoken="no">

<cfmodule template="/util/DumpDebug.cfm" text="end   $RCSfile: incentives_save.cfm,v $">
