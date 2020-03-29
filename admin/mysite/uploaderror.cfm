<cfset PageAccess = application.dealer_access>
<cfinclude template = "../security.cfm">

                        <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 24, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!--- $Id: uploaderror.cfm,v 1.4 2000/03/03 17:54:29 jkrauss Exp $ --->
<!--- Photo Upload Error.  Currently called from preowned_inv_photo_rusure_main.cfm, 
but it could be called generically from any photo uploading sections in the future. --->
<!--------------------------------------------------------------------------------
CFERROR files cannot contain CFML.  So we can't do cfincludes or cfoutput variable-defined paths, etc.
The only variables it recognizes is #Error. variables#
--------------------------------------------------------------------------------->

<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: uploaderror.cfm,v $">
<!doctype html public "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>WorldDealer My Site -- Photo Upload Error</title>
	<link rel=stylesheet href="../admin.css" type="text/css">
</head>

<body bgcolor="black">
<table border=0 cellpadding=10 cellspacing=0 bgcolor="white" align="center">
<form method="post">
<tr align="center">
	<td>
		Sorry, the file you uploaded was invalid.
		<br>You must choose a JPEG file (.JPG extension).
		<br><br>
		Click <b>Back</b> to try again.
		<!--- linda, 1/24/2000: want to keep this generic for any type of photo uploading in the future.
		<br>
		Click <b>Cancel</b> to return to the Pre-Owned vehicles listing. --->
	</td>
</tr>
<tr align="center">
	<td>
		<cfoutput>
		<a href="JavaScript:history.back();"
			onmouseover="self.status='Back';return true"
			onmouseout="self.status='';return true"><img
			src="#application.RELATIVE_PATH#/images/admin/back.gif" border="0" name="Back" value="Back"></a>
		</form>
		<!--- linda, 1/24/2000: want to keep this generic for any type of photo uploading in the future.
		<form action="preowned_inv.cfm" method="post">
		<input type="Image" src="#application.RELATIVE_PATH#/images/admin/cancel.gif" border="0" name="Cancel" value="Cancel">
		</form> --->
		</cfoutput>
	</td>
</tr>
</table>
</body>
</html>
<cfmodule template="/util/DumpDebug.cfm" text="end   $RCSfile: uploaderror.cfm,v $">
