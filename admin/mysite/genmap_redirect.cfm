                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 10, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!--- $Id: genmap_redirect.cfm,v 1.6 2000/04/07 18:34:08 lswanson Exp $ --->

<!---
map_redirect.cfm - display an interstitial, make maps, grab them,
then redirect back to happiness
--->

<!--- linda, 4/7/00: already called by calling file, *_save.cfm
<cfinclude template="../security.cfm"> --->

<cfset successtemplate = "#application.RELATIVE_PATH#/templates/admin/dlr/goodmap.cfm">

<cfquery name="gatherinfo" datasource="#gDSN#">
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
</cfquery>

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
<cfif findnocase("P.O.", #gatherinfo.addressline1#)>
 	<cfset street = "#gatherinfo.AddressLine2#">
<cfelseif findnocase("P.O.", #gatherinfo.addressline2#)>
	<cfset street = "#gatherinfo.AddressLine1#">
<cfelse>
	<cfset street = "#gatherinfo.AddressLine1# #gatherinfo.AddressLine2#">
</cfif>

<cfset street = urlencodedformat(street)>
<cfset city = urlencodedformat(gatherinfo.city)>
<cfset state = gatherinfo.stateabbr>
<cfset zipcode = urlencodedformat(gatherinfo.zip)>
<cfset dealercode = g_dealercode>
<cfset location = successtemplate>

<cfset myurl = "#application.MAPPER_URL#/scripts/mapper-static2.pl?street=#street#&city=#city#&state=#state#&zipcode=#zipcode#&dealercode=#dealercode#&location=#location#">
<cfhttp method="get" url="#myurl#">

<!--- Maps worked --->
<cfif find("SUCCESS", cfhttp.filecontent) neq 0>
	<!--- grab the maps --->
	<cfloop index="mapNumber" from="1" to="10">
		<cfset outputfilename = "#g_DealerCode#_#mapNumber#_map_gra.gif">
 		<cfhttp url="#application.MAPPER_URL#/WorldDealer/images/maps/#outputFilename#"
				method="get"
				path="#application.ROOT_DIR#\images\maps"
				file="#outputFilename#">
	</cfloop>
	
	<!--- make the maps go bye bye --->
<!--- linda, 4/30/99: hold onto these until above copy is working
	<CFHTTP METHOD="POST" URL="#application.MAPPER_URL#/scripts/erase-maps.pl">
		<CFHTTPPARAM TYPE="formfield" NAME="dealercode" VALUE="#g_DealerCode#">
		<CFHTTPPARAM TYPE="formfield" NAME="location" VALUE="#successTemplate#">
	</CFHTTP>
 --->	
	<!--- redirect to happiness --->
	<cflocation url="#form.NextStep#" addtoken="no">
	
<cfelseif find("FAIL", cfhttp.filecontent) neq 0>
	<!--- mapper script says the address didn't turn up from the mapping server --->
	<cfmodule template="maperror.cfm"
			errorstring="The address entered was not found in the mapping database.<br><br>
			Please click the ""Back"" button below and enter a valid address, city, state and zipcode to try again.">
	<cfabort>
	
<cfelse>
	<!--- some other sort of error occured while trying to make maps --->
	<cfmodule template="maperror.cfm"
			errorstring="Please click the ""Back"" button below and try again.">
	<cfabort>
</cfif>