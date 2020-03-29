  <!--- Created by AppNet, Inc., Detroit 
                       www.appnet.com
             Copyright (c) 1999, 2000 AppNet, Inc. 
   All other trademarks and servicemarks are the property of   
their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
            Appnet, Inc. logos are registered trademarks.  
                  Created: <January 10, 2000>
           webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: banners_add_save.cfm,v 1.2 2000/06/16 20:30:19 jkrauss Exp $--->

<cfset PageAccess = application.dealer_access>
<cfinclude template = "../security.cfm">

		
		<cfquery name="GetArttempID" datasource="#gDSN#">
			SELECT		ArtTempID,
						DealerWebID
			FROM		DealerWebs 
			WHERE		DealerCode = '#g_dealercode#';
		</cfquery>
		
		<cfquery name="addSpecPromo" datasource="#gDSN#">
			INSERT INTO SpecialPromotions (
						ArtTempID,
						Description,
						ExpirationDate)
			VALUES 		(#GetArtTempID.ArtTempID#,
						'#Form.SpecPromoDescription#',
						#CreateODBCDate(Form.ExpirationDate)#);
		</cfquery>
	
		<cfquery name="GetSpecPromoID" datasource="#gDSN#">
			SELECT	MAX(SpecPromoID) AS New_Record
			FROM	SpecialPromotions;
		</cfquery>
		
		<cfset #variables.specpromoid# = #getspecpromoid.new_record#>
			<cfquery name="addBanner" datasource="#gDSN#">
			INSERT INTO Banners (
				Description,
				URLLink,
				FileLocation,
				SpecPromoID,
				Status,
				LinkYesNo,
				BannerType,
				FontName,
				XCord,
				FontSize,
				FontStyle,
				FontColor,
				textBoundsX,
				textBoundsY,
				textBoundsWidth,
				textBoundsHeight
				)
			VALUES (
				'#Form.title#',
				'SomeURL',
				'http://#g_host#/templates/#getarttempid.arttempid#/of_#getarttempid.arttempid#_index.cfm',
				#GetSpecPromoID.New_Record#,
				'1',
				'#FORM.LinkYesNo#',
				#Form.BannerType#,
				'#Form.FontName#',
				'#Form.textJustification#',
				#Form.FontSize#,
				'#Form.FontStyle#',
				'#Form.textColor#',
				#form.textBoundsX#,
				#form.textBoundsY#,
				#form.textBoundsWidth#,
				#form.textBoundsHeight#
				);
		</cfquery>
	
		<cfquery name="getBannerID" datasource="#gDSN#">
			SELECT		MAX(BannerID) as New_record
			FROM		Banners;
		</cfquery>
		
		<cfquery name="addDealerBanners" datasource="#gDSN#">
			INSERT INTO DealerBanners (
 				DealerWebID,
				BannerID
				)
			VALUES (
				#getarttempid.DealerWebID#,
				#getBannerID.new_record#
				);
		</cfquery>
	
		<cfquery name="addDealerSpclPromo" datasource="#gDSN#">
			INSERT INTO DealerSpecialPromotions (
				DealerWebID,
				SpecPromoID
				)
			VALUES (
				#getarttempid.DealerWebID#,
				#getSpecPromoID.New_Record#
				);
		</cfquery>
		
		
		<!--- RENAME TEMP BANNER WITH CORRECT NAME SCHEME --->
		<cffile action="COPY"
		source="#g_rootdir#\images\banner\temp_#form.tmpid#_adbanner_hea.gif"
		destination="#g_rootdir#\images\banner\#g_dealercode#_#variables.specpromoid#_adbanner_hea.gif">

