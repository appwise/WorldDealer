                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 10, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!--- $Id: genexe.cfm,v 1.16 2000/06/01 16:40:01 jkrauss Exp $ --->

<!---
genexe.cfm - a module to display an interstitial page while generating logos and maps
attributes:
    windowTitle - title for the browser window
	screenTitle - title (or heading) in the body
	nextStep - URL to redirect to when image generation is complete
	uniqueID - string to prepend on logo and banner filenames to make them unique
	displayName - string to display on logos
--->

<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: genexe.cfm,v $">
<!--- linda, 4/7/00: already called by calling file, *_save.cfm
<cfinclude template="../security.cfm"> --->

<!doctype html public "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>

<head>
	<title><cfoutput>#attributes.windowTitle#</cfoutput></title>
	<link rel=stylesheet href="../admin.css" type="text/css">

	<!--- required attributes --->
	<cfparam name="attributes.uniqueID">
	<cfparam name="attributes.nextStep">
	<cfparam name="attributes.displayName">

	<!--- optional attributes --->
	<cfparam name="attributes.windowTitle" default="Default Window Title">
	<cfparam name="attributes.screenTitle" default="Default Screen Title">

	<!--- <cfif goodbrowser> --->
		<script language="JavaScript">
		<!--
		function submitevent() { parent.document.myform.submit(); }
		//-->
		</script>
	<!--- </cfif> --->
</head>

<body OnLoad="submitevent();">
<br><br><br><br><br>
<div align="center">

<table border=0 cellpadding=10 cellspacing=0 bgcolor="FFFFFF">
<tr align="center">
	<!--- display wizard title and subtitle --->
	<td>
		<h3><cfoutput>#attributes.screenTitle#</cfoutput></h3>
	</td>
</tr>
<tr align="center">
	<td>
		Please wait while your <b>custom logos</b> are created.<br>
		This may take a minute; please be patient.<br><br>
		<i><b>Do not hit the Stop button on your browser!</b></i>
	</td>
</tr>
<tr align="center">
	<td>
		<img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/wheelfw.gif" BORDER=0 AlT="Please be patient.">
	</td>
</tr>
</table>
</div>

<form name="myform" action="genexe_redirect.cfm" method="post">
	<input type="hidden" name="nextStep" value="<cfoutput>#attributes.nextStep#</cfoutput>">
	<input type="hidden" name="uniqueID" value="<cfoutput>#attributes.uniqueID#</cfoutput>">
	<input type="hidden" name="displayName" value="<cfoutput>#attributes.displayName#</cfoutput>">
</form>

</body>
</html>
<cfmodule template="/util/DumpDebug.cfm" text="end   $RCSfile: genexe.cfm,v $">
