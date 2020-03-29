                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 24, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: err_reqfields.cfm,v 1.2 2000/04/10 21:51:51 lswanson Exp $--->

<!--- this gets called whenever a user doesn't fill out a required field. --->
<!--------------------------------------------------------------------------------
CFERROR files cannot contain CFML.  So we can't do cfincludes or cfoutput variable-defined paths, etc.
The only variables it recognizes is #Error. variables#
--------------------------------------------------------------------------------->

<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: err_reqfields.cfm,v $">

<!doctype html public "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>

<head>
	<title>WorldDealer -- Required Fields</title>
	<link rel=stylesheet href="../admin.css" type="text/css">
</head>

<body>
<br><br><br><br><br>
<table border="0" cellpadding="10" cellspacing="0" bgcolor="white" align="center">
<tr align="center">
	<td>
		<h3>Oops</h3>
		Some fields were not completed in the form.
		<br>The following problems occurred:
		#Error.InvalidFields#
	</td>
</tr>
<tr align="center">
	<td>
		<a href="JavaScript:history.back();"
			onmouseover="self.status='Back';return true"
			onmouseout="self.status='';return true"><img
			src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/back.gif" border="0" width="46" height="15" name="Back" value="Back"></a>
	</td>
</tr>
</table>
</body>
</html>
<cfmodule template="/util/DumpDebug.cfm" text="end   $RCSfile: err_reqfields.cfm,v $" printtrace="true">