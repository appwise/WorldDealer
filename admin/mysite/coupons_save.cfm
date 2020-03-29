<cfset PageAccess = application.dealer_access>
<cfinclude template = "../security.cfm">

                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 10, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: coupons_save.cfm,v 1.12 2000/06/15 22:13:45 jkrauss Exp $--->

<!--- Replace CR's with <BR>'s --->
<cfset #final_text# = #replace(#form.description#, chr(13), "<BR>", "ALL")#>

<cfquery name="getDealerWebID" datasource="#gDSN#">
	SELECT
		DealerWebID
	FROM
		DealerWebs
	WHERE
		dealerCode='#g_dealercode#';
</cfquery>

<cfquery name="getCouponID" datasource="#gDSN#">
	SELECT 	CouponTypeID
	FROM 	CouponTypes
	WHERE 	CouponType='#coupontype#'
</cfquery>

<cfif #form.modeop# is "modify">

	<cfquery name="updCoupon" datasource="#gDSN#">
		UPDATE
			VirtualCoupons
		SET
			Description = '#final_text#',
			Title = '#Form.couponTitle#',
			CouponTypeID = #getCouponID.coupontypeID#,
			ExpirationDate = #CreateODBCDate(Form.ExpirationDate)#,
			FontName = '#Form.fontName#',
			XCord = '#Form.textJustification#',
			FontSize = #Form.fontSize#,
			FontStyle = '#Form.fontStyle#',
			FontColor = '#Form.textColor#',
			textBoundsX = #Form.textboundsx#,
			textBoundsY = #Form.textboundsy#,
			textBoundsWidth = #Form.textboundswidth#,
			textBoundsHeight = #Form.textboundsheight#
		WHERE
			VirtualCouponID = #form.CouponID#;
	</cfquery>
	
	<cfset q_couponid = #form.couponid#>
	
<cfelse>

		<cfquery name="addCoupon" datasource="#gDSN#">
		INSERT INTO VirtualCoupons (
			Description,
			Title,
			DealerWebID,
			Status,
			CouponTypeID,
			ExpirationDate,
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
			'#final_text#',
			'#Form.couponTitle#',
			#getDealerWebID.DealerWebID#,
			'A',
			#getCouponID.coupontypeID#,
			#CreateODBCDate(Form.ExpirationDate)#,
			'#Form.fontName#',
			'#Form.textJustification#',
			#Form.fontSize#,
			'#Form.fontStyle#',
			'#Form.textColor#',
			#Form.textboundsx#,
			#Form.textboundsy#,
			#Form.textboundswidth#,
			#Form.textboundsheight#
			)
		</cfquery>
				
		<cfquery name="GetNewCoupon" datasource="#gDSN#">
		SELECT
			MAX(VirtualCouponID) as New_Record
		FROM
			VirtualCoupons;
		</cfquery>
		<cfset q_couponid = #getnewcoupon.new_record#>
</cfif>


<!--- RENAME TEMP COUPON WITH CORRECT NAME SCHEME --->
<cfquery name="getTemplate" datasource="#gDSN#">
	SELECT ArtTempID
	FROM DealerWebs
	WHERE DealerCode = '#g_dealercode#'
</cfquery>

<cffile action="rename"
		source="#g_rootdir#\images\coupons\temp_#getTemplate.ArtTempID#_#form.tmpid#_coupon.gif"
		destination="#g_rootdir#\images\coupons\#g_dealercode#_#getTemplate.ArtTempID#_#q_CouponID#_coupon.gif">


<cfif #form.modeop# is "modify">
	<cflocation url="coupons.cfm?mod=yes" addtoken="no">
<cfelse>
	<cflocation url="coupons.cfm" addtoken="no">
</cfif>