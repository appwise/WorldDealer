                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 13, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!--- $Id: incentives_discl.cfm,v 1.3 2000/05/18 23:53:08 lswanson Exp $ --->
<!--- Showroom: Custom Dealership Vehicle Incentives Disclaimer --->

<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: incentives_discl.cfm,v $">

<cfif #form.templateid# eq 1>
	<!--- Standard MSRP, no additional disclaimer info req'd.  continue on to Car Photo --->
	<cfinclude template="incentives_photo.cfm">
<cfelse>
	<!doctype html public "-//W3C//DTD HTML 4.0 Transitional//EN">
	<html>
	<head>
		<title>WorldDealer My Site -- Showroom: Custom Vehicle Incentives Disclaimer</title>
	</head>
	
	<cfset PageAccess = application.account_coordinator_access>
	<cfset title = "National and Regional Incentives">
	<cfset section = "incentives_discl">
	<cfinclude template="../template.cfm">

	</html>
</cfif>

<cfmodule template="/util/DumpDebug.cfm" text="end   $RCSfile: incentives_discl.cfm,v $">
