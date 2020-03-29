<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: index.cfm,v $">
<!doctype html public "-//W3C//DTD HTML 3.2 Final//EN">

<html>

    <!-- ----------------------------------------------------------- -->
    <!--     Bozo the Clown for sigma6, interactive media, Detroit      -->
    <!--    jturner@sigma6.com   www.sigma6.com    www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->

<head>

	<title></title>

	<cfif left("#CGI.HTTP_HOST#", 4) is "www.">
		<cfset tmphost = removechars("#CGI.HTTP_HOST#", 1, 4)>
	<cfelse>
		<cfset tmphost = "#CGI.HTTP_HOST#">
	</cfif>

	<!--- find the corresponding dealercode for the URL --->
    <cfquery name="findDLRCode" datasource="#gDSN#">
		SELECT	DealerCode
		FROM	Dealers
		WHERE	Dealers.URL = '#tmpHOST#'
	</cfquery>
	
	<cfif finddlrcode.recordcount>
		<cfset #tmpurl# = "templates/dlr/index.cfm?dealercode=#findDLRCode.DealerCode#">
		<cflocation url="#tmpURL#">
	<cfelse>
		<!--- dealercode not found for that URL; search in 2ndary URL table --->
		<cfquery name="findDLRCodeAlt" datasource="#gDSN#">
			SELECT	DealerCode
		    FROM	DealerURL
			WHERE	URL = '#tmpHOST#'
		</cfquery>
		
		<cfif finddlrcodealt.recordcount>
			<cfset #tmpurl# = "templates/dlr/index.cfm?dealercode=#findDLRCodeAlt.DealerCode#">
			<cflocation url="#tmpURL#">
		<cfelse>
			<!--- If still no URL match found, send it to default --->
			<cflocation url="http://www.worlddealer.net">
		</cfif>
	</cfif>

</head>

<body bgcolor="FFFFFF">

</body>

</html>
<cfmodule template="/util/DumpDebug.cfm" text="end   $RCSfile: index.cfm,v $">
