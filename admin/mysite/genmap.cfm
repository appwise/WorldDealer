                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 10, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!--- $Id: genmap.cfm,v 1.11 2000/04/07 18:34:08 lswanson Exp $ --->

<!---
genmap.cfm - a module to display an interstitial page while generating maps
attributes:
    windowTitle - title for the browser window
	screenTitle - title (or heading) in the body
	nextStep - URL to redirect to when image generation is complete
--->

<!--- linda, 4/7/00: already called by calling file, *_save.cfm
<cfinclude template="../security.cfm"> --->

<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: genmap.cfm,v $">

<cfabort> <!--- Chris Wacker 11/22/2000 --->

<!doctype html public "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<title><cfoutput>#attributes.windowTitle#</cfoutput></title>
	<link rel=stylesheet href="../admin.css" type="text/css">

	<!--- required attributes --->
	<cfparam name="attributes.nextStep">
	
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
		Please wait while your <b>Custom Maps</b> are created.<br>
		This may take a minute, please be patient.<br><br>
		<i><b>Do not hit the Stop button on your browser!</b></i>
	</td>
</tr>
<tr align="center">
	<td>
		<img src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/wheelfw.gif" BORDER=0 AlT="Please be patient.">
	</td>
</tr>
</table>
</div>

<form name="myform" action="genmap_redirect.cfm" method="POST">
	<input type="hidden" name="nextStep" value="<CFOUTPUT>#attributes.nextStep#</cfoutput>">
</form>

</body>
</html>
<cfmodule template="/util/DumpDebug.cfm" text="end   $RCSfile: genmap.cfm,v $">
