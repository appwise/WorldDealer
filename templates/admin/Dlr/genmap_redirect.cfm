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
   <!--   Last updated: April 30, 1999                              -->
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
   <!--- $Id: genmap_redirect.cfm,v 1.4 1999/11/29 16:34:04 lswanson Exp $ --->

<!---
map_redirect.cfm - display an interstitial, make maps, grab them,
then redirect back to happiness
--->
<CFSET g_DealerCode = Form.dealerCode>
<CFSET successTemplate = "http://#application.HOST##application.RELATIVE_PATH#/templates/admin/dlr/goodmap.cfm">

<!--- append FromTemplate to redirect location --->
<CFIF Find("?", Form.nextStep) EQ 0>
	<CFSET donelocation = Form.nextStep & "?FromTemplate=genmap_redirect">
<CFELSE>
	<CFSET donelocation = Form.nextStep & "&FromTemplate=genmap_redirect">
</CFIF>
		
<CFQUERY NAME="gatherinfo" datasource="#gDSN#">
SELECT
	AddressLine1,
	AddressLine2,
	City,
	Stateabbr,
	Zip
FROM
	Dealers
WHERE
	DealerCode = '#g_DealerCode#';
</CFQUERY>

<!--- make the maps --->
<!--- Linda, 4/23/99: this used to work with CF 3.1, but a bug crept into CF 4.0 in the CFHTTP & CFHTTPPARAM.
This may work again if CF fixes their bug!! --->
<!--- 
<CFHTTP METHOD="POST" URL="#application.MAPPER_URL#/scripts/mapper-static2.pl">
	<CFHTTPPARAM TYPE="formfield" NAME="street" VALUE="#gatherinfo.AddressLine1# #gatherinfo.AddressLine2#">
	<CFHTTPPARAM TYPE="formfield" NAME="city" VALUE="#gatherinfo.City#">
	<CFHTTPPARAM TYPE="formfield" NAME="state" VALUE="#gatherinfo.StateAbbr#">
	<CFHTTPPARAM TYPE="formfield" NAME="zipcode" VALUE="#gatherinfo.zip#">
	<CFHTTPPARAM TYPE="formfield" NAME="dealercode" VALUE="#g_DealerCode#">
	<CFHTTPPARAM TYPE="formfield" NAME="location" VALUE="#successTemplate#">
</CFHTTP>
 --->
<!--- skip P.O. Box shit: don't want that printing on the map image --->
<CFIF FindNoCase("P.O.", #gatherinfo.AddressLine1#)>
 	<CFSET street = "#gatherinfo.AddressLine2#">
<CFELSEIF FindNoCase("P.O.", #gatherinfo.AddressLine2#)>
	<CFSET street = "#gatherinfo.AddressLine1#">
<CFELSE>
	<CFSET street = "#gatherinfo.AddressLine1# #gatherinfo.AddressLine2#">
</cfif>

<CFSET street = URLEncodedFormat(street)>
<CFSET city = URLEncodedFormat(gatherinfo.City)>
<CFSET state = gatherinfo.StateAbbr>
<CFSET zipcode = URLEncodedFormat(gatherinfo.zip)>
<CFSET dealercode = g_DealerCode>
<CFSET location = successTemplate>

<CFSET myurl = "#application.MAPPER_URL#/scripts/mapper-static2.pl?street=#street#&city=#city#&state=#state#&zipcode=#zipcode#&dealercode=#dealercode#&location=#location#">
<CFHTTP METHOD="get" URL="#myurl#">

<!--- Maps worked --->
<CFIF Find("SUCCESS", CFHTTP.FileContent) NEQ 0>
	<!--- grab the maps --->
	<CFLOOP INDEX="mapNumber" FROM="1" TO="10">
		<CFSET outputFilename = "#g_DealerCode#_#mapNumber#_map_gra.gif">
 		<CFHTTP URL="#application.MAPPER_URL#/WorldDealer/images/maps/#outputFilename#"
				METHOD="get"
				PATH="#application.ROOT_DIR#\images\maps"
				FILE="#outputFilename#">
	</CFLOOP>
	
	<!--- make the maps go bye bye --->
<!--- linda, 4/30/99: hold onto these until above copy is working
	<CFHTTP METHOD="POST" URL="#application.MAPPER_URL#/scripts/erase-maps.pl">
		<CFHTTPPARAM TYPE="formfield" NAME="dealercode" VALUE="#g_DealerCode#">
		<CFHTTPPARAM TYPE="formfield" NAME="location" VALUE="#successTemplate#">
	</CFHTTP>
 --->	
	<!--- redirect to happiness --->
	<CFLOCATION URL="#donelocation#" ADDTOKEN="yes">
	
<CFELSEIF Find("FAIL", CFHTTP.FileContent) NEQ 0>
	<!--- mapper script says the address didn't turn up from the mapping server --->
	<CFMODULE TEMPLATE="maperror.cfm"
			errorString="The address entered was not found in the mapping database.<BR><BR>Please click the ""Back"" button below and enter a valid address, city, state and zipcode to try again."
			dealerCode="#g_DealerCode#">
	<CFABORT>
	
<CFELSE>
	<!--- some other sort of error occured while trying to make maps --->
	<CFMODULE TEMPLATE="maperror.cfm"
			errorString="Please click the ""Back"" button below and try again."
			dealerCode="#g_DealerCode#">
	<CFABORT>
</CFIF>