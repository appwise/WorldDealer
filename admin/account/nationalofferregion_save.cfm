<cfset PageAccess = application.account_coordinator_access>
<cfinclude template = "../security.cfm">

<!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 10, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: nationalofferregion_save.cfm,v 1.4 2000/03/09 21:18:41 bbickel Exp $--->

<cfquery name="updateregion" datasource="#gDSN#">
	UPDATE MakeRegions
	SET    RegionName ='#form.RegionName#'
	WHERE  RegionID =#Form.regionID#
</cfquery>

<cflocation url="incentives_make.cfm" addtoken="No">