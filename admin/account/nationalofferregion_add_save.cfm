<cfset PageAccess = application.account_coordinator_access>
<cfinclude template = "../security.cfm">

<!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 14, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: nationalofferregion_add_save.cfm,v 1.5 2000/03/21 16:11:00 jkrauss Exp $--->

<cfquery name="getmaxregionID" datasource="#gDSN#">
	SELECT RegionID
	FROM 	MakeRegions
	ORDER BY RegionID DESC
</cfquery>

<cfquery name="addregion" datasource="#gDSN#">
	INSERT INTO MakeRegions(
			regionID,
			MakeNumber,
			RegionName)
	VALUES( #getmaxRegionID.RegionID# +1,
			#form.makenumber#,
			'#form.RegionName#')
</cfquery>

<cflocation url="incentives_make.cfm" addtoken="No">                                                                                                                                                                                                 