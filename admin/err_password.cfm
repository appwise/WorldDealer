                        <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 11, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->            
<!---$Id: err_password.cfm,v 1.2 2000/04/10 21:34:19 lswanson Exp $--->

<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: err_password.cfm,v $">

<!doctype html public "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>

<head>
	<title>WorldDealer -- Invalid Password</title>
	<link rel=stylesheet href="admin.css" type="text/css">
</head>

<body>
<br><br><br><br><br>
<table border="0" cellpadding="10" cellspacing="0" bgcolor="white" align="center">
<tr align="center">
	<td>
		<h3>WorldDealer HomeBase</h3>
	</td>
</tr>
<tr align="center">
	<td>
		<b>Authorization Failed!</b>
		<br><br>
		You have entered an invalid password.
		<br>
		Please contact your system administrator for assistance.
		<p>
		Click <b>Back</b> to try again.
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
<cfmodule template="/util/DumpDebug.cfm" text="end   $RCSfile: err_password.cfm,v $" printtrace="true">
