<cfset PageAccess = application.dealer_access>

                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 10, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: banners_action_main.cfm,v 1.21 2000/07/05 17:11:49 jkrauss Exp $--->

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
	<cfquery name="GetBanner" datasource="#gDSN#">
		SELECT
			SpecialPromotions.ExpirationDate,
			SpecialPromotions.Description as q_SpecPromoDescription
		FROM
			SpecialPromotions
		WHERE
			SpecPromoID = #form.SpecPromoID#;
	</cfquery>
	
	<form name="delete" action="banners_delete.cfm" METHOD="post">
	<table cellpadding=0 width="100%" cellspacing=0 border=0>
	<tr align="center">
		<td>
			You are about to permanently Delete the following Banner.
			<br>Are you sure you wish to proceed?
			<br><br>
		</td>
	</tr>
	<tr align="center">
		<td>
		<table border=0>
		<cfoutput query="GetBanner">
			<tr align="center">
				<td>
					<img src="#application.RELATIVE_PATH#/images/banner/#Trim(g_dealercode)#_#specPromoID#_adbanner_hea.gif">
					<br>
					#q_SpecPromoDescription#
				</td>
			</tr>
			<tr align="center">
				<td>
					Expires: #DateFormat(ExpirationDate, "mmmm d, yyyy")#
				</td>
			</tr>
		</cfoutput>
		</table>
		</td>
	</tr>	
	<tr>
		<td>&nbsp;&nbsp;&nbsp;</td>
	</tr>
	<input type="hidden" name="SpecPromoID" value="<CFOUTPUT>#form.SpecPromoID#</cfoutput>">
	<tr align="center">
		<td>
		<a href="banners.cfm"><img src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/cancel.gif" BORDER="0" alt="Cancel"></a>
		&nbsp;&nbsp;
		<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/deletebutton.gif" BORDER="0" name="Delete" value="Delete">
		</td>
	</tr>
	</table>
	</form>

<cfelse>

	<cfset maxnumofbanners = 36>
	
	<cfif modifymode>
		<cfquery name="getBanner" datasource="#gDSN#">
	 		SELECT
			SpecialPromotions.ExpirationDate,
			SpecialPromotions.Description as q_SpecPromoDescription,
			Banners.Description AS q_BannerDescription,
			Banners.SpecPromoID as q_SpecPromoID,
			Banners.LinkYesNo,
			Banners.BannerID,
			Banners.BannerType,
			Banners.FontName,
			Banners.xcord,
			Banners.FontSize,
			Banners.FontStyle,
			Banners.FontColor,
			Banners.textBoundsX,
			Banners.textBoundsY,
			Banners.textBoundsWidth,
			Banners.textBoundsHeight
		FROM
			Banners,
			DealerBanners,
			SpecialPromotions
		WHERE
			DealerWebID = (SELECT DealerWebID FROM DealerWebs WHERE DealerCODE = '#g_dealercode#') 
			AND status = '1'
			AND DealerBanners.bannerid=Banners.bannerid
			AND SpecialPromotions.SpecPromoID=Banners.specpromoid
			AND Banners.SpecPromoID = #form.SpecPromoID#;
		</cfquery>
		
		<cfquery name="GetBannerID" datasource="#gDSN#">
			SELECT BannerID
			FROM Banners
			WHERE SpecPromoID = #form.SpecPromoID#;
		</cfquery>
	</cfif>
	
<form name="modify_banner" action="banners_redirect.cfm" METHOD="post">
<table border="0" cellpadding="3" width="100%">
<tr>
	<td>Enter the following information. Required fields are bolded.</td>
</tr>
<tr>
	<td>&nbsp;&nbsp;&nbsp;</td>
</tr>
<tr>
	<td align="center">
			<b>Select a Banner Template</b>
	</td>
</tr>
<tr align="center">
	<td>
	<table border="0" cellspacing="2" cellpadding="0">
		<!--- Linda, 2-9-99: consolidated 140 lines of hard code --->
		<!--- DSF: added maxNumOfBanners var at top 021899 --->
		<cfloop index="num" from="1" to="#maxNumOfBanners#">
			<tr align="center">
				<cfoutput>
				<td valign="middle">
					<input type="radio" name="bannertype" value="#num#" 
						<cfif modifymode>
							<cfif #num# eq #getbanner.bannertype#>
								CHECKED
							</cfif>
						<cfelseif #num# eq 1>
							CHECKED
						</cfif>>
				</td>
				<td>
					<img src="#application.RELATIVE_PATH#/images/blank_banners/f_blank#num#_adbanner_hea.gif" width="400" height="48">
				</td>
				</cfoutput>
			</tr>
			<tr>
				<td colspan=2>&nbsp;</td>
			</tr>
		</cfloop>
	</table>
	</td>
</tr>
<cfoutput>
<tr>
	<td align="CENTER">
	<table border="0" cellspacing="0" cellpadding="2">
	<tr>
		<td align="right"><b>Banner Title</b>&nbsp;&nbsp;</td>
		<td>
			<input type="text" name="title"
				value=<cfif modifymode>"#getBanner.q_BannerDescription#"<cfelse>"Enter Banner Title"</cfif> 
				size="20" maxlength="150">
		</td>
	</tr>
	<tr>
		<td align="right"><b>Expiration Date</b>&nbsp;&nbsp;</td>
		<td>
			<input type="text" name="expirationdate"
				value=<cfif modifymode>"#DateFormat(getBanner.ExpirationDate,'mm/dd/yyyy')#"<cfelse>"#DateFormat(DateAdd("m", 1, Now()), 'mm/dd/yyyy')#"</cfif> 
				size="10" maxlength="10">
		</td>
	</tr>
	</table>
	</td>
</tr>
</cfoutput>
<tr>
	<td>&nbsp;&nbsp;</td>
</tr>
<cfif modifymode>
	<input type="hidden" name="bannerid" value="<CFOUTPUT>#getbannerID.BannerID#</cfoutput>">
	<input type="hidden" name="specpromoid" value="<CFOUTPUT>#getbanner.q_SpecPromoID#</cfoutput>">
</cfif>
<tr align="center">
	<td><b>Select from the list of style attributes below</b></td>
</tr>
<tr align="CENTER">
	<td>
	<table border=0>
	<cfoutput>
		<tr>
			<td align="CENTER">
				<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="RIGHT">Font Name</td>
					<td>&nbsp;&nbsp;</td>
					<td>
					<cfif modifymode>
						<cfset fontname = "#getBanner.FontName#">
					<cfelse>
						<cfset fontname = "Arial">
					</cfif>
					<select name="FontName">
						<option value="Sansserif" <cfif #fontname# eq "Sansserif">SELECTED</cfif>>Arial Helvetica
						<option value="Serif" <cfif #fontname# eq "Serif">SELECTED</cfif>>Times Roman
						<option value="Monospaced" <cfif #fontname# eq "Monospaced">SELECTED</cfif>>Courier
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
							<cfset fontsize = #getBanner.fontsize#>
						<cfelse>
							<cfset fontsize = "24">
						</cfif>				
						<select name="fontsize">
						<cfloop index="num" from="16" to="28" step="2">
							<option value = #num# <cfif #fontsize# eq #num#>SELECTED</cfif>>#num#
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
						<cfset fontstyle = "#getBanner.FontStyle#">
					<cfelse>
						<cfset fontstyle = "Plain">
					</cfif>
					<select name="fontstyle">
						<option value="Plain" <cfif #fontstyle# eq "Plain">SELECTED</cfif>>Plain
						<option value="Bold" <cfif #fontstyle# eq "Bold">SELECTED</cfif>>Bold
						<option value="Italic" <cfif #fontstyle# eq "Italic">SELECTED</cfif>>Italic
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
							<cfset textColor = #getBanner.fontcolor#>
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
					<table width="400" cellpadding="3" bgcolor="##FFF5D9"><tr><td><!--- FFF5D9 --->
						The Text Area is the area on the banner where your text will appear.  You may customize this area by 
						selecting the number of pixels from the left and top the text area begins, and how wide and tall you 
						want the area to be.
					</td></tr></table>
					</td>
				</tr>
				<tr>
					<td align="RIGHT">Pixels From Left:</td>
					<td width="5">&nbsp;</td>
					<td><input type="Text" name="textBoundsX" size="3" maxlength="3" value="<cfif parameterexists(getBanner.textBoundsX)><cfif getBanner.textBoundsX is not "">#getBanner.textBoundsX#<cfelse>0</cfif><cfelse>0</cfif>"></td>
				</tr>
				<tr>
					<td align="RIGHT">Pixels From Top:</td>
					<td width="5">&nbsp;</td>
					<td><input type="Text" name="textBoundsY" size="3" maxlength="3" value="<cfif parameterexists(getBanner.textBoundsY)><cfif getBanner.textBoundsY is not "">#getBanner.textBoundsY#<cfelse>7</cfif><cfelse>7</cfif>"></td>
				</tr>
				<tr>
					<td align="RIGHT">Text Area Width:</td>
					<td width="5">&nbsp;</td>
					<td><input type="Text" name="textBoundsWidth" size="3" maxlength="3" value="<cfif parameterexists(getBanner.textBoundsWidth)><cfif getBanner.textBoundsWidth is not "">#getBanner.textBoundsWidth#<cfelse>400</cfif><cfelse>400</cfif>"></td>
				</tr>
				<tr>
					<td align="RIGHT">Text Area Height:</td>
					<td width="5">&nbsp;</td>
					<td><input type="Text" name="textBoundsHeight" size="3" maxlength="3" value="<cfif parameterexists(getBanner.textBoundsHeight)><cfif getBanner.textBoundsHeight is not "">#getBanner.textBoundsHeight#<cfelse>41</cfif><cfelse>41</cfif>"></td>
				</tr>
				<tr>
					<td colspan="3" align="CENTER"><b><font color="Red">Note:</font> All banners are 400w x 48h pixels.</b></td>
				</tr>				
				<tr>
					<td colspan=3>&nbsp;</td>
				</tr>
				<tr>
					<td align="RIGHT">Horizontal Alignment</td>
					<td>&nbsp;&nbsp;</td>
					<td>
						<cfif modifymode>
							<cfset textJustification = #getBanner.xcord#>
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
	</table>
	</td>
</tr>
<tr align="center">
	<td>
	<cfif modifymode>
		<input type="hidden" name="modifyflag" value="1">
	</cfif>
	<cfif newmode>
		<input type="hidden" name="newflag" value="1">
	</cfif>
	<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/continue.gif" BORDER="0" NAME="Continue" VALUE="Continue"><p>
	<a href="banners.cfm"><img src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/cancel.gif" BORDER="0" alt="Cancel"></a>
	</td>
</tr>
</table>
</form>
</cfif>