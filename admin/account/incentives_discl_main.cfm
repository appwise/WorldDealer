                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 13, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!--- $Id: incentives_discl_main.cfm,v 1.3 2000/05/18 23:53:08 lswanson Exp $ --->
<!--- Incentives: Custom Disclaimer --->

<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: incentives_discl_main.cfm,v $">

<cfif parameterexists(form.offerid)>
	<!--- existing incentive --->
	<cfset editmode = true>

	<!--- Customize Disclaimer --->
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

<cfquery name="getMakeName" datasource="#gDSN#">
	SELECT	MakeName 
	FROM 	Makes
	WHERE	MakeNumber = #URL.MakeNumber#
</cfquery>
	
<cfquery name="getRegionName" datasource="#gDSN#">
	SELECT	RegionName
	FROM 	MakeRegions
	WHERE	RegionID = #URL.RegionID#
</cfquery>

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

<cfoutput>
<form name="IncentivesDiscl" action="incentives_photo.cfm?MakeNumber=#URL.MakeNumber#&RegionID=#URL.RegionID#" method="post">
<table border="0" cellpadding="10" cellspacing="0" width="100%">
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
			wrap="virutal"><cfif editmode><cfif #getdisclaimer.recordcount#>#Replace(getDisclaimer.DisclaimerText,"<br>",Chr(13),"ALL")#</cfif></cfif></textarea>
	</td>
</tr>
<tr align="center">
	<td>
		<a href="JavaScript:history.back();"
			onmouseover="self.status='Back';return true"
			onmouseout="self.status='';return true"><img
			src="#application.RELATIVE_PATH#/images/admin/back.gif" border=0 name="Back" value="Back"></a>
		&nbsp;&nbsp;
		<a href="JavaScript:document.IncentivesDiscl.reset();"
			onmouseover="self.status='Reset Text';return true"
			onmouseout="self.status='';return true"><img
			src="#application.RELATIVE_PATH#/images/admin/reset.gif" border=0 name="Reset" value="Reset"></a>
		&nbsp;&nbsp;
		<input type="Image" 
			src="#application.RELATIVE_PATH#/images/admin/next.gif" 
			border="0" 
			name="Next" 
			value="Next">
		<br><br>
		<a href="incentives.cfm?MakeNumber=#URL.MakeNumber#&RegionID=#URL.RegionID#"
			onmouseover="self.status='Cancel';return true"
			onmouseout="self.status='';return true"><img 
			src="#application.RELATIVE_PATH#/images/admin/cancel.gif"
			width="47" height="15" border="0"
			alt="Cancel"></a>
		<cfif editmode>
			<input type="hidden" name="offerID" value="#form.offerID#">
		<cfelse>
			<!--- Regions selected for New Incentive --->
			<input type="hidden" name="Regions" value="#Form.Regions#">
		</cfif>
		<input type="hidden" name="ModelID" value="#Form.ModelID#">
		<input type="hidden" name="offer_name" value="#form.Offer_name#">
		<input type="hidden" name="offer_body" value="#form.offer_body#">
		<input type="hidden" name="expiration" value="#form.expiration#">
		<input type="hidden" name="templateid" value="#form.templateid#">
	</td>
</tr>
</table>
</form>
</cfoutput>
<!--- </cfif> --->

<cfmodule template="/util/DumpDebug.cfm" text="end   $RCSfile: incentives_discl_main.cfm,v $">
