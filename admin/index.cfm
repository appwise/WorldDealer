<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: index.cfm,v $">
<!doctype html public "-//W3C//DTD HTML 4.0 Transitional//EN">
                        <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 11, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->            
                 <!---$Id: index.cfm,v 1.20 2000/03/03 21:53:55 lswanson Exp $--->
   
<html>

<head>
	<title>WorldDealer -- WorldDealer HomeBase Login</title>
	<link rel=stylesheet href="admin.css" type="text/css">
	
	<!--- linda, 12/14/99: attempt at making the submit button activated by the Enter key, instead of requiring a mouse click.
	<cfif goodbrowser>
		<SCRIPT LANGUAGE="JavaScript">
		// <!--// Hide from non-JavaScript browsers
		document.login.Submit.focus();
		//-->
		</script>
	</cfif>
 --->
</head>

<body>

<div align="center">

<!--- linda, 3/3/2000: keep this message for future scheduled down times.
<table width="50%">
<tr align="center">
	<td>
		<img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/wd_logo.gif" border="0" width="182" height="53">
		<br><br>
	</td>
</tr>
<tr>
	<td align="center">
		<h3>Scheduled Maintenance</h3>
	</td>
</tr>
<tr>
	<td>
		<font color="White">
		We at WorldDealer&#153; are proud to announce that Internet traffic has
		grown significantly over the past six months!
		<br><br>
		Along with this tremendous growth comes a need to expand our hosting
		capabilities.  Therefore, there will be a temporary delay in service
		starting at 4:00 PM EST Friday, March 3 and returning to full service at
		12:00 PM EST Saturday, March 4.  During this short delay in service you
		will have no access to your maintenance administration.  Your Dealership 
		Website will be off-line between the hours of 9:00 AM EST and 11:00 AM 
		EST Saturday, March 4.
		<br><br>
		As you continue to grow your online presence it is also essential for
		continued expansion of our software and server capabilities.  We
		apologize in advance for any inconvenience this may cause you and will
		be happy to assist you in any way.  We appreciate your patience and are
		committed to providing you the latest in technology and Website
		innovations.
		<br><br>
		If you have any questions please don't hesitate to contact us toll-free
		at (800) 934-6006 or via e-mail at 
		<a href="mailto:support@worlddealer.net">support@worlddealer.net</a>.
		Thank you again for your continued business with WorldDealer&#153;!
		<br><br>
		</font>
	</td>
</tr>
<tr>
	<td align="center">
		<font color="White">
		<b>The WorldDealer Team</b>
		</font>
	</td>
</tr>
</table>
 --->
 
<br><br><br><br><br><br>
<form name="login" action="login.cfm" method="POST">
<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td colspan="4"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/login_top.gif" border="0" width="342" height="11"></td>
</tr>
<tr>
	<td><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/login_left.gif" border="0" width="8" height="66"></td>
	<td colspan="2" align="right" bgcolor="black"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/login_wdlogo.gif" border="0" width="215" height="66"></td>
	<td><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/login_right.gif" border="0" width="13" height="66"></td>
</tr>
<tr>
	<td colspan="4"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/login_middle.gif" width="342" height="18" border="0"></td>
</tr>
<tr>
	<!--- rowspan of 3, so it goes all along the left side.  
	height of 150, so it doesn't break the left & right lines up with a browser font size <= 14. --->
	<td rowspan="3"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/login_left.gif" border="0" width="8" height="150"></td>
	<td bgcolor="black">&nbsp;</td>
	<td bgcolor="white"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/login_please.gif" border="0" width="215" height="62"></td>
	<td rowspan="3"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/login_right.gif" border="0" width="13" height="150"></td>
</tr>
<tr>
	<td valign="top"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/login_unpw.gif" border="0" width="106" height="47"></td>
	<td valign="top" bgcolor="white">
		<font size="-1">
		&nbsp;<input type="Text" name="Username" tabindex="1" size=15 maxlength=15>
		<br>
		&nbsp;<input type="Password" name="password" tabindex="2" size=15 maxlength=15>
		</font>
	</td>
</tr>
<tr>
	<td bgcolor="black">&nbsp;</td>
	<td bgcolor="white">&nbsp;&nbsp;<input type="image" src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/submitwhite.gif" border="0" width="67" height="15"></td>
</tr>
<tr>
	<td colspan="4"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/login_bottom.gif" border="0" width="342" height="15"></td>
</tr>
</table>
<input type="hidden" name="Username_required" value="Please enter a user name.">
<input type="hidden" name="password_required" value="Please enter your password.">
</form> 

</div>
</body>
</html>
<cfmodule template="/util/DumpDebug.cfm" text="end   $RCSfile: index.cfm,v $">