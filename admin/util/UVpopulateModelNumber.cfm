<!--- this is a utility to populate the UVMake table by gleening info from the UsedVehicle Table --->
<!--- then...it populates teh UVModels table --->
<!--- then...just when you think it's done, it gives each vehicle in the UsedVehicle Table a ModelNumber --->

<!--- go WD 4.0!!! --->

<cfquery name="getUVMakes" datasource="#gDSN#">
	SELECT distinct Make
	FROM UsedVehiclesModels
</cfquery>

<cfquery name="countUVMakes" datasource="#gDSN#">
	SELECT MakeNumber
	FROM UVMakes
</cfquery>

<cfset count = countUVMakes.recordcount + 1>

<cfloop query="getUVMakes">

	<cfquery name="checkCurrentMakes" datasource="#gDSN#">
		SELECT MakeName
		FROM UVMakes
		WHERE MakeName = '#getUVMakes.Make#'
	</cfquery>

	<cfif checkCurrentMakes.recordcount is 0>
	
		<cfquery name="popUVMake" datasource="#gDSN#">
			INSERT INTO UVMakes (MakeNumber, MakeName)
			VALUES (#count#, '#Make#')
		</cfquery>
	
		<cfoutput>#Make#</cfoutput><br>
	
		<cfset count = count + 1>
		
	</cfif>
	
</cfloop>

makes done<p>





<cfquery name="getUVModels" datasource="#gDSN#">
	SELECT distinct Make, ModelName
	FROM UsedVehiclesModels
	ORDER BY Make
</cfquery>

<cfquery name="countUVModels" datasource="#gDSN#">
	SELECT MAX(ModelNumber) as maxmodelnumber
	FROM UVModels
</cfquery>

<cfset count = countUVModels.maxmodelnumber + 1>

<cfoutput>#count#<br></cfoutput>

<cfloop query="getUVModels">

	<cfquery name="checkCurrentModels" datasource="#gDSN#">
		SELECT ModelName
		FROM UVModels
		WHERE ModelName = '#getUVModels.ModelName#'
	</cfquery>
	
	<cfif checkCurrentModels.recordcount is 0>
	
		<cfquery name="getMake" datasource="#gDSN#">
			SELECT MakeNumber
			FROM UVMakes
			WHERE MakeName = '#Make#'
		</cfquery>
		
		<cfquery name="popUVModels" datasource="#gDSN#">
			INSERT INTO UVModels (ModelNumber, ModelName, MakeNumber)
			VALUES (#count#, '#ModelName#', #getMake.MakeNumber#)
		</cfquery>
		
		<cfoutput>#count# #Make#(#getMake.MakeNumber#), #ModelName#</cfoutput><br>
		
		<cfset count = count + 1>
	
	</cfif>
	
</cfloop>

models done<p>





<cfquery name="getRecords" datasource="#gDSN#">
        SELECT UsedVehicleID, Make, ModelName
        FROM UsedVehicles
</cfquery>

<cfloop query="getRecords">
	
	<cfquery name="getModelNumbers" datasource="#gDSN#">
		SELECT ModelNumber
		FROM UVModels
		WHERE ModelName = '#getRecords.ModelName#'
	</cfquery>
	
	<cfoutput>#getModelNumbers.ModelNumber# - #getRecords.ModelName# -- ID=#getRecords.UsedVehicleID#<br></cfoutput>
	
	<cfquery name="populateModelNumbers" datasource="#gDSN#">
		UPDATE UsedVehicles
		SET ModelNumber = #getModelNumbers.ModelNumber#
		WHERE UsedVehicleID = #getRecords.UsedVehicleID#
	</cfquery>

</cfloop>

all done ... thank you for playing