                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 21, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!--- $Id: preowned_inv_save.cfm,v 1.11 2000/06/06 19:26:09 jkrauss Exp $ --->
<!--- Pre-Owned Vehicles: queries to insert or update vehicles --->

<cfset PageAccess = application.dealer_access>
<cfinclude template = "../security.cfm">
	
<!--- just building the "display" fields for the db --->
<cfset stereoType = ''>
<cfif parameterexists(form.amfm)>
	<cfif #form.amfm# is 'y'>
		<cfset stereoType = 'AM/FM'>
	</cfif>
</cfif>
<cfif parameterexists(form.cd)>
	<cfif #form.cd# is 'y'>
		<cfif #len(trim(stereoType))# gt 0>
			<cfset stereoType = stereoType & ', CD'>
		<cfelse>
			<cfset stereoType = 'CD'>
		</cfif>
	</cfif>
</cfif>
<cfif parameterexists(form.cassette)>
	<cfif #form.cassette# is 'y'>
		<cfif #len(trim(stereoType))# gt 0>
			<cfset stereoType = stereoType & ', Cassette'>
		<cfelse>
			<cfset stereoType = 'Cassette'>
		</cfif>
	</cfif>
</cfif>
<cfif parameterexists(form.cdChanger)>
	<cfif #form.cdChanger# is 'y'>
		<cfif #len(trim(stereoType))# gt 0>
			<cfset stereoType = stereoType & ', Changer'>
		<cfelse>
			<cfset stereoType = 'Changer'>
		</cfif>
	</cfif>
</cfif>

<cfset brakes=''>
<cfif parameterexists(form.powerBrakes)>
	<cfif #form.powerBrakes# is 'y'>
		<cfset brakes = 'Power Brakes'>
	</cfif>
</cfif>
<cfif parameterexists(form.abs)>
	<cfif #form.ABS# is 'y'>
		<cfif #len(trim(brakes))# gt 0>
			<cfset brakes = brakes & ', '>
		</cfif>
		<cfset brakes = brakes & 'ABS'>
	</cfif>
</cfif>

<!--- Existing Used Vehicle --->
<cfif #isdefined("form.UsedVehicleID")#>
	<cfquery name="updVehicle" datasource="#gDSN#">
		UPDATE	UsedVehicles
		SET		UsedVehicles.VIN = '#rtrim(UCase(Form.VIN))#',
				UsedVehicles.ModelNumber = #Form.ModelNumber#,
				UsedVehicles.intcolor = '#rtrim(Form.intcolor)#',
				UsedVehicles.NewUsed = '#Form.NewUsed#',
				UsedVehicles.extcolor = '#rtrim(Form.extcolor)#',
				UsedVehicles.transmission = '<cfif parameterexists(form.transmission)>#Form.transmission#</cfif>',
				UsedVehicles.mileage = <cfif Form.mileage is ''>0<cfelse>#Form.mileage#</cfif>,
				UsedVehicles.price = <cfif Form.price is ''>0<cfelse>#Form.price#</cfif>,
				UsedVehicles.stock = '#rtrim(Form.stock)#',
				UsedVehicles.CarYear = #rtrim(Form.CarYear)#,
				UsedVehicles.Features = '#Form.features#',
				UsedVehicles.vehicleType = '<cfif parameterexists(form.vehicleType)>#Form.vehicleType#</cfif>',
				UsedVehicles.vehicleCategory = '<cfif parameterexists(form.vehicleCategory)>#Form.vehicleCategory#</cfif>',
				UsedVehicles.bodyStyle = '<cfif parameterexists(form.bodyStyle)>#Form.bodyStyle#</cfif>',
				UsedVehicles.doors = '<cfif parameterexists(form.doors)>#Form.doors#</cfif>',
				UsedVehicles.trim = '#rtrim(Form.trim)#',
				UsedVehicles.Image = '#Form.Image#'
		WHERE	UsedVehicles.UsedVehicleID = #Form.UsedVehicleID#
	</cfquery>
	
	<cfquery name="delVehicleOptions" datasource="#gDSN#">
		DELETE FROM UsedVehiclesOptions
		WHERE	UsedVehiclesOptions.UsedVehicleID = #Form.UsedVehicleID#
	</cfquery>				

	<cfloop index="LoopIndex" from="1" to="5">
		<cfset tmp= evaluate('form.option' & #loopindex#)>
		<cfif tmp neq "">
			<cfquery name="addextraoptions" datasource="#gDSN#">
			INSERT INTO UsedVehiclesOptions (
				UsedVehicleID, options
				)
			VALUES (
				#Form.UsedVehicleID#, '#tmp#'
				)
			</cfquery>
		</cfif>
	</cfloop>												
<cfelse>
	<!--- insert a new Used Vehicle --->

	<CFIF IsDefined("Form.ModelNumber")>
    <CFIF IsNumeric(Form.ModelNumber)>
    <cfset newModelNumber = Form.ModelNumber>
    <CFELSE>
    <cfset newModelNumber = Int(Form.ModelNumber)>
    </CFIF>
</CFIF>

	
	
	<cftransaction>
		<cfquery name="addVehicle" datasource="#gDSN#">
		INSERT INTO UsedVehicles (
			DealerCode,
			VIN,
			ModelName,
			ModelNumber,
			NewUsed,
			intcolor,
			extcolor,
			transmission,
			mileage,
			price,
			stock,
			CarYear,
			Features,
			vehicleType,
			vehicleCategory,
			bodyStyle,
			doors,
			trim,
			Image
			)
		VALUES (
			'#g_dealercode#',
		 	'#UCase(Form.VIN)#',
			'unneccessary',
			#Form.ModelNumber#,
			<!--- #newModelNumber#, --->
			'#Form.NewUsed#',
			'#Form.intcolor#',
			'#Form.extcolor#',
			'#Form.transmission#',
			<cfif Form.mileage is ''>0<cfelse>#Form.mileage#</cfif>,
			<cfif Form.price is ''>0<cfelse>#Form.price#</cfif>,
			'#Form.stock#',
			#Form.CarYear#,
			'#Form.features#',
			'#Form.vehicleType#',
			'#Form.vehicleCategory#',
			'#Form.bodyStyle#',
			'#Form.doors#',
			'#Form.trim#',
			'#Form.Image#'
			)
		</cfquery>
			
		<cfquery name="selectVehicleID" datasource="#gDSN#">
		SELECT MAX(UsedVehicleID) as UsedVehicleID
		FROM UsedVehicles
		</cfquery>
			
		<cfloop index="LoopIndex" from="1" to="5">
			<cfset tmp= evaluate('form.option' & #loopindex#)>
			<cfif tmp neq "">
				<cfquery name="addextraoptions" datasource="#gDSN#">
				INSERT INTO UsedVehiclesOptions (
					UsedVehicleID, options
					)
				VALUES (
					#selectVehicleID.UsedVehicleID#, '#tmp#'
					)
				</cfquery>
			</cfif>
		</cfloop>
	</cftransaction>	
</cfif>

<cfquery name="check4details" datasource="#gDSN#">
	SELECT	*
	FROM	UVDetails 
			INNER JOIN UsedVehicles ON UVDetails.UsedVehicleID = UsedVehicles.UsedVehicleID
	WHERE	UsedVehicles.VIN = '#Form.VIN#'
</cfquery>
	
<cfif check4details.recordcount>
	<cfquery name="updVehicleDetails" datasource="#gDSN#">
		UPDATE 	UVDetails
		SET		UVDetails.engineSize = '#Form.engineSize#',
				UVDetails.engineConfig = '#Form.engineConfig#',
				UVDetails.engineCylinders = '#Form.engineCylinders#',
				UVDetails.enginePerfType = '#Form.enginePerfType#',
				UVDetails.driveType = '#Form.driveType#',
				UVDetails.upholstery = '#Form.upholstery#',
				UVDetails.seatingType = '#Form.seatingType#',
				UVDetails.stereoType = '#stereoType#',
				UVDetails.stereoRear = '<cfif parameterexists(form.stereoRear)>#Form.stereoRear#</cfif>',
				UVDetails.television = '<cfif parameterexists(form.television)>#Form.television#</cfif>',
				UVDetails.airConditioning = '<cfif parameterexists(form.airConditioning)>#Form.airConditioning#</cfif>',
				UVDetails.airConditioningRear = '<cfif parameterexists(form.airConditioningRear)>#Form.airConditioningRear#</cfif>',
				UVDetails.climateControl = '<cfif parameterexists(form.climateControl)>#Form.climateControl#</cfif>',
				UVDetails.cruiseControl = '<cfif parameterexists(form.cruiseControl)>#Form.cruiseControl#</cfif>',
				UVDetails.tiltWheel = '<cfif parameterexists(form.tiltWheel)>#Form.tiltWheel#</cfif>',
				UVDetails.brakes = '#brakes#',
				UVDetails.powerLocks = '<cfif parameterexists(form.powerLocks)>#Form.powerLocks#</cfif>',
				UVDetails.powerSeats = '<cfif parameterexists(form.powerSeats)>#Form.powerSeats#</cfif>',
				UVDetails.powerSteering = '<cfif parameterexists(form.powerSteering)>#Form.powerSteering#</cfif>',
				UVDetails.powerWindows = '<cfif parameterexists(form.powerWindows)>#Form.powerWindows#</cfif>',
				UVDetails.airbagDriver = '<cfif parameterexists(form.airbagDriver)>#Form.airbagDriver#</cfif>',
				UVDetails.airbagPassenger = '<cfif parameterexists(form.airbagPassenger)>#Form.airbagPassenger#</cfif>',
				UVDetails.tractionControl = '<cfif parameterexists(form.tractionControl)>#Form.tractionControl#</cfif>',
				UVDetails.boxType = '#Form.boxType#',
				UVDetails.payload = '#Form.payload#',
				UVDetails.warranty = '#Form.warranty#',
				UVDetails.warrantyMonths = '#Form.warrantyMonths#',
				UVDetails.warrantyMiles = <cfif form.warrantyMiles is ''>0<cfelse>#Form.warrantyMiles#</cfif>,
				UVDetails.wheelDescription = '#Form.wheelDescription#',
				UVDetails.luggageRack = '<cfif parameterexists(form.luggageRack)>#Form.luggageRack#</cfif>',
				UVDetails.runningBoards = '<cfif parameterexists(form.runningBoards)>#Form.runningBoards#</cfif>',
				UVDetails.slidingWindow = '<cfif parameterexists(form.slidingWindow)>#Form.slidingWindow#</cfif>',
				UVDetails.towingPackage = '<cfif parameterexists(form.towingPackage)>#Form.towingPackage#</cfif>'
		WHERE 	UVDetails.UsedVehicleID = #Form.UsedVehicleID#
	</cfquery>
<cfelse>
	<cfquery name="getUVID" datasource="#gDSN#">
		SELECT DISTINCT UsedVehicleID
		FROM UsedVehicles
		WHERE VIN = '#Form.VIN#'
	</cfquery>
	<cfquery name="insertDetails" datasource="#gDSN#">
		INSERT INTO UVDetails (
				UsedVehicleID,
				engineSize,
				engineConfig,
				engineCylinders,
				enginePerfType,
				driveType,
				upholstery,
				seatingType,
				stereoType,
				airConditioning,
				cruiseControl,
				tiltWheel,
				brakes,
				powerLocks,
				powerSeats,
				powerSteering,
				powerWindows,
				airbagDriver,
				airbagPassenger,
				tractionControl,
				boxType,
				payload,
				warranty,
				warrantyMonths,
				warrantyMiles,
				wheelDescription,
				luggageRack,
				runningBoards,
				slidingWindow,
				towingPackage
				)
		VALUES (
				#getUVID.UsedVehicleID#,
				'#Form.engineSize#',
				'#Form.engineConfig#',
				'#Form.engineCylinders#',
				'#Form.enginePerfType#',
				'#Form.driveType#',
				'#Form.upholstery#',
				'#Form.seatingType#',
				'#stereoType#',
				'<cfif parameterexists(form.airConditioning)>#Form.airConditioning#</cfif>',
				'<cfif parameterexists(form.cruiseControl)>#Form.cruiseControl#</cfif>',
				'<cfif parameterexists(form.tiltWheel)>#Form.tiltWheel#</cfif>',
				'#brakes#',
				'<cfif parameterexists(form.powerLocks)>#Form.powerLocks#</cfif>',
				'<cfif parameterexists(form.powerSeats)>#Form.powerSeats#</cfif>',
				'<cfif parameterexists(form.powerSteering)>#Form.powerSteering#</cfif>',
				'<cfif parameterexists(form.powerWindows)>#Form.powerWindows#</cfif>',
				'<cfif parameterexists(form.airbagDriver)>#Form.airbagDriver#</cfif>',
				'<cfif parameterexists(form.airbagPassenger)>#Form.airbagPassenger#</cfif>',
				'<cfif parameterexists(form.tractionControl)>#Form.tractionControl#</cfif>',
				'#Form.boxType#',
				'#Form.payload#',
				'#Form.warranty#',
				'#Form.warrantyMonths#',
				<cfif form.warrantyMiles eq ''>0<cfelse>#Form.warrantyMiles#</cfif>,
				'#Form.wheelDescription#',
				'<cfif parameterexists(form.luggageRack)>#Form.luggageRack#</cfif>',
				'<cfif parameterexists(form.runningBoards)>#Form.runningBoards#</cfif>',
				'<cfif parameterexists(form.slidingWindow)>#Form.slidingWindow#</cfif>',
				'<cfif parameterexists(form.towingPackage)>#Form.towingPackage#</cfif>'
				)
	</cfquery>
</cfif>
	
<cfif form.image eq 'y'>    <!--- They chose to include a custom Image --->
	<cfif form.tmpid is not 0>    <!--- They actually submitted a new image --->
		<cfif isdefined("form.UsedVehicleID")>
			<cfset vehicle_id = #form.usedvehicleid#>
		<cfelse>
			<cfset vehicle_id = #selectvehicleid.usedvehicleid#>
		</cfif>
		
		<cfif isdefined("form.NewUsed")>
			<input type="hidden" name="NewUsed" value="#form.NewUsed#">
		</cfif>
		
		<!--- Rename the uploaded image --->
		<cffile action="copy" source="#g_rootdir#\images\usedvehicles\temp_#form.tmpid#_.jpg" destination="#g_rootdir#\images\usedvehicles\#form.VIN#.jpg">
	</cfif>
</cfif>

<cflocation url="preowned_inv.cfm" addtoken="no">
