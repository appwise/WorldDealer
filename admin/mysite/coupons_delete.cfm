                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 10, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: coupons_delete.cfm,v 1.8 2000/03/13 22:26:56 jkrauss Exp $--->

<cfset PageAccess = application.dealer_access>
<cfinclude template = "../security.cfm">

<cfquery name="getTemplate" datasource="#gDSN#">
	SELECT ArtTempID
	FROM DealerWebs
	WHERE DealerCode = '#g_dealercode#'
</cfquery>

<cfquery name="KillCoupon" datasource="#gDSN#">
	UPDATE VirtualCoupons
	SET Status = 'I'
	WHERE VirtualCouponID = #form.CouponID#;
</cfquery>

<cffile action="DELETE" file="#g_rootdir#\images\coupons\#g_dealercode#_#getTemplate.ArtTempID#_#form.CouponID#_coupon.gif">

<cflocation url="coupons.cfm" addtoken="no">