<!---
Created by Sigma6, Inc.
Copyright (c) 1998 Sigma6, Inc.
All Rights Reserved.  Used By Permission.

Sigma6, interactive media, Detroit/NYC
conceive : construct : connect
www.sigma6.com   webmaster@sigma6.com   info@sigma6.com

Last updated: <May 27, 1998>

Daniel Fettinger for sigma6, interactive media, Detroit
dfettinger@sigma6.com   www.sigma6.com    www.s6313.com
conceive : construct : connect

Sigma6, s6, and the Sigma6 logos are registered trademarks.
All other trademarks and servicemarks are the property of
their respective owners.
--->

<!--- $Id: application.cfm,v 1.21 2000/06/21 21:55:58 lswanson Exp $ --->

<!--- global DataSource Name --->
<CFSET gDSN = "WorldDlr">

<CFAPPLICATION NAME="dealercode" CLIENTMANAGEMENT="YES">


<!--- Path from the web root directory to Worlddealer root, if they're not the same --->
<!--- Linda, 10/4/00: since we don't have a wwwroot anymore, 
or because the CF settings are different, this extra /worlddealer subdir is redundant now. 
with /worlddealer, the images weren't coming in correctly; they were looking in an extra subdir of worlddealer.--->
<!--- <CFSET g_relpath = '/worlddealer'> --->
<CFSET g_relpath = ''>


<!--- s6 jturner: the "if" statement should key off of CGI.SERVER_NAME. 
 If it is equal to "montana.sigma6.net" then it's at the colo, "olympus.sigma6.com" is here.
 --->

<CFIF #CGI.SERVER_NAME# EQ "olympus.sigma6.com">
	<!--- if Olympus --->
	<!--- exception: if developer on Olympus in own CVS repository, override g_relpath & show unique g_RootDir --->
	<CFIF FindNoCase('bbickel', CGI.CF_TEMPLATE_PATH)>
   		<CFSET g_relpath = "/bbickel/worlddealer">
		<CFSET g_RootDir = "f:\wwwroot\bbickel\worlddealer">
    <CFELSEIF FindNoCase('jkrauss', CGI.CF_TEMPLATE_PATH)>
   		<CFSET g_relpath = "/jkrauss/worlddealer">
		<CFSET g_RootDir = "f:\wwwroot\jkrauss\worlddealer">
    <CFELSEIF FindNoCase('jweitz', CGI.CF_TEMPLATE_PATH)>
   		<CFSET g_relpath = "/jweitz/worlddealer">
		<CFSET g_RootDir = "f:\wwwroot\jweitz\worlddealer">
    <CFELSEIF FindNoCase('lswanson', CGI.CF_TEMPLATE_PATH)>
   		<CFSET g_relpath = "/lswanson/worlddealer">
		<CFSET g_RootDir = "f:\wwwroot\lswanson\worlddealer">
	<CFELSE>
		<CFSET g_RootDir = "e:\worlddealer"> <!--- The Worlddealer Web Root directory path --->
	</CFIF>
<cfelseif #cgi.server_name# eq "montana.sigma6.net">
	<!--- if Montana at colo --->
	<cfset g_rootdir = "e:\worlddealer"> <!--- The Worlddealer Web Root directory path --->
<!--- linda, 3/6/2000: it's not recognizing the server_name as karachi, so make it the default ELSE setting. --->
<!--- <cfelseif #cgi.server_name# eq "karachi.sigma6.net"> --->
<cfelse>
	<!--- if Karachi at colo --->
	<cfset g_rootdir = "e:\worlddealer"> <!--- The Worlddealer Web Root directory path --->
<!--- 
<cfelse>
	<!--- if laptop --->
	<CFSET g_RootDir = 'c:\InetPub\wwwroot\worlddealer'>
 --->	
</cfif>

<CFSET application.RELATIVE_PATH = g_relpath>


<!-------------------------------------------------------DEFAULT LOCATION (splash)---------------------->
<CFIF NOT IsDefined("section")>
	<CFSET section = "sp_redirect">
</CFIF>
<!-------------------------------------------------------END DEFAULT LOCATION--------------------------->
<!-------------------------------------------------------TRACK SESSION DEALERCODE----------------------->

<CFIF IsDefined("URL.dealercode")>
	<CFSET #variables.dealercode# = "#RTrim(URL.dealercode)#">
	<CFSET #client.dealercode# = "#RTrim(URL.dealercode)#">
	<CFCOOKIE NAME="dealercode" VALUE="#RTrim(URL.dealercode)#">
<CFELSE>
	<CFIF IsDefined("client.dealercode")>
		<CFSET #variables.dealercode# = "#RTrim(client.dealercode)#">
		<CFCOOKIE NAME="dealercode" VALUE="#RTrim(client.dealercode)#">
	<CFELSE>
		<CFIF IsDefined("cookie.dealercode")>
			<CFSET #variables.dealercode# = "#RTrim(cookie.dealercode)#">
			<CFSET #client.dealercode# = "#RTrim(cookie.dealercode)#">
		<CFELSE>
			<CFSET NotFound = TRUE> <!--- See below ---> 
		</CFIF>
	</CFIF>
</CFIF>

<CFIF IsDefined("NotFound")>
	<!--- Try to get the dealercode from the URL --->
	 <CFIF #getToken(CGI.http_host,3,".")# IS NOT ''>
		<!--- HTTP_HOST in the form HOSTNAME.DOMAIN.COM  --->
		<CFSET start = #Find(".",CGI.http_host,1)#>
		<CFIF start IS NOT 0>
			<!--- Remove the first part of the hostname so it's in the form DOMAIN.COM --->
			<CFSET hostname = #RemoveChars(CGI.http_host,1,start)#>
		</CFIF>
	<CFELSE>
		<!--- The URL they entered is already in the form DOMAIN.COM --->
		<CFSET hostname = #CGI.http_host#>
	</CFIF>

	<CFQUERY NAME="findDLRCode" DATASOURCE="#gDSN#">
		SELECT	DealerCode,
			  	ArtTempID
	    FROM	DealerWebs
		WHERE	DealerWebs.BaseURL = '#hostname#'
	</CFQUERY>

	<CFIF #findDLRCode.RecordCount# IS NOT 0>
		<CFSET #variables.dealercode# = "#RTrim(finddlrcode.dealercode)#">
		<CFSET #client.dealercode# = "#RTrim(findDLRcode.dealercode)#">
		<CFCOOKIE NAME="dealercode" VALUE="#RTrim(findDLRCode.dealercode)#">
		<CFSET temp = "_" & #findDLRCode.ArtTempID# & "_">
		<CFSET temp2 = "/" & #findDLRCode.ArtTempID# & "/">
		<CFSET new_path = Replace(CGI.path_info, "_1_", temp, "ONE")>
		<CFSET new_path = Replace(new_path, "_2_", temp, "ONE")>
		<CFSET new_path = Replace(new_path, "_3_", temp, "ONE")>
		<CFSET new_path = Replace(new_path, "_4_", temp, "ONE")>
		<CFSET new_path = Replace(new_path, "_5_", temp, "ONE")>
		<CFSET new_path = Replace(new_path, "_6_", temp, "ONE")>
		<CFSET new_path = Replace(new_path, "_7_", temp, "ONE")>
		<CFSET new_path = Replace(new_path, "_8_", temp, "ONE")>
		<CFSET new_path = Replace(new_path, "/1/", temp2, "ONE")>
		<CFSET new_path = Replace(new_path, "/2/", temp2, "ONE")>
		<CFSET new_path = Replace(new_path, "/3/", temp2, "ONE")>
		<CFSET new_path = Replace(new_path, "/4/", temp2, "ONE")>
		<CFSET new_path = Replace(new_path, "/5/", temp2, "ONE")>
		<CFSET new_path = Replace(new_path, "/6/", temp2, "ONE")>
		<CFSET new_path = Replace(new_path, "/7/", temp2, "ONE")>
		<CFSET new_path = Replace(new_path, "/8/", temp2, "ONE")>
		<CFSET tmpurl = "http://" & #CGI.http_host# & #new_path# & "?dealercode=" & #findDLRCode.dealercode#>
		<!--- Redirect to the correct art template, in case it has changed and someone bookmarked an old page --->
		<CFLOCATION URL="#tmpURL#">
		
	<CFELSE>
	<!--- First check against DealerURL table for secondary URL --->
		<CFQUERY NAME="findDLRCodeAlt" DATASOURCE="#gDSN#">
			SELECT	DealerWebs.DealerCode as q_DealerCode,
				  	DealerWebs.ArtTempID as q_ArtTempID
		    FROM	DealerWebs,DealerURL
			WHERE	DealerURL.URL = '#hostname#'
				AND	DealerWebs.DealerCode = DealerURL.DealerCode
		</CFQUERY>
	<!-- If recordcount is 0, then give cookie message--->
		<CFIF findDLRCodeAlt.RecordCount eq 0>
			Sorry!<BR>
			This site requires the use of cookies (client side persistent information).<BR>
			If you are seeing this message, it means that you are using a browser that
			either can not accept cookies, or that you have them disabled.  Please alter
			your preferences to allow the acceptance of cookies, or update your browser.
			<CFABORT>
	<!--- otherwise, set the dealercode variable and send them on --->
		<CFELSE>
			<CFSET #variables.dealercode# = "#RTrim(findDLRCodeAlt.q_dealercode)#">
			<CFSET #client.dealercode# = "#RTrim(findDLRCodeAlt.q_dealercode)#">
			<CFCOOKIE NAME="dealercode" VALUE="#RTrim(findDLRCodeAlt.q_dealercode)#">
	
			<CFSET temp = "_" & #findDLRCodeAlt.q_ArtTempID# & "_">
			<CFSET temp2 = "/" & #findDLRCodeAlt.q_ArtTempID# & "/">
			<CFSET new_path = Replace(CGI.path_info, "_1_", temp, "ONE")>
			<CFSET new_path = Replace(new_path, "_2_", temp, "ONE")>
			<CFSET new_path = Replace(new_path, "_3_", temp, "ONE")>
			<CFSET new_path = Replace(new_path, "_4_", temp, "ONE")>
			<CFSET new_path = Replace(new_path, "_5_", temp, "ONE")>
			<CFSET new_path = Replace(new_path, "_6_", temp, "ONE")>
			<CFSET new_path = Replace(new_path, "_7_", temp, "ONE")>
			<CFSET new_path = Replace(new_path, "_8_", temp, "ONE")>
			<CFSET new_path = Replace(new_path, "/1/", temp2, "ONE")>
			<CFSET new_path = Replace(new_path, "/2/", temp2, "ONE")>
			<CFSET new_path = Replace(new_path, "/3/", temp2, "ONE")>
			<CFSET new_path = Replace(new_path, "/4/", temp2, "ONE")>
			<CFSET new_path = Replace(new_path, "/5/", temp2, "ONE")>
			<CFSET new_path = Replace(new_path, "/6/", temp2, "ONE")>
			<CFSET new_path = Replace(new_path, "/7/", temp2, "ONE")>
			<CFSET new_path = Replace(new_path, "/8/", temp2, "ONE")>
			<CFSET tmpurl = "http://" & #CGI.http_host# & #new_path# & "?dealercode=" & #findDLRCodeAlt.q_dealercode#>
	
			<--- Redirect to the correct art template, in case is has changed and someone bookmarked an old page --->
			<CFLOCATION URL="#tmpURL#">
		</CFIF>
		
	</CFIF>
</CFIF>
<!-----------------------------------------------------END TRACK SESSION DEALERCODE----------------------->
<!-----------------------------------------------------DEALER INFORMATION--------------------------------->
<CFQUERY NAME="dealerinfo" DATASOURCE="#gDSN#">
	SELECT	*
	FROM	Dealers
	WHERE	dealercode='#variables.dealercode#';
</CFQUERY>

<CFIF #dealerinfo.recordCount# EQ 0>
	Sorry, the site you requested was not found.  Please check the URL and try again.
	<CFABORT>
</CFIF>

<!--- If Collection, set g_Col --->
<CFIF Mid(#dealerinfo.dealercode#, 6, 4) EQ '0000'>
	<CFSET g_Col = "true">
<CFELSE>
	<CFSET g_Col = "false">
</CFIF>

<CFOUTPUT>
<CFQUERY NAME="ArtTempID" DATASOURCE="#gDSN#">
	SELECT	ArtTempID,
			DealerWebID,
			CalculatorYesNo,
			webstateid
	FROM	DealerWebs
	WHERE dealercode='#variables.dealercode#'
</CFQUERY>
</cfoutput>

<CFIF #ArtTempID.webstateid# NEQ 1>
	<CFINCLUDE template="notactive.cfm">
	<CFABORT>
</CFIF>

<!-----------------------------------------------------END DEALER INFORMATION------------------------------->