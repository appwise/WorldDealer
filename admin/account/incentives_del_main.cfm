                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 14, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!--- Delete Incentive? --->

<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: incentives_del_main.cfm,v $">

<cfquery name="GetOffer" datasource="#gDSN#">
	SELECT 	Models.Description as ModelDescription,
			Offers.Name,
			Offers.Description as OfferDescription,
			Offers.ExpirationDate,
			Offers.DisclaimerID,
			OfferDisclaimers.TemplateID
	FROM	(Offers 
			INNER JOIN Models ON Offers.ModelID = Models.ModelID)
			INNER JOIN OfferDisclaimers ON Offers.DisclaimerID = OfferDisclaimers.DisclaimerID
	WHERE 	Offers.OfferID = #url.OfferID#
</cfquery>

<cfoutput>
<table align="center" border="0" cellpadding="5" cellspacing="0">
<tr>
	<td align="center" colspan="2">
		"Deleting" will just change the Expiration Date to today.
		<br>
		Are you sure you wish to proceed?
		<br><br>
	</td>
</tr>
<tr>
	<td><b>Model:</b></td>
	<td>#GetOffer.ModelDescription#</td>
</tr>
<tr>
	<td><b>Offer Name:</b></td>
	<td>#GetOffer.Name#</td>
</tr>
<tr>
	<td><b>Offer Description:</b></td>
	<td>#GetOffer.OfferDescription#</td>
</tr>
<tr>
	<td><b>Expiration Date:</b></td>
	<td>#DateFormat(GetOffer.expirationDate, "mmmm d, yyyy")#</td>
</tr>
<tr>
	<td><b>Disclaimer:</b></td>
	<td>
		<!--- linda, 11/15/99: this needs to be db-driven, not file-content-driven in the future!! --->
		<cfif #getoffer.disclaimerid# is not "">
			<cfset #variables.id# = #getoffer.disclaimerid#>
			<cfinclude template="#getoffer.templateid#.cfm">
		</cfif>
	</td>
</tr>
			
<form action="incentives_del_save.cfm" method="post">
<input type="hidden" name="offerID" value="#url.offerID#">
<input type="hidden" name="MakeNumber" value="#url.MakeNumber#">
<input type="hidden" name="RegionID" value="#url.RegionID#">
<tr>
	<td align="center" colspan="2">
		<br><br>
		<a href="incentives.cfm?MakeNumber=#URL.MakeNumber#&RegionID=#URL.RegionID#"
			onmouseover="self.status='Cancel';return true"
			onmouseout="self.status='';return true"><img 
			src="#application.RELATIVE_PATH#/images/admin/cancel.gif"
			width="47" height="15" border="0"
			alt="Cancel"></a>
		&nbsp;&nbsp;
		<input type="Image"
			src="#application.RELATIVE_PATH#/images/admin/deletebutton.gif"
			border="0"
			name="Delete"
			value="Delete Incentive">
	</td>
</tr>
</form>
</table>
</cfoutput>
<cfmodule template="/util/DumpDebug.cfm" text="end   $RCSfile: incentives_del_main.cfm,v $">
