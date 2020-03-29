<cfset PageAccess = application.dealer_access>

                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 10, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: banners_confirm_main.cfm,v 1.16 2000/07/05 17:11:49 jkrauss Exp $--->
<!--- This query gets the name of the collection you are on and the dealers under it --->
<!--- get all dealerships within collection --->

<cfquery name="getCollDealers" datasource="#gDSN#">
	SELECT	dealers.Dealercode, 
			Dealers.DealershipName
	FROM	Dealers 
			INNER JOIN CollectionDealers ON Dealers.DealerCode = CollectionDealers.DealerCode
	WHERE	CollectionDealers.Coll_DealerCode = '#g_dealercode#'
	ORDER BY	DealershipName
</cfquery> 

<cfif isdefined("URL.ModifyFlag")>
	<cfset editmode = true>
	<cfquery name="getBanner" datasource="#gDSN#">
		SELECT	Banners.LinkYesNo, 
				SpecialPromotions.Description
		FROM 	Banners INNER JOIN SpecialPromotions ON Banners.SpecPromoID = SpecialPromotions.SpecPromoID
		WHERE 	Banners.BannerID = #URL.BannerID#
	</cfquery>
<cfelse>
	<cfset editmode = false>
</cfif>

<form action="banners_save.cfm" method="POST">

<cfoutput>
<table width="100%" border="0" cellspacing="0" cellpadding="3">
<!--- Collections can add banners for several dealerships at once.  (But cannot modify them at once.  Edit at Dealer level.) --->
<cfif g_col and not editmode>
<tr>
	<!--- start loop for getting dealers inside the collection--->
	<td align="center">
		Changes made to this banner will apply only to the Dealer you select.
		<br>
		<br>
		<table border="0" align="center">
		<tr>
			<td align="left">
			<input type="checkbox" name="colldealers" value="#g_dealercode#" checked>#getDlrName.Name#<br>
			<input type="hidden" name="colldealers_required" value="Please select at least one dealership.">
			<cfloop query = "getCollDealers">
				<input type="checkbox" name="colldealers" value="#Dealercode#">#dealershipname#<br>
			</cfloop>
			</td>
		</tr>
		</table>
	</td>
	<!--- end loop--->
</tr>
</cfif>
<tr align="center">
	<td>
		This is a preview of what your banner will look like.
	</td>
</tr>
<tr>
	<td>&nbsp;&nbsp;&nbsp;</td>
</tr>
<tr align="center">
	<td>
	<!--- Fix this later --->
		<img src="#application.RELATIVE_PATH#/images/banner/temp_#URL.tmpid#_adbanner_hea.gif">
		<br>
		#Replace(url.title,"~"," ","ALL")#
	</td>
</tr>
<tr>
	<td>&nbsp;</td>
</tr>
<tr>
	<td align="CENTER">Would you like this banner to be linked to a Special Promotion page<br>containing the text entered below?</td>
</tr>
<tr>
	<td align=center>
		<cfif editmode>
			<cfset linkyn = #getbanner.linkyesno#>
		<cfelse>
			<cfset linkyn = "N">
		</cfif>
		
		Yes <input type="radio" name="LinkYesNo" value="Y" <cfif #linkyn# eq "Y">CHECKED</cfif>>
		&nbsp;&nbsp;
		No <input type="radio" name="LinkYesNo" value="N" <cfif #linkyn# eq "N">CHECKED</cfif>>
		
	</td>
</tr>
<tr>
	<td>&nbsp;</td>
</tr>
<tr>
	<td align="CENTER">
		<b>In the space below, enter the text of your Special Promotion</b>
	</td>
</tr>
<tr>
	<td align="center">
		<textarea name="specpromodescription" cols="35" rows="10" wrap="PHYSICAL"><cfif editmode>#GetBanner.Description#<cfelse>Enter your Special Promotion</cfif></textarea>
	</td>
</tr>
<tr>
	<td>&nbsp;</td>
</tr>

<input type="hidden" name="title" value="#Replace(URL.title,'~',' ','ALL')#">
<input type="hidden" name="tmpid" value="#URL.tmpid#">
<input type="hidden" name="ExpirationDate" value="#URL.ExpirationDate#">
<input type="hidden" name="BannerType" value="#URL.BannerType#"> 
<input type="hidden" name="FontName" value="#URL.FontName#"> 
<input type="hidden" name="textJustification" value="#URL.textJustification#"> 
<input type="hidden" name="FontSize" value="#URL.FontSize#"> 
<input type="hidden" name="FontStyle" value="#URL.FontStyle#"> 
<input type="hidden" name="textColor" value="#URL.textColor#">
<input type="hidden" name="textBoundsX" value="#URL.textBoundsX#">
<input type="hidden" name="textBoundsY" value="#URL.textBoundsY#">
<input type="hidden" name="textBoundsWidth" value="#URL.textBoundsWidth#">
<input type="hidden" name="textBoundsHeight" value="#URL.textBoundsHeight#">
<cfif isdefined("URL.ModifyFlag")>
	<input type="hidden" name="ModifyFlag" value="1">
	<input type="hidden" name="BannerID" value="#URL.BannerID#">
	<input type="hidden" name="SpecPromoID" value="#URL.SpecPromoID#">
<cfelse>
	<input type="hidden" name="NewFlag" value="1">
</cfif>

<tr>
	<td align="center">
		<input type="Image" src="#application.RELATIVE_PATH#/images/admin/save.gif" BORDER="0" NAME="Save" VALUE="Save">
		</form>
		<form name="Cancel" action="banners.cfm" method="POST">
		<input type="Image" src="#application.RELATIVE_PATH#/images/admin/cancel.gif" BORDER="0" NAME="Cancel" VALUE="Cancel">
		</form>
	</td>
</tr>
</table>
</cfoutput>
	
