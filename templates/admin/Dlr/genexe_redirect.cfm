<CFSETTING ENABLECFOUTPUTONLY="YES">

   <!-- ----------------------------------------------------------- -->
   <!--              Created by Sigma6, Inc.                        -->
   <!--     Copyright (c) 1998, 1999 Sigma6, Inc.                   -->
   <!--         All Rights Reserved.  Used By Permission.           -->
   <!-- ----------------------------------------------------------- -->
   <!-- ----------------------------------------------------------- -->
   <!--           Sigma6, interactive media, Detroit/NYC            -->
   <!--               conceive : construct : connect                -->
   <!--   www.sigma6.com   webmaster@sigma6.com   info@sigma6.com   -->
   <!--                                                             -->
   <!--   Last updated: Monday, June 15, 1998                       -->
   <!-- ----------------------------------------------------------- -->
   <!--      Tim Taylor for sigma6, interactive media, Detroit      -->
   <!--    ttaylor@sigma6.com   www.sigma6.com    www.s6313.com     -->
   <!--               conceive : construct : connect                -->
   <!-- ----------------------------------------------------------- -->
   <!-- ----------------------------------------------------------- -->
   <!-- Sigma6, s6, and the Sigma6 logos are registered trademarks. -->
   <!-- All other trademarks and servicemarks are the property of   -->
   <!-- their respective owners.                                    -->
   <!-- ----------------------------------------------------------- -->
   <!--- $Id: genexe_redirect.cfm,v 1.9 2000/01/31 22:52:03 jkrauss Exp $ --->
   
   
<!---   
theDebugger on = 1 
theDebugger Off = 0
If there is an error the cfhttp that caused it will be the last one displayed.
If there are no error turn theDebugger off to stop the CFABORT 

Good Luck 
Alan L. Warchuck
(The Devil sent his minion and his name was ImageGen)
--->

<CFSET theDebugger=0>
   
<!--- It cycles through as many logo types as there are: 1 = Splash logo, 2 = LeftNav logo --->
<CFSET NUM_LOGO_TYPES = 3>
<CFSET SPLASH_LOGO_TYPE = 1>
<CFSET LEFT_LOGO_TYPE = 2>
<CFSET COL_SP_LOGO_TYPE = 3>  <!--- linda, 8/26/99: this has to be last, because CF doesn't have a CFCONTINUE 
statement, just CFBREAK, which totally breaks you out of the loop & doesn't allow you to continue on to the 
next iteration of the loop --->

<!--- just do the default banner once: 1 per dealer --->
<CFSET BannerDone = False>

<!--- required form fields --->
<CFPARAM NAME="Form.nextStep">
<CFPARAM NAME="Form.uniqueID">
<CFPARAM NAME="Form.displayName">


<!--- append FromTemplate to redirect location --->
<CFIF Find("?", Form.nextStep) EQ 0>
        <CFSET location = Form.nextStep & "?FromTemplate=genexe_redirect">
<CFELSE>
        <CFSET location = Form.nextStep & "&FromTemplate=genexe_redirect">
</CFIF>

<CFSET displayName = "#Form.displayName#">
<CFSET displayNameLength = Len(displayName)>

<CFIF #theDebugger# Equal 1>
        <CFOUTPUT>
                Displayname: #Form.displayName#<br>
        </cfoutput>
</cfif>


<!--- Default Banner with the dealership's name on it ------------------------------------------------->
<!--- this only occurs once.  Keep it out of the loop.  so we have to call imagegen code twice, who cares? --->
<CFIF #theDebugger# Equal 1>                                    
        <cfoutput>
           process 2(Creating the default banner)<BR>
        </cfoutput>             
</CFIF>
                        
<CFSET InputPath = #g_imagegen_root# & "\images\blank_banners">
<CFSET inputFilename = "f_blank1_adbanner_hea.gif">
<CFSET OutputPath = #g_RootDir# & "\images\banner">
<CFSET OutputFilename = #Form.uniqueID# & "_default_adbanner_hea.gif"> 
        
<!--- <CFIF #displayNameLength# LE 30>
        <CFSET size = 24>
        <CFSET fontname = "Times New Roman">
<CFELSE> --->
        <CFSET size = 18>
        <CFSET fontname = "Arial,Helvetica">
<!--- </CFIF> --->
        

<CFSET inputfilename = "#inputPath#/#inputFilename#">
<CFSET textstring = URLEncodedFormat(displayName)>
<CFSET fontname = URLEncodedFormat(fontname)>
<CFSET xcord = "Center">
<CFSET ycord = "Middle">
<CFSET style = "plain">
<CFSET color = "white">

<CFSET myurl = "http://#g_imagegen2#/servlet/imagegen?imagefile=#inputfilename#&text=#textstring#&fontname=#fontname#&xcord=#xcord#&ycord=#ycord#&size=#size#&style=#style#&color=#color#">
<CFHTTP METHOD="get" URL="#myurl#" PORT="8080" PATH="#outputPath#" FILE="#outputFilename#"> 

<!--- Create the Splash & Upper Left Nav Logos for all templates ------------------------------------>
<!--- select all the art templates --->
<CFQUERY NAME="selectTemplates" datasource="#gDSN#">
        SELECT
                ArtTemplates.ArtTempID as q_ArtTempID,
                ArtTemplates.Description as q_Description,
                ArtTemplates.TemplateLocation as q_TemplateLocation,
                ArtTemplates.FontName as q_FontName,
		        ArtTemplates.FontStyle as q_FontStyle,
		        ArtTemplates.FontColor as q_FontColor,
        		ArtTemplates.sp_FontSize as q_sp_FontSize,
                ArtTemplates.logo_FontSize as q_Logo_FontSize,
		        ArtTemplates.sp_YCoord as q_sp_YCoord,
        		ArtTemplates.logo_YCoord as q_logo_YCoord,
                ArtTemplates.sp_break as q_sp_break,
                ArtTemplates.logo_break as q_logo_break
        FROM
                ArtTemplates
        ORDER BY
                TemplateLocation ASC
</CFQUERY>

<!--- loop for each art template. --->
<CFLOOP QUERY="selectTemplates">

        <CFIF #theDebugger# Equal 1>
                <cfoutput>
                <P>&nbsp;</P>
                Main Loop: #q_TemplateLocation# Time(s)<BR>

                <br>Just inside loop:  What did we get???
                <BR>
                <BR>ArtTempID = #selectTemplates.q_ArtTempID#
                <BR>Description = #selectTemplates.q_Description#
                <BR>TemplateLocation = #selectTemplates.q_TemplateLocation#
                <BR>FontName = #selectTemplates.q_FontName#
                <BR>sp_FontSize = #selectTemplates.q_sp_FontSize#
                <BR>logo_FontSize = #selectTemplates.q_Logo_FontSize#
                <BR>FontStyle = #selectTemplates.q_FontStyle#
                <BR>FontColor = #selectTemplates.q_FontColor#
                <BR>sp_YCoord = #selectTemplates.q_sp_YCoord#   <!--- used for Splash Logo --->
                <BR>logo_YCoord = #selectTemplates.q_logo_YCoord#       <!--- used for upper Left Nav Logo --->
                <!--- <BR>YCoordC = #selectTemplates.q_YCoordC# --->
                <!--- <BR>DLRSplash = #selectTemplates.q_DLRSplash# --->
                <BR>sp_break = #selectTemplates.q_sp_break#             <!--- where to break the line in the Splash Logo text --->
                <BR>logo_break = #selectTemplates.q_logo_break# <!--- where to break the line in the upper Left Nav Logo text --->
                </cfoutput>
        </CFIF> 

        <!--- font settings common to all logo types --->
        <CFSET fontname = "#q_FontName#">
        <CFSET xcord = "Center">
        <CFSET style = "#q_FontStyle#">
        <CFSET color = "#q_FontColor#">

        <!--- loop for each dealer logo type: splash, splash collection, leftnav --->
        <CFLOOP FROM="1" TO="#NUM_LOGO_TYPES#" INDEX="logoType" STEP="1">
                <CFIF #theDebugger# Equal 1>
                        <cfoutput>
                                <P>
                                Sub Loop: #logoType#<BR>
                        </cfoutput>             
                </CFIF>
        
                <CFSET isOversizedDisplayName = FALSE>

                <!--- Create Splash Logo --->
                <CFIF logoType EQ SPLASH_LOGO_TYPE>
                        <CFIF #theDebugger# Equal 1>            
                                <cfoutput>
                                        process 3(Creating the Splash Logo)<BR>
                                </cfoutput>             
                        </CFIF>
                        
                        <!--- splash logo specific settings --->
                        <CFSET InputPath = #g_imagegen_root# & "\images\blank_logos">
                        <CFSET inputFilename = "f_sp_x_#q_TemplateLocation#_hea.gif">
                        <CFSET OutputPath = #g_RootDir# & "\images\sp_logo">
                        <CFSET outputFilename = "sp_#Form.uniqueID#_#q_TemplateLocation#_hea.gif">
                        <CFSET ycord = "#q_sp_YCoord#">
                                
                        <!--- check for oversized wideload --->
                        <CFIF (#displayNameLength# GT #q_sp_break#) AND (#q_sp_break# IS NOT 0)>
                                <CFSET isOversizedDisplayName = TRUE>
                                <CFSET size = #q_sp_FontSize# - 6>
                        <CFELSE>
                                <CFSET size = #q_sp_FontSize#>
                        </CFIF>
                        
                <!--- Create Left Nav Logo --->
                <CFELSEIF logoType EQ LEFT_LOGO_TYPE>
                        <CFIF #theDebugger# Equal 1>
                                <cfoutput>
                                        process 4(Creating the Upper Left Nav Logo)<BR>
                                </cfoutput>             
                        </CFIF>
                        
                        <!--- upper left nav specific font settings --->
                        <CFSET InputPath = #g_imagegen_root# & "\images\blank_logos">
                        <CFSET inputFilename = "f_x_#q_TemplateLocation#_logo_hea.gif">
                        <CFSET OutputPath = #g_RootDir# & "\images\logo">
                        <CFSET outputFilename = "#Form.uniqueID#_#q_TemplateLocation#_logo_hea.gif">
                        <CFSET ycord = "#q_logo_YCoord#">
                        
                        <!--- check for oversized wideload --->
                        <CFIF (#displayNameLength# GT #q_logo_break#) AND (#q_logo_break# IS NOT 0)>
                                <CFSET isOversizedDisplayName = TRUE>
                                <CFSET size = #q_logo_FontSize# - 4>
                        <CFELSE>
                                <CFSET size = #q_logo_FontSize#>
                        </CFIF>
                <!--- Create Collection Splash Logo --->
                <CFELSEIF logoType EQ COL_SP_LOGO_TYPE>
					<!--- only create collection splash logos for collections. --->
					<!--- 8/23/99: Not all templates have collection splash logos.  
					Couldn't get FileExists to work with a filename containing variables,
					so just create it for all templates for now.  
					There'll be some bogus logos created, but only the templates that use 
					them (i.e., Gas Station) are coded to look for collection logos. --->
					<CFIF Mid(#Form.uniqueID#, 6, 4) IS '0000'> <!--- AND FileExists(<cfoutput>f_col_sp_x_#q_TemplateLocation#_hea.gif</cfoutput>) --->
                        <CFIF #theDebugger# Equal 1>            
                                <cfoutput>
                                        process 3.5(Creating the Collection Splash Logo)<BR>
                                </cfoutput>             
                        </CFIF>
                        
                        <!--- splash logo specific settings --->
                        <CFSET InputPath = #g_imagegen_root# & "\images\blank_logos">
                        <CFSET inputFilename = "f_col_sp_x_#q_TemplateLocation#_hea.gif">
                        <CFSET OutputPath = #g_RootDir# & "\images\sp_logo">
                        <CFSET outputFilename = "col_sp_#Form.uniqueID#_#q_TemplateLocation#_hea.gif">
                        <CFSET ycord = "#q_sp_YCoord#">
                                
                        <!--- check for oversized wideload --->
                        <CFIF (#displayNameLength# GT #q_sp_break#) AND (#q_sp_break# IS NOT 0)>
                                <CFSET isOversizedDisplayName = TRUE>
                                <CFSET size = #q_sp_FontSize# - 6>
                        <CFELSE>
                                <CFSET size = #q_sp_FontSize#>
                        </CFIF>
					<CFELSE>
						<!--- if it doesn't apply, don't go thru the imagegen calls, cuz imagegen will overwrite the good logos with garbage --->
						<cfbreak>
					</CFIF>

                </CFIF>
                
                <!--- set text for image, fixing it if it's too long for image --->
                <CFSET textstring = displayName>
                <CFIF isOversizedDisplayName>
                        <CFIF #theDebugger# Equal 1>
                                <cfoutput>
                                   proc 5(fixing oversized properties)<BR>
                                </cfoutput>             
                        </CFIF>
                        
                        <!---
                        determine where to break a line following these rules:
                                1. break on a space after middle of display name
                            2. failing 1., break on the 1st space
                                3. if space found anywhere, replace space with '~'
                                4. if no space found, don't break
                        --->
                        <CFSET middle = displayNameLength / 2>
                        <CFSET pos = Find(" ", displayName, middle)>
                        <CFIF pos EQ 0>
                                <CFSET pos = Find(" ", displayName, 1)>
                        </CFIF>
                        <CFIF pos NEQ 0>
                                <CFIF #theDebugger# Equal 1>
                                        <cfoutput>
                                        proc 6 (breaking line on 1st space<BR>
                                        </cfoutput>             
                                </CFIF>
                                <!--- remove the space and insert a tilde '~' --->
                                <CFSET textstring = #Insert("~", RemoveChars(displayName, pos, 1), (pos - 1))#>
                        </CFIF>
                </CFIF>
<!--- 
                <CFIF #theDebugger# Equal 1>
                        <CFOUTPUT>
                        <FONT SIZE=-1>
                        &lt;CFHTTP METHOD="POST" URL="#g_imagegen#" Port="8080" Path="#OutputPath#" FILE="#outputFilename#"&gt;<BR>
                        &lt;CFHTTPPARAM type="formfield" name="inputfilename" value="#InputPath#\#inputFilename#"&gt;<BR>
                        &lt;CFHTTPPARAM type="formfield" name="textstring" value="#textstring#"&gt;<BR>
                        &lt;CFHTTPPARAM type="formfield" name="fontname" value="#fontname#"&gt;<BR>
                        &lt;CFHTTPPARAM type="formfield" name="xcord" value="#xcord#"&gt;<BR>
                        &lt;CFHTTPPARAM type="formfield" name="ycord" value="#ycord#"&gt;<BR>
                        &lt;CFHTTPPARAM type="formfield" name="size" value="#size#"&gt;<BR>
                        &lt;CFHTTPPARAM type="formfield" name="style" value="#style#"&gt;<BR>
                        &lt;CFHTTPPARAM type="formfield" name="color" value="#color#"&gt;<BR>
                        &lt;/CFHTTP&gt;<BR>
                        </FONT>
                        </CFOUTPUT>
                </CFIF>         
 --->
                        
                <!--- generate image --->
                <!--- Linda, 4/23/99: this used to work with CF 3.1, but a bug crept into CF 4.0 in the CFHTTP & CFHTTPPARAM 
                This may work again if CF fixes their bug!! --->
                <!--- 
                <CFHTTP METHOD="POST" URL="#g_imagegen#" PORT="8080" PATH="#OutputPath#" FILE="#outputFilename#">
                        <CFHTTPPARAM type="formfield" name="inputfilename" value="#InputPath#\#inputFilename#">
                        <CFHTTPPARAM type="formfield" name="textstring" value="#textstring#">
                        <CFHTTPPARAM type="formfield" name="fontname" value="#fontname#">
                        <CFHTTPPARAM type="formfield" name="xcord" value="#xcord#">
                        <CFHTTPPARAM type="formfield" name="ycord" value="#ycord#">
                        <CFHTTPPARAM type="formfield" name="size" value="#size#">
                        <CFHTTPPARAM type="formfield" name="style" value="#style#">
                        <CFHTTPPARAM type="formfield" name="color" value="#color#">
                </CFHTTP> --->
                
                <CFSET inputfilename = "#inputPath#/#inputFilename#">
                <CFSET textstring = URLEncodedFormat(textstring)>
                <CFSET fontname = URLEncodedFormat(fontname)>
                <CFSET xcord = "#xcord#">
                <CFSET ycord = "#ycord#">
                <CFSET size = #size#>
                <CFSET style = "#style#">
                <CFSET color = "#color#">
                                
                <CFSET myurl = "http://#g_imagegen2#/servlet/imagegen?imagefile=#inputfilename#&text=#textstring#&fontname=#fontname#&xcord=#xcord#&ycord=#ycord#&size=#size#&style=#style#&color=#color#">
                <CFIF #theDebugger# Equal 1>
                        <CFOUTPUT>
                        <BR><BR>THE REAL DEAL:<BR>&lt;CFHTTP METHOD="get" URL="#myurl#" PORT="8080" PATH="#outputPath#" FILE="#outputFilename#"&gt;<BR>
                        </CFOUTPUT>
                </CFIF>
                <CFHTTP METHOD="get" URL="#myurl#" PORT="8080" PATH="#outputPath#" FILE="#outputFilename#">
        </CFLOOP>
</CFLOOP>

<CFIF #theDebugger# Equal 1>
        <CFABORT>
</cfif> 

<CFSETTING ENABLECFOUTPUTONLY="NO">
<CFLOCATION URL="#location#" ADDTOKEN="no">