                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 10, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: myinfo_brands_main.cfm,v 1.15 2000/04/28 20:37:02 jkrauss Exp $--->

<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: myinfo_brands_main.cfm,v $">

<!--- # of makes displayed --->
<cfset maxmakes = 10>

<!--- JOEL:	If URL.Field and URL.MakeNo, we're going to update the database and set the mode to editmode.
			We're going to copy some code from below so that we have the same code copied all over this page. --->
<cfif isdefined("URL.Field")>
	<!--- get snapshot of existing Makes & Regions --->
	<cfquery name="getDlrMakesRegions" datasource="worlddlr">
		SELECT 	RowID,
				MakeNumber,
				RegionID
		FROM 	DealerFranchise
		WHERE	DealerFranchise.dealercode = '#g_dealercode#'
		ORDER BY DealerFranchise.RowID 
	</cfquery>
	
	<cfset addnewmake = 0>
	
	<!--- for each of the existing Makes/Regions, compare against newly entered Make/Region --->
	<cfset count = 1>
	<cfloop query="getDlrMakesRegions">
		<!--- if there's no new make # in that spot (1-10), delete existing one. --->
		<cfif count eq #url.count#>
			<cfif #evaluate("URL.MakeNo")# eq "">
				<cfquery name="deleteDealerFranchise" datasource="worlddlr">
					DELETE FROM	
							DealerFranchise
					WHERE	RowID = #RowID#
				</cfquery>
				<cfset addnewmake = 1>
			<cfelseif #evaluate("URL.MakeNo")# neq #makenumber#>
				<!--- Update existing Makes & Regions with new ones. --->
				<cfquery name="updateDealerFranchise" datasource="worlddlr">
					UPDATE	DealerFranchise
					SET		MakeNumber = #Evaluate("URL.MakeNo")#,
							RegionID = 0
					WHERE	RowID = #RowID#
				</cfquery>			
				<cfset addnewmake = 1>
			</cfif>
			<cfbreak>
		</cfif>
		
		<cfset count = count + 1>
	</cfloop>
	
	<!--- now insert any New entries --->
	<cfif addnewmake eq 0>
		<cfquery name="insertDealerFranchise" datasource="worlddlr">
			INSERT INTO DealerFranchise(
				DF_Number,
				MakeNumber,
				RegionID,
				Dealercode)
			VALUES(
				#Val(Mid(g_dealercode,11,3))#,
				#Evaluate("URL.MakeNo")#,
				0,
				'#g_dealercode#')
		</cfquery>
	</cfif>
</cfif>
<!--- JOEL:  Here ends the tomfoolery --->

<!--- user is coming at this page with a dealer already selected --->
<cfquery name="getDealerInfo" datasource="worlddlr">
	SELECT *
	FROM Dealers
	WHERE Dealers.DealerCode = '#g_dealercode#'
</cfquery>

<!--- Dealer Makes Query used in drop down list below --->
<cfquery name="getDealerMakes" datasource="worlddlr">
	<!--- LEFT JOIN because we want all Records from DealerFranchise, but only records from MakeRegions that 
	have valid data in them.  i.e. There may be makes without regions. --->
	SELECT 	Makes.MakeNumber, 
			Makes.MakeName, 
			MakeRegions.RegionID, 
			MakeRegions.RegionName
	FROM 	(DealerFranchise 
			INNER JOIN Makes ON DealerFranchise.MakeNumber = Makes.MakeNumber) 
			LEFT JOIN MakeRegions ON DealerFranchise.RegionID = MakeRegions.RegionID
	WHERE	DealerFranchise.dealercode = '#g_dealercode#'
	ORDER BY DealerFranchise.RowID
</cfquery>

<cfquery name="getMakes" datasource="worlddlr">
	SELECT		MakeNumber, MakeName
	FROM		Makes
	ORDER BY	MakeName
</cfquery>

<cfquery name="getStates" datasource="worlddlr">
	SELECT		StateAbbr, 
				Description
	FROM		States
	ORDER BY	Description
</cfquery>

<cfif goodbrowser>
	<script language="JavaScript">
	<!--
	function onMakeChange(field,value,count){	
		location.href = 'myinfo_brands.cfm?Field=' + field + '&MakeNo=' + value + '&Count=' + count;			
	}
	//-->
	</script>
</cfif>

<h4>Franchises Offered</h4>

<form action="myinfo_brands_save.cfm" method="POST">
<table width="100%" border="0" cellspacing="0" cellpadding="5">
<tr>
	<!--- This will be displayed for Dealers Add/Update --->
	<td align="center">
		<table border="0" cellpadding="0" cellspacing="5">
		<tr>
			<td><b>Franchise</b></td>
			<td><b>Region</b></td>
		</tr>
			<!--- initialize all the Make & Region variables 1-10 --->
			<cfloop index="count" from="1" to=#maxmakes#>
				<cfset whatever = setvariable("DealerMake#count#", 0)>
				<cfset dummyvar = setvariable("DealerRegion#count#", 0)>
			</cfloop>

			<!--- Populate the Make & Region variables --->
			<cfset count = 0>
			<cfloop query="getDealerMakes">
				<cfset count = count + 1>
				<cfset whatever = setvariable("DealerMake#count#", #makenumber#)>
				<cfset dummyvar = setvariable("DealerRegion#count#", #regionid#)>
			</cfloop>
				
			<cfloop index="count" from="1" to=#maxmakes#>
				<tr>
				<!--- Linda, 12/30/99: can't figure out how to identify the element that they selected a make from.
				Since the Select boxes are defined in a loop, they use variables.  element[0] is the 1st element.
				So it would seem like element [0] is dealercode and element[1] would be the 1st make drop-down, 
				which would be convenient, cuz that's the same as the looping's count. --->
					<td>
						<cfset seldealermake = "selDealerMake" & #count#>
						<cfoutput><select name="#selDealerMake#" <cfif goodbrowser>onChange="onMakeChange('#selDealerMake#',#selDealerMake#.options[selectedIndex].value,#count#)"</cfif>></cfoutput>
							<option value="">Select Make <cfoutput>#count#</cfoutput>
							<cfloop query="getMakes">
								<option value=<cfoutput>#makenumber#</cfoutput>							
									<cfif isdefined("URL.MakeNumber")>
										<cfif #getmakes.makenumber# eq #url.makenumber#>
											SELECTED
										</cfif>
									<cfelseif #getmakes.makenumber# eq #evaluate("DealerMake#count#")#>
										SELECTED
									</cfif>								
								><cfoutput>#makename#</cfoutput>
							</cfloop>
						</select>
					</td>
					<td>
						<cfset seldealerregion = "selDealerRegion" & #count#>
						<select name="<cfoutput>#selDealerRegion#</cfoutput>">
							<cfif getDealerInfo.RecordCount>
								<!--- if a Make is selected, find corresp Regions --->												
								<cfif #evaluate("DealerMake#count#")#>
									<cfquery name="getRegions" datasource="worlddlr">
										SELECT	RegionID,
												RegionName
										FROM	MakeRegions
										WHERE	MakeNumber = <cfif isdefined("URL.MakeNumber")>#URL.MakeNumber#<cfelse>#Evaluate("DealerMake#count#")#</cfif>
										ORDER BY RegionName
									</cfquery>
									<cfif #getregions.recordcount# eq 0>
										<option value="">No Regions Available
									<cfelse>
										<option value="">Select Region <cfoutput>#count#</cfoutput>
										<cfloop query="getRegions">
											<option value=<cfoutput>#RegionID#</cfoutput> <cfif #getregions.regionid# eq #evaluate("DealerRegion#count#")#>SELECTED</cfif>><cfoutput>#RegionName#</cfoutput>
										</cfloop>
									</cfif>
								<cfelse>
									<option value="">Select Make First
								</cfif>
							<cfelse>
								<option value="">Select Make First
							</cfif>
						</select>
					</td>
				</tr>
			</cfloop>
			<input type="hidden" name="selDealerMake1_required" value="Please select a Make."> 					
		</table>
	</td>
</tr>
<tr>
	<td align="center">
		<br>
		<a href="myinfo.cfm"><img src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/back.gif" border="0" width="46" height="15" alt="Back"></a>
		&nbsp;
		<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/save.gif" name="Save" border="0">
	</td>
</tr>
</form>
</table>
<cfmodule template="/util/DumpDebug.cfm" text="end   $RCSfile: myinfo_brands_main.cfm,v $">
