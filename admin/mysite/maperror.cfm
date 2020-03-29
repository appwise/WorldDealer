                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 10, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: maperror.cfm,v 1.12 2000/04/07 18:34:08 lswanson Exp $--->

<!---
maperror.cfm - a module to display an error to the user that mapping didn't work
   attributes:
       errorString - string describing the error that occured
--->

<cfset PageAccess = application.dealer_access>
<cfinclude template = "../security.cfm">

<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: maperror.cfm,v $">
<!doctype html public "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<title>WorldDealer My Site -- Map Creation Error</title>
	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="../admin.css" type="text/css">

	<cfparam name="attributes.errorString">

</head>

<body>
<br><br><br><br><br>
<table border=0 cellpadding=0 cellspacing=0 width="100%">
<tr align="center">
	<td>
		<h3>WorldDealer - Create Maps</h3>
	</td>
</tr>
<tr align="center">
	<td>
		<b>An error occurred while creating your custom maps.</b>
		<br><br>
	</td>
</tr>
<tr align="center">
	<td>
		<cfoutput>#attributes.errorString#</cfoutput>
	</td>
</tr>
<tr align="center">
	<td>
		<a href="JavaScript:history.back();"
			onmouseover="self.status='Back';return true"
			onmouseout="self.status='';return true"><img
			src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/back.gif" border="0" name="Back" value="Back"></a>
	</td>
</tr>
</table>
</body>
</html>
<cfmodule template="/util/DumpDebug.cfm" text="end   $RCSfile: maperror.cfm,v $">