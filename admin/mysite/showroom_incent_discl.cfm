<cfset PageAccess = application.dealer_access>

                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 13, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!--- $Id: showroom_incent_discl.cfm,v 1.10 2000/03/21 16:11:03 jkrauss Exp $ --->
<!--- Showroom: Custom Dealership Vehicle Incentives Disclaimer --->

<cfif #form.templateid# eq 1>
	<!--- Standard MSRP, no additional disclaimer info req'd.  continue on to Car Photo --->
	<cfinclude template="showroom_incent_photo.cfm">
<cfelse>
	<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: showroom_incent_discl.cfm,v $">
<!doctype html public "-//W3C//DTD HTML 4.0 Transitional//EN">
	<html>
	<head>
		<title>WorldDealer My Site -- Showroom: Custom Vehicle Incentives Disclaimer</title>
	</head>
	
	<cfset title = "IncentivesManager&##153;">
	<cfset section = "showroom_incent_discl">
	<cfinclude template="../template.cfm">
	
	</html>
<cfmodule template="/util/DumpDebug.cfm" text="end   $RCSfile: showroom_incent_discl.cfm,v $">
</cfif>