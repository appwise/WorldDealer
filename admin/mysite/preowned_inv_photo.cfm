
                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 21, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!--- $Id: preowned_inv_photo.cfm,v 1.8 2000/05/11 18:52:51 jkrauss Exp $ --->
<!--- Pre-Owned Vehicle Photo --->

<cfif #form.image# eq 'n'>
	<!--- No Used Vehicle Photo.  continue on to save. --->
	<cfinclude template="preowned_inv_save.cfm">
<cfelse>
	<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: preowned_inv_photo.cfm,v $">
<!doctype html public "-//W3C//DTD HTML 4.0 Transitional//EN">
	<html>
	<head>
		<title>WorldDealer My Site -- Pre-Owned: Vehicle Photo</title>
	</head>
	
	<cfset PageAccess = application.dealer_access>
	<cfset title = "InventoryManager&##153;">
	<cfset section = "preowned_inv_photo">
	<cfinclude template="../template.cfm">
	
	</html>
<cfmodule template="/util/DumpDebug.cfm" text="end   $RCSfile: preowned_inv_photo.cfm,v $">
</cfif>