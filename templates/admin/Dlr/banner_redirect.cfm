<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

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
   <!--   Last updated:                Monday, May 18, 1998         -->
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
   <!--- $Id: banner_redirect.cfm,v 1.6 1999/11/29 16:34:03 lswanson Exp $ --->

<!--- 	
theDebugger on = 1 
theDebugger Off = 0
--->

<CFSET theDebugger = 0>

<!--- Banner Redirect --->

<!--- Find the next available Temp BannerID --->
<CFX_DIRECTORYLIST DIRECTORY="#g_rootdir#\images\banner"
		NAME="banner_query"
		SORT="type ASC, name ASC">
		
<CFIF #banner_query.recordcount# IS NOT 0>

	<!--- Found some Temp Banners --->
	<CFSET max_id = 0>
	<CFLOOP query="banner_query">
		<CFIF #Mid(name, 1, 4)# IS 'temp'>
		
			<!--- Found a file starting with 'temp' --->
			<CFSET the_ID = #GetToken(name, 2, "_")#>
			<CFIF #the_ID# GT #max_ID#>
				<CFSET #max_ID# = #the_ID#>
			</CFIF>
		</CFIF> 
	</CFLOOP>
	<CFSET #tmpID# = #max_ID# + 1>
<CFELSE>

	<!--- No temp banners found --->
	<CFSET tmpID = '1'>
</CFIF>

<CFSET inputPath = g_imagegen_root & '/images/blank_banners'>
<CFSET inputFilename = form.inputfilename>
<CFSET outputPath = g_RootDir & '/images/banner'>
<CFSET outputFilename = 'temp_#tmpID#_adbanner_hea.gif'>

<!---
	<CFHTTPPARAM type="formfield" name="location" value="#location#">
	<CFHTTPPARAM type="formfield" name="outputfilename" value="#g_imagegen_root#\Images\Blank_Banners\temp_#tmpID#_adbanner_hea.gif">
--->

<!--- generate image --->
<!--- Linda, 4/23/99: this used to work with CF 3.1, but a bug crept into CF 4.0 in the CFHTTP & CFHTTPPARAM 
This may work again if CF fixes their bug!! --->
<!--- 
<CFHTTP METHOD="POST" URL="#g_imagegen#" PORT="8080" PATH="#outputPath#" FILE="#outputFilename#">
	<CFHTTPPARAM type="formfield" name="inputfilename" value="#inputPath#/#inputFilename#">
	<CFHTTPPARAM type="formfield" name="textstring" value="#form.textstring#">
	<CFHTTPPARAM type="formfield" name="fontname" value="#Form.fontname#">
	<CFHTTPPARAM type="formfield" name="xcord" value="#Form.xcord#">
	<CFHTTPPARAM type="formfield" name="ycord" value="#Form.ycord#">
	<CFHTTPPARAM type="formfield" name="size" value="#Form.size#">
	<CFHTTPPARAM type="formfield" name="style" value="#Form.style#">
	<CFHTTPPARAM type="formfield" name="color" value="#Form.color#">
</CFHTTP>
--->

		<CFSET inputfilename = "#inputPath#/#inputFilename#">
		<CFSET textstring = URLEncodedFormat(form.textstring)>
		<CFSET fontname = URLEncodedFormat(form.fontname)>
		<CFSET xcord = "#form.xcord#">
		<CFSET ycord = "#form.ycord#">
		<CFSET size = "#form.size#">
		<CFSET style = "#form.style#">
		<CFSET color = "#form.color#">
		
		<CFSET myurl = "http://#g_imagegen2#/servlet/imagegen?imagefile=#inputfilename#&text=#textstring#&fontname=#fontname#&xcord=#xcord#&ycord=#ycord#&size=#size#&style=#style#&color=#color#">
		<CFHTTP METHOD="get" URL="#myurl#" PORT="8080" PATH="#outputPath#" FILE="#outputFilename#"> 

<CFIF #theDebugger# Equal 1>
	<CFOUTPUT>
		&lt;CFHTTP METHOD="POST" URL="#g_imagegen#" PORT="8080" PATH="#outputPath#" FILE="#outputFilename#"&gt;<BR>
		&lt;CFHTTPPARAM type="formfield" name="inputfilename" value="#inputPath#\#inputFilename#"&gt;<BR>
		&lt;CFHTTPPARAM type="formfield" name="textstring" value="#form.textstring#"&gt;<BR>
		&lt;CFHTTPPARAM type="formfield" name="fontname" value="#form.fontname#"&gt;<BR>
		&lt;CFHTTPPARAM type="formfield" name="xcord" value="#form.xcord#"&gt;<BR>
		&lt;CFHTTPPARAM type="formfield" name="ycord" value="#form.ycord#"&gt;<BR>
		&lt;CFHTTPPARAM type="formfield" name="size" value="#form.size#"&gt;<BR>
		&lt;CFHTTPPARAM type="formfield" name="style" value="#form.style#"&gt;<BR>
		&lt;CFHTTPPARAM type="formfield" name="color" value="#form.color#"&gt;<BR>
		&lt;/CFHTTP&gt;<BR>
	</CFOUTPUT>
	<CFABORT>
</cfif>

<CFOUTPUT>
<CFSET location = form.location & '&tmpid=' & #tmpid#>
<CFLOCATION URL="#location#&FontName=#URLEncodedFormat(Form.FontName)#&XCord=#Form.XCord#&YCord=#Form.YCord#&FontSize=#Form.Size#&FontStyle=#Form.Style#&FontColor=#Form.Color#">
</cfoutput>