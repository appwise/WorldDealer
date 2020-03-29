                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 17, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: login_main.cfm,v 1.7 2000/06/15 17:11:20 jkrauss Exp $ --->
<!--- Home: Login --->

<form name="login" action="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/admin/login.cfm" method="POST">
<div align="center">
<table border="0" cellspacing="0" cellpadding="5">
<tr>
    <td>&nbsp;</td>
    <td><h4>Please Log In</h4></td>
</tr>
<tr>
    <td><b>Username:</b></td>
    <td>
		<font size="-1">
		<input type="Text" name="Username" tabindex="1">
		</font>
    </td>
</tr>
<tr>
    <td><b>Password:</b></td>
	<td>
		<font size="-1">
		<input type="Password" name="password" tabindex="2">
		</font>
    </td>
<tr>
    <td>&nbsp;</td>
    <td align=center>
	<input type="image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/submitwhite.gif" BORDER=0 width=65 height=15 tabindex="3" name="Submit" alt="Submit">
    </td>
</tr>
</table>
</div>
<input type="hidden" name="Username_required" value="Please enter a user name.">
<input type="hidden" name="password_required" value="Please enter your password.">
</form>