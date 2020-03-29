<cfset PageAccess = application.dealer_access>

                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 10, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: coupons_confirm_main.cfm,v 1.18 2000/06/15 22:13:45 jkrauss Exp $--->

<cfquery name="getDlrArtTemp" datasource="#gDSN#">
	SELECT	ArtTempID 
	FROM	DealerWebs
	WHERE	dealerCode = '#g_dealercode#';
</cfquery>

<cfif isdefined("URL.ModifyFlag")>
	<cfquery name="getCoupon" datasource="#gDSN#">
		SELECT 	Description,
				ExpirationDate
		FROM 	VirtualCoupons
		WHERE 	VirtualCouponID = #URL.CouponID#
	</cfquery>
</cfif>

<!--- change ImageGen's ~ to <br> tags for the database --->
<cfset #final_title# = #replace(#url.couponTitle#, "~", "<BR>", "ALL")#>

<form action="coupons_save.cfm" method="POST">
<table width="100%" cellpadding=0 cellspacing=0 border=0>
<tr align="center">
	<td>
		This is a preview of what your coupon will look like.
	</td>
</tr>
<tr>
	<td>&nbsp;&nbsp;&nbsp;</td>
</tr>
<tr align="center">
	<td>
		<cfoutput query="getDlrArtTemp">
			<img src="#application.RELATIVE_PATH#/images/coupons/temp_#ArtTempID#_#url.tmpid#_coupon.gif">
			<br>
			#Replace(URL.couponTitle, "~", "<BR>", "ALL")#
		</cfoutput>
	</td>
</tr>
<tr>
	<td>&nbsp;&nbsp;&nbsp;</td>
</tr>
<tr align="center">
	<td>
		<b>Description</b>
	</td>
</tr>
<tr align="center">
	<td width=80%>
		<cfif parameterexists(url.modifyflag)>
			<!--- Remove <BR> tags and re-format --->
			<cfset mod_coupon_text = #replace(getCoupon.description, "<BR>", chr(13), "ALL")#>
			<textarea name="description" cols="30" rows="10" wrap="PHYSICAL"><cfoutput>#mod_coupon_text#</cfoutput></textarea>
		<cfelse>
			<textarea name="description" cols="30" rows="10" wrap="PHYSICAL">Coupon Description</textarea>
		</cfif>
	</td>
</tr>
<tr>
	<td>&nbsp;&nbsp;&nbsp;</td>
</tr>
<tr align="center">
	<td>
		<b>Expiration Date</b>
	</td>
</tr>
<tr align="center">
	<td width=80%>
		<cfif parameterexists(url.modifyflag)>
			<cfoutput query="getCoupon">
				<input type="text" name="expirationdate" value="#DateFormat(ExpirationDate,'mm/dd/yyyy')#" size="10" maxlength="10">
			</cfoutput>
		<cfelse>
			<input type="text" name="expirationdate" value="<CFOUTPUT>#DateFormat(DateAdd("m", 1, Now()), 'mm/dd/yyyy')#</cfoutput>" size="10" maxlength="10">
		</cfif>
	</td>
</tr>
<tr>
	<td>&nbsp;&nbsp;&nbsp;</td>
</tr>
<cfoutput>
	<input type="hidden" name="couponTitle" value="#final_title#">
	<input type="hidden" name="tmpid" value="#URL.tmpid#">
	<input type="hidden" name="NextStep" value="webvrfy_s11.cfm">
	<input type="hidden" name="coupontype" value="#URL.coupontype#">
	<input type="hidden" name="fontName" value="#URL.fontName#"> 
	<input type="hidden" name="textJustification" value="#URL.textJustification#"> 
	<input type="hidden" name="fontSize" value="#URL.fontSize#"> 
	<input type="hidden" name="fontStyle" value="#URL.fontStyle#"> 
	<input type="hidden" name="textColor" value="#URL.textColor#">
 	<input type="hidden" name="textBoundsX" value="#URL.textboundsx#">
 	<input type="hidden" name="textBoundsY" value="#URL.textboundsy#">
 	<input type="hidden" name="textBoundsWidth" value="#URL.textboundswidth#">
 	<input type="hidden" name="textBoundsHeight" value="#URL.textboundsheight#">
	<cfif parameterexists(url.modifyflag)>
		<input type="hidden" name="CouponID" value="#URL.CouponID#">
		<input type="hidden" name="modeop" value="modify">
	<cfelse>
		<input type="hidden" name="modeop" value="new">
	</cfif>
</cfoutput>
<tr align="center">
	<td>
	<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/save.gif" BORDER="0" NAME="Save" VALUE="Save"><br>&nbsp;
	</td>
</tr>
</form>
<tr align="center">
	<td>
	<a href="coupons.cfm"><img src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/cancel.gif" border=0 alt=""></a>
	</td>
</tr>
</table>
</form>

	
