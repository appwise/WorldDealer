                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 10, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: myinfo_url.cfm,v 1.11 2000/06/15 17:11:20 jkrauss Exp $--->

<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: myinfo_url.cfm,v $">

<!doctype html public "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<title>WorldDealer My Site -- My Info: Web Address</title>
</head>

<cfset PageAccess = application.sysadmin_access>

<!--- include the template and a variable to make known that you're on the my info section --->
<cfset title = "Web Address">
<cfset section = "myinfo_url">
<cfinclude template="../template.cfm">

</html>
<cfmodule template="/util/DumpDebug.cfm" text="end   $RCSfile: myinfo_url.cfm,v $">