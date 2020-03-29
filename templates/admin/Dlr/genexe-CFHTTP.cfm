 <CFINCLUDE template="security.cfm"> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
    <!-- ----------------------------------------------------------- -->
    <!--                  Created by sigma6, Detroit                 -->
    <!--             Copyright (c) 1997, 1998, 1999 sigma6.          -->
    <!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->

    <!-- ----------------------------------------------------------- -->
    <!--    Howard Levine for sigma6, interactive media, Detroit     -->
    <!--    hlevine@sigma6.com   www.sigma6.com    www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
	<!--- $Id: genexe-CFHTTP.cfm,v 1.7 1999/11/29 15:36:34 lswanson Exp $ --->

        
   
     <CFIF ParameterExists(URL.dlrcode)>
	     <CFSET g_DealerCode = #URL.dlrcode#>
	<CFELSEIF ParameterExists(Form.dlrcode)>
		<CFSET g_DealerCode = #form.dlrcode#>
	</CFIF>
	
	
	     <CFQUERY NAME="getDLRName" datasource="#gDSN#">
		      SELECT Dealers.DisplayName
			    FROM Dealers
			   WHERE Dealers.Dealercode = '#g_Dealercode#'
		 </CFQUERY>

<!---    #URL.Template# is the current Art Template  (starts at Zero for default banner and maps)		--->
<!---    #URL.step# toggles between "splash" and "left"    												--->
<!---	 URL.step = splash  for Splash page Logo														--->
<!---    URL.step = left   for left menu logo  															--->
<!---	 #progress# is the current iteration of genexe.cfm												--->

<CFIF NOT IsDefined("url.template")>
	<!--- First iteration --->
	<CFSET Art_Template = 0>
	<CFSET step = 'splash'>
	<CFSET progress=1>
<CFELSE>
	<!--- Not first time --->	
	<CFSET Art_Template = #url.template#>
	<CFSET progress = url.progress + 1>
	<CFIF #url.step# EQ 'splash'>
		<CFSET #step# = 'left'>
	<CFELSE>
		<CFSET Art_Template = #url.template# + 1>
		<CFSET #step# = 'splash'>
	</CFIF>
</CFIF>

<!--- <CFIF Art_Template EQ 1 AND step EQ 'splash'>
<CFOUTPUT>#cftoken#<br>#cfid#</CFOUTPUT><CFABORT>
</CFIF>
 --->
 
<CFIF #variables.progress# GT 2 >
	<!--- Need to retreive an image from the Java Image generator host --->
	<CFSET #tmp# = #g_rootdir# & #URL.out#>
	<CFSET #dest_path# = #GetDirectoryFromPath(tmp)#>
	<CFSET #dest_file# = #GetFileFromPath(tmp)#>
	<!--- Get the new image --->
	<CFHTTP URL="http://#g_imagegen2#/imagegen#url.out#"
		METHOD="get"
		PATH="#dest_path#"
		FILE="#dest_file#">
</CFIF>


<!--- linda 4/28/99: I think what would be better is, wherever genexe-CFHTTP.cfm is called, have it only call this 
for valid templates.  Have IT call CFLOCATION webvrfy_s2 when it runs out of valid templates. --->
<!--- 4/29/99: actually, i don't see that genexe-CFHTTP.cfm is ever called!! --->
<CFIF Art_Template GT #Application.MaxTemplate#>   <!--- ALL DONE!! --->
	<CFLOCATION url="#g_relpath#/templates/admin/dlr/webvrfy_s2.cfm?dlrcode=#g_dealercode#">
</CFIF>


     <CFQUERY NAME="getTemplateInfo" datasource="#gDSN#">
              SELECT ArtTemplates.ArtTempID as q_ArtTempID,
					 ArtTemplates.Description as q_Description,
 					 ArtTemplates.TemplateLocation as q_TemplateLocation,
				  	 ArtTemplates.FontName as q_FontName,
                     ArtTemplates.FontStyle as q_FontStyle,
                     ArtTemplates.FontColor as q_FontColor,
                     ArtTemplates.sp_FontSize as q_sp_FontSize,
					 ArtTemplates.logo_FontSize as q_Logo_FontSize,
                     ArtTemplates.sp_YCoord as q_sp_YCoord,
                     ArtTemplates.logo_YCoord as q_logo_YCoord,
					 ArtTemplates.sp_break,
					 ArtTemplates.logo_break
                FROM ArtTemplates
               WHERE ArtTemplates.TemplateLocation = #Art_Template#
           </CFQUERY>
		   
		   <CFSET how_long = #Len(GetDLRName.DisplayName)#>
			
			

<SCRIPT LANGUAGE="JavaScript">
<!--
function submitevent() { parent.document.myform.submit(); }
  //-->
</SCRIPT>


<!--- This is the "location" variable which gets passed back to genexe.cfm for the iteration loop --->
<CFSET #tmp# = #g_host# & #g_relpath#>
<CFSET redirect = "http://#g_host_ip#/templates/admin/dlr/genexe.cfm?dlrcode=" & #g_dealercode# & "&step=" & #step# & "&template=" & #art_template# & "&progress=" & #progress#>

<HTML>

<HEAD>

     <TITLE><CFOUTPUT>Dealer Administration, Create Logos - #progress# of 14</CFOUTPUT></TITLE>
	 
	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>

<CFSET too_long = 0>

<CFOUTPUT>
<!--- <FORM action="http://#g_host#/templates/admin/dlr/genexe_redirect.cfm" method="post" name="myform"> --->
</CFOUTPUT>

<CFHTTP url="http://#g_host#/templates/admin/dlr/genexe_redirect.cfm" method="post">

	
<CFIF #art_template# EQ 0 AND #step# EQ 'splash'>
	<!--- FOR NOW DO NOTHING --->

	<CFLOCATION url="#redirect#" addtoken="yes">
	
	
	<!--- Need to create the static maps --->
	
<!--- 	<CFQUERY name="getMapInfo" datasource="#gDSN#">
		SELECT AddressLine1 as q_Street,
				City as q_City,
				StateAbbr as q_State,
				Zip as q_Zipcode
			FROM Dealers
			WHERE DealerCode = '#g_dealercode#';
	</CFQUERY> --->
	
	<!--- Post to the mapping script --->
<!---
	<CFHTTP method="post" url="http://#g_host#/scripts/example.pl">
	<CFHTTPPARAM name="location" type="formfield" value="#redirect#">
	<CFHTTPPARAM name="street" type="formfield" value="#getMapInfo.q_street#">
	<CFHTTPPARAM name="city" type="formfield" value="#getMapInfo.q_city#">
	<CFHTTPPARAM name="state" type="formfield" value="#getMapInfo.q_state#">
	<CFHTTPPARAM name="zipcode" type="formfield" value="#getMapInfo.q_zipcode#">
	<CFHTTPPARAM name="dealercode" type="formfield" value="#g_dealercode#">
	</CFHTTP>    --->
	<!--- The mapping script "example.pl" will redirect back to genexe.cfm --->
	
	
	<CFELSEIF #art_template# EQ '0' AND #step# EQ 'left'>
	<!--- Create default adbanner --->
	<CFSET #redirect# = #redirect# & '&out=' & '\images\banner\' & #g_dealercode# & '_default_adbanner_hea.gif'>
	<!--- <CFOUTPUT> --->
	
	<CFHTTPPARAM type="formfield" name="inputfilename" value="#g_imagegen_root#\images\blank_banners\blank_adbanner_hea.gif">
	<CFHTTPPARAM type="formfield" name="outputfilename" value="#g_imagegen_root#\images\blank_banners\#g_dealercode#_default_adbanner_hea.gif">
	<CFHTTPPARAM type="formfield" name="ycord" value="Middle">
	<CFIF #how_long# LE 35>
		<CFHTTPPARAM type="formfield" name="size" value="18">
		<CFHTTPPARAM type="formfield" name="fontname" value="Times New Roman">
	<CFELSE>
		<CFHTTPPARAM type="formfield" name="size" value="14">
		<CFHTTPPARAM type="formfield" name="fontname" value="Arial,Helvetica">
	</CFIF>
	<CFHTTPPARAM type="formfield" name="style" value="plain">
	<CFHTTPPARAM type="formfield" name="color" value="white">
	<!--- </CFOUTPUT> --->

	
<CFELSEIF #step# EQ 'splash'>

	<CFSET #redirect# = #redirect# & '&out=' & '\images\sp_logo\sp_' & #g_dealercode# & '_' & #Art_Template# & '_hea.gif'>
	<!--- <CFOUTPUT> --->
	<CFHTTPPARAM type="formfield" name="inputfilename" value="#g_imagegen_root#\images\blank_logos\sp_x_#Art_Template#_hea.gif">
	<CFHTTPPARAM type="formfield" name="outputfilename" value="#g_imagegen_root#\images\sp_logo\sp_#g_dealercode#_#Art_Template#_hea.gif">
	<CFHTTPPARAM type="formfield" name="ycord" value="#getTemplateInfo.q_sp_YCoord#">
	<CFHTTPPARAM type="formfield" name="fontname" value="#getTemplateInfo.q_FontName#">
	<CFHTTPPARAM type="formfield" name="style" value="#getTemplateInfo.q_FontStyle#">
	<CFHTTPPARAM type="formfield" name="color" value="#getTemplateInfo.q_FontColor#">
	<CFIF (#how_long# GT #GetTemplateInfo.sp_break#) AND (#GetTemplateInfo.sp_break# IS NOT 0)>
		<CFSET too_long = 1>
		<CFHTTPPARAM type="formfield" name="size" value="#Evaluate(getTemplateInfo.q_sp_FontSize / 2)#">
	<CFELSE>
		<CFHTTPPARAM type="formfield" name="size" value="#getTemplateInfo.q_sp_FontSize#">
	</CFIF>
	<!--- </CFOUTPUT> --->

<CFELSEIF #step# EQ 'left'>

	<CFSET #redirect# = #redirect# & '&out=' & '\images\logo\' & #g_dealercode# & '_' & #Art_Template# & '_logo_hea.gif'>
	<!--- <CFOUTPUT> --->
	<CFHTTPPARAM type="formfield" name="inputfilename" value="#g_imagegen_root#\images\blank_logos\x_#Art_Template#_logo_hea.gif">
	<CFHTTPPARAM type="formfield" name="outputfilename" value="#g_imagegen_root#\images\logo\#g_dealercode#_#Art_Template#_logo_hea.gif">
	<CFHTTPPARAM type="formfield" name="ycord" value="#getTemplateInfo.q_logo_YCoord#">
	<CFHTTPPARAM type="formfield" name="fontname" value="#getTemplateInfo.q_FontName#">
	<CFHTTPPARAM type="formfield" name="style" value="#getTemplateInfo.q_FontStyle#">
	<CFHTTPPARAM type="formfield" name="color" value="#getTemplateInfo.q_FontColor#">
	<CFIF (#how_long# GT #GetTemplateInfo.logo_break#) AND (#GetTemplateInfo.logo_break# IS NOT 0)>
		<CFSET too_long = 1>
		<CFHTTPPARAM type="formfield" name="size" value="#Evaluate(getTemplateInfo.q_logo_FontSize - 3)#">
	<CFELSE>
		<CFHTTPPARAM type="formfield" name="size" value="#getTemplateInfo.q_logo_FontSize#">
	</CFIF>
<!--- 	</CFOUTPUT> --->
	
</CFIF>
	
<CFIF too_long EQ 1>
	<!--- NEED TO BREAK  A LINE  --->
	<CFSET middle = #how_long# / 2>
	<CFSET #next_space# = #Find(" ",GetDLRName.DisplayName, middle)#>
	<CFIF #next_space# IS NOT 0>  <!--- Found a space --->
		<CFSET tmp = #RemoveChars(GetDLRName.DisplayName,next_space,1)#>
		<CFSET mod_DisplayName = #Insert("~",tmp,(next_space-1))#>
	<CFELSE>
		<CFSET #left_space# = #Find(" ",GetDLRName.DisplayName,1)#>
		<CFIF #left_Space# IS NOT 0>  <!--- Found a space --->
			<!--- look to the left --->
			<CFSET tmp = #RemoveChars(GetDLRName.DisplayName,left_space,1)#>
			<CFSET mod_DisplayName = #Insert("~",tmp,(left_space - 1))#>
		<CFELSE>
			<!--- Didn't find a space --->
			<CFSET mod_DisplayName = #GetDLRName.DisplayName#>
		</CFIF>
	</CFIF>
<CFELSE>
	<CFSET mod_DisplayName = #GetDLRName.DisplayName#>
</CFIF>
<!--- 
<CFOUTPUT> --->
<CFHTTPPARAM type="formfield" name="textstring" value="#URLEncodedFormat(mod_DisplayName)#">
<CFHTTPPARAM type="formfield" name="xcord" value="Center">
<CFHTTPPARAM type="formfield" name="location" value="#redirect#">
<!--- </CFOUTPUT> --->
<!--- <INPUT type="submit"> --->
</CFHTTP>

<body>
<br><br><br><br><br>
<div align="center">
<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=520 BGCOLOR="FFFFFF">
<TR><TD>&nbsp;<p></TD></TR>
<TR ALIGN="center">
<TD ALIGN="middle"><h3><FONT FACE="Arial,Helvetica">Dealer Administration - Create New Web</FONT></h3></TD></TR>
<TR><TD>&nbsp;</TD></TR>
<TR><TD ALIGN="center"><FONT FACE="Arial,Helvetica">Please wait while your custom graphic logos are being created...</FONT></TD></TR>
<TR><TD>&nbsp;</TD></TR>
<TR><TD align="center"><FONT FACE="Arial,Helvetica" size="-1"><b>Overall Progress:</b></FONT></TD></TR>
<TR><TD>&nbsp;</TD></TR>
<TR><TD ALIGN="center" valign="middle">
	<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=0 WIDTH=400>
	<CFOUTPUT>
	<TR><TD align="left" valign="middle"><IMG
						SRC="#g_relpath#/images/demosite/progress.gif"
						ALT=""
						HEIGHT=16
						WIDTH = #Evaluate ((400 / 14) * progress)#></TD></TR>
	</CFOUTPUT>
	</TABLE>
</TD></TR><TR><TD>&nbsp;</TD></TR>
<TR><TD align="center"><FONT FACE="Arial,Helvetica" SIZE="-1"><b>Creating <CFOUTPUT>#getTemplateInfo.q_description#
<CFIF #art_Template# EQ '0' AND #step# EQ 'splash'>Dealership Maps
<CFELSEIF #art_Template# EQ '0' AND #step# EQ 'left'>Default Ad Banner
<CFELSEIF #step# eq 'splash'>Splash Page Logo
<CFELSEIF #step# eq 'left'>Navigation Menu Logo
</CFIF>
</CFOUTPUT>
</b></FONT></TD></TR>
<TR><TD>&nbsp;</TD></TR></TABLE>
<p>

</div>
</BODY>
</HTML>

<CFLOCATION url="#redirect#">