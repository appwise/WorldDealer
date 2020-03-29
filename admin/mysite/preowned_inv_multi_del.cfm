                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 21, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!--- $Id: preowned_inv_multi_del.cfm,v 1.5 2000/05/11 18:52:51 jkrauss Exp $ --->
<!--- Delete Pre-Owned Vehicles --->

<cfset PageAccess = application.dealer_access>
<cfinclude template = "../security.cfm">

<cfset vehicles = ArrayNew(1)>
<cfset vehicles = ListToArray(#form.UsedVehicleID#)>
<cfset count = 0>

<cfloop index="count" list="#form.UsedVehicleID#">
	<cfquery name="KillVehicle" datasource="#gDSN#">
		DELETE FROM UsedVehicles
		WHERE	UsedVehicleID = #count#
	</cfquery>
	
	<cfquery name="KillUVDetails" datasource="#gDSN#">
		DELETE FROM UVDetails
		WHERE	UsedVehicleID = #count#
	</cfquery>
	
	<cfquery name="KillExtraFeatures" datasource="#gDSN#">
		DELETE FROM UsedVehiclesOptions
		WHERE	UsedVehicleID = #count#
	</cfquery>
</cfloop>

<cflocation url="preowned_inv.cfm" addtoken="no">