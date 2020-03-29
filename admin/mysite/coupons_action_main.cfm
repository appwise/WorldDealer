<cfset PageAccess = application.dealer_access>

                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 10, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: coupons_action_main.cfm,v 1.20 2000/06/23 17:58:45 jkrauss Exp $--->

<cfset deletemode = "false">
<cfset modifymode = "false">
<cfset newmode = "false">

<cfif parameterexists(form.delete.x)>
	<cfset deletemode = "true">
<cfelseif parameterexists(form.modify.x)>
	<cfset modifymode = "true">
<cfelse>
	<cfset newmode = "true">
</cfif>

<cfif deletemode>
	<cfquery name="GetCoupon" datasource="#gDSN#">
		SELECT
			VirtualCoupons.Description,
			VirtualCoupons.Title,
			VirtualCoupons.DealerWebID,
			VirtualCoupons.VirtualCouponID,
			DealerWebs.ArtTempID,
			DealerWebs.dealerCode
		FROM
			VirtualCoupons, DealerWebs
		WHERE
			VirtualCouponID = #Form.CouponID# AND VirtualCoupons.DealerWebID = DealerWebs.DealerWebID;
	</cfquery>
	
	<form name="deletecoupon" action="coupons_delete.cfm" METHOD="post">
	<table border="0" cellspacing="0" cellpadding="3" width="100%">
	<tr align="center">
		<td>
		You are about to permanently Delete the following Coupon.<br>
		Are you sure you wish to proceed?
		</td>
	</tr>
	<tr>
		<td>&nbsp;&nbsp;&nbsp;</td>
	</tr>
	<tr align="center">
		<td>
		<table border=0>
		<cfoutput query="getCoupon">
		<tr align="center">
			<td>
				<img src="#application.RELATIVE_PATH#/images/coupons/#Trim(g_dealercode)#_#artTempID#_#VirtualCouponID#_coupon.gif"><br>
				#title#<p>
				#description#
			</td>
		</tr>
		</cfoutput>
		</table>
		</td>
	</tr>	
	<tr>
		<td>&nbsp;&nbsp;&nbsp;</td>
	</tr>
	<input type="hidden" name="CouponID" value="<CFOUTPUT>#form.CouponID#</cfoutput>">
	<tr align="center">
		<td>
		<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/deletebutton.gif" BORDER="0" name="Delete" value="Delete Coupon"><p>
		<a href="coupons.cfm"><img src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/cancel.gif" border=0 alt="Cancel"></a>
		</td>
	</tr>
	</form>
	</table>

<cfelse>

	<cfquery name="getDlrArtTemp" datasource="#gDSN#">
		SELECT 	ArtTempID 
		FROM 	DealerWebs
		WHERE 	DealerCode = '#g_dealercode#'
	</cfquery>
	
	<cfquery name="getArtTempDefaults" datasource="#gDSN#">
		SELECT	*
		FROM	ArtTemplates
		WHERE	artTempID = #getDlrArtTemp.ArtTempID#
	</cfquery>

	<cfif modifymode>		
		<cfquery name="getCoupon" datasource="#gDSN#">
			SELECT	*
			FROM 	VirtualCoupons
			WHERE	VirtualCouponID = #Form.CouponID#;
		</cfquery>
	</cfif>
	
	<form name="make_coupon" action="coupons_redirect.cfm" method="post">
	<table width="100%" cellpadding=0 cellspacing=0 border=0>
	<tr align="center">
		<td>Enter the following information. Required fields are bolded.</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td align="center"><b>Select a Coupon Type</b></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td align="center">
		<table border=0>
		<cfquery name="getCouponTypes" datasource="#gDSN#">
			SELECT 	CouponTypeID, 
					CouponType
			FROM 	CouponTypes
			ORDER BY CouponTypeID
		</cfquery>
		
		<!--- Loop through all coupon types --->
		<cfset count = 0>
		<cfloop query="getCouponTypes">
		<cfset count = count + 1>
			<cfoutput>
			<tr>
				<td align="center" valign="middle">
					<input type="radio" name="coupontype" value="#CouponType#" <cfif modifymode><cfif #getcoupon.coupontypeid# eq #coupontypeid#>CHECKED</cfif><cfelseif newmode><cfif count eq 1>CHECKED</cfif></cfif>>
				</td>
				<td>
					<img src="#application.RELATIVE_PATH#/images/blank_coupons/f_#getDlrArtTemp.ArtTempID#_#CouponType#_coupon_blank.gif" alt="#CouponType#">
				</td>
			</tr>
			</cfoutput>
			<tr>
				<td colspan=2>&nbsp;</td>
			</tr>
		</cfloop>
	 	</table>
		</td>
	</tr>
	<tr>
		<td align="CENTER"><b>Coupon Title</b>&nbsp;&nbsp;
		<input type="text" name="couponTitle" value="<cfif modifymode><cfoutput query="getCoupon">#title#</cfoutput><cfelse>Coupon Title</cfif>" size=12 maxlength="40">
		<input type="hidden" name="couponTitle_required" value="Please enter the Coupon Title, as it should appear on the coupon.">
		</td>
	</tr>
	<tr>
		<td>&nbsp;<br>&nbsp;</td>
	</tr>
	<tr align="center">
		<td><b>Select from the list of style attributes below</b></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<cfoutput>
	<tr>
		<td align="CENTER">
			<table border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td align="RIGHT">Font Name</td>
				<td>&nbsp;&nbsp;</td>
				<td>
				<cfif modifymode>
					<cfset fontName = "#getCoupon.fontName#">
				<cfelse>
					<cfset fontName = "SansSerif">
				</cfif>
				<select name="fontName">
					<option value="SansSerif" <cfif #fontName# eq "SansSerif">SELECTED</cfif>>Helvetica
					<option value="Serif" <cfif #fontName# eq "Serif">SELECTED</cfif>>Times Roman
					<option value="Monospaced" <cfif #fontName# eq "Monospaced">SELECTED</cfif>>Courier
				</select>
				</td>
			</tr>
			<tr>
				<td colspan=3>&nbsp;</td>
			</tr>
			<tr>
				<td align="RIGHT">Font Size</td>
				<td>&nbsp;&nbsp;</td>
				<td>
					<cfif modifymode>
						<cfset fontSize = #getCoupon.fontSize#>
					<cfelse>
						<cfset fontSize = "24">
					</cfif>				
					<select name="fontSize">
					<cfloop index="num" from="16" to="28" step="2">
						<option value = #num# <cfif #fontSize# eq #num#>SELECTED</cfif>>#num#
					</cfloop>
					</select>
				</td>
			</tr>
			<tr>
				<td colspan=3>&nbsp;</td>
			</tr>
			<tr>
				<td align="RIGHT">Font Style</td>
				<td>&nbsp;&nbsp;</td>
				<td>
				<cfif modifymode>
					<cfset fontStyle = "#getCoupon.fontStyle#">
				<cfelse>
					<cfset fontStyle = "Plain">
				</cfif>
				<select name="fontStyle">
					<option value="Plain" <cfif #fontStyle# eq "Plain">SELECTED</cfif>>Plain
					<option value="Bold" <cfif #fontStyle# eq "Bold">SELECTED</cfif>>Bold
					<option value="Italic" <cfif #fontStyle# eq "Italic">SELECTED</cfif>>Italic
				</select>
				</td>
			</tr>
			<tr>
				<td colspan=3>&nbsp;</td>
			</tr>
			<tr>
				<td align="RIGHT">Color</td>
				<td>&nbsp;&nbsp;</td>
				<td>
					<cfif modifymode>
						<cfset textColor = #getCoupon.fontColor#>
					<cfelse>
						<cfset textColor = "Black">
					</cfif>
					<select name="textColor">
						<option value="Black"<cfif #textColor# eq "Black"> selected</cfif>>Black
						<option value="Cyan"<cfif #textColor# eq "Cyan"> selected</cfif>>Cyan
						<option value="DarkGray"<cfif #textColor# eq "DarkGray"> selected</cfif>>Dark Gray
						<option value="Gray"<cfif #textColor# eq "Gray"> selected</cfif>>Gray
						<option value="LightGray"<cfif #textColor# eq "LightGray"> selected</cfif>>Silver
						<option value="Magenta"<cfif #textColor# eq "Magenta"> selected</cfif>>Magenta
						<option value="Orange"<cfif #textColor# eq "Orange"> selected</cfif>>Orange
						<option value="Pink"<cfif #textColor# eq "Pink"> selected</cfif>>Pink
						<option value="Red"<cfif #textColor# eq "Red"> selected</cfif>>Red
						<option value="White"<cfif #textColor# eq "White"> selected</cfif>>White
						<option value="Yellow"<cfif #textColor# eq "Yellow"> selected</cfif>>Yellow
					</select>
				</td>
			</tr>
			<tr>
				<td colspan=3>&nbsp;</td>
			</tr>
				<tr>
					<td colspan=3>
					<table width="400" cellpadding="3" bgcolor="##FFF5D9"><tr><td>
						The Text Area is the area on the banner where your text will appear.  You may customize this area by 
						selecting the number of pixels from the left and top the text area begins, and how wide and tall you 
						want the area to be.
					</td></tr></table>
					</td>
				</tr>
			<tr>
				<td align="RIGHT">Pixels From Left:</td>
				<td width="5">&nbsp;</td>
				<td><input type="Text" name="textBoundsX" size="3" maxlength="3" value="<cfif parameterexists(getCoupon.textBoundsX)>#getCoupon.textBoundsX#<cfelse>#getArtTempDefaults.coup_textBoundsX#</cfif>"></td>
			</tr>
			<tr>
				<td align="RIGHT">Pixels From Top:</td>
				<td width="5">&nbsp;</td>
				<td><input type="Text" name="textBoundsY" size="3" maxlength="3" value="<cfif parameterexists(getCoupon.textBoundsY)>#getCoupon.textBoundsY#<cfelse>#getArtTempDefaults.coup_textBoundsY#</cfif>"></td>
			</tr>
			<tr>
				<td align="RIGHT">Text Area Width:</td>
				<td width="5">&nbsp;</td>
				<td><input type="Text" name="textBoundsWidth" size="3" maxlength="3" value="<cfif parameterexists(getCoupon.textBoundsWidth)>#getCoupon.textBoundsWidth#<cfelse>#getArtTempDefaults.coup_textBoundsWidth#</cfif>"></td>
			</tr>
			<tr>
				<td align="RIGHT">Text Area Height:</td>
				<td width="5">&nbsp;</td>
				<td><input type="Text" name="textBoundsHeight" size="3" maxlength="3" value="<cfif parameterexists(getCoupon.textBoundsHeight)>#getCoupon.textBoundsHeight#<cfelse>#getArtTempDefaults.coup_textBoundsHeight#</cfif>"></td>
			</tr>
			<tr>
				<td colspan=3>&nbsp;</td>
			</tr>
			<tr>
				<td align="RIGHT">Horizontal Alignment</td>
				<td>&nbsp;&nbsp;</td>
				<td>
					<cfif modifymode>
						<cfset textJustification = #getCoupon.xcord#>
					<cfelse>
						<cfset textJustification = "Centered">
					</cfif>				
					<select name="textJustification">
						<option value="Centered" <cfif #textJustification# eq "Centered">SELECTED</cfif>>Centered
						<option value="Left" <cfif #textJustification# eq "Left">SELECTED</cfif>>Left
						<option value="Right" <cfif #textJustification# eq "Right">SELECTED</cfif>>Right
					</select>
				</td>
			</tr>
			</table>
		</td>
	</tr>
	</cfoutput>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<input type="hidden" name="arttempid" value="<CFOUTPUT>#getDlrArtTemp.ArtTempID#</cfoutput>">
	<cfif modifymode>
		<input type="hidden" name="couponid" value="<CFOUTPUT>#form.CouponID#</cfoutput>">
		<input type="hidden" name="modeop" value="modify">
	<cfelse>
		<input type="hidden" name="modeop" value="new">
	</cfif>
	<tr align="center">
		<td>
		<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/continue.gif" width=66 height=15 BORDER="0" value="Continue" name="Continue"><p>
		<a href="coupons.cfm"><img src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/cancel.gif" width=47 height=15 border=0 alt=""></a>
		</td>
	</tr>
	</table>
	</form>

</cfif>