<cfset PageAccess = application.account_coordinator_access>
<cfinclude template = "../security.cfm">

                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <February 8, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: dealers_delete.cfm,v 1.7 2000/05/10 17:13:28 lswanson Exp $ --->

<!--- Queries to do the actual deleting of the dealership.
This deletes all records in the database and images that are related to this dealership. --->
<cftransaction>
	<cfquery name="selectDealerWebID" datasource="#gDSN#">
		SELECT	DealerWebID
		FROM	DealerWebs
		WHERE	DealerCode = '#g_DealerCode#'
	</cfquery>

	<!--- DealerWebs - based tables --->		
	<cfif #selectdealerwebid.recordcount# gt 0>
		<!--- DealerBanners -> Banners -> DealerSpecialPromotions -> SpecialPromotions --->
		<cfquery name="getDealerBanners" datasource="#gDSN#">
			SELECT	Banners.BannerID, 
					Banners.SpecPromoID
			FROM	DealerBanners INNER JOIN Banners ON DealerBanners.BannerID = Banners.BannerID
			WHERE	DealerBanners.DealerWebID = #selectDealerWebID.DealerWebID#
		</cfquery>
	
		<cfquery name="deleteDealerBanners" datasource="#gDSN#">
			DELETE FROM DealerBanners
			WHERE DealerWebID = #selectDealerWebID.DealerWebID#
		</cfquery>
	
		<cfloop query="GetDealerBanners">
			<cfquery name="deleteBanners" datasource="#gDSN#">
				DELETE FROM Banners
				WHERE BannerID = #getDealerBanners.BannerID#
			</cfquery>

			<cfquery name="deleteDlrSpecPromos" datasource="#gDSN#">
				DELETE FROM DealerSpecialPromotions
				WHERE SpecPromoID = #GetDealerBanners.SpecPromoID#
			</cfquery>

			<cfquery name="deleteSpecPromos" datasource="#gDSN#">
				DELETE FROM SpecialPromotions
				WHERE SpecPromoID = #GetDealerBanners.SpecPromoID#
			</cfquery>
		</cfloop>

		<cfif g_dlr>
			<!--- DealerOffers -> Offers -> OfferDisclaimers --->
			<!--- get custom Dealer offers --->
			<cfquery name="GetDLROffers" datasource="#gDSN#">
				SELECT	Offers.OfferID, 
						Offers.DisclaimerID
				FROM	DealerOffers INNER JOIN Offers ON DealerOffers.OfferID = Offers.OfferID
				WHERE	DealerOffers.DealerWebID = #selectDealerWebID.DealerWebID#
						AND	Offers.OfferTypeID = 2 <!--- 1=national, 2=dealer --->
			</cfquery>
	
			<!--- the above Offer queries only dealt with dealer offers, this query now deletes all offers, 
			including links to national and regional offers, associated with this dealer --->	
			<cfquery name="deleteDealerOffers" datasource="#gDSN#">
				DELETE FROM DealerOffers
				WHERE DealerWebID = #selectDealerWebID.DealerWebID#
			</cfquery>

			<!--- now delete the custom Dealer offers found above. --->
			<cfloop query="GetDLROffers">
				<cfquery name="deleteOffers" datasource="#gDSN#">
					DELETE FROM Offers
					WHERE OfferID = #GetDLROffers.OfferID#
				</cfquery>

				<cfquery name="deleteOfferDisclaimers" datasource="#gDSN#">
					DELETE FROM OfferDisclaimers
					WHERE DisclaimerID = #GetDLROffers.DisclaimerID#
				</cfquery>

				<!--- getting errors on live system; can't duplicate on olympus.  maybe error if custom discl doesn't exist. --->
				<cfquery name="CustomDisclExist" datasource="#gDSN#">
					SELECT	DisclaimerID
					FROM	CustomDisclaimers
					WHERE	DisclaimerID = #GetDLROffers.DisclaimerID#
				</cfquery>
				
				<cfif CustomDisclExist.RecordCount>
					<cfquery name="deleteCustomDisclaimers" datasource="#gDSN#">
						DELETE FROM CustomDisclaimers
						WHERE DisclaimerID = #GetDLROffers.DisclaimerID#
					</cfquery>
				</cfif>
			</cfloop>
		</cfif>
			
		<cfif g_dlr>
			<!--- VirtualCoupons --->			
			<cfquery name="deleteCoupons" datasource="#gDSN#">
				DELETE FROM VirtualCoupons
				WHERE DealerWebID = #selectDealerWebID.DealerWebID#
			</cfquery>
		</cfif>
	</cfif>

	<!--- DealerCode - based tables --->
	<!--- Accounts --->
	<cfquery name="deleteAccounts" datasource="#gDSN#">
		DELETE FROM Accounts
		WHERE AccountKey = '#g_DealerCode#'
	</cfquery>
	
	<!--- AccountSecurity: reset the dealercode back to blank, since the dealer you were on just got deleted. --->
	<cfquery name="getSessionID" datasource="#gDSN#">
		SELECT	SessionID
		FROM	AccountSecurity
		WHERE	UserID = #getUserInfo.RowID#
		ORDER BY SessionID DESC
	</cfquery>
	
	<cfquery name="updLastDlrSelected" datasource="#gDSN#">
		UPDATE	AccountSecurity
		SET		Dealercode = ''
		WHERE	SessionID = #getSessionID.SessionID#
	</cfquery>

	<!--- CollectionDealers --->
	<cfif g_col>
		<cfquery name="deleteCollectionDealers" datasource="#gDSN#">
			DELETE FROM CollectionDealers
			WHERE Coll_Dealercode = '#g_dealercode#'
		</cfquery>
	<cfelseif g_dlr>
		<cfquery name="deleteCollectionDealers" datasource="#gDSN#">
			DELETE FROM CollectionDealers
			WHERE Dealercode = '#g_dealercode#'
		</cfquery>
	</cfif>
	
	<cfif g_dlr>
		<!--- DealerFranchise --->
		<cfquery name="deleteDealerFranchise" datasource="#gDSN#">
			DELETE FROM DealerFranchise
			WHERE Dealercode = '#g_DealerCode#'
		</cfquery>
	</cfif>
	
	<cfif g_col>
		<!--- DealersNonWD --->
		<cfquery name="deleteDealersNonWD" datasource="#gDSN#">
			DELETE FROM DealersNonWD
			WHERE GroupDealerCode = '#g_DealerCode#'
		</cfquery>
	</cfif>
	
	<!--- DealerURL --->
	<cfquery name="updDealerURL" datasource="#gDSN#">
		DELETE FROM DealerURL
		WHERE	Dealercode = '#g_dealercode#'
	</cfquery>

	<cfif g_dlr>
		<!--- DlrXRef --->
		<cfquery name="updDlrXRef" datasource="#gDSN#">
			DELETE FROM DlrXRef
			WHERE	Dealercode = '#g_dealercode#'
		</cfquery>
		
		<!--- HoursofOperation --->
		<cfquery name="updHoursofOperation" datasource="#gDSN#">
			DELETE FROM HoursofOperation
			WHERE	Dealercode = '#g_dealercode#'
		</cfquery>
	</cfif>
	
	<!--- RequestInfoGeneral, ~Quote, ~Financing, ~Service, ~Parts  --->
	<cfquery name="getGeneral" datasource="#gDSN#">
		SELECT 	RequestInfoID
		FROM 	RequestInfoGeneral
		WHERE 	DealerCode = '#g_DealerCode#'
	</cfquery>
		
	<cfloop query="getGeneral">
		<cfquery name="deleteRequestInfoQuote" datasource="#gDSN#">
			DELETE FROM RequestInfoQuote
			WHERE RequestInfoGeneralID = #getGeneral.RequestInfoID#
		</cfquery>
		
		<cfquery name="deleteRequestInfoFinancing" datasource="#gDSN#">
			DELETE FROM RequestInfoFinancing
			WHERE RequestInfoGeneralID = #getGeneral.RequestInfoID#
		</cfquery>
		
		<cfquery name="deleteRequestInfoService" datasource="#gDSN#">
			DELETE FROM RequestInfoService
			WHERE RequestInfoGeneralID = #getGeneral.RequestInfoID#
		</cfquery>
		
		<cfquery name="deleteRequestInfoParts" datasource="#gDSN#">
			DELETE FROM RequestInfoParts
			WHERE RequestInfoGeneralID = #getGeneral.RequestInfoID#
		</cfquery>
	</cfloop>
		
	<cfquery name="deleteRequestInfoGeneral" datasource="#gDSN#">
		DELETE FROM RequestInfoGeneral
		WHERE DealerCode = '#g_DealerCode#'
	</cfquery>
		
	<cfif g_dlr>
		<!--- UsedVehicles, UsedVehiclesOptions --->
		<cfquery name="getUsedVehicles" datasource="#gDSN#">
			SELECT 	UsedVehicleID
			FROM	UsedVehicles
			WHERE	Dealercode = '#g_DealerCode#'
		</cfquery>
			
		<cfloop query="getUsedVehicles">
			<cfquery name="deleteUsedVehiclesOptions" datasource="#gDSN#">
				DELETE FROM UsedVehiclesOptions
				WHERE UsedVehicleID = #getUsedVehicles.UsedVehicleID#
			</cfquery>
		</cfloop>
		
		<cfquery name="deleteUsedVehicles" datasource="#gDSN#">
			DELETE FROM UsedVehicles
			WHERE DealerCode = '#g_DealerCode#'
		</cfquery>
	</cfif>

	<!--- DealerWebs --->
	<cfquery name="deleteDealerWebs" datasource="#gDSN#">
		DELETE FROM DealerWebs
		WHERE	Dealercode = '#g_dealercode#'
	</cfquery>

	<!--- Dealers --->
	<cfquery name="deleteDealer" datasource="#gDSN#">
		DELETE FROM Dealers
		WHERE DealerCode = '#g_DealerCode#'
	</cfquery>

	<!--- Delete all images for this dealership --->
	<!--- banner images --->
	<cfx_directorylist directory="#g_rootdir#\images\banner" name="banner_query" sort="type ASC, name ASC">
	
	<cfloop query="banner_query">
		<cfset match = #find(g_dealercode, name, 1)#>
		<cfif #match# eq 1> <!--- This file starts with g_dealercode --->
			<cffile action="delete" file="#g_rootdir#\images\banner\#name#">
		</cfif>
	</cfloop>

	<cfif g_dlr>
		<!--- coupon images --->
		<cfx_directorylist directory="#g_rootdir#\images\coupons" name="coupon_query" sort="type ASC, name ASC">
	
		<cfloop query="coupon_query">
			<cfset match = #find(g_dealercode, name, 1)#>
			<cfif #match# eq 1> <!--- This file starts with g_dealercode --->
				<cffile action="delete" file="#g_rootdir#\images\coupons\#name#">
			</cfif>
		</cfloop>
	</cfif>

	<!--- leftnav logo images --->
	<cfx_directorylist directory="#g_rootdir#\images\logo" name="logo_query" sort="type ASC, name ASC">

	<cfloop query="logo_query">
		<cfset match = #find(g_dealercode, name, 1)#>
		<cfif #match# eq 1> <!--- This file starts with g_dealercode --->
			<cffile action="delete" file="#g_rootdir#\images\logo\#name#">
		</cfif>
	</cfloop>

	<cfif g_dlr>
		<!--- map images --->
		<cfx_directorylist directory="#g_rootdir#\images\maps" name="maps_query" sort="type ASC, name ASC">
		
		<cfloop query="maps_query">
			<cfset match = #find(g_dealercode, name, 1)#>
			<cfif #match# eq 1> <!--- This file starts with g_dealercode --->
				<cffile action="delete" file="#g_rootdir#\images\maps\#name#">
			</cfif>
		</cfloop>
	</cfif>
	
	<!--- splash page logo images --->
	<cfx_directorylist directory="#g_rootdir#\images\sp_logo" name="sp_logo_query" sort="type ASC, name ASC">
	
	<cfloop query="sp_logo_query">
	<cfset match = #find(g_dealercode, name, 1)#>
		<cfif #match# eq 4> <!--- This file starts with "sp_<g_dealercode>" --->
			<cffile action="delete" file="#g_rootDir#\images\sp_logo\#name#">
		</cfif>
	</cfloop>
</cftransaction>
