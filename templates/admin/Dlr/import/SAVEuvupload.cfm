
   <!-- ----------------------------------------------------------- -->
   <!--               Copyright (c) 1998 Sigma6, Inc.               -->
   <!--         All Rights Reserved.  Used By Permission.           -->
   <!-- ----------------------------------------------------------- -->
   <!-- ----------------------------------------------------------- -->
   <!--           Sigma6, interactive media, Detroit/NYC            -->
   <!--               conceive : construct : connect                -->
   <!--   www.sigma6.com   webmaster@sigma6.com   info@sigma6.com   -->
   <!-- ----------------------------------------------------------- -->
   <!-- ----------------------------------------------------------- -->
   <!-- Sigma6, s6, and the Sigma6 logos are registered trademarks. -->
   <!-- All other trademarks and servicemarks are the property of   -->
   <!-- their respective owners.                                    -->
   <!-- ----------------------------------------------------------- -->

<!--- create the filename to retrieve via CFFTP --->
<CFSET varDateString = #DateFormat(Now(),"yyyymmdd")#>
<CFSET varFileName = 'SI' & #varDateString# & '.txt'>

<!--- create the filepath for the storing the file on the local system (this system) --->
<CFSET varLocalFile = 'C:\TEMP\' & #varFileName#>

<!--- open an anonymous FTP connection --->
<CFFTP ACTION="Open"
       SERVER="ftp.sigma6.com"
	   USERNAME="anonymous"
	   PASSWORD="webmaster@sigma6.com"
	   CONNECTION="UVRetrieve"
	   STOPONERROR="Yes">

<!--- change dirs to pub --->	   
<CFFTP CONNECTION="UVRetrieve"
       ACTION="ChangeDir"
	   DIRECTORY="pub">

<!--- retrieve file --->	   
<CFFTP CONNECTION="UVRetrieve"
       ACTION="GetFile"
	   TRANSFERMODE="ASCII"
       LOCALFILE="#varLocalFile#"
	   REMOTEFILE="#varFileName#">

<!--- close connection --->	  
<CFFTP CONNECTION="UVRetrieve"
       ACTION="Close">
	   
<!--- read in file from disk, store contents in a variable --->	   
<CFFILE ACTION="Read"
        FILE="#varLocalFile#"
		VARIABLE="varUVContents">	  
		

<!--- look for consecutive delimiters, and insert a space in between them --->
<!--- for some reason, the Replace function misses some of the consecutive delimiters on the first --->
<!--- pass, so do the Replace twice to get everything.  --->
<CFSET varUVContents = Replace(varUVContents, "||", "| |", "ALL")>
<CFSET varUVContents = Replace(varUVContents, "||", "| |", "ALL")>

<!--- the files from Reynolds and Reynolds are delimited with a pipe character ("|") --->
<!--- however, there is no trailing pipe on each record, so we need to break on --->
<!--- carriage-control (ASCII #13) and linefeed (ASCII #10) --->
<CFSET varLineFeed = Chr(10)>
<CFSET varCarriageControl = Chr(13)>

<!--- we have no idea how many records there are, so append an end-of-file marker to the contents --->
<!--- then use the FIND function to get the last character before the end-of-file marker --->
<CFSET varUVContents = #varUVContents# & #varCarriageControl# & #varLineFeed# & 'ENDOFFILE'>

<CFSET varLastCharacter = Find("ENDOFFILE",varUVContents,1)>
<CFSET varLastCharacter = #varLastCharacter# - 1>

<!--- using the GetToken function, we can loop through the text file line by line --->
<!--- doing an insert for each line as we go.  Also, keep count of the total records, --->
<!--- just for grins.  We don't know how many records there are in each file, so we'll --->
<!--- loop for 10K records, and break when we reach ENDOFFILE --->
<!--- the first record is always column names, so we'll start with line 2 --->
<CFLOOP INDEX="LineCounter" FROM="2" TO="10000">

    <CFSET varTextLine = GetToken(varUVContents,#LineCounter#,#varCarriageControl#)>
	<CFOUTPUT>#varTextLine#</CFOUTPUT>

    <!--- look for ENDOFFILE, break if we find it --->
	<CFIF #Find('ENDOFFILE',varTextLine,1)# GT 0>

	   <CFSET varRecordCount = #LineCounter#>
	   <CFBREAK>

	</CFIF>
    <!--- no end of file, so do the insert --->

	<!--- first, translate the line into a 1-D array of 57 elements --->
	<!--- convert spaces to NULL --->
    <CFSET arrTemp = ListToArray(#varTextLine#,"|#varCarriageControl##varLineFeed#")>
	<CFLOOP INDEX="CellCounter" FROM="1" TO="#ArrayLen(arrTemp)#">
	     <CFIF #Left(arrTemp[CellCounter],1)# EQ ' '>
		     <CFSET arrTemp[#CellCounter#] = ''>
		 </CFIF>
	</CFLOOP>

    <CFIF #ArrayLen(arrTemp)# EQ 57>
		<!--- do the actual insert --->
	    <CFQUERY NAME="insUV#LineCounter#" DATASOURCE="#gDSN#" USERNAME="sa" PASSWORD="">
	         INSERT INTO UVImport
			     VALUES ('#arrTemp[1]#',
				         '#arrTemp[2]#',
						 '#arrTemp[3]#',
						 '#arrTemp[4]#',
						 '#arrTemp[5]#',
						 '#arrTemp[6]#',
						 '#arrTemp[7]#',
	                     '#arrTemp[8]#',
	                     '#arrTemp[9]#',
	                     '#arrTemp[10]#',
	                     '#arrTemp[11]#', 
	                     CONVERT(money,#arrTemp[12]#),
	                     '#arrTemp[13]#',
	                     '#arrTemp[14]#',
	                     '#arrTemp[15]#',
	                     '#arrTemp[16]#', 
	                     '#arrTemp[17]#',
	                     '#arrTemp[18]#',
	                     '#arrTemp[19]#',
	                     '#arrTemp[20]#',
	                     '#arrTemp[21]#', 
	                     '#arrTemp[22]#',
	                     '#arrTemp[23]#',
	                     '#arrTemp[24]#',
	                     '#arrTemp[25]#',
	                     '#arrTemp[26]#', 
	                     '#arrTemp[27]#',
	                     '#arrTemp[28]#',
	                     '#arrTemp[29]#',
	                     '#arrTemp[30]#',
	                     '#arrTemp[31]#', 
	                     '#arrTemp[32]#',
	                     '#arrTemp[33]#',
	                     '#arrTemp[34]#',
	                     '#arrTemp[35]#',
	                     '#arrTemp[36]#', 
	                     '#arrTemp[37]#',
	                     '#arrTemp[38]#',
	                     '#arrTemp[39]#',
	                     '#arrTemp[40]#',
	                     '#arrTemp[41]#', 
	                     '#arrTemp[42]#',
	                     '#arrTemp[43]#',
	                     '#arrTemp[44]#',
	                     '#arrTemp[45]#',
	                     '#arrTemp[46]#', 
	                     '#arrTemp[47]#',
	                     '#arrTemp[48]#',
	                     '#arrTemp[49]#',
	                     '#arrTemp[50]#',
	                     '#arrTemp[51]#', 
	                     '#arrTemp[52]#',
	                     '#arrTemp[53]#',
	                     '#arrTemp[54]#',
	                     '#arrTemp[55]#',
	                     '#arrTemp[56]#', 
	                     '#arrTemp[57]#')
	    </CFQUERY>	
    </CFIF>
	
	<!--- clear out the array, just to be sure --->
    <CFSET varResult = ArrayClear(arrTemp)>	
    <!--- clear out the line bucket --->
	<CFSET varTextLine = ''>
	
</CFLOOP>

<!--- The following Routines will load the Used Vehicle Tables --->
<!--- For any questions awarchuck@sigma6.com --->
<!--- Set up counters and static variables --->
<CFSET Modelcount = 0> 
<CFSET UsedVehiclecount = 0>
<CFSET Optionscount = 0>
<CFSET VINfound = 0>
<CFSET Modelfound = 0>

<CFQUERY NAME="getUVImportData" DATASOURCE="#gDSN#">
<!---  Query to read the Converted Used Vehicle Data --->
         SELECT DealerID,
		        stockNumber,
				year,
				make,
				model,
				trim,
				vehicleType,
				bodyStyle,
				color,
				miles,
				vin,
				retailPrice,
				doors,
				airConditioning,
				boxType,
				cruiseControl,
				driveType,
				driverAirBag,
				engineSize,
				engineConfig,
				engineCylinders,
				enginePerfType,
				fuelInjection,
				fuelType,
				luggageRack,
				optionalFuel,
				passengerAirBag,
				payloadType,
				powerLocks,
				powerSeats,
				powerSteering,
				powerWindows,
				raisedRoof,
				rearAirConditioning,
				rearStereo,
				runningBoards,
				shell,
				slidingWindow,
				stereoType,
				television,
				tiltWheel,
				towingPackage,
				tractionControl,
				transmission,
				vrc,
				vehicleCatagory,
				domesticImport,
				brakes,
				climateControl,
				seatingCapacity,
				seatingType,
				sideDoor,
				upholstery,
				wheelDescription,
				engineDisplay,
				picture,
				certifications
        FROM UVImport;
</CFQUERY>

<!--- Let's loop through the downloaded Used Vehicle Table and populate the UsedVehiclesModels Table, UsedVehicles Table & UsedVehiclesOptions Table --->
<CFLOOP QUERY="getUVImportData">
  <CFTRANSACTION>
    <!---  Change the year from two digits to 4 digits, and hope they aren't using this 30 years down the road. --->
	<CFSET theYear = val("getUVImportData.year")>
	<CFIF TheYear GE 30>
		<CFSET convertedmodelyear = "19" & #getUVImportData.year#>
	<CFELSE>
		<CFSET convertedmodelyear = "20" & #getUVImportData.year#>
	</CFIF>
	<CFSET convertedmodelyear = "19" & #getUVImportData.year#>

	<CFQUERY NAME="Check4Model" DATASOURCE="#gDSN#">
	<!--- Query to see if Make, Model, Year already exists in the UsedVehiclesModels Table --->
			SELECT	Count(ModelName) AS Modelfound
      		FROM	UsedVehiclesModels
     		WHERE	UsedVehiclesModels.Make = '#getUVImportData.make#'
			AND		UsedVehiclesModels.ModelName = '#getUVImportData.model#'
			AND		UsedVehiclesModels.Year = #convertedmodelyear#
	</CFQUERY>

	<!--- Check to see if Make, Model, Year already exists in the UsedVehiclesModels Table --->
    <CFIF #Modelfound# IS 0>
		<CFSET Modelcount = IncrementValue(Modelcount)>
        <!--- OK, it doesn't exist, lets add it --->
    	<CFQUERY Name="PutMakeModelYear" Datasource="#gDSN#">
				INSERT INTO UsedVehiclesModels
							(Make, ModelName, Year)
				VALUES		('#getUVImportData.make#','#getUVImportData.model#',#convertedmodelyear#)
		</CFQUERY>     			 
	</CFIF>

	<CFQUERY NAME="Check4Vehicle" DATASOURCE="#gDSN#">
	<!--- Query to see if this vehicle already exists in the UsedVehicles Table using the VIN# --->
			SELECT	Count(VIN) AS VINfound
      		FROM	UsedVehicles
     		WHERE	UsedVehicles.VIN = '#getUVImportData.vin#'
	</CFQUERY>

	<!--- Check to see if VIN already exists in UsedVehicles --->
	<CFIF #VINfound# IS 0>
        <CFSET UsedVehiclecount = IncrementValue(UsedVehiclecount)>
        <!--- OK, it doesn't exist, lets add it --->
		<CFQUERY NAME="addUsedVehicle" DATASOURCE="#gDSN#">
				INSERT INTO UsedVehicles (
							DealerCode,
							VIN,
							ModelName,
							make,
							intcolor,
							extcolor,
							transmission,
							mileage,
							price,
							stock,
							CarYear,
							Features,
							Image
							)
				VALUES (
							<!--- Set Dealer Code --->
							<!--- This code is for testing only --->
							<!--- We need to decide on a conversion or cross reference table --->
                            <CFIF #getUVImportData.DealerID# IS '6055'>
	                            '11-111',
							<CFELSE>
								'#getUVImportData.DealerID#',
							</CFIF>
							<!--- Set VIN Number --->
							'#getUVImportData.vin#',
							<!--- Set Model --->
							'#getUVImportData.model#',
							<!--- Set Make --->
							'#getUVImportData.make#',
							<!--- Set Interior Color --->
							'none',
							<!--- Set External Color --->
							<CFIF #getUVImportData.color# NEQ ''>
								'#getUVImportData.color#',
							<CFELSE>
								'none',
							</CFIF>
							<!--- Set Transmission Type --->
							<CFIF #getUVImportData.transmission# EQ ''>
							    'none',
							<CFELSEIF #getUVImportData.transmission# EQ 'Automatic'> 
                                'Automatic',
							<CFELSEIF #getUVImportData.transmission# EQ 'Manual'> 	
								'Manual',
							<CFELSEIF #getUVImportData.transmission# EQ 'Auto w/OD'> 		
								'Automatic',
							<CFELSE>
							    'none',
							</CFIF>	
							<!--- Set Mileage --->
							<CFIF #getUVImportData.miles# GT '0'>
								#getUVImportData.miles#,
							<CFELSE>
								0,
							</CFIF>	
							<!--- Set Price --->
							<CFIF #getUVImportData.retailPrice# NEQ ''>
								#getUVImportData.retailPrice#,
							<CFELSE>
								0,
							</CFIF>
							<!--- Set Stock Number --->
							<CFIF #getUVImportData.stockNumber# NEQ ''>
								'#getUVImportData.stockNumber#',
							<CFELSE>
								'none',
            				</CFIF>
							<!--- Set Model Year --->
							#convertedmodelyear#,
							<!--- Set Features --->
							' ',
							<!--- Set Image Flag --->
							'N'
								)
		</CFQUERY>
        <!--- Now we need to get the UsedVehicleID for the Vehicle we just added from UsedVehicles Table --->
        <CFQUERY NAME="GetUsedVehicleID" DATASOURCE="#gDSN#">
				SELECT	Max(UsedVehicleID) as UsedVehicleID
                  FROM	UsedVehicles
     			 WHERE	UsedVehicles.VIN = '#getUVImportData.vin#'
     			   and  UsedVehicles.stock = '#getUVImportData.stockNumber#'		
		</CFQUERY>
		                    <!--- Now we need to add all the new options to the UsedVehiclesOptions Table --->
	   	<CFLOOP INDEX="OptionCount" FROM="1" TO="20"> 
			<CFSET addrec = 0>
            <!--- Check for Engine Display --->
			<CFIF #OptionCount# IS 1>
	            <CFIF #getUVImportData.engineDisplay# GT ' '>
    	            <CFSET theoption = "#getUVImportData.engineDisplay#">
					<CFSET addrec = 1>
				</CFIF>
			</CFIF>
            <!--- Check for air conditioning --->
			<CFIF #OptionCount# IS 2>
	            <CFIF #getUVImportData.airConditioning# IS 'S'>
    	            <CFSET theoption = "Air Conditioning">
					<CFSET addrec = 1>
				</CFIF>
			</CFIF>
            <!--- Check for rear air conditioning --->
			<CFIF #OptionCount# IS 3>
	            <CFIF #getUVImportData.rearAirConditioning# IS 'S'>
    	            <CFSET theoption = "Rear Air Conditioning">
					<CFSET addrec = 1>
				</CFIF>
			</CFIF>
            <!--- Check for cruise control --->
			<CFIF #OptionCount# IS 4>
				<CFIF #getUVImportData.cruiseControl# IS 'S'>
					<CFSET theoption = "Cruise Control">
					<CFSET addrec = 1>
				</cfif>
			</CFIF>
            <!--- Check for driver air bag --->
			<CFIF #OptionCount# IS 5>
				<CFIF #getUVImportData.driverAirBag# IS 'S'>
					<CFSET theoption = "Driver side air bag">
					<CFSET addrec = 1>
				</cfif>
			</CFIF>
            <!--- Check for passenger air bag --->
			<CFIF #OptionCount# IS 6>
				<CFIF #getUVImportData.passengerAirBag# IS 'S'>
					<CFSET theoption = "Passenger side air bag">
					<CFSET addrec = 1>
				</cfif>
			</CFIF>
            <!--- Check for Power Locks --->
			<CFIF #OptionCount# IS 7>
				<CFIF #getUVImportData.powerLocks# IS 'S'>
					<CFSET theoption = "Power Locks">
					<CFSET addrec = 1>
				</cfif>
			</CFIF>
            <!--- Check for Power Seats --->
			<CFIF #OptionCount# IS 8>
				<CFIF #getUVImportData.powerSeats# IS 'S'>
					<CFSET theoption = "Power Seats">
					<CFSET addrec = 1>
				</cfif>
			</CFIF>
            <!--- Check for Power Windows --->
			<CFIF #OptionCount# IS 9>
				<CFIF #getUVImportData.powerWindows# IS 'S'>
					<CFSET theoption = "Power Windows">
					<CFSET addrec = 1>
				</cfif>
			</CFIF>
            <!--- Check for Tilt Steering Wheel --->
			<CFIF #OptionCount# IS 10>
				<CFIF #getUVImportData.tiltWheel# IS 'S'>
					<CFSET theoption = "Tilt Steering Wheel">
					<CFSET addrec = 1>
				</cfif>
			</CFIF>
            <!--- Check for Drive Type --->
			<CFIF #OptionCount# IS 11>
				<CFIF #getUVImportData.driveType# GT ' '>
					<CFSET theoption = "#getUVImportData.driveType#" & " Drive">
					<CFSET addrec = 1>
				</cfif>
			</CFIF>
			<!--- Check for Pay Load --->
			<CFIF #OptionCount# IS 12>
				<CFIF #getUVImportData.payloadType# GT ' '>
					<CFSET theoption = "#getUVImportData.payloadType#" & " Pay Load">
					<CFSET addrec = 1>
				</cfif>
			</CFIF>
            <!--- Check for rear stereo --->
			<CFIF #OptionCount# IS 13>
	            <CFIF #getUVImportData.rearStereo# IS 'S'>
    	            <CFSET theoption = "Rear Stereo">
					<CFSET addrec = 1>
				</CFIF>
			</CFIF>
            <!--- Check for a shell --->
			<CFIF #OptionCount# IS 14>
	            <CFIF #getUVImportData.shell# IS 'S'>
    	            <CFSET theoption = "Shell">
					<CFSET addrec = 1>
				</CFIF>
			</CFIF>
            <!--- Check for Sliding Window --->
			<CFIF #OptionCount# IS 15>
	            <CFIF #getUVImportData.slidingwindow# IS 'S'>
    	            <CFSET theoption = "Sliding Window">
					<CFSET addrec = 1>
				</CFIF>
			</CFIF>
            <!--- Check for Stereo Type --->
			<CFIF #OptionCount# IS 16>
	            <CFIF #getUVImportData.stereoType# GT ' '>
    	            <CFSET theoption = "#getUVImportData.stereoType#">
					<CFSET addrec = 1>
				</CFIF>
			</CFIF>
            <!--- Check for television --->
			<CFIF #OptionCount# IS 17>
	            <CFIF #getUVImportData.television# IS 'S'>
    	            <CFSET theoption = "Television">
					<CFSET addrec = 1>
				</CFIF>
			</CFIF>
            <!--- Check for Towing Package --->
			<CFIF #OptionCount# IS 18>
	            <CFIF #getUVImportData.towingPackage# IS 'S'>
    	            <CFSET theoption = "Towing Package">
					<CFSET addrec = 1>
				</CFIF>
			</CFIF>
            <!--- Check for Traction Control --->
			<CFIF #OptionCount# IS 19>
	            <CFIF #getUVImportData.tractionControl# IS 'S'>
    	            <CFSET theoption = "Traction Control">
					<CFSET addrec = 1>
				</CFIF>
			</CFIF>
            <!--- Check for rear air conditioning --->
			<CFIF #OptionCount# IS 20>
	            <CFIF #getUVImportData.seatingType# GT ' '>
    	            <CFSET theoption = "seats - " & "#getUVImportData.seatingType#">
					<CFSET addrec = 1>
				</CFIF>
			</CFIF>
	        <!--- If we have an option Add an option record to the UsedVehiclesOptions Table --->
			<CFIF #addrec# IS 1>
				<CFSET Optionscount = IncrementValue(Optionscount)>
				<CFQUERY NAME="addoptions" DATASOURCE="#gDSN#">
					INSERT INTO UsedVehiclesOptions (
								UsedVehicleID,
								options
								)
					VALUES (
							#GetUsedVehicleID.UsedVehicleID#,
						   '#theoption#'
						   )
				</CFQUERY>
				<CFSET addrec = 0>
			</CFIF>
    	</CFLOOP>												
	</CFIF>
  </CFTRANSACTION>
</cfloop>
<!--- Done with the awarchuck routine --->