                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 16, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!--- $Id: showroom_incent_del.cfm,v 1.7 2000/03/03 17:54:28 jkrauss Exp $ --->
<!--- Showroom: Delete Vehicle Incentives --->

<cfset PageAccess = application.dealer_access>
<cfinclude template = "../security.cfm">

<cfquery name="getDLROffers" datasource="#gDSN#">
	SELECT 	Offers.OfferID,
			Offertypes.OfferTypeID as incentType,
			DealerWebs.DealerWebID
	FROM 	DealerWebs 
			INNER JOIN DealerOffers ON DealerWebs.DealerWebID = DealerOffers.DealerWebID
			INNER JOIN Offers ON DealerOffers.OfferID = Offers.OfferID
			INNER JOIN OfferTypes ON Offers.OfferTypeID = OfferTypes.OfferTypeID
			INNER JOIN Models ON Offers.ModelID = Models.ModelID
			INNER JOIN Makes ON Models.Make = Makes.MakeNumber
	WHERE 	DealerWebs.DealerCode = '#g_dealercode#' 
	<cfif #form.all# is true>
		<!--- Get ALL Offers for this Dealer --->
		AND	Offers.ExpirationDate > #CreateODBCDate(DateFormat(Now(), "mm/dd/yyyy"))#
	<cfelse>
		<!--- Just get the offer specified --->
		AND	Offers.OfferID = #form.OfferID#
	</cfif>
</cfquery>

<!--- This will loop thru all of the dealership's offers if All is set in query, or just one if ALL is false. --->
<cfloop query="getDLROffers">
	<!--- Check what type of offer this is --->
	<cfif #incenttype# eq 2> 
		<!--- It's a custom (Dealer Offer), do mark it deleted --->
		<!--- linda, 11/8/99: setting expiration date to 1/1/95 is how it's "deleted" --->
		<cfquery name="ExpireOffer" datasource="#gDSN#">
			UPDATE	Offers
			SET		ExpirationDate = #CreateODBCDate('1/1/95')#
			WHERE	OfferID = #offerid#
		</cfquery>
	<cfelse>
		<!--- It's a National Offer so remove the entry in DealerOffers --->
		<cfquery name="RemoveOffer" datasource="#gDSN#">
			DELETE	DealerOffers
			WHERE 	DealerWebID = #DealerWebID# 
			AND 	OfferID = #offerid#;
		</cfquery>
	</cfif>
</cfloop>

<cflocation url="showroom_incent.cfm" addtoken="no">