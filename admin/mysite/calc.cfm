<cfset PageAccess = application.dealer_access>
<cfinclude template = "../security.cfm">

                        <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 11, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!--- $Id: calc.cfm,v 1.6 2000/03/03 17:54:25 jkrauss Exp $ --->
<!--- Main calculator page that calls template that calls calculator content --->

<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: calc.cfm,v $">
<!doctype html public "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<title>WorldDealer My Site -- Calculator</title>
</head>

<cfset title = "Calculator">
<cfset section = "calc">
<cfinclude template="../template.cfm">

</html>
<cfmodule template="/util/DumpDebug.cfm" text="end   $RCSfile: calc.cfm,v $">