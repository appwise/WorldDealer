                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 13, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->

<!--- user has confirmed the deletion.  Mark the offer as Expired today.  Never actually delete. --->

<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: incentives_del_save.cfm,v $">

<cfset PageAccess = application.account_coordinator_access>
<cfinclude template = "../security.cfm">

<cfset YesterdayDate = #CreateODBCDate(Now())#>
<cfset ExpireYesterday = #DateAdd('D', -1, YesterdayDate)#>

<CFQUERY name="DeleteOffer" datasource="#gDSN#">
	UPDATE	Offers
	SET 	ExpirationDate = #ExpireYesterday#
	WHERE 	OfferID = #form.OfferID#
</CFQUERY>
	
<CFLOCATION URL="incentives.cfm?MakeNumber=#form.MakeNumber#&RegionID=#form.RegionID#" addtoken="no">

<cfmodule template="/util/DumpDebug.cfm" text="end   $RCSfile: incentives_del_save.cfm,v $">
