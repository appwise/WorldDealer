<cfset PageAccess = application.dealer_access>

<cfinclude template = "../security.cfm">

<cfquery name="oldTemp" datasource="#gDSN#">
	SELECT ArtTempID as OLDTemp
	FROM DealerWebs
	WHERE DealerCode = '#g_dealercode#'
</cfquery>

<cfif parameterexists(form.arttempid)>
	<CFSET arttempid = #Form.arttempid#>
<cfelseif parameterexists(url.pleasechange)>
	<CFSET arttempid = #URL.pleaseChange#>
</cfif>

<cfquery name="updateDLR" datasource="#gDSN#">
	UPDATE DealerWebs
	SET DealerWebs.ArtTempID = #arttempid#
	WHERE DealerWebs.DealerCode = '#g_dealercode#'
</cfquery>

<cfquery name="getcoupdefaults" datasource="#gDSN#">
	SELECT 	coup_textBoundsX, coup_textBoundsY, coup_textBoundsWidth, coup_textBoundsHeight
	FROM 	ArtTemplates
	WHERE 	ArtTempID = #arttempid#
</cfquery>

<cfquery name="getDealerInfo" datasource="#gDSN#">
	SELECT	DisplayName
	FROM 	Dealers 
	WHERE	DealerCode = '#g_dealercode#'
</cfquery>
	
<cfquery name="getCouponStuff" datasource="#gDSN#">
	SELECT *
	FROM VirtualCoupons
	WHERE DealerWebID = 
		(SELECT DealerWebID
		FROM DealerWebs
		WHERE DealerCode = '#g_dealercode#') AND status = 'A'
</cfquery>
<!--- LINDA: debugging imagegen 
theDebugger on = 1 
theDebugger Off = 0
--->
<cfset thedebugger=0>
<!--- add the imagegen stuff here --->	
	<cfloop query="getCouponStuff">
	
	<!--- should update each coupon so that the textbox coordinates become the template-default. --->
	<cfquery name="switchBox" datasource="#gDSN#">
		UPDATE 	VirtualCoupons
		SET 	textBoundsX = #getcoupdefaults.coup_textBoundsX#, 
				textBoundsY = #getcoupdefaults.coup_textBoundsY#, 
				textBoundsWidth = #getcoupdefaults.coup_textBoundsWidth#, 
				textBoundsHeight = #getcoupdefaults.coup_textBoundsHeight#
		WHERE 	VirtualCouponID = #VirtualCouponID#
	</cfquery>
	
	<cfquery name="getCoupType" datasource="#gDSN#">
		SELECT CouponType as CoupType
		FROM CouponTypes
		WHERE CouponTypeID = #getCouponStuff.CouponTypeID#
	</cfquery>
		
	<!--- delete the old images --->
	<cfif FileExists("#g_rootdir#/images/coupons/#g_dealercode#_#oldTemp.oldTemp#_#VirtualCouponID#_coupon.gif")>
		<cffile action="DELETE" file="#g_rootdir#/images/coupons/#g_dealercode#_#oldTemp.oldTemp#_#VirtualCouponID#_coupon.gif">
	</cfif>
		
		<cfset #textstring# = #replace(#title#, "<BR>", "~", "ALL")#>
		<!--- Bug fix for image generator.  If there is a ~ in the textstring and textstring does not start with a ~, --->
		<!--- then insert a ~ at beginning of textstring --->
		<cfif #thedebugger# equal 1>
			<cfoutput>
				<p>&nbsp;</p>
				TEST 1: textstring before: #textstring#<br>
			</cfoutput>
		</cfif>	
		
		<cfif find("~", textstring, 1) and (left(textstring, 1) is not '~')>
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
		
		<!--- create images with the new template --->
		<cfset inputpath = g_imagegen_root & '/images/blank_coupons'>
		<cfset inputfilename = 'f_' & #arttempid# & '_' & #getCoupType.CoupType# & '_coupon_blank.gif'>
		<cfset outputpath = g_rootdir & '/images/coupons'>
		<cfset outputfilename = #g_dealercode# & '_' & #arttempid# & '_' & #VirtualCouponID# & '_coupon.gif'>
		
		<cfif #thedebugger# eq 1>
			<cfoutput>
			<p>&nbsp;</p>
			TEST 3a: inside loop. ArtTemplate: #arttempid#<br>
			
			<form action="#g_imagegen#" method="POST">
				<input type="text" name="inputfilename" value="#inputPath#/#inputFilename#">
				<input type="text" name="textstring" value="#final_text#">
				<input type="text" name="fontName" value="#fontName#">
				<input type="text" name="textJustification" value="#textJustification#">
				<input type="text" name="fontSize" value="#fontSize#">
				<input type="text" name="fontStyle" value="#fontStyle#">
				<input type="text" name="textColor" value="#textColor#">
				<input type="text" name="textBoundsX" value="#textBoundsX#">
				<input type="text" name="textBoundsY" value="#textBoundsY#">
				<input type="text" name="textBoundsWidth" value="#textBoundsWidth#">
				<input type="text" name="textBoundsHeight" value="#textBoundsHeight#">
				<input type="submit">
			</form>
			</cfoutput>
		</cfif>	
		
		<cfset inputfilename="#inputPath#/#inputFilename#">
	
		<cfset myurl = "http://#g_imagegen2#/sigma6/servlet/ImageGenerator?imageFile=#inputfilename#&textString=#textstring#&fontName=#fontName#&textJustification=#xcord#&fontSize=#fontSize#&fontStyle=#fontStyle#&textColor=#fontColor#&textBoundsX=#getcoupdefaults.coup_textboundsx#&textBoundsY=#getcoupdefaults.coup_textboundsy#&textBoundsWidth=#getcoupdefaults.coup_textboundswidth#&textBoundsHeight=#getcoupdefaults.coup_textboundsheight#">
		<cfhttp method="get" url="#myurl#" port="8081" path="#outputPath#" file="#outputFilename#">
					
	</cfloop>
	
	<!--- delete old logos --->
	<cfif FileExists("#g_rootdir#/images/logo/#g_dealercode#_#oldTemp.oldTemp#_logo_hea.gif")>
		<cffile action="DELETE" file="#g_rootdir#/images/logo/#g_dealercode#_#oldTemp.oldTemp#_logo_hea.gif">
	</cfif>
	<cfif FileExists("#g_rootdir#/images/sp_logo/sp_#g_dealercode#_#oldTemp.oldTemp#_hea.gif")>
		<cffile action="DELETE" file="#g_rootdir#/images/sp_logo/sp_#g_dealercode#_#oldTemp.oldTemp#_hea.gif">
	</cfif>
	
	<!--- logos generated here --->
	<!--- JOEL:  for some reason, I couldn't include the cfmodule for genexe right here...it made the page
				time out consistently.  so I've added this design_logos page to call genexe.  it works. --->
	<cflocation url="design_logos.cfm" addtoken="No">
<!--- end of the imagegen stuff here --->
<cfif findnocase('msie', cgi.http_user_agent)>
	<script language="javascript">
	<!--
		location.replace('design.cfm');
	//-->
	</script>
<cfelse>
	<cflocation url="design.cfm" addtoken="No">

</cfif>