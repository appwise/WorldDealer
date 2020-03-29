<!----------------DO NOT USE THIS FILE, THIS IS A WORK IN PROGRESS!!!!!!!!!!!!
we tried to add the functionality that would allow collections to add coupons for the dealers.
The database is populated with the correct information but the problem lies with image gen.  
The collection that is creating the coupon may have the dashboard template selected and the 
dealer may have blue collage selected.  The problem is that the dealer with blue collage will
now have a coupon with the design for dashboard.  This won't work because alot of the dealers
in a collection have different templates.  not too mention the size,color, and other aspects 
of the text.  Someone may choose to take this up at a later time.  6/05/00 bbickel --->
































<!--- Created by AppNet, Inc., Detroit 
                       www.appnet.com
             Copyright (c) 1999, 2000 AppNet, Inc. 
   All other trademarks and servicemarks are the property of   
their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
            Appnet, Inc. logos are registered trademarks.  
                  Created: <January 10, 2000>
           webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: coupons_add_save_inprogress.cfm,v 1.2 2000/06/21 15:17:05 lswanson Exp $--->

<cfquery name="getDealerinfo" datasource="#gDSN#">
	SELECT
		DealerWebID,
		ArttempID
	FROM
		DealerWebs
	WHERE
		dealerCode='#g_dealercode#';
</cfquery>

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
			YCord,
			FontSize,
			FontStyle,
			FontColor
			)
		VALUES (
			'#final_text#',
			'#Form.couponTitle#',
			#getdealerinfo.DealerWebID#,
			'A',
			#getCouponID.coupontypeID#,
			#CreateODBCDate(Form.ExpirationDate)#,
			'#Form.FontName#',
			'#Form.XCord#',
			'#Form.YCord#',
			#Form.FontSize#,
			'#Form.FontStyle#',
			'#Form.FontColor#'
			)
		</cfquery>
				
		<cfquery name="GetNewCoupon" datasource="#gDSN#">
		SELECT
			MAX(VirtualCouponID) as New_Record
		FROM
			VirtualCoupons;
		</cfquery>
		<cfset q_couponid = #getnewcoupon.new_record#>
<!--- RENAME TEMP COUPON WITH CORRECT NAME SCHEME --->
<cffile action="rename"
		source="#g_rootdir#\images\coupons\temp_#getdealerart.ArtTempID#_#form.tmpid#_coupon.gif"
		destination="#g_rootdir#\images\coupons\#g_dealercode#_#getdealerinfo.ArtTempID#_#q_CouponID#_coupon.gif">
