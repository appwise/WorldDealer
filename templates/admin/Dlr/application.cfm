<CFSETTING ENABLECFOUTPUTONLY="YES">
<!---
Created by Sigma6, Inc.
Copyright (c) 1998 Sigma6, Inc.
All Rights Reserved.  Used By Permission.

Sigma6, interactive media, Detroit/NYC
conceive : construct : connect
www.sigma6.com   webmaster@sigma6.com   info@sigma6.com

Last updated: <Aug 10, 1998>

Tim Taylor for sigma6, interactive media, Detroit
ttaylor@sigma6.com   www.sigma6.com    www.s6313.com
conceive : construct : connect

Sigma6, s6, and the Sigma6 logos are registered trademarks.
All other trademarks and servicemarks are the property of
their respective owners.
--->
<!--- $Id: application.cfm,v 1.14 2000/03/10 21:35:19 lswanson Exp $ --->

<!---
application.cfm - Dealer Admin application file
--->

<CFAPPLICATION NAME="DLRADMIN" CLIENTMANAGEMENT="yes">

<!--- <CFERROR TYPE="REQUEST" TEMPLATE="dberror.cfm" MAILTO="jturner@sigma6.com"> --->

<!--- global DataSource Name --->
<CFSET gDSN="WorldDlr">

<!------- globals -------->
<CFPARAM name="g_DealerCode" default="">
<CFPARAM name="g_CollectionID" default="">
<CFPARAM name="g_StateAbbr" default="">
<CFPARAM name="g_DealershipName" default="">

<!--- Path from the web root directory to Worlddealer root, if they're not the same --->
<CFSET g_relpath = "/worlddealer">

<CFIF #CGI.SERVER_NAME# EQ "olympus.sigma6.com">
	<!--- if Olympus --->
	<CFSET g_Host = "olympus.sigma6.com"> <!--- Host name of the Web server --->
	<CFSET g_host_ip = "olympus.sigma6.com"> <!--- On the Production Site this needs to be an IP address due to DNS problems --->
	
	<!--- exception: if developer on Olympus in own CVS repository, override g_relpath & show unique g_RootDir --->
	<CFIF FindNoCase('bbickel', CGI.CF_TEMPLATE_PATH)>
   		<CFSET g_relpath = "/bbickel/worlddealer">
		<CFSET g_RootDir = "f:\wwwroot\bbickel\worlddealer">
    <CFELSEIF FindNoCase('jkrauss', CGI.CF_TEMPLATE_PATH)>
   		<CFSET g_relpath = "/jkrauss/worlddealer">
		<CFSET g_RootDir = "f:\wwwroot\jkrauss\worlddealer">
    <CFELSEIF FindNoCase('lswanson', CGI.CF_TEMPLATE_PATH)>
   		<CFSET g_relpath = "/lswanson/worlddealer">
		<CFSET g_RootDir = "f:\wwwroot\lswanson\worlddealer">
	<CFELSE>
		<CFSET g_RootDir = "f:\wwwroot\worlddealer"> <!--- The Worlddealer Web Root directory path --->
	</CFIF>
<cfelseif #cgi.server_name# eq "montana.sigma6.net">
	<!--- if Montana at colo --->
	<cfset g_host = "montana.sigma6.net"> <!--- Host name of the Web server --->
	<cfset g_host_ip = "204.157.203.3"> <!--- On the Production Site this needs to be an IP address due to DNS problems --->
	<cfset g_rootdir = "e:\worlddealer"> <!--- The Worlddealer Web Root directory path --->
<!--- linda, 3/6/2000: it's not recognizing the server_name as karachi, so make it the default ELSE setting. --->
<!--- <cfelseif #cgi.server_name# eq "karachi.sigma6.net"> --->
<cfelse>
	<!--- if Karachi at colo --->
	<cfset g_host = "worlddealer.sigma6.net"> <!--- Host name of the Web server --->
	<cfset g_host_ip = "204.157.203.7"> <!--- On the Production Site this needs to be an IP address due to DNS problems --->
	<cfset g_rootdir = "e:\wwwroot\worlddealer"> <!--- The Worlddealer Web Root directory path --->
<!--- 	
<cfelse>
	<!--- if laptop --->
	<CFSET g_Host = "127.0.0.1"> <!--- Host name of the Web server --->
	<CFSET g_host_ip = "127.0.0.1"> <!--- On the Production Site this needs to be an IP address due to DNS problems --->
	<CFSET g_RootDir = "c:\InetPub\wwwroot\worlddealer"> <!--- The Worlddealer Web Root directory path ---> 
--->
</cfif>


<!--- <CFSET g_imagegen_root = "c:\netscape\suitespot\wwwroot"> ---> <!--- Path to ImageGenerator files --->
<CFSET g_imagegen_root = "c:/worlddealer"> <!--- Path to ImageGenerator files --->

<!--- linda, 3/6/2000: it's not recognizing the server_name as karachi, so make it the default ELSE setting. --->
<!--- <cfif #cgi.server_name# eq "olympus.sigma6.com" or 
	#cgi.server_name# eq "montana.sigma6.net" or
	#cgi.server_name# eq "karachi.sigma6.net"> --->	
	<!--- if Olympus or colo --->
	<CFSET g_imagegen = "http://204.176.48.79:8080/servlet/imagegen"> <!--- URL of the ImageGenerator --->
	<CFSET g_imagegen2 = '204.176.48.79'> <!--- Host name of the ImageGenerator --->
	<CFSET g_mapper = "http://204.176.48.79"> <!-------- Mapper location, which is Wddegen server ---->
<!--- 	
<cfelse>
	<!--- if laptop --->
	<CFSET g_imagegen = "http://127.0.0.1:8080/InetPub/wwwroot/servlet/imagegen"> <!--- URL of the ImageGenerator --->
	<CFSET g_imagegen2 = '127.0.0.1'> <!--- Host name of the ImageGenerator --->
	<CFSET g_mapper = "http://127.0.0.1"> <!-------- Mapper location ---->
</cfif>
 --->
 
<!--- (fake) constants as application variables so they are accessible to CFMODULE templates --->
<CFSET application.ROOT_DIR = g_RootDir>
<CFSET application.RELATIVE_PATH = g_relpath>
<CFSET application.IMAGEGEN_URL = g_imagegen>
<CFSET application.IMAGEGEN_HOST = g_imagegen2>
<CFSET application.IMAGEGEN_ROOT = g_imagegen_root>
<CFSET application.MAPPER_URL = g_mapper>
<CFSET application.HOST = g_Host>

<!--- access level constants --->
<CFSET application.DEALER_ACCESS=0>
<CFSET application.ACCOUNT_COORDINATOR_ACCESS=1>
<CFSET application.ACCOUNT_EXECUTIVE_ACCESS=2>
<CFSET application.SYSADMIN_ACCESS=3>

<!--- linda, 11/30/99: moved this below where application.relativepath is defined, so validerror.cfm can use it. 
But it *still* doesn't recognize the variable name.  pooh.--->
<CFERROR TYPE="VALIDATION" TEMPLATE="validerror.cfm">

<!------- queries -------->
<!---
<cfquery name="getDealerWeb"
         datasource="#gDSN#">
         SELECT DealerWebID as q_DealerWebID,
                        WebStateID as q_WebStateID,
                                BaseURL as q_BaseURL,
                                ArtTempID as q_ArtTempID,
                                OffersSetApartText as q_OffersSetApartText,
                                VehicleInqSetApartText as q_VehicleInqSetApartText,
                                ServiceInqSetApartText as q_ServiceInqSetApartText,
                                ServiceMainText as q_ServiceMainText,
                                DealerProfileMainText as q_DealerProfileMainText
           FROM DealerWebs
          WHERE DealerWebs.DealerCode = g_DealerCode
</cfquery>
--->


<CFQUERY NAME="getAcctExecs" datasource="#gDSN#">
SELECT
	AEID as q_AEID,
    FirstName as q_AEFirstName,
    LastName as q_AELastName
FROM
	AccountExecs
</CFQUERY>

<CFQUERY NAME="getAcctCoordinators" datasource="#gDSN#">
SELECT
	ACID as q_ACID,
	FirstName as q_ACFirstName,
	LastName as q_ACLastName
FROM
	AccountCoordinators
</CFQUERY>

<CFSETTING ENABLECFOUTPUTONLY="NO">