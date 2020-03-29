                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 13, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->

<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: incentives_photo_main.cfm,v $">

<cfif #isdefined("form.OfferID")#>  
	<!--- Existing Offer --->
	<cfquery name="GetOffer" datasource="#gDSN#">
		SELECT	CarcutID
		FROM	Offers
		WHERE	Offers.OfferID = #form.OfferID#;
	</cfquery>
	
	<cfset editmode = true>
<cfelse>
	<cfset editmode = false>
</cfif>

<!--- LINDA: enhanced this query, so it looks in the right dir (Make) for carcuts --->
<cfquery name="getCarCuts" datasource="#gDSN#">
	SELECT	CarCutKey.CarCutID,
		   	Models.Make
	FROM 	CarCutKey INNER JOIN Models ON CarCutKey.ModelID = Models.ModelID
	WHERE 	CarCutKey.ModelID = #form.ModelID#;
</cfquery>

<!--- these happen for every mode, to display in the page heading --->
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

<!--- Choose CarCut --->
<cfoutput>

<form  action="incentives_save.cfm?MakeNumber=#URL.MakeNumber#&RegionID=#URL.RegionID#" method="post">
<table border=0 cellspacing=0 cellpadding=0 align="center">
<tr align=center>
	<td>
		Select the vehicle image for this incentive.
	</td>
</tr>
<tr align=center>
	<td>
		<br>
		<!--- Display all the Carcuts for the selected model --->
		<cfset #counter# = 1>
		<cfloop query="getCarCuts">
			Image #counter#: 
			<input type="radio"
				name="carcut"
				value="#carcutID#"
				<cfif editmode>
					<cfif #carcutid# eq #getoffer.carcutid#>CHECKED</cfif>
				<cfelse>
					<cfif #carcutid# eq '1'>CHECKED</cfif>
				</cfif>>
			&nbsp;&nbsp;
			<img
				src="#application.RELATIVE_PATH#/images/vehicles/#Make#/#form.modelID#_#carcutID#.jpg"
				align="middle">
			<p>
			<cfset #counter# = #counter# + 1>
		</cfloop>
	</td>
</tr>
<tr align="center">
	<td>
		<br>
		<cfif editmode>
			<input type="hidden" name="offerID" value="#form.offerID#">
		<cfelse>
			<input type="hidden" name="Regions" value="#Form.Regions#">
		</cfif>
		<input type="hidden" name="ModelID" value="#Form.ModelID#">
		<input type="hidden" name="offer_name" value="#form.Offer_name#">
		<input type="hidden" name="offer_body" value="#form.offer_body#">
		<input type="hidden" name="expiration" value="#form.expiration#">
		<input type="hidden" name="templateid" value="#form.templateid#">
		<cfif parameterexists(form.disclaimer_body)>
			<input type="hidden" name="disclaimer_body" value="#form.disclaimer_body#">
		</cfif>
		<a href="incentives.cfm?MakeNumber=#URL.MakeNumber#&RegionID=#URL.RegionID#"
			onmouseover="self.status='Cancel';return true"
			onmouseout="self.status='';return true"><img 
			src="#application.RELATIVE_PATH#/images/admin/cancel.gif"
			width="47" height="15" border="0"
			alt="Cancel"></a>
		&nbsp;&nbsp;
		<input type="Image"
			src="#application.RELATIVE_PATH#/images/admin/save.gif"
			border="0"
			name="Save"
			value="Save">
		</form>
	</td>
</tr>
</table>
</cfoutput>
<cfmodule template="/util/DumpDebug.cfm" text="end   $RCSfile: incentives_photo_main.cfm,v $">
