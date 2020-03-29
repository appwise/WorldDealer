<!--- $Id: deletedealerkill.cfm,v 1.4 1999/11/29 16:34:03 lswanson Exp $ --->
	<CFTRANSACTION>
		<CFQUERY name="selectDealerWebID" datasource="#gDSN#">
			SELECT DealerWebID
			FROM DealerWebs
			WHERE DealerCode = '#g_DealerCode#';
		</CFQUERY>

		<!--- DealerWebs - based tables --->		
		<CFIF #selectDealerWebID.RecordCount# GT 0>
			<!--- DealerSpecialPromotions, SpecialPromotions associated with banners --->
			<CFQUERY name="GetDlrSpecPromos" datasource="#gDSN#">
				SELECT SpecPromoID 
				FROM DealerSpecialPromotions
				WHERE DealerWebID = #selectDealerWebID.DealerWebID#;
			</CFQUERY>
			
			<CFQUERY name="deleteDlrSpecPromos" datasource="#gDSN#">
				DELETE FROM DealerSpecialPromotions
				WHERE DealerWebID = #selectDealerWebID.DealerWebID#;
			</CFQUERY>
		
			<CFLOOP query="GetDlrSpecPromos">
				<CFQUERY name="deleteSpecPromos" datasource="#gDSN#">
					DELETE FROM SpecialPromotions
					WHERE SpecPromoID = #GetDlrSpecPromos.SpecPromoID#;
				</CFQUERY>
			</CFLOOP>

			<!--- DealerBanners, Banners --->
			<CFQUERY name="getDealerBanners" datasource="#gDSN#">
				SELECT BannerID
				FROM DealerBanners
				WHERE DealerWebID = #selectDealerWebID.DealerWebID#;
			</CFQUERY>
		
			<CFQUERY name="deleteDealerBanners" datasource="#gDSN#">
				DELETE FROM DealerBanners
				WHERE DealerWebID = #selectDealerWebID.DealerWebID#;
			</CFQUERY>
		
			<CFLOOP QUERY="GetDealerBanners">
				<CFQUERY name="deleteBanners" datasource="#gDSN#">
					DELETE FROM Banners
					WHERE BannerID = #getDealerBanners.BannerID#
				</CFQUERY>
			</CFLOOP>
		
			<!--- DealerOffers, Offers, OfferDisclaimers --->
			<CFQUERY name="GetDLROffers" datasource="#gDSN#">
				SELECT 	DealerOffers.OfferID,
						Offers.DisclaimerID
				FROM 	DealerOffers,
					 	Offers
				WHERE 	DealerOffers.DealerWebID = #selectDealerWebID.DealerWebID# AND
					  	Offers.OfferTypeID = 2 AND	<!--- 1=national, 2=dealer --->
				  	  	Offers.OfferID = DealerOffers.OfferID;
			</CFQUERY>
			
			<CFQUERY name="deleteDealerOffers" datasource="#gDSN#">
				DELETE FROM DealerOffers
				WHERE DealerWebID = #selectDealerWebID.DealerWebID#;
			</CFQUERY>

			<CFLOOP query="GetDLROffers">
				<CFQUERY name="deleteOfferDisclaimers" datasource="#gDSN#">
					DELETE FROM OfferDisclaimers
					WHERE DisclaimerID = #GetDLROffers.DisclaimerID#;
				</CFQUERY>
			
				<CFQUERY name="deleteOffers" datasource="#gDSN#">
					DELETE FROM Offers
					WHERE OfferID = #GetDLROffers.OfferID#;
				</CFQUERY>
			</CFLOOP>
		
			<!--- VirtualCoupons --->			
			<CFQUERY name="deleteCoupons" datasource="#gDSN#">
				DELETE FROM VirtualCoupons
				WHERE DealerWebID = #selectDealerWebID.DealerWebID#;
			</CFQUERY>
		
			<!--- DealerWebs --->
			<CFQUERY name="deleteDealerWebs" datasource="#gDSN#">
				DELETE FROM DealerWebs
				WHERE DealerWebID = #selectDealerWebID.DealerWebID#;
			</CFQUERY>
		</CFIF>

		<!--- DealerCode - based tables --->		
		<!--- RequestInfoGeneral, ~Quote, ~Financing, ~Service, ~Parts  --->
		<CFQUERY name="getGeneral" datasource="#gDSN#">
			SELECT 	RequestInfoID
			FROM 	RequestInfoGeneral
			WHERE 	DealerCode = '#g_DealerCode#';
		</CFQUERY>
			
		<CFLOOP query="getGeneral">
			<CFQUERY name="deleteRequestInfoQuote" datasource="#gDSN#">
			DELETE FROM RequestInfoQuote
			WHERE RequestInfoGeneralID = #getGeneral.RequestInfoID#
			</cfquery>
			
			<CFQUERY name="deleteRequestInfoFinancing" datasource="#gDSN#">
			DELETE FROM RequestInfoFinancing
			WHERE RequestInfoGeneralID = #getGeneral.RequestInfoID#
			</cfquery>
			
 			<CFQUERY name="deleteRequestInfoService" datasource="#gDSN#">
			DELETE FROM RequestInfoService
			WHERE RequestInfoGeneralID = #getGeneral.RequestInfoID#
			</cfquery>
			
			<CFQUERY name="deleteRequestInfoParts" datasource="#gDSN#">
			DELETE FROM RequestInfoParts
			WHERE RequestInfoGeneralID = #getGeneral.RequestInfoID#
			</cfquery>
		</CFLOOP>
			
		<CFQUERY name="deleteGeneral" datasource="#gDSN#">
			DELETE FROM RequestInfoGeneral
			WHERE DealerCode = '#g_DealerCode#';
		</CFQUERY>
			
		<!--- DealerURL --->
		<CFQUERY name="deleteDealerURL" datasource="#gDSN#">
			DELETE FROM DealerURL
			WHERE DealerCode = '#g_DealerCode#';
		</CFQUERY>
			
		<!--- HoursOfOperation --->
		<CFQUERY name="deleteHrsofOperation" datasource="#gDSN#">
			DELETE FROM HoursOfOperation
			WHERE DealerCode = '#g_DealerCode#';
		</CFQUERY>
			
		<!--- UsedVehicles, UsedVehiclesOptions --->
		<cfquery name="getUsedVehicles" datasource="#gDSN#">
		SELECT 	UsedVehicleID
		FROM	UsedVehicles
		WHERE	Dealercode = '#g_DealerCode#'
		</cfquery>
			
		<CFQUERY name="deleteUsedVehicles" datasource="#gDSN#">
			DELETE FROM UsedVehicles
			WHERE DealerCode = '#g_DealerCode#';
		</CFQUERY>

		<CFLOOP query="getUsedVehicles">
			<CFQUERY name="deleteUsedVehiclesOptions" datasource="#gDSN#">
			DELETE FROM UsedVehiclesOptions
			WHERE UsedVehicleID = #getUsedVehicles.UsedVehicleID#
			</cfquery>
		</cfloop>
						
		<!--- DealerFranchise --->
		<CFQUERY name="deleteDealerFranchise" datasource="#gDSN#">
			DELETE FROM DealerFranchise
			WHERE DF_Number = #Val(Mid(g_DealerCode, 11, 3))#
		</cfquery>
		
		<!--- Dealers --->
		<CFQUERY name="deleteDealer" datasource="#gDSN#">
		DELETE FROM Dealers
		WHERE DealerCode = '#g_DealerCode#';
		</CFQUERY>

	</CFTRANSACTION>