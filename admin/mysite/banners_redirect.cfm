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
   <!--- $Id: banners_redirect.cfm,v 1.9 2000/06/22 16:33:31 jkrauss Exp $ --->

<cfset PageAccess = application.dealer_access>
<cfinclude template = "../security.cfm">

<cfset bannerx = form.textBoundsX + form.textBoundsWidth>
<cfset bannery = form.textBoundsY + form.textBoundsHeight>

<cfif bannerx gt 400>
	<cflocation url="../err_widebanner.cfm" addtoken="No">
</cfif>

<cfif bannery gt 48>
	<cflocation url="../err_tallbanner.cfm" addtoken="No">
</cfif>

<cfoutput>
<cfif isdefined("Form.ModifyFlag")>
	<cfset tmp_location="banners_confirm.cfm?modifyflag=1&bannerid=#form.bannerID#&specpromoid=#form.specpromoid#&expirationdate=#URLEncodedFormat(form.expirationdate)#&title=#URLEncodedFormat(title)#&BannerType=#form.BannerType#">
<cfelseif isdefined("Form.NewFlag")>
	<cfset tmp_location="banners_confirm.cfm?newflag=1&expirationdate=#URLEncodedFormat(form.expirationdate)#&title=#URLEncodedFormat(title)#&BannerType=#form.BannerType#">
</cfif>
<cfset tmp_inputfilename = "f_blank#form.bannertype#_adbanner_hea.gif">
<cfset tmp_textstring = "#title#">
</cfoutput>


<!--- 	
theDebugger On = 1 
theDebugger Off = 0
--->
<cfset thedebugger = 0>

<!--- Banner Redirect --->

<!--- Find the next available Temp BannerID --->
<cfx_directorylist directory="#g_rootdir#\images\banner"
		name="banner_query"
		sort="type ASC, name ASC">
		
<cfif #banner_query.recordcount# is not 0>

	<!--- Found some Temp Banners --->
	<cfset max_id = 0>
	<cfloop query="banner_query">
		<cfif #mid(name, 1, 4)# is 'temp'>
		
			<!--- Found a file starting with 'temp' --->
			<cfset the_id = #gettoken(name, 2, "_")#>
			<cfif #the_id# gt #max_id#>
				<cfset #max_id# = #the_id#>
			</cfif>
		</cfif> 
	</cfloop>
	<cfset #tmpid# = #max_id# + 1>
<cfelse>

	<!--- No temp banners found --->
	<cfset tmpid = '1'>
</cfif>

<cfset inputpath = g_imagegen_root & '/images/blank_banners'>
<cfset inputfilename = tmp_inputfilename>
<cfset outputpath = g_rootdir & '/images/banner'>
<cfset outputfilename = 'temp_#tmpid#_adbanner_hea.gif'>

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

		<cfset inputfilename = "#inputPath#/#inputFilename#">
		<cfset textstring = urlencodedformat(tmp_textstring)>
		<cfset fontname = "#form.fontname#">
		<cfset textJustification = "#form.textJustification#">
		<cfset fontsize = "#form.fontsize#">
		<cfset fontstyle = "#form.fontstyle#">
		<cfset textcolor = "#form.textcolor#">
		<cfif trim(form.textBoundsX) is not ''><cfset textBoundsX = "#form.textBoundsX#"><cfelse><cfset textBoundsX = 0></cfif>
		<cfif trim(form.textBoundsY) is not ''><cfset textBoundsY = "#form.textBoundsY#"><cfelse><cfset textBoundsY = 0></cfif>
		<cfif trim(form.textBoundsWidth) is not ''><cfset textBoundsWidth = "#form.textBoundsWidth#"><cfelse><cfset textBoundsWidth = 400></cfif>
		<cfif trim(form.textBoundsHeight) is not ''><cfset textBoundsHeight = "#form.textBoundsHeight#"><cfelse><cfset textBoundsHeight = 48></cfif>
		
		<!--- &outputImageFormat=GIF -- when added to the myurl, this will force ImageGenerator to output the image as a gif...
										which can then be transparent.  It is not currently used because jpg, which is the
										default format from ImageGenerator, is the only way to get anti-aliased text. --->
		<cfset myurl = "http://#g_imagegen2#/sigma6/servlet/ImageGenerator?imageFile=#inputfilename#&textString=#textstring#&fontName=#fontname#&textJustification=#textJustification#&fontSize=#fontsize#&fontStyle=#fontstyle#&textColor=#textcolor#&textBoundsX=#textBoundsX#&textBoundsY=#textBoundsY#&textBoundsWidth=#textBoundsWidth#&textBoundsHeight=#textBoundsHeight#">
		<cfhttp method="get" url="#myurl#" port="8081" path="#outputPath#" file="#outputFilename#"> 

<cfif #thedebugger# equal 1>
	<!--- <cflocation url="joel.cfm">
	<cfoutput>
		&lt;CFHTTP METHOD="POST" URL="#g_imagegen#" PORT="8080" PATH="#outputPath#" FILE="#outputFilename#"&gt;<br>
		&lt;CFHTTPPARAM type="formfield" name="inputfilename" value="#inputPath#\#inputFilename#"&gt;<br>
		&lt;CFHTTPPARAM type="formfield" name="textstring" value="#tmp_textstring#"&gt;<br>
		&lt;CFHTTPPARAM type="formfield" name="fontname" value="#form.fontname#"&gt;<br>
		&lt;CFHTTPPARAM type="formfield" name="size" value="#form.size#"&gt;<br>
		&lt;CFHTTPPARAM type="formfield" name="style" value="#form.style#"&gt;<br>
		&lt;CFHTTPPARAM type="formfield" name="color" value="#form.color#"&gt;<br>
		&lt;/CFHTTP&gt;<br>
	</cfoutput>
	<cfabort> --->
</cfif>

<cfoutput>
<cfset location = tmp_location & '&tmpid=' & #tmpid#>
<cflocation url="#location#&fontName=#fontname#&textJustification=#textJustification#&fontSize=#fontsize#&fontStyle=#fontstyle#&textColor=#textcolor#&textBoundsX=#textBoundsX#&textBoundsY=#textBoundsY#&textBoundsWidth=#textBoundsWidth#&textBoundsHeight=#textBoundsHeight#">
</cfoutput>