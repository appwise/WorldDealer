                        <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <March 6, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->            
<!---$Id: err_widebanner.cfm,v 1.1 2000/06/22 16:33:30 jkrauss Exp $--->
   
<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: err_widebanner.cfm,v $">

<!doctype html public "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>

<head>
	<title>WorldDealer -- Insufficient Access</title>
	<link rel=stylesheet href="admin.css" type="text/css">
</head>

<body>
<br><br><br><br><br>
<table border="0" cellpadding="10" cellspacing="0" bgcolor="white" align="center">
<tr align="center">
	<td>
		<h3>Text Area is too wide.</h3>
	</td>
</tr>
<tr align="center">
	<td>
		The banner is only 400 pixels wide.<br>
		The <b>Pixels From Left</b> and <b>Text Area Width</b> must total less than 400.  
		<br><br>
		Click Back to continue in allowable areas.
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
<cfmodule template="/util/DumpDebug.cfm" text="end   $RCSfile: err_widebanner.cfm,v $" printtrace="true">