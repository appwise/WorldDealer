                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 10, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: myinfo_brands_save.cfm,v 1.7 2000/04/28 20:37:02 jkrauss Exp $--->

<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: myinfo_brands_save.cfm,v $">
<cfset PageAccess = application.account_coordinator_access>
<cfinclude template = "../security.cfm">

<cfquery name="getDlrMakesRegions" datasource="#gDSN#">
	SELECT 	RowID,
			MakeNumber,
			RegionID
	FROM 	DealerFranchise
	WHERE	DealerFranchise.dealercode = '#g_dealercode#'
	ORDER BY DealerFranchise.RowID
</cfquery>

<cfset maxmakes = 10>
<cfset count = 1>

<cfloop query="getDlrMakesRegions">
	<!--- if there's no new make # in that spot (1-10), delete existing one. --->
	<cfif #Evaluate("Form.selDealerMake#count#")# EQ "">
		<cfquery name="deleteDealerFranchise" datasource="#gDSN#">
			DELETE FROM	
					DealerFranchise
			WHERE	RowID = #RowID#					
		</cfquery>
	<cfelse>
		<!--- Update existing Makes & Regions with new ones. --->
		<cfif (#MakeNumber# NEQ #Evaluate("Form.selDealerMake#count#")#)
			OR (#RegionID# NEQ #Evaluate("Form.selDealerRegion#count#")#)>
			<CFQUERY NAME="updateDealerFranchise" datasource="#gDSN#">
				UPDATE	DealerFranchise
				SET		MakeNumber = #Evaluate("Form.selDealerMake#count#")#,
						RegionID = <cfif #Evaluate("Form.selDealerRegion#count#")# GT 0>#Evaluate("Form.selDealerRegion#count#")#<cfelse>0</cfif>
				WHERE	RowID = #RowID#
			</CFQUERY>			
		</cfif>
	</cfif>	
	<cfset count = count + 1>
</cfloop>

<!--- now loop through the rest of the New Makes/Regions, & insert any New entries --->
<cfloop index="count" from="#count#" to="#maxMakes#">
	<cfif #Evaluate("Form.selDealerMake#count#")# GT "">
		<cfquery name="insertDealerFranchise" datasource="#gDSN#">
			INSERT INTO DealerFranchise(
					DF_Number,
					MakeNumber,
					RegionID,
					dealercode)
			VALUES	(#Val(Mid(g_dealercode,11,3))#,
					#Evaluate("Form.selDealerMake#count#")#,
					<cfif #Evaluate("Form.selDealerRegion#count#")# GT 0>#Evaluate("Form.selDealerRegion#count#")#<cfelse>0</cfif>,
					'#g_dealercode#')
		</cfquery>
	</CFIF>
</cfloop>

<cflocation url="myinfo_brands.cfm" addtoken="no">

<cfmodule template="/util/DumpDebug.cfm" text="end   $RCSfile: myinfo_brands_save.cfm,v $">
