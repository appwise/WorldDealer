                        <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 11, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->            
                                    <!---$Id: template.cfm,v 1.23 2000/03/10 21:14:57 lswanson Exp $--->

<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: template.cfm,v $">
<cfinclude template="security.cfm">

<!doctype html public "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<title>World Dealer Site Template</title>
	<link rel=stylesheet href="../admin.css" type="text/css">
</head>

<body bgcolor="White" marginheight=0 marginwidth=0 leftmargin=0 topmargin=0 link="#FFCC00" vlink="#FFCC00">

<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="Black">
<tr>
	<td bgcolor="Black"><cfinclude template="topnav.cfm"></td>
</tr>
<tr>
	<td bgcolor="Black">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<!--- set the dir variable, used to determine which sections' files to include --->
		<cfif findnocase('home', cgi.cf_template_path)>
			<cfset dir = 'home'>
		<cfelseif findnocase('mysite', cgi.cf_template_path)>
			<cfset dir = 'mysite'>
		<cfelseif findnocase('reports', cgi.cf_template_path)>
			<cfset dir = 'reports'>
		<cfelseif findnocase('help', cgi.cf_template_path)>
			<cfset dir = 'help'>
		<cfelseif findnocase('news', cgi.cf_template_path)>
			<cfset dir = 'news'>
		<cfelseif findnocase('account', cgi.cf_template_path)>
			<cfset dir = 'account'>
		<cfelse>
			<cfset dir = '.'>
		</cfif>

		<td width="150" valign="TOP">
			<cfinclude template="#dir#/leftnav.cfm">
		</td>
		<td width="100%" valign="TOP" bgcolor="White">
			<cfinclude template="titlebar.cfm">
			<cfinclude template="#dir#/#section#_main.cfm">
 		</td>
		<td width="131" valign="TOP">
			<cfinclude template="rightnav.cfm">
		</td>
	</tr>
	</table>
	</td>
</tr>
<tr>
	<td bgcolor="Black" height="5"></td>
</tr>
</table>

</body>
</html>
<cfmodule template="/util/DumpDebug.cfm" text="end   $RCSfile: template.cfm,v $" printtrace=true> 