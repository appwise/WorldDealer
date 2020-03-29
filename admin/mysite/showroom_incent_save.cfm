                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 16, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!--- $Id: showroom_incent_save.cfm,v 1.7 2000/03/21 16:11:03 jkrauss Exp $ --->
<!--- Showroom Incentives: queries to insert or update Custom Vehicle Incentives --->

<cfset PageAccess = application.dealer_access>
<cfinclude template = "../security.cfm">

<!--- Existing Incentive --->
<cfif #isdefined("form.OfferID")#>
	<!--- Do an UPDATE on an Existing Offer--->
	<cfquery name="UpdateOffers" datasource="#gDSN#">
		UPDATE	Offers
		SET 	Name = '#form.Offer_Name#',
				Description = '#Form.Offer_Body#',
				ExpirationDate = #CreateODBCDate(Form.Expiration)#,
				CarCutID = #form.CarCut#,
				ModelID = #form.ModelID#
		WHERE 	OfferID = #form.OfferID#
	</cfquery>
	
	<cfquery name="getDisclaimerID" datasource="#gDSN#">
		SELECT 	DisclaimerID
		FROM 	Offers
		WHERE 	OfferID = #form.OfferID#;
	</cfquery>
	
	<!--- Update the disclaimer --->
	<cfquery name="updateOfferDisclaimers" datasource="#gDSN#">
		UPDATE	OfferDisclaimers
		SET		TemplateID = #Form.TemplateID#
		WHERE	DisclaimerID = #getDisclaimerID.DisclaimerID#
	</cfquery>
	
	<!--- If it's a Custom disclaimer (=0) --->
	<cfif #form.templateid# eq 0>
		<!--- First Check if this Custom Disclaimer Exists, so we know whether to insert or update --->
		<cfquery name="CheckDisclaimer" datasource="#gDSN#">
			SELECT 	DisclaimerID
			FROM 	CustomDisclaimers
			WHERE 	DisclaimerID = #getDisclaimerID.disclaimerID#;
		</cfquery>
		
		<cfset disclaimer_text = #replace(form.disclaimer_body, chr(13), "<BR>", "ALL")#>
		
		<!--- add or update the Custom Disclaimer text --->
		<cfif #checkdisclaimer.recordcount# eq 0>
			<cfquery name="InsCustomDisclaimer" datasource="#gDSN#">
				INSERT INTO CustomDisclaimers (
							DisclaimerID,
							DisclaimerText)
				VALUES 		(#getDisclaimerID.disclaimerID#,
							'#Disclaimer_Text#')
			</cfquery>
		<cfelse>
			<cfquery name="UpdCustomDisclaimer" datasource="#gDSN#">
				UPDATE 	CustomDisclaimers
				SET 	DisclaimerText = '#Disclaimer_Text#'
				WHERE 	DisclaimerID = #getDisclaimerID.disclaimerID#;
			</cfquery>
		</cfif>
	</cfif>
<cfelse>
	<!--- insert a new incentive --->
	<!--- insert the disclaimer 1st, cuz we need the DisclaimerID for the Offers --->
	<cfquery name="InsertOfferDisclaimers" datasource="#gDSN#">
		INSERT INTO OfferDisclaimers (TemplateID)
		VALUES (#Form.TemplateID#)
	</cfquery>

	<cfquery name="getDisclaimerID" datasource="#gDSN#">
		SELECT	Max(DisclaimerID) as DisclaimerID
		FROM 	OfferDisclaimers;
	</cfquery>

	<!--- Custom Disclaimer --->
	<cfif #form.templateid# eq 0>
		<cfset disclaimer_text = #replace(form.disclaimer_body, chr(13), "<BR>", "ALL")#>
		<cfquery name="InsCustomDisclaimer" datasource="#gDSN#">
			INSERT INTO CustomDisclaimers 
						(DisclaimerID,
						DisclaimerText)
			VALUES 		(#getDisclaimerID.DisclaimerID#,
						'#Disclaimer_Text#');
		</cfquery>
	</cfif>
	
	<!--- now insert the Incentive --->
	<cfquery name="InsertOffers" datasource="#gDSN#">
		INSERT INTO Offers (
					OfferTypeID,
					Name,
					Description,
					ExpirationDate,
					CarCutID,
					DisclaimerID,
					ModelID)
		VALUES		(
					2,  		<!--- Dealer type = 2 --->
					'#form.Offer_Name#',
					'#form.Offer_Body#',
					#CreateODBCDate(form.expiration)#,
					#form.carcut#,
					#getDisclaimerID.DisclaimerID#,
					#form.ModelID#)
	</cfquery>

	<!--- get OfferID that was just added, so we can add it to DealerOffers table --->	
	<cfquery name="getOfferID" datasource="#gDSN#">
		SELECT	Max(OfferID) as new_record
		FROM	Offers;
	</cfquery>

	<cfquery name="getDealerWebID" datasource="#gDSN#">
		SELECT	DealerWebID
		FROM	DealerWebs
		WHERE	DealerCode='#g_dealercode#';
	</cfquery>
	
	<cfquery name="newDealerOffer" datasource="#gDSN#">
		INSERT INTO DealerOffers 
				(DealerWebID, 
				OfferID)
		VALUES (#getDealerWebID.dealerWebID#, 
				#getofferID.new_record#);
	</cfquery> 
</cfif>

<cflocation url="showroom_incent.cfm" addtoken="no">
