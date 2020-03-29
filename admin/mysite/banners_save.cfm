          <!--- Created by AppNet, Inc., Detroit 
                       www.appnet.com
             Copyright (c) 1999, 2000 AppNet, Inc. 
   All other trademarks and servicemarks are the property of   
their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
            Appnet, Inc. logos are registered trademarks.  
                  Created: <January 10, 2000>
           webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: banners_save.cfm,v 1.10 2000/06/16 20:30:19 jkrauss Exp $--->

<cfset PageAccess = application.dealer_access>
<cfinclude template = "../security.cfm">

<cfif isdefined("Form.ModifyFlag")>

	<cfquery name="updPromo" datasource="#gDSN#">
		UPDATE 	SpecialPromotions
		SET		Description = '#Form.SpecPromoDescription#',
				ExpirationDate = #CreateODBCDate(Form.ExpirationDate)#
		WHERE 	SpecPromoID = #Form.SpecPromoID#
	</cfquery>

	<cfquery name="updBanners" datasource="#gDSN#">
		UPDATE 	Banners
		SET		Description = '#Form.title#',
				LinkYesNo = '#FORM.LinkYesNo#',
				BannerType = #Form.BannerType#,
				FontName = '#Form.FontName#',
				xcord = '#Form.textJustification#',
				FontSize = #Form.FontSize#,
				FontStyle = '#Form.FontStyle#',
				FontColor = '#Form.textColor#',
				textBoundsX = #form.textBoundsX#,
				textBoundsY = #form.textBoundsY#,
				textBoundsWidth = #form.textBoundsWidth#,
				textBoundsHeight = #form.textBoundsHeight#
		WHERE	BannerID = #Form.BannerID#;
	</cfquery>
	
	<cfset #variables.specpromoid# = #form.specpromoid#>
	<!--- RENAME TEMP BANNER WITH CORRECT NAME SCHEME --->
	<cffile action="COPY"
	source="#g_rootdir#\images\banner\temp_#form.tmpid#_adbanner_hea.gif"
	destination="#g_rootdir#\images\banner\#g_dealercode#_#variables.specpromoid#_adbanner_hea.gif">
	
</cfif>

<cfif isdefined("Form.NewFlag")>
	<cfif g_col>
		<cfloop index="colldealersindex" list="#form.colldealers#" delimiters="," >
			<CFSET g_dealercode = "#colldealersindex#"> 
			<CFINCLUDE template= "banners_add_save.cfm">
		</cfloop>	
	<CFELSE>
		<CFINCLUDE template= "banners_add_save.cfm">
	</cfif>
</cfif>


<cfif isdefined("Form.ModifyFlag")>
	<cflocation url="banners.cfm?mod=yes" addtoken="no">
<cfelse>
	<cflocation url="banners.cfm" addtoken="no">
</cfif> 