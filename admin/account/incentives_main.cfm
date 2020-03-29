                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 11, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!--- $Id: incentives_main.cfm,v 1.6 2000/05/18 23:53:08 lswanson Exp $ --->
<!--- List National & Regional Incentives --->
<!--- URL params: MakeNumber, RegionID --->

<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: incentives_main.cfm,v $">

<cfoutput>
<!--- get the Make & Region names for the page heading --->
<cfquery name="getMakeRegion" datasource="#gDSN#">
	SELECT	Makes.MakeName 
			<cfif #url.regionid#>
				, MakeRegions.RegionName
			</cfif>
	FROM	Makes
	<cfif #url.regionid#>
			INNER JOIN MakeRegions ON Makes.MakeNumber = MakeRegions.MakeNumber
	WHERE 	MakeRegions.RegionID = #URL.RegionID#
	<cfelse>
	WHERE 	Makes.MakeNumber = #URL.MakeNumber#
	</cfif>
</cfquery>

<!--- List of incentives to add/modify/delete --->
<!--- linda, 11/11/99: if RegionID is selected, show region, & hone right in on the incentives with that region.
if RegionID is 0, it's National, so we have to find incentives indirectly by make & model --->
<cfquery name="getOffers" datasource="#gDSN#">
	SELECT	Offers.OfferID, 
			Models.Description, 
			Offers.Name, 
			Offers.ExpirationDate
	FROM 	Offers INNER JOIN Models ON Offers.ModelID = Models.ModelID
	WHERE 	Models.Make = #URL.MakeNumber# 
			<cfif #url.regionid#>
				AND Offers.RegionID = #URL.RegionID#
			<cfelse>
				AND Offers.OfferTypeID = 1
			</cfif>
			<!--- linda, 12/15/99: theresa doesn't want to see expired/"deleted" incentives --->
			<!--- Chris Wacker 11/13/2000 12:16 PM
			Changed ">" symbol to ">=" --->
			AND Offers.ExpirationDate >= #CreateODBCDate(DateFormat(Now(), "mm/dd/yyyy"))#
	ORDER BY Models.Description, Offers.ExpirationDate
</cfquery>

<!--- Incentives Listing --->
<form action="incentives_edit.cfm?MakeNumber=#URL.MakeNumber#&RegionID=#URL.RegionID#" method="post">
<table align="center" border="0" cellpadding="10" cellspacing="0">
<tr align="center">
	<td>
		<h3>#getMakeRegion.MakeName# <cfif #url.regionid# eq 0>National<cfelse>#getMakeRegion.RegionName#</cfif></h3>
	</td>
</tr>
<cfif #getoffers.recordcount#>
	<tr>
		<td>
			<table align="center" border="1" cellpadding="10" cellspacing="0">	
			<tr>
				<td>&nbsp;</td>
				<td align="center"><b>Model</b></td>
				<td align="center"><b>Incentive Name</b></td>
				<td align="center"><b>Expiration Date</b></td>
			</tr>
			<cfloop query="getOffers">
				<tr>
					<td>
						<input type="radio"
							name="offerID"
							value="#OfferID#"
							<cfif #getoffers.currentrow# eq 1>CHECKED</cfif>>
					</td>
					<td>#description#</td>
					<td>#Name#</td>
					<td align="center">#DateFormat(expirationdate,"mm/dd/yyyy")#</td>
				</tr>
			</cfloop>
			</table>
		</td>
	</tr>
<cfelse>
	<tr align="center">
		<td>
			There are currently NO <b>#getMakeRegion.MakeName# <cfif #url.regionid# eq 0>National<cfelse>#getMakeRegion.RegionName#</cfif></b> offers available.
		</td>
	</tr>
</cfif>

<!--- Add, Modify, Delete, Back buttons --->
<tr>
	<td align="center">
		<br>
		<input type="Image"
			src="#application.RELATIVE_PATH#/images/admin/add.gif"
			border="0"
			name="Add"
			value="Add New Incentive">
		<cfif #getoffers.recordcount#>
			&nbsp;&nbsp;
			<input type="Image"
				src="#application.RELATIVE_PATH#/images/admin/modify.gif"
				border="0"
				name="Modify"
				value="Modify Incentive">
			&nbsp;&nbsp;
			<input type="Image"
				src="#application.RELATIVE_PATH#/images/admin/deletebutton.gif"
				border="0"
				name="Delete"
				value="Delete Incentive">
		</cfif>
		<br><br>
		<a href="incentives_make.cfm?MakeNumber=#URL.MakeNumber#"><input type="Image"
			src="#application.RELATIVE_PATH#/images/admin/back.gif"
			border="0"
			name="Back"
			value="Back"></a>
	</td>
</tr>
</table>
</form>
</cfoutput>
<cfmodule template="/util/DumpDebug.cfm" text="end   $RCSfile: incentives_main.cfm,v $">