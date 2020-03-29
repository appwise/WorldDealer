                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 21, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!--- $Id: preowned_inv_del.cfm,v 1.7 2000/05/11 18:52:51 jkrauss Exp $ --->
<!--- Delete Pre-Owned Vehicles --->

<cfset PageAccess = application.dealer_access>
<cfinclude template = "../security.cfm">

<cfquery name="KillVehicle" datasource="#gDSN#">
	DELETE FROM UsedVehicles
	WHERE	UsedVehicleID = #form.UsedVehicleID#
</cfquery>

<cfquery name="KillVehicleDetails" datasource="#gDSN#">
	DELETE FROM UVDetails
	WHERE	UsedVehicleID = #form.UsedVehicleID#
</cfquery>

<cfquery name="KillExtraFeatures" datasource="#gDSN#">
	DELETE FROM UsedVehiclesOptions
	WHERE	UsedVehicleID = #form.UsedVehicleID#
</cfquery>

<cflocation url="preowned_inv.cfm" addtoken="no">