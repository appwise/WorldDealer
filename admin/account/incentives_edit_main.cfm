                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 14, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: incentives_edit_main.cfm,v 1.3 2000/05/18 23:53:08 lswanson Exp $ --->

<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: incentives_edit_main.cfm,v $">

<cfif #isdefined("form.Delete.X")#> 
	<cflocation url="incentives_del.cfm?OfferID=#form.OfferID#&Makenumber=#url.makenumber#&RegionID=#url.regionID#">
</cfif>

<!--- get make & region to display in the page heading --->
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

<!--- listing of model names for the drop-down. --->
<cfquery name="GetModels" datasource="#gDSN#">
	SELECT	ModelID,
			Description
	FROM 	Models
	WHERE	Make = #URL.MakeNumber#
	ORDER BY Models.Description
</cfquery>

<cfif isdefined ("form.Modify.X")> 
	<cfset modifymode="true">
	<cfquery name="getNationalOffer" datasource="#gDSN#">
		SELECT 	Offers.OfferID,
				Offers.ModelID, 
				Offers.Name, 
				Offers.Description, 
				Offers.ExpirationDate, 
				OfferDisclaimers.TemplateID
		FROM 	Offers INNER JOIN OfferDisclaimers ON Offers.DisclaimerID = OfferDisclaimers.DisclaimerID
		WHERE 	OfferID = #form.OfferID#;
	</cfquery>
<cfelse>
	<cfset modifymode="false">	
	<cfquery name="getRegions" datasource="#gDSN#">
		SELECT	RegionID,
				RegionName
		FROM	MakeRegions
		WHERE	MakeNumber = #URL.MakeNumber#
		ORDER BY RegionName
	</cfquery>
</cfif>

<cfoutput>
<!--- Note: Next takes you to Disclaimer page, but if they select standard MSRP, Dislaimer fwds to Photo page. --->
<form  action="incentives_discl.cfm?makenumber=#url.makenumber#&RegionID=#url.regionID#" method="post">
<table border=0 cellpadding=0 cellspacing=0 align="center">
<tr align="center">
	<td>
		<h3>
		#getMakeName.MakeName# <cfif #url.regionid# eq 0>National<cfelse>#getRegionName.RegionName#</cfif>
		</h3>
	</td>
</tr>
<!--- Enter Regions, Model, Incentive Name, Incentive Description, Expiration Date, OfferDisclaimers --->
<!--- if adding an incentive, allow them to add it for several regions at once. --->
<cfif modifymode eq "false">
	<tr align=center>
		<td>
			<br>
			<b>Which Regions does this incentive apply to?</b>
		</td>
	</tr>
	<tr align="center">
		<td>
			<input type="checkbox" name="Regions" value="0"<cfif #url.regionid# eq 0> CHECKED</cfif>>National
			<cfloop query = "getRegions">
				<input type="checkbox" name="Regions" value="#regionID#"<cfif #url.regionid# eq #regionid#> CHECKED</cfif>>#RegionName#
			</cfloop>
			<input type="hidden" name="Regions_required" value="Please select at least one Region that this incentive applies to.">
		</td>
	</tr>
</cfif>
<tr align=center>
	<td>
		<br>
		<b>Select a Model</b>
	</td>
</tr>
<tr align=center>
	<td>
		<select name="modelID">
		<cfloop query="getModels">
			<option value="#ModelID#"<cfif modifymode><cfif #getnationaloffer.modelid# is modelid> SELECTED</cfif></cfif>>#getmodels.Description#</option>
		</cfloop>
		</select>
	</td>
</tr>
<tr align=center>
	<td>
		<br>
		<b>Incentive Name</b>
	</td>
</tr>
<tr align=center>
	<td>
		<input type="text"
			name="offer_name"
			size="35"
			maxlength="35"
			<cfif modifymode>
				value="#GetNationalOffer.Name#"
			</cfif>>
	</td>
</tr>
<tr align=center>
	<td>
		<br>
		<b>Incentive Description</b>
	</td>
</tr>
<tr align=center>
	<td>
		<textarea name="offer_body"
			cols="35"
			rows="10"
			wrap="PHYSICAL"><cfif modifymode>#getNationalOffer.Description#</cfif></textarea>
	</td>
</tr>
<tr align=center>
	<td>
		<br>
		<b>Expiration Date</b> (mm/dd/yyyy)
	</td>
</tr>
<tr align=center>
	<td>
		<input type="text"
			name="expiration"
			maxlength="10"
			<cfif modifymode>
				value="#DateFormat(getNationalOffer.ExpirationDate,'mm/dd/yyyy')#"
			<cfelse>
				value="#DateFormat(DateAdd("m",1,Now()),'mm/dd/yyyy')#"
			</cfif>>
		<input type="hidden" name="expiration_date" value="You must enter an expiration date in the form mm/dd/yyyy">
	</td>
</tr>
<tr align="center">
	<td>
		<br>
		<b>Please choose a Disclaimer Template</b>
	</td>
</tr>
<tr align="center">
	<td>
		<table border=1>
		<tr>
			<td align=center valign=middle>
				<input type="radio" name="templateID" value="1" <cfif modifymode eq "false">CHECKED<cfelseif modifymode and #getnationaloffer.templateid# is '1'>CHECKED</cfif>>
			</td>
			<td align=left>
				<b>MSRP:</b>
				<br>
				MSRP. Title and taxes extra.
			</td>
		</tr>
		<tr>
			<td align="center" valign="middle">
				<input type="Radio" name="templateID" value="0" <cfif modifymode><cfif #getnationaloffer.templateid# is '0'>CHECKED</cfif></cfif>>
			</td>
			<td align="left">
				<b>Custom:</b>
				<br>
				Enter a custom disclaimer.
			</td>
		</tr>
		</table>
	</td>
</tr>
<cfif modifymode>
	<input type="hidden" name="offerID" value="#form.offerID#">
</cfif>

<tr align="center">
	<td>
		<br>
		<a href="incentives.cfm?MakeNumber=#URL.MakeNumber#&RegionID=#URL.RegionID#"
			onmouseover="self.status='Cancel';return true"
			onmouseout="self.status='';return true"><img 
			src="#application.RELATIVE_PATH#/images/admin/cancel.gif"
			width="47" height="15" border="0"
			alt="Cancel"></a>
		&nbsp;&nbsp;
		<input type="Image"
			src="#application.RELATIVE_PATH#/images/admin/next.gif"
			border="0"
			name="Next"
			value="Next">
	</td>
</tr>
</table>
</form>
</cfoutput>
<cfmodule template="/util/DumpDebug.cfm" text="end   $RCSfile: incentives_edit_main.cfm,v $">
