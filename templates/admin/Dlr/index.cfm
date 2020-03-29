<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

   <!-- ----------------------------------------------------------- -->
   <!--                Created by Sigma6, Inc.                      -->
   <!--     Copyright (c) 1998, 1999 Sigma6, Inc.                   -->
   <!--         All Rights Reserved.  Used By Permission.           -->
   <!-- ----------------------------------------------------------- -->
   <!-- ----------------------------------------------------------- -->
   <!--           Sigma6, interactive media, Detroit/NYC            -->
   <!--               conceive : construct : connect                -->
   <!--   www.sigma6.com   webmaster@sigma6.com   info@sigma6.com   -->
   <!--                                                             -->
   <!--   Last updated: <May 13, 1998>                              -->
   <!-- ----------------------------------------------------------- -->
   <!--     Howard Levine for sigma6, interactive media, Detroit    -->
   <!--    hlevine@sigma6.com   www.sigma6.com    www.s6313.com     -->
   <!--               conceive : construct : connect                -->
   <!-- ----------------------------------------------------------- -->
   <!-- ----------------------------------------------------------- -->
   <!-- Sigma6, s6, and the Sigma6 logos are registered trademarks. -->
   <!-- All other trademarks and servicemarks are the property of   -->
   <!-- their respective owners.                                    -->
   <!-- ----------------------------------------------------------- -->
	<!--- $Id: index.cfm,v 1.16 2000/05/18 18:27:07 lswanson Exp $ --->
<HTML>

<HEAD>
	<TITLE>WorldDealer - Dealer Administration, Login</TITLE>
	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">
	
	<!--- linda, 12/14/99: attempt at making the submit button activated by the Enter key, instead of requiring a mouse click.
	<SCRIPT LANGUAGE="JavaScript">
	// <!--// Hide from non-JavaScript browsers
	document.login.Submit.focus();
	//-->
	</SCRIPT>
 --->
</HEAD>
<BODY link="#ffcc00" vlink="#cccccc">
<br><br><br><br><br><br>
<div align="center">

<!--- linda, 3/3/2000: keep this message for future scheduled down times.
<table width="50%">
<tr>
	<td align="center">
		<font color="#ffcc00"><h3>Scheduled Maintenance</h3></font>
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
<!--- Linda, 5/18/00: taking down old admin.  Link to new.
<form name="login" action="login.cfm" method="POST">
<table border="0">
<TR>
	<TD ALIGN="CENTER" COLSPAN=2>
     	<FONT COLOR=FFFFFF>
     	<h3><b>Dealer Administration</b></h3>
     	</FONT>
  	</TD>
</TR>
<TR>
    <TD>&nbsp;</TD>
    <TD>
       	<FONT COLOR=ffcc00>
       	<B>Please Log In</B>
       	</FONT>
    </TD>
</TR>
<TR>
    <TD>
    	<FONT COLOR=FFFFFF>
       	<B>Username:</B>
       	</FONT>
    </TD>
    <TD>
		<font size="-1">
		<input type="Text" name="Username" tabindex="1">
		</font>
    </TD>
</TR>
<TR>
    <TD>
    	<FONT COLOR=FFFFFF>
	    <B>Password:</B>
    	</FONT>
    </TD>
	<TD>
		<font size="-1">
		<input type="Password" name="password" tabindex="2">
		</font>
    </TD>
<TR>
    <TD>&nbsp;</TD>
    <TD ALIGN=CENTER>
		<INPUT TYPE="image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/submit.gif" BORDER=0 width=65 height=28 tabindex="3" name="Submit" alt="Submit">
    </TD>
</TR>
</TABLE>
<input type="hidden" name="Username_required" value="Please enter a user name.">
<input type="hidden" name="password_required" value="Please enter your password.">
</FORM> 
 --->
 
<table border="0" cellpadding="0" cellspacing="0" width="50%">
<tr align="center">
	<td>
		<font color="#ffcc00"><h3>New WorldDealer Administration</h3></font>
	</td>
</tr>
<tr>
	<td>
		<font color="White">
		We have made significant improvements to the WorldDealer Administration tool.
		We trust you will find it more intuitive, more visually appealing, and, above all, easier to update your Website.
		<br>Please update your bookmarks to the 
		<a href="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/admin/index.cfm">new location</a>.
		</font>
	</td>
</tr>
<tr align="center">
	<td>
		<BR>
		<a href="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/admin/index.cfm"><img 
			src="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/continue.gif"
			width="66"
			height="15"
			border="0"
			alt="Continue"></a>
	</td>
</tr>
</table>
 
</div>
</BODY>
</HTML>
