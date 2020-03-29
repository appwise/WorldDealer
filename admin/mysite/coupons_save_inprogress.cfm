





<!----------------DO NOT USE THIS FILE, THIS IS A WORK IN PROGRESS!!!!!!!!!!!!
we tried to add the functionality that would allow collections to add coupons for the dealers.
The database is population with the correct information but the problem lies with image gen.  The collection that is creating
the coupon may have the dashboard template selected and the dealer may have blue collage selected.  The problem is that the dealer with blue collage will
now have a coupon with the design for dashboard.  This won't work because alot of the dealers in a collection have different templates.  not too mention the size,color,
and other aspects of the text.  Someone may choose to take this up at a later time.  6/05/00 bbickel --->




























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
<!---$Id: coupons_save_inprogress.cfm,v 1.1 2000/06/15 21:56:18 bbickel Exp $--->

<!--- Replace CR's with <BR>'s --->
<cfset #final_text# = #replace(#form.description#, chr(13), "<BR>", "ALL")#>

<cfquery name="getDealerart" datasource="#gDSN#">
	SELECT
		ArttempID
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
			FontName = '#Form.FontName#',
			XCord = '#Form.XCord#',
			YCord = '#Form.YCord#',
			FontSize = #Form.FontSize#,
			FontStyle = '#Form.FontStyle#',
			FontColor = '#Form.FontColor#'
		WHERE
			VirtualCouponID = #form.CouponID#;
	</cfquery>
	
	<cfset q_couponid = #form.couponid#>
	<!--- RENAME TEMP COUPON WITH CORRECT NAME SCHEME --->
	<cffile action="rename"
		source="#g_rootdir#\images\coupons\temp_#getdealerart.ArtTempID#_#form.tmpid#_coupon.gif"
		destination="#g_rootdir#\images\coupons\#g_dealercode#_#getdealerart.ArtTempID#_#q_CouponID#_coupon.gif">

<cfelse>
	<cfif g_col>
		<cfloop index="colldealersindex" list="#form.colldealers#" delimiters="," >
			<CFSET g_dealercode = "#colldealersindex#"> 
			<CFINCLUDE template= "coupons_add_save.cfm">
		</cfloop>	
	<CFELSE>
		<CFINCLUDE template= "coupons_add_save.cfm">
	</cfif>
		
</cfif>

<cfif #form.modeop# is "modify">
	<cflocation url="coupons.cfm?mod=yes" addtoken="no">
<cfelse>
	<cflocation url="coupons.cfm" addtoken="no">
</cfif>