<cfset PageAccess = application.dealer_access>

                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 10, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: banners_main.cfm,v 1.13 2000/03/21 16:11:01 jkrauss Exp $--->

<cfquery name="getBanners" datasource="#gDSN#">
	SELECT
		Banners.FileLocation,
		SpecialPromotions.ExpirationDate,
		Banners.BannerID as q_BannerID,
		Banners.LinkYesNo,
		SpecialPromotions.SpecPromoID
	FROM
		Banners,
		DealerBanners,
		SpecialPromotions
	WHERE
		DealerWebID = (SELECT DealerWebID FROM DealerWebs WHERE DealerCode = '#g_dealercode#') 
		AND	status = '1'
		AND	DealerBanners.bannerid=Banners.bannerid
		AND	SpecialPromotions.SpecPromoID=Banners.specpromoid;
</cfquery>

<cfset justmodified = "false">
<cfif ParameterExists(url.mod)>
	<cfset justmodified = "true">
</cfif>

<form name="banners" action="banners_action.cfm" method="post">
<table>
<cfif #getbanners.recordcount# gt 0>
	<tr>
		<td>
		Use this page to create, maintain, or delete your Website's banners.  These banners will appear at the top of each 
		interior page on your Website.  They will be rotated on a random basis.  Setting banner expiration dates enables 
		you to choose when a banner  leaves rotation or becomes "inactive." You also have the option of creating a 
		click-through page for your banner that enables you to enter additional information about that banner's promotion.<br><br>

		To select a banner, click the radio button next to the banner of your choice then use the Add, Modify, or Delete 
		buttons at the bottom of this page to create, edit or delete a Special Promotion Banner.
		</td>
	</tr>
	<tr>
		<td align="CENTER">
		<table border=0>
		<cfoutput query="getBanners">
		<tr>
			<td align="center" valign="middle">
				<input type="radio" name="SpecPromoID" value="#specpromoid#"<cfif #getbanners.currentrow# eq 1>CHECKED</cfif>>
			</td>
			<td align="center">
				Expires on: #DateFormat(ExpirationDate,"mmmm d, yyyy")#<br>
				<img src="#application.RELATIVE_PATH#/images/banner/#g_dealercode#_#specpromoid#_adbanner_hea.gif">
			</td>
		</tr>
		</cfoutput>
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<cfif justmodified>
	<tr>
		<td align="CENTER">
			<table border="0" cellspacing="0" cellpadding="0"><tr><td>
			<font color="Red"><b>NOTE:</b></font><br>
			You may have to refresh your browser window<br>
			to see the changes you've just made.
			</td></tr></table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	</cfif>
	<tr align="center">
		<td>
		<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/modify.gif" BORDER="0" name="Modify" value="Modify">
		&nbsp;&nbsp;&nbsp;
		<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/deletebutton.gif" BORDER="0" name="Delete" value="Delete">
		</td>
	</tr>
	<tr align="center">
		<td>
		<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/add.gif" BORDER="0" name="Add" value="Add">
		</td>
	</tr>
<cfelse>
	<tr>
		<td>
			This page will allow you to create, maintain, or delete your Website banners. Banners appear at the top of each inside page of
			your Website, and are rotated on a random basis. Expiration dates allow you to decide when a banner becomes "inactive," as
			well as allow you to "re-activate" a banner. You have the option of including a click-through page for your banner, which allows
			you to enter additional information about special promotions.
			<br><br>
			There are currently NO Special Promotion Banners Associated with this Dealership.  Click the 'Add' button to add a banner.
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr align="center">
		<td>
		<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/add.gif" BORDER="0" name="Add" value="Add">
		</td>
	</tr>
</cfif>
</table>
</form>