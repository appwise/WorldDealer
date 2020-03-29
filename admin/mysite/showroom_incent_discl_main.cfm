<cfset PageAccess = application.dealer_access>

                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 13, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!--- $Id: showroom_incent_discl_main.cfm,v 1.12 2000/03/21 16:11:03 jkrauss Exp $ --->
<!--- Showroom: Custom Dealership Vehicle Incentives Disclaimer --->

<!--- linda, 1/19/00: this was taking too long: loading Custom disclaimer page, then Photo page.
<cfif #form.templateid# eq 1>
	<cfoutput>
	<cfif goodbrowser>
	<SCRIPT LANGUAGE="JavaScript">
	<!--
	function submitevent() { parent.document.FwdToPhoto.submit(); }
	//-->
	</script>
	</cfif>
	
	<body OnLoad="submitevent();">
	--- Standard MSRP, no additional disclaimer info req'd.  continue on to Car Photo ---
	<form name="FwdToPhoto" action="showroom_incent_photo.cfm" method="post">
	<input type="hidden" name="ModelID" value="#Form.ModelID#">
	<input type="hidden" name="offer_name" value="#form.Offer_name#">
	<input type="hidden" name="offer_body" value="#form.offer_body#">
	<input type="hidden" name="expiration" value="#form.expiration#">
	<input type="hidden" name="templateid" value="#form.templateid#">
	</form>
	</body>
	</cfoutput>
<cfelse>
 --->

<!--- Customize Disclaimer --->
<cfif isdefined("form.offerid")>
	<cfset editmode = true>
	<cfquery name="getDisclaimer" datasource="#gDSN#">
		SELECT	CustomDisclaimers.DisclaimerID, 
				CustomDisclaimers.DisclaimerText
		FROM 	(CustomDisclaimers 
				INNER JOIN OfferDisclaimers ON CustomDisclaimers.DisclaimerID = OfferDisclaimers.DisclaimerID) 
				INNER JOIN Offers ON OfferDisclaimers.DisclaimerID = Offers.DisclaimerID
		WHERE 	Offers.OfferID = #form.offerid#
	</cfquery>
<cfelse>
	<cfset editmode = false>
</cfif>

<cfoutput>
<table border="0" cellpadding="5" cellspacing="0" width="100%">
<form name="DealerIncentivesDiscl" action="showroom_incent_photo.cfm" method="post">
<tr align="center">
	<td>
		<h4>Custom Disclaimer</h4>
	</td>
</tr>
<tr align="center">
	<td>
		<textarea name="disclaimer_body" 
			cols=35
			rows=10
			wrap="virutal"><cfif editmode><cfif #getdisclaimer.recordcount#>#Replace(getDisclaimer.DisclaimerText,"<BR>",Chr(13),"ALL")#</cfif><cfelse>Enter your disclaimer here.</cfif></textarea>
	</td>
</tr>
<tr align="center">
	<td>
		<cfif isdefined("form.OfferID")>
			<input type="hidden" name="OfferID" value="#Form.OfferID#">
		</cfif>
		<input type="hidden" name="ModelID" value="#Form.ModelID#">
		<input type="hidden" name="offer_name" value="#form.Offer_name#">
		<input type="hidden" name="offer_body" value="#form.offer_body#">
		<input type="hidden" name="expiration" value="#form.expiration#">
		<input type="hidden" name="templateid" value="#form.templateid#">
		
		<a href="JavaScript:history.back();"
			onmouseover="self.status='Back';return true"
			onmouseout="self.status='';return true"><img
			src="#application.RELATIVE_PATH#/images/admin/back.gif" border=0 name="Back" value="Back"></a>
		<a href="JavaScript:document.DealerIncentivesDiscl.reset();"
			onmouseover="self.status='Reset Text';return true"
			onmouseout="self.status='';return true"><img
			src="#application.RELATIVE_PATH#/images/admin/reset.gif" border=0 name="Reset" value="Reset"></a>
		<input type="Image" 
			src="#application.RELATIVE_PATH#/images/admin/next.gif" 
			border="0" 
			name="Next" 
			value="Next">
		</form>
		<form name="Cancel" action="showroom_incent.cfm" method="post">
		<input type="Image" src="#application.RELATIVE_PATH#/images/admin/cancel.gif" border="0" name="Cancel" value="Cancel">
		</form>
	</td>
</tr>
</table>
</cfoutput>
<!--- </cfif> --->

