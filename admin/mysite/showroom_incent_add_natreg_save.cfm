                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 13, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!--- $Id: showroom_incent_add_natreg_save.cfm,v 1.7 2000/03/21 16:11:03 jkrauss Exp $ --->
<!--- Showroom: Add Vehicle Incentives.  Add National / Regional offers they've selected in showroom_incent_add.cfm --->

<cfset PageAccess = application.dealer_access>
<cfinclude template = "../security.cfm">

<cfquery name="selectDealerWebID" datasource="#gDSN#">
	SELECT	DealerWebID 
	FROM	DealerWebs
	WHERE	DealerCode = '#g_dealercode#';
</cfquery>


<!--- insert the selected National / Regional Incentive, 
or all National / Regional Incentives that aren't already associated with this dealership. --->
<cfoutput>
<cfquery name="insertDealerOffers" datasource="#gDSN#">
	INSERT INTO DealerOffers (
		DealerWebID,
		OfferID
		)
	SELECT DISTINCT
		#selectDealerWebID.DealerWebID#,
		Offers.OfferID
	FROM
		Offers		 
	WHERE
		<cfif #form.offerid# eq 'all'>
			Offers.OfferID IN (
				SELECT	Offers.OfferID
				<cfif #form.offertype# is 1> <!--- national --->
				FROM 	(Offers INNER JOIN Models ON Offers.ModelID = Models.ModelID) 
						INNER JOIN DealerFranchise ON Models.Make = DealerFranchise.MakeNumber
				<cfelseif #form.offertype# is 5>  <!--- regional --->
				FROM 	(((DealerFranchise 
						INNER JOIN Offers ON DealerFranchise.RegionID = Offers.RegionID) 
						INNER JOIN Models ON Offers.ModelID = Models.ModelID) 
						INNER JOIN Makes ON Models.Make = Makes.MakeNumber) 
						INNER JOIN MakeRegions ON DealerFranchise.RegionID = MakeRegions.RegionID
				</cfif>
				WHERE 	Offers.OfferTypeID = #Form.OfferType# AND 
						Offers.ExpirationDate > #CreateODBCDate(DateFormat(Now(), "mm/dd/yyyy"))# AND 
						DealerFranchise.dealercode = '#g_dealercode#'
				)
			AND Offers.OfferID NOT IN (
				SELECT	DealerOffers.OfferID
				FROM	DealerOffers
				WHERE	DealerWebID = #selectDealerWebID.DealerWebID#
				)
		<cfelse>
			Offers.OfferID = #Form.OfferID#
		</cfif>
</cfquery>
</cfoutput>

<cflocation url="showroom_incent.cfm" addtoken="no">

