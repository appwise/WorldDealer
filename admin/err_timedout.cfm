                        <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <February 29, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->            
<!---$Id: err_timedout.cfm,v 1.3 2000/04/10 21:34:19 lswanson Exp $--->
   
<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: err_timedout.cfm,v $">

<!doctype html public "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>

<head>
	<title>WorldDealer -- Session Timed Out</title>
	<link rel=stylesheet href="admin.css" type="text/css">
</head>

<body>
<br><br><br><br><br>
<table border="0" cellpadding="10" cellspacing="0" bgcolor="white" align="center">
<tr align="center">
	<td>
		<h3>Session Timed Out</h3>
	</td>
</tr>
<tr align="center">
	<td>
		Click Continue to Log In again.
	</td>
</tr>
<tr align="center">
	<td>
		<a href="index.cfm"><img 
			src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/continue.gif" border="0" width="66" height="15" alt="Continue"></a>
	</td>
</tr>
</table>
</body>
</html>
<cfmodule template="/util/DumpDebug.cfm" text="end   $RCSfile: err_timedout.cfm,v $" printtrace="true">