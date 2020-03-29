<cfset PageAccess = application.dealer_access>

                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 13, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!--- $Id: showroom_incent_add_natreg_main.cfm,v 1.9 2000/03/21 16:11:03 jkrauss Exp $ --->
<!--- Showroom: Add Vehicle Incentives.  Select from pre-defined National/Regional Incentives. --->


<cfquery name="selectDealerWebID" datasource="#gDSN#">
	SELECT	DealerWebID 
	FROM	DealerWebs
	WHERE	DealerCode = '#g_dealercode#';
</cfquery>

<!--- Depending on which Incentive type they chose, get National & Regional offers or redirect to add Custom Incentive --->
<cfswitch expression="#URL.OfferType#">
	<cfcase value="1">
		<!--- National Incentive --->
		<cfset national = true>
		<cfset regional = false>
		
		<cfoutput>
<!--- Chris Wacker 11/13/2000 11:43 PM
		Modified 	Offers.ExpirationDate GT #CreateODBCDate(DateFormat(Now(), "mm/dd/yyyy"))#
		To			Offers.ExpirationDate GTE #CreateODBCDate(DateFormat(Now(), "mm/dd/yyyy"))# --->
		
		<cfquery name="getoffers" datasource="#gDSN#">
		SELECT 	Offers.OfferID, 
				Offers.OfferTypeID, 
				Offers.Name, 
				Offers.Description as OfferDescription,
				Offers.ExpirationDate, 
				Offers.ModelID, 
				Models.Description as ModelsDescription,
				Models.Make,
				Makes.MakeName
		FROM 	((Offers 
				INNER JOIN Models ON Offers.ModelID = Models.ModelID) 
				INNER JOIN DealerFranchise ON Models.Make = DealerFranchise.MakeNumber
				INNER JOIN Makes ON Models.Make = Makes.MakeNumber)
		WHERE 	Offers.OfferTypeID = #URL.OfferType# 
				AND Offers.ExpirationDate GTE #CreateODBCDate(DateFormat(Now(), "mm/dd/yyyy"))#
				AND DealerFranchise.dealercode = '#g_dealercode#' 
				AND Offers.OfferID NOT IN (
					SELECT	DealerOffers.OfferID
					FROM	DealerOffers
					WHERE	DealerWebID = #selectDealerWebID.DealerWebID#
					)
		ORDER BY Makes.MakeName, 
				Models.Description,
				Offers.ExpirationDate
		</cfquery>
		</cfoutput>
	</cfcase>

	<cfcase value="5">
		<!--- Regional Incentive --->
		<cfset national = false>
		<cfset regional = true>
		<cfoutput>
		<cfquery name="getoffers" datasource="#gDSN#">
			SELECT 	Offers.OfferID, 
					Makes.MakeName, 
					MakeRegions.RegionName, 
					Models.Description as ModelsDescription,
					Offers.Name, 
					Offers.Description as OfferDescription, 
					Offers.ExpirationDate
			FROM 	(((DealerFranchise 
					INNER JOIN Offers ON DealerFranchise.RegionID = Offers.RegionID) 
					INNER JOIN Models ON Offers.ModelID = Models.ModelID) 
					INNER JOIN Makes ON Models.Make = Makes.MakeNumber) 
					INNER JOIN MakeRegions ON DealerFranchise.RegionID = MakeRegions.RegionID
			WHERE 	(Offers.OfferTypeID=#URL.OfferType#)
					AND (Offers.ExpirationDate GTE #CreateODBCDate(DateFormat(Now(), "mm/dd/yyyy"))#)
					AND (DealerFranchise.dealercode = '#g_dealercode#')
					AND Offers.OfferID NOT IN (
						SELECT	DealerOffers.OfferID
						FROM	DealerOffers
						WHERE	DealerWebID = #selectDealerWebID.DealerWebID#
						)
			ORDER BY Makes.MakeName,
					Models.Description,
					MakeRegions.RegionName,
					Offers.ExpirationDate;
		</cfquery>
		</cfoutput>
	</cfcase>
</cfswitch>


<cfoutput>
<form action="showroom_incent_add_natreg_save.cfm" method="post">
<table border="0" cellpadding="10" cellspacing="0" width="100%">
<cfif #getoffers.recordcount# eq 0>
	<tr align="center">
		<td>
			There are currently NO <cfif national>National<cfelse>Regional</cfif> Offers to add.
		</td>
	</tr>
<cfelse>
	<tr align="center">
 		<td>
			Choose from the following list of <cfif national>National<cfelse>Regional</cfif> Offers
		</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr align="Center">
		<td>
			<table border=1 cellspacing=0 cellpadding=2>
				<!--- Do the header stuff --->
				<tr align="center">
					<td>&nbsp;</td>
					<td><b>Make<b></td>
					<td><b>Model<b></td>
					<cfif regional>
						<td><b>Region</b></td>
					</cfif>
					<td><b>Offer Name</b></td>
					<td><b>Description</b></td>
					<td><b>ExpirationDate<b></td>
				</tr>
				<!--- Add ALL National Offers. --->
				<tr align="center">
					<td><input type="radio" name="OfferID" value="All"></td>
					<!--- Chris Wacker 11/13/2000  11:50 AM --->
					<!--- Construct of previous code was rough --->
					<cfif regional>
					<cfset negnatvar = 6>
					<cfelse>
					<cfset negnatvar = 5>
					</cfif>
					<td colspan= #negnatvar#>
					<font color="cc0000">Add <b>All</b> <cfif national>National<cfelse>Regional</cfif> Offers.</font></td>
				</tr>
				<cfloop query="getOffers">
					<!--- Display offers --->
					<tr align="center">
						<td>
					<!--- Chris Wacker 11/13/2000  11:55 AM --->
					<!--- Construct of previous code was rough --->
						<cfif #getoffers.currentrow# eq 1>
							<input type="radio" name="OfferID" value="#OfferID#" CHECKED>
						<cfelse>
							<input type="radio" name="OfferID" value="#OfferID#">
						</cfif>
						</td>
						<td>#MakeName#</td>
						<td>#ModelsDescription#</td>
						<cfif regional>
							<td>#RegionName#</td>
						</cfif>
						<td>#Name#</td>
						<td>#OfferDescription#</td>
						<td>#DateFormat(ExpirationDate, "mm/dd/yyyy")#</td>
					</tr>
				</cfloop>
			</table>
		</td>
	</tr>
</cfif>
<tr><td>&nbsp;</td></tr>
<tr align="center">
	<td>
		<input type="hidden" name="OfferType" value=#url.offertype#>
		<cfif #getoffers.recordcount#>				
			<input type="Image" src="#application.RELATIVE_PATH#/images/admin/save.gif" border="0" name="Save" value="Save">
		</cfif>
		</form>
		<form action="showroom_incent.cfm" method="post">
		<input type="Image" src="#application.RELATIVE_PATH#/images/admin/cancel.gif" border="0" name="Cancel" value="Cancel">
		</form>
	</td>
</tr>
</table>
</cfoutput>


