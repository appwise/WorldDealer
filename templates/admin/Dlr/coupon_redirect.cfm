<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

   <!-- ----------------------------------------------------------- -->
   <!--     Created by Sigma6, Inc.                                 -->
   <!--     Copyright (c) 1998, 1999 Sigma6, Inc.                   -->
   <!--         All Rights Reserved.  Used By Permission.           -->
   <!-- ----------------------------------------------------------- -->
   <!-- ----------------------------------------------------------- -->
   <!--           Sigma6, interactive media, Detroit/NYC            -->
   <!--               conceive : construct : connect                -->
   <!--   www.sigma6.com   webmaster@sigma6.com   info@sigma6.com   -->
   <!--                                                             -->
   <!--   Last updated: 4/23/1999                                   -->
   <!-- ----------------------------------------------------------- -->
   <!--    Michael Bailey for sigma6, interactive media, Detroit    -->
   <!--    mbailey@sigma6.com   www.sigma6.com    www.s6313.com     -->
   <!--               conceive : construct : connect                -->
   <!-- ----------------------------------------------------------- -->
   <!-- ----------------------------------------------------------- -->
   <!-- Sigma6, s6, and the Sigma6 logos are registered trademarks. -->
   <!-- All other trademarks and servicemarks are the property of   -->
   <!-- their respective owners.                                    -->
   <!-- ----------------------------------------------------------- -->
	<!--- $Id: coupon_redirect.cfm,v 1.6 1999/11/29 16:34:03 lswanson Exp $ --->

<!--- LINDA: debugging imagegen 
theDebugger on = 1 
theDebugger Off = 0
--->
<CFSET theDebugger=0>

<!--- Coupon Redirect --->
<!--- Find the next available CouponID --->
<!--- <CFX_DIRECTORYLIST DIRECTORY="#g_rootdir#\images\coupons" --->
<!--- <CFX_DIRECTORYLIST DIRECTORY="c:\netscape\sweetspot\wwwroot\images\coupons" --->
<CFX_DIRECTORYLIST DIRECTORY="#g_rootdir#\images\coupons"
NAME="listCouponDirectory"
SORT="type ASC, name ASC">
<CFIF #listCouponDirectory.RecordCount# IS NOT 0>
	<CFSET max_id = 0>
	<CFLOOP query="listCouponDirectory">
		<CFIF Left(name, 4) IS 'temp'>
			<CFSET the_ID = GetToken(name, 3, "_")>
			<CFIF the_ID GT max_ID>
				<CFSET max_ID = the_ID>
			</CFIF>
		</CFIF> 
	</CFLOOP>
	<CFSET tmpID = max_ID + 1>
<CFELSE>
	<CFSET tmpID = '1'>
</CFIF>

<!--- Bug fix for image generator.  If there is a ~ in the textstring and textstring does not start with a ~, --->
<!--- then insert a ~ at beginning of textstring --->
<CFIF #theDebugger# Equal 1>
	<cfoutput>
		<P>&nbsp;</P>
		TEST 1: textstring before: #Form.textstring#<BR>
	</cfoutput>
</CFIF>	

<CFIF Find("~", Form.textstring, 1)
		AND (Left(Form.textstring, 1) IS NOT '~')>
	<CFSET textstring2 = Insert("~", Form.textstring, 0)>
<CFELSE>
	<CFSET textstring2 = Form.textstring>
</CFIF>

<CFIF #theDebugger# Equal 1>
	<cfoutput>
		<P>&nbsp;</P>
		TEST 2a: textstring after: #Form.textstring#<BR>
		TEST 2b: textstring2 after: #textstring2#<BR>		
	</cfoutput>
</CFIF>	

<!--- loop for all the template types --->
<CFQUERY NAME="getTemplates" datasource="#gDSN#">
	SELECT	ArtTempID,
			TemplateLocation
    FROM	ArtTemplates
</CFQUERY>

<CFLOOP query="getTemplates">

	<CFSET inputPath = g_imagegen_root & '/images/blank_coupons'>
	<CFSET inputFilename = 'f_' & #TemplateLocation# & '_' & Form.couponType & '_coupon_blank.gif'>
	<CFSET outputPath = g_RootDir & '/Images/Coupons'>
	<CFSET outputFilename = 'temp_' & #TemplateLocation# & '_' & tmpID & '_coupon.gif'>

	<CFIF #theDebugger# EQ 1>
		<CFOUTPUT>
		<P>&nbsp;</P>
		TEST 3a: inside loop. ArtTemplate: #TemplateLocation#<BR>
		
		<FORM ACTION="#g_imagegen#" METHOD="POST">
			<INPUT type="text" name="inputfilename" value="#inputPath#/#inputFilename#">
			<INPUT type="text" name="textstring" value="#textstring2#">
			<INPUT type="text" name="fontname" value="#Form.fontname#">
			<INPUT type="text" name="xcord" value="#Form.xcord#">
			<INPUT type="text" name="ycord" value="#Form.ycord#">
			<INPUT type="text" name="size" value="#Form.size#">
			<INPUT type="text" name="style" value="#Form.style#">
			<INPUT type="text" name="color" value="#Form.color#">
			<INPUT TYPE="submit">
		</FORM>
		</cfoutput>
	</CFIF>	
		
<!--- XXX: commented out image creation for now --->
<!--- Linda, 4/23/99: this used to work with CF 3.1, but a bug crept into CF 4.0 in the CFHTTP & CFHTTPPARAM, where it duplicates the data.
i.e. data in: text.  data out: text,text. 
This may work again if CF fixes their bug!! --->
<!--- send a post request to the image generator. Any form variables that are already defined are also sent. --->
<!---  	<CFHTTP METHOD="POST" URL="#g_imagegen#" PATH="#outputPath#" PORT="8080" FILE="#outputFilename#">
 		<CFHTTPPARAM type="formfield" name="inputfilename" value="#inputPath#/#inputFilename#">
		<CFHTTPPARAM type="formfield" name="textstring" value="#textstring2#">
		<CFHTTPPARAM type="formfield" name="fontname" value="#Form.fontname#">
		<CFHTTPPARAM type="formfield" name="xcord" value="#Form.xcord#">
		<CFHTTPPARAM type="formfield" name="ycord" value="#Form.ycord#">
		<CFHTTPPARAM type="formfield" name="size" value="#Form.size#">
		<CFHTTPPARAM type="formfield" name="style" value="#Form.style#">
		<CFHTTPPARAM type="formfield" name="color" value="#Form.color#"> --->

	<CFSET p1="#inputPath#/#inputFilename#">
	<!--- <CFSET p2=URLEncodedFormat(textstring2)> linda, 5/5/99: this ends up putting URLcodes into the text: BAD BAD!!--->
	<CFSET p2="#textstring2#">
	<CFSET p3=URLEncodedFormat(Form.fontname)>
	<CFSET p4="#Form.xcord#">
	<CFSET p5="#Form.ycord#">
	<CFSET p6="#Form.size#">
	<CFSET p7="#Form.style#">
	<CFSET p8="#Form.color#">

	<CFSET myurl = "http://#g_imagegen2#/servlet/imagegen?imagefile=#p1#&text=#p2#&fontname=#p3#&xcord=#p4#&ycord=#p5#&size=#p6#&style=#p7#&color=#p8#"> 
	<CFHTTP METHOD="get" URL="#myurl#" PORT="8080" PATH="#outputPath#" FILE="#outputFilename#"> 

	<CFIF #theDebugger# Equal 1>
		<cfoutput>
		<P>&nbsp;</P>
		TEST 5a: textstring end of loop: #Form.textstring#<BR>
		TEST 5b: textstring2 end of loop: #textstring2#<BR>		
		</cfoutput>
	</CFIF>		
	
</CFLOOP>

<!--- determine the location --->
<CFSET location = "webnew_s10.cfm?dlrcode=#URL.dlrcode#&tmpid=#tmpid#&couponTitle=#Form.textstring#&couponType=#Form.couponType#&confirm=1">
<CFIF IsDefined("Form.ModifyFlag")>
	<CFSET location = "#location#&modifyflag=1&couponID=#Form.couponID#">
<CFELSEIF IsDefined("Form.NewFlag")>
	<CFSET location = "#location#&newflag=1">
</CFIF>
<CFLOCATION URL="#location#" addtoken="no">