                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 10, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!--- $Id: genexe_redirect.cfm,v 1.14 2000/06/22 15:50:46 jkrauss Exp $ --->
   
   
<!---   
theDebugger on = 1 
theDebugger Off = 0
If there is an error the cfhttp that caused it will be the last one displayed.
If there are no error turn theDebugger off to stop the CFABORT 

Good Luck 
Alan L. Warchuck
(The Devil sent his minion and his name was ImageGen)
Joel R. Krauss
(I second that emotion)
--->
<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: genexe_redirect.cfm,v $">

<cfset thedebugger=0>
   
<!--- It cycles through as many logo types as there are: 1 = Splash logo, 2 = LeftNav logo --->
<cfset num_logo_types = 3>
<cfset splash_logo_type = 1>
<cfset left_logo_type = 2>
<cfset col_sp_logo_type = 3>  <!--- linda, 8/26/99: this has to be last, because CF doesn't have a CFCONTINUE 
statement, just CFBREAK, which totally breaks you out of the loop & doesn't allow you to continue on to the 
next iteration of the loop --->

<!--- just do the default banner once: 1 per dealer --->
<cfset bannerdone = false>

<!--- required form fields --->
<cfparam name="Form.nextStep">
<cfparam name="Form.uniqueID">
<cfparam name="Form.displayName">

<!--- append FromTemplate to redirect location --->
<cfif find("?", form.nextstep) eq 0>
	<cfset location = form.nextstep & "?FromTemplate=genexe_redirect">
<cfelse>
	<cfset location = form.nextstep & "&FromTemplate=genexe_redirect">
</cfif>

<cfset displayname = "#Form.displayName#">
<cfset displaynamelength = len(displayname)>

<cfif #thedebugger# equal 1>
	Displayname: <cfoutput>#Form.displayName#</cfoutput><br>
</cfif>


<!--- Default Banner with the dealership's name on it -------------------------------------------------------->
<!--- this only occurs once.  Keep it out of the loop.  so we have to call imagegen code twice, who cares? --->
<cfif #thedebugger# equal 1>                                    
	process 2(Creating the default banner)<br>
</cfif>
                        
<cfset inputpath = #g_imagegen_root# & "\images\blank_banners">
<cfset inputfilename = "f_blank1_adbanner_hea.gif">
<cfset outputpath = #g_rootdir# & "\images\banner">
<cfset outputfilename = #form.uniqueid# & "_default_adbanner_hea.gif"> 

<cfset inputfilething = "#inputPath#/#inputFilename#">
<cfset textstring = urlencodedformat(displayname)>

<cfset myurl = "http://#g_imagegen2#/sigma6/servlet/ImageGenerator?imageFile=#inputfilething#&textString=#textstring#&textJustification=centered&textColor=white&fontSize=18&outputImageFormat=GIF&outputImageFormat=gif">
<cfhttp method="get" url="#myurl#" port="8081" path="#outputPath#" file="#outputFilename#"> 

<!--- Create the Splash & Upper Left Nav Logos for all templates ------------------------------------>
<!--- select all the art templates --->
<cfquery name="selectTemplates" datasource="#gDSN#">
	SELECT	*
	FROM	ArtTemplates INNER JOIN DealerWebs ON ArtTemplates.ArtTempID = DealerWebs.ArtTempID
	WHERE	DealerWebs.DealerCode = '#g_dealercode#'
</cfquery>


<!--- loop for each art template. --->
<cfloop query="selectTemplates">
	<cfif #thedebugger# equal 1>
		<cfoutput>
		<p>&nbsp;</p>
		Main Loop: #arttempid# Time(s)<br>
		
		<br>Just inside loop:  What did we get???
		<br>
		<br>ArtTempID = #selectTemplates.ArtTempID#
		<br>Description = #selectTemplates.Description#
		<br>arttempid = #selectTemplates.arttempid#
		<br>FontName = #selectTemplates.FontName#
		<br>sp_FontSize = #selectTemplates.sp_FontSize#
		<br>logo_FontSize = #selectTemplates.Logo_FontSize#
		<br>FontStyle = #selectTemplates.FontStyle#
		<br>FontColor = #selectTemplates.FontColor#
		<br>sp_YCoord = #selectTemplates.sp_YCoord#   <!--- used for Splash Logo --->
		<br>logo_YCoord = #selectTemplates.logo_YCoord#       <!--- used for upper Left Nav Logo --->
		<br>sp_break = #selectTemplates.sp_break#             <!--- where to break the line in the Splash Logo text --->
		<br>logo_break = #selectTemplates.logo_break# <!--- where to break the line in the upper Left Nav Logo text --->
		</cfoutput>
	</cfif> 
	
	<!--- font settings common to all logo types --->
	<cfset fontname = "#FontName#">
	<cfset xcord = "Center">
	<cfset style = "#FontStyle#">
	<cfset color = "#FontColor#">
	
	<!--- loop for each dealer logo type: splash, splash collection, leftnav --->
	<cfloop from="1" to="#NUM_LOGO_TYPES#" index="logoType" step="1">
	
		<cfif #thedebugger# equal 1>
			<p>
			Sub Loop: <cfoutput>#logoType#</cfoutput><br>
		</cfif>
		
		<cfset isoversizeddisplayname = false>
		
		<!--- Create Splash Logo --->
		<cfif logotype eq splash_logo_type>
			<cfif #thedebugger# equal 1>            
				process 3(Creating the Splash Logo)<br>
			</cfif>
			
			<!--- splash logo specific settings --->
			<cfset inputpath = #g_imagegen_root# & "\images\blank_logos">
			<cfset inputfilename = "f_sp_x_#arttempid#_hea.gif">
			<cfset outputpath = #g_rootdir# & "\images\sp_logo">
			<cfset outputfilename = "sp_#Form.uniqueID#_#arttempid#_hea.gif">
			<cfset textAlign = #sp_textAlign#>
			<cfset fontSize = #sp_fontSize#>
			<cfset textColor = #sp_textColor#>
			<cfset textBoundsX = #sp_textBoundsX#>
			<cfset textBoundsY = #sp_textBoundsY#>
			<cfset textBoundsWidth = #sp_textBoundsWidth#>
			<cfset textBoundsHeight = #sp_textBoundsHeight#>
			
			<!--- check for oversized wideload
			<cfif (#displaynamelength# gt #sp_break#) and (#sp_break# is not 0)>
				<cfset isoversizeddisplayname = true>
				<cfset size = #sp_fontsize# - 6>
			<cfelse>
				<cfset size = #sp_fontsize#>
			</cfif> --->

		<!--- Create Left Nav Logo --->
		<cfelseif logotype eq left_logo_type>
		   <cfif #thedebugger# equal 1>
				process 4(Creating the Upper Left Nav Logo)<br>
		   </cfif>
		   
		   <!--- upper left nav specific font settings --->
			<cfset inputpath = #g_imagegen_root# & "\images\blank_logos">
			<cfset inputfilename = "f_x_#arttempid#_logo_hea.gif">
			<cfset outputpath = #g_rootdir# & "\images\logo">
			<cfset outputfilename = "#Form.uniqueID#_#arttempid#_logo_hea.gif">
			<cfset textAlign = #logo_textAlign#>
			<cfset fontSize = #logo_fontSize#>
			<cfset textColor = #logo_textColor#>
			<cfset textBoundsX = #logo_textBoundsX#>
			<cfset textBoundsY = #logo_textBoundsY#>
			<cfset textBoundsWidth = #logo_textBoundsWidth#>
			<cfset textBoundsHeight = #logo_textBoundsHeight#>
		   
		   <!--- check for oversized wideload
		   <cfif (#displaynamelength# gt #logo_break#) and (#logo_break# is not 0)>
				<cfset isoversizeddisplayname = true>
				<cfset size = #logo_fontsize# - 4>
		   <cfelse>
				<cfset size = #logo_fontsize#>
		   </cfif> --->
		<!--- Create Collection Splash Logo --->
		<cfelseif logotype eq col_sp_logo_type>
			<!--- only create collection splash logos for collections. --->
			<!--- 8/23/99: Not all templates have collection splash logos.  
			Couldn't get FileExists to work with a filename containing variables,
			so just create it for all templates for now.  
			There'll be some bogus logos created, but only the templates that use 
			them (i.e., Gas Station) are coded to look for collection logos. --->
			<cfif mid(#form.uniqueid#, 6, 4) is '0000'> <!--- AND FileExists(<cfoutput>f_col_sp_x_#arttempid#_hea.gif</cfoutput>) --->
				<cfif #thedebugger# equal 1>            
					process 3.5(Creating the Collection Splash Logo)<br>
				</cfif>
				
				<!--- splash logo specific settings --->
				<cfset inputpath = #g_imagegen_root# & "\images\blank_logos">
				<cfset inputfilename = "f_col_sp_x_#arttempid#_hea.gif">
				<cfset outputpath = #g_rootdir# & "\images\sp_logo">
				<cfset outputfilename = "col_sp_#Form.uniqueID#_#arttempid#_hea.gif">
				<cfset textAlign = #sp_textAlign#>
				<cfset fontSize = #sp_fontSize#>
				<cfset textColor = #sp_textColor#>
			<cfset textBoundsX = #sp_textBoundsX#>
			<cfset textBoundsY = #sp_textBoundsY#>
			<cfset textBoundsWidth = #sp_textBoundsWidth#>
			<cfset textBoundsHeight = #sp_textBoundsHeight#>
				        
				<!--- check for oversized wideload
				<cfif (#displaynamelength# gt #sp_break#) and (#sp_break# is not 0)>
					<cfset isoversizeddisplayname = true>
					<cfset size = #sp_fontsize# - 6>
				<cfelse>
					<cfset size = #sp_fontsize#>
				</cfif> --->
			<cfelse>
				<!--- if it doesn't apply, don't go thru the imagegen calls, cuz imagegen will overwrite the good logos with garbage --->
				<cfbreak>
			</cfif>
		</cfif>
	        
		<!--- set text for image, fixing it if it's too long for image --->
		<cfset textstring = displayname>
		<cfif isoversizeddisplayname>
			<cfif #thedebugger# equal 1>
				proc 5(fixing oversized properties)<br>
			</cfif>
			
			<!---
				determine where to break a line following these rules:
				1. break on a space after middle of display name
				2. failing 1., break on the 1st space
				3. if space found anywhere, replace space with '~'
				4. if no space found, don't break
			--->
			<cfset middle = displaynamelength / 2>
			<cfset pos = find(" ", displayname, middle)>
			<cfif pos eq 0>
				<cfset pos = find(" ", displayname, 1)>
			<cfelse>
				<cfif #thedebugger# equal 1>
					proc 6 (breaking line on 1st space<br>
				</cfif>
				<!--- remove the space and insert a tilde '~'
				<cfset textstring = #insert("~", removechars(displayname, pos, 1), (pos - 1))#> --->
			</cfif>
		</cfif>
        
        <cfset inputfilename = "#inputPath#/#inputFilename#">
        <cfset textstring = urlencodedformat(textstring)>
                        
        <cfset myurl = "http://#g_imagegen2#/sigma6/servlet/ImageGenerator?imageFile=#inputfilename#&textString=#textstring#&fontName=#fontName#&fontSize=#fontSize#&textColor=#textColor#&textJustification=#textAlign#&textBoundsX=#textBoundsX#&textBoundsY=#textBoundsY#&textBoundsWidth=#textBoundsWidth#&textBoundsHeight=#textBoundsHeight#">
        <cfif #thedebugger# equal 1>
			<cfoutput>
			<br><br>THE REAL DEAL:<br>&lt;CFHTTP METHOD="get" URL="#myurl#" PORT="8081" PATH="#outputPath#" FILE="#outputFilename#"&gt;<br>
			</cfoutput>
        </cfif>
		<cfhttp method="get" url="#myurl#" port="8081" path="#outputPath#" file="#outputFilename#">
	</cfloop>
</cfloop>

<cfif #thedebugger# equal 1>
	where we at, yo? location is <cfoutput>'#location#'</cfoutput>
</cfif> 

<cflocation url="#location#" addtoken="yes">

<cfmodule template="/util/DumpDebug.cfm" text="end   $RCSfile: genexe_redirect.cfm,v $">
