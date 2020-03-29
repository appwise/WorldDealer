                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 10, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!--- $Id: showroom.cfm,v 1.12 2000/05/18 23:50:51 lswanson Exp $ --->
<!--- Main Showroom page that sets vars & calls template that calls showroom content --->

<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: showroom.cfm,v $">
<!doctype html public "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<title>WorldDealer My Site -- Showroom</title>
</head>

<cfset PageAccess = application.dealer_access>
<cfset title = "Showroom">
<cfset section = "showroom">
<cfinclude template="../template.cfm">

</html>
<cfmodule template="/util/DumpDebug.cfm" text="end   $RCSfile: showroom.cfm,v $">
