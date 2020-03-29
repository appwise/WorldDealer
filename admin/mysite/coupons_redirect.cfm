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
	<!--- $Id: coupons_redirect.cfm,v 1.13 2000/06/21 20:50:27 jkrauss Exp $ --->
	
<cfset PageAccess = application.dealer_access>
<cfinclude template = "../security.cfm">

<!--- change the <br> tags in the database to ~ so that ImageGen can put a break in the text --->
<cfset #final_title# = #replace(#Form.couponTitle#, "<BR>", "~", "ALL")#>
<cfset textstring = #urlencodedformat(final_title)#>

<!--- LINDA: debugging imagegen 
theDebugger on = 1 
theDebugger Off = 0
--->
<cfset thedebugger=0>

<!--- Coupon Redirect --->
<!--- Find the next available CouponID --->
<!--- <CFX_DIRECTORYLIST DIRECTORY="#g_rootdir#\images\coupons" --->
<!--- <CFX_DIRECTORYLIST DIRECTORY="c:\netscape\sweetspot\wwwroot\images\coupons" --->
<cfx_directorylist directory="#g_rootdir#\images\coupons" name="listCouponDirectory" sort="type ASC, name ASC">
<cfif #listcoupondirectory.recordcount#>
	<cfset max_id = 0>
	<cfloop query="listCouponDirectory">
		<cfif left(name, 4) is 'temp'>
			<cfset the_id = gettoken(name, 3, "_")>
			<cfif the_id gt max_id>
				<cfset max_id = the_id>
			</cfif>
		</cfif> 
	</cfloop>
	<cfset tmpid = max_id + 1>
<cfelse>
	<cfset tmpid = '1'>
</cfif>

<!--- Bug fix for image generator.  If there is a ~ in the textstring and textstring does not start with a ~, --->
<!--- then insert a ~ at beginning of textstring --->
<cfif #thedebugger# equal 1>
	<cfoutput>
		<p>&nbsp;</p>
		TEST 1: textstring before: #textstring#<br>
	</cfoutput>
</cfif>	

<cfif find("~", textstring, 1)
		and (left(textstring, 1) is not '~')>
	<cfset textstring2 = insert("~", textstring, 0)>
<cfelse>
	<cfset textstring2 = textstring>
</cfif>

<cfif #thedebugger# equal 1>
	<cfoutput>
		<p>&nbsp;</p>
		TEST 2a: textstring after: #textstring#<br>
		TEST 2b: textstring2 after: #textstring2#<br>		
	</cfoutput>
</cfif>	

<!--- get the current art template --->
<cfquery name="getTemplate" datasource="#gDSN#">
	SELECT ArtTempID
	FROM DealerWebs
	WHERE DealerCode = '#g_dealercode#'
</cfquery>

<!--- <cfloop query="getTemplates">
		JOEL: not making coupons for all of the templates any more.  only the current template.
		images are re-generated for new templates once they are selected --->

	<cfset inputpath = g_imagegen_root & '/images/blank_coupons'>
	<cfset inputfilename = 'f_' & #getTemplate.ArtTempID# & '_' & #form.coupontype# & '_coupon_blank.gif'>
	<cfset outputpath = g_rootdir & '/images/coupons'>
	<cfset outputfilename = 'temp_' & #getTemplate.ArtTempID# & '_' & tmpid & '_coupon.gif'>

	<cfif #thedebugger# eq 1>
		<cfoutput>
		<p>&nbsp;</p>
		TEST 3a: inside loop. ArtTemplate: #arttempid#<br>
		
		<form action="#g_imagegen#" method="POST">
			<input type="text" name="inputfilename" value="#inputPath#/#inputFilename#">
			<input type="text" name="textstring" value="#textstring#"><!--- textstring2 --->
			<input type="text" name="fontName" value="#Form.fontName#">
			<input type="text" name="textJustification" value="#Form.textJustification#">
			<input type="text" name="fontSize" value="#Form.fontSize#">
			<input type="text" name="fontStyle" value="#Form.fontStyle#">
			<input type="text" name="textColor" value="#Form.textColor#">
			<input type="text" name="textBoundsX" value="#Form.textboundsx#">
			<input type="text" name="textBoundsY" value="#Form.textboundsy#">
			<input type="text" name="textBoundsWidth" value="#Form.textboundswidth#">
			<input type="text" name="textBoundsHeight" value="#Form.textboundsheight#">
			<input type="submit">
		</form>
		</cfoutput>
	</cfif>	
		
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

	<cfset inputfilename = "#inputPath#/#inputFilename#">

	<!--- &outputImageFormat=GIF -- when added to the myurl, this will force ImageGenerator to output the image as a gif...
									which can then be transparent.  It is not currently used because jpg, which is the
									default format from ImageGenerator, is the only way to get anti-aliased text. --->
	<cfset myurl = "http://#g_imagegen2#/sigma6/servlet/ImageGenerator?imageFile=#inputfilename#&textString=#textstring#&fontName=#form.fontName#&textJustification=#form.textJustification#&fontSize=#form.fontSize#&fontStyle=#form.fontStyle#&textColor=#form.textColor#&textBoundsX=#Form.textboundsx#&textBoundsY=#Form.textboundsy#&textBoundsWidth=#Form.textboundswidth#&textBoundsHeight=#Form.textboundsheight#"> 
	<cfhttp method="get" url="#myurl#" port="8081" path="#outputPath#" file="#outputFilename#"> 

	<cfif #thedebugger# equal 1>
		<cfoutput>
		<p>&nbsp;</p>
		TEST 5a: textstring end of loop: #textstring#<br>
		TEST 5b: textstring2 end of loop: #textstring2#<br>
		</cfoutput>
	</cfif>		
	
<!--- </cfloop>
		JOEL: not making coupons for all of the templates any more.  only the current template.
		images are re-generated for new templates once they are selected --->

<!--- determine the location --->
<cfset location = "coupons_confirm.cfm?tmpid=#tmpid#&couponTitle=#textstring#&couponType=#Form.couponType#&confirm=1">

<cfset location = "#location#&FontName=#Form.FontName#&textJustification=#Form.textJustification#&fontSize=#Form.fontSize#&fontStyle=#Form.fontStyle#&textColor=#Form.textColor#&textBoundsX=#Form.textboundsx#&textBoundsY=#Form.textboundsy#&textBoundsWidth=#Form.textboundswidth#&textBoundsHeight=#Form.textboundsheight#">

<cfif form.modeop eq "modify">
	<cfset location = "#location#&modifyflag=1&couponID=#Form.couponID#">
<cfelseif form.modeop eq "new">
	<cfset location = "#location#&newflag=1">
</cfif>

<cflocation url="#location#" addtoken="no">