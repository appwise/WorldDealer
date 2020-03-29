<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!---
Created by Sigma6, Inc.
Copyright (c) 1999 Sigma6, Inc.
All Rights Reserved.  Used By Permission.

Sigma6, interactive media, Detroit/NYC
conceive : construct : connect
www.sigma6.com   webmaster@sigma6.com   info@sigma6.com

Created: <December 6, 1999>

Linda Swanson for sigma6, interactive media, Detroit
lswanson@sigma6.com   www.sigma6.com    www.s6313.com
conceive : construct : connect

Sigma6, s6, and the Sigma6 logos are registered trademarks.
All other trademarks and servicemarks are the property of
their respective owners.
--->
<!--- routine to find all Used Vehicle images, then find corresponding records in Used Vehicles table.
If found, set Image flag to "Y".  Otherwise, delete the image; the corresp. vehicle no longer exists. --->
<!--- $Id: updpics.cfm,v 1.2 2000/02/02 16:59:58 lswanson Exp $ --->

<html>
<head>
	<title>Update Used Vehicle Pictures</title>
</head>

<body>
	<cfoutput>
	<cfx_directorylist directory="e:\worlddealer\images\UsedVehicles"
		name="uvpics_query"
		sort="name ASC">

	<cfloop query="uvpics_query">
		<cfif #Right(name, 4)# EQ ".jpg">
			<cfset picVIN = #Left(name, Len(name)-4)#>
			<br>picVIN = #picVIN#
			<cfquery name="getVIN" datasource="#gDSN#">
				SELECT	Image
				FROM	UsedVehicles
				WHERE	VIN = '#picVIN#'
			</cfquery>
			
			<cfif #getVIN.RecordCount#>
				<br>updating #getVIN.RecordCount# records
				<cfquery name="updImage" datasource="#gDSN#">
					UPDATE	UsedVehicles
					SET		Image = 'Y'
					WHERE	VIN = '#picVIN#'
				</cfquery>
			<cfelse>
				<br>(temporarily NOT) deleting image: #name#
				<!--- linda, 2-2-2000: problem with valid images being deleted.  so don't delete any more pics for now.
				<cffile action="delete" file="#g_rootdir#\images\UsedVehicles\#name#"> --->
			</cfif>
		</cfif>
	</cfloop>
	</cfoutput>
</body>
</html>
