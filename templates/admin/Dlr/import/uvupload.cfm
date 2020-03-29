                        <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1998, 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <sometime back in 1998>
                          webmaster@sigma6.com and info@sigma6.com --->            
<!--- $Id: uvupload.cfm,v 1.24 2000/06/22 15:31:23 lswanson Exp $ --->
<!--- linda, 5/11/00: even tho this is faster, it still chokes on hundreds/thousands of records.  
will need to rewrite in java. --->

<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: uvupload.cfm,v $">

<!doctype html public "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<cfoutput>
	<head>
<!---Check URL New variable to determine if this is a 'New' or 'Previously Owned' vehicle upload 
     JC Xceed Consulting--->
		<cfif #New# eq "TRUE">
			<title>WorldDealer | New Vehicle Upload</title>
		<Cfelse>
			<title>WorldDealer | Used Vehicle Upload</title>
		</Cfif>
	</head>



<body>
<cfmodule template="/util/debug.cfm" text="turn debug messages on">
<cfmodule template="/util/debug.cfm" text="turn debug verbose messages on">


<cfquery name="DeleteImportedData" datasource="#gDSN#">
	DELETE FROM UVImport
</cfquery>

<cfmodule template="/util/DumpDebug.cfm" text="Deleted all UVImport records">

<!--- create the filename to retrieve via CFFTP --->
<cfset vardatestring = #dateformat(now(),"yyyymmdd")#>

<cfif #New# eq "True">
<cfset varfilename = #vardatestring# & '.nv.txt'>
<cfelse>
<cfset varfilename = #vardatestring# & '.txt'>
</cfif>

<!--- create the filepath for storing the file on the local system (this system) --->
<!--- linda, 10/29/99: This puts the formatted file on the server's (Olympus or Montana) C: drive.
Ali has restricted access to Olympus\temp, because it was getting too full of junk.  When you need to
see it again (for ADP uvuploading, further testing, etc.), let Ali know & he'll make it visible again. --->
<cfset varlocalfile = 'c:\temp\' & #varfilename#>

<!--- open an anonymous FTP connection --->
<cfftp action="Open"
       server="ftp.sigma6.com"
	   username="rr"
	   password="wd2000"
	   connection="UVRetrieve"
	   stoponerror="Yes">

<cfmodule template="/util/DumpDebug.cfm" text="Opened FTP Connection">

<!--- retrieve file --->	   
<cfftp action="GetFile"
	   connection="UVRetrieve"
       transfermode="ASCII"
       localfile="#varLocalFile#"
	   remotefile="/var/home/ftp/rr/rr/#varFileName#">

<cfmodule template="/util/DumpDebug.cfm" text="Retrieved FTP File">

<!--- close connection --->	  
<cfftp connection="UVRetrieve"
       action="Close">

<cfmodule template="/util/DumpDebug.cfm" text="Closed FTP Connection">

<!--- Linda, 5/9/00: Futile attempt at eliminating 5 steps (1. read file into variable, 2. replace characters within this variable,
3. loop through variable, inserting each record into an array, 4. insert each valid array into the UVImport table, 
5. (still required) delete dealerships' prev UV recs, 6. insert UVImport into UsedVehicles, UsedVehiclesOptions, and UVDetails.)
<cfhttp method="Get"
	url="#g_host#/temp/#varfilename#"
	name="getRRuv"
	columns="DealerID,stockNumber,year,make,model,trim,vehicleType,bodyStyle,color,miles,vin,retailPrice,doors,airConditioning,boxType,cruiseControl,driveType,driverAirBag,engineSize,engineConfig,engineCylinders,enginePerfType,fuelInjection,fuelType,luggageRack,optionalFuel,passengerAirBag,payloadType,powerLocks,powerSeats,powerSteering,powerWindows,raisedRoof,rearAirConditioning,rearStereo,runningBoards,shell,slidingWindow,stereoType,television,tiltWheel,towingPackage,tractionControl,transmission,vrc,vehicleCategory,domesticImport,brakes,climateControl,seatingCapacity,seatingType,sideDoor,upholstery,wheelDescription,engineDisplay"
	delimiter=","
	textqualifier="">
<cfmodule template="/util/DumpDebug.cfm" text="Queried text file.">

records: #getRRuv.recordcount#<br>
<cfloop query="getRRuv">
	dealer: '#getRRuv.DealerID#'<br>
	stock: '#getRRuv.stockNumber#'<br>
</cfloop>
--->

<!--- read in file from disk, store contents in a variable --->	   
<cffile action="Read"
        file="#varLocalFile#"
		variable="varUVContents">	  
		
<cfmodule template="/util/DumpDebug.cfm" text="Read File From Disk, #varLocalFile#">
	   
<!--- look for consecutive delimiters, and insert a space in between them --->
<!--- for some reason, the Replace function misses some of the consecutive delimiters on the first --->
<!--- pass, so do the Replace twice to get everything.  --->

<!--- linda, 4/12/00: insert spaces for ListToArray() --->
<cfset varuvcontents = replace(varuvcontents, "||", "| |", "ALL")>
<cfset varuvcontents = replace(varuvcontents, "||", "| |", "ALL")>

<!--- a stray ' in the data file will kill the insert query --->
<cfset varuvcontents = replace(varuvcontents, "'", "", "ALL")>

<cfmodule template="/util/DumpDebug.cfm" text="Searched & Replaced some characters">

<!--- the records from RR are delimited with a carriage-control (ASCII #13) and linefeed (ASCII #10) --->
<!--- the fields are delimited with a pipe character ("|") --->
<cfset delimiter = chr(13) & chr(10)>

<!--- we have no idea how many records there are, so append an end-of-file marker to the contents --->
<!--- then use the FIND function to get the last character before the end-of-file marker --->
<cfset varuvcontents = #varuvcontents# & #delimiter# & 'endoffile'>

<cfmodule template="/util/DumpDebug.cfm" text="Start Looping from now thru eternity">

<!--- Using the GetToken function, we can loop through the text file line by line, --->
<!--- doing an insert into UVImport for each line as we go.  Loop until we reach ENDOFFILE. --->
<!--- get 1st record --->
<cfset LineCounter = 1>
<cfset vartextline = gettoken(varuvcontents, #linecounter#, #delimiter#)>
<cfloop condition="not #find('endoffile', vartextline, 1)#">
	<!--- first, translate the line into a 1-D array of 57 elements --->
	<!--- 9/23/99: 55 elements now.  dropped picture (56) and certifications (57).  
		  So, array is just 55, but insert still needs to be 57, so send 2 empty cells at the end. --->
    
	<cfset arrayRecord = ListToArray(#vartextline#, "|")>

	<cfmodule template="/util/DumpDebug.cfm" text="found rec: #LineCounter#">

    <cfif #arraylen(arrayRecord)# eq 56>
	
		<!--- linda, 4/12/00: now that we're done w ListToArray(), take the extra spaces out again. --->
		<cfloop index="CellCounter" from="1" to="#ArrayLen(arrayRecord)#">
		    <cfif #left(arrayRecord[cellcounter], 1)# eq ' '>
				<cfset arrayRecord[#cellcounter#] = ''>
			</cfif>
		</cfloop>
	
		<!--- mileage: tho it's stored as text in the UVImport table, it's stored as a number in the Used Vehicles table --->
	    <cfif not isnumeric(#arrayRecord[10]#)>
		    <cfset arrayRecord[10] = 0>
		</cfif>
		
		<!--- price --->
	    <cfif not isnumeric(#arrayRecord[12]#)>
		    <cfset arrayRecord[12] = 0>
		</cfif>
		
		<!--- do the actual insert --->
		<!--- linda, 10/12/99: truncate to 20, so it doesn't stop the upload if data is longer.  
		for some fields (model, etc.), we need to make the field longer (35, etc.) so it matches the 
		Used Vehicles table. Whoever set up the UVImport table made all the fields 20 long. --->
	    <cfquery name="insUV#LineCounter#" datasource="#gDSN#" username="sa" password="">
	         INSERT INTO UVImport
			     VALUES ('#Left("#arrayRecord[1]#", 20)#',
						 '#Left("#arrayRecord[2]#", 20)#',
						 '#Left("#arrayRecord[3]#", 20)#',
						 '#Left("#arrayRecord[4]#", 20)#',
						 '#Left("#arrayRecord[5]#", 20)#',
						 '#Left("#arrayRecord[6]#", 20)#',
						 '#Left("#arrayRecord[7]#", 20)#',
						 '#Left("#arrayRecord[8]#", 20)#',
						 '#Left("#arrayRecord[9]#", 20)#',
						 '#Left("#arrayRecord[10]#", 20)#',
						 '#Left("#arrayRecord[11]#", 20)#',
	                     CONVERT(money,#arrayRecord[12]#),
						 '#Left("#arrayRecord[13]#", 20)#',
						 '#Left("#arrayRecord[14]#", 20)#',
						 '#Left("#arrayRecord[15]#", 20)#',
						 '#Left("#arrayRecord[16]#", 20)#',
						 '#Left("#arrayRecord[17]#", 20)#',
						 '#Left("#arrayRecord[18]#", 20)#',
						 '#Left("#arrayRecord[19]#", 20)#',
						 '#Left("#arrayRecord[20]#", 20)#',
						 '#Left("#arrayRecord[21]#", 20)#',
						 '#Left("#arrayRecord[22]#", 20)#',
						 '#Left("#arrayRecord[23]#", 20)#',
						 '#Left("#arrayRecord[24]#", 20)#',
						 '#Left("#arrayRecord[25]#", 20)#',
						 '#Left("#arrayRecord[26]#", 20)#',
						 '#Left("#arrayRecord[27]#", 20)#',
						 '#Left("#arrayRecord[28]#", 20)#',
						 '#Left("#arrayRecord[29]#", 20)#',
						 '#Left("#arrayRecord[30]#", 20)#',
						 '#Left("#arrayRecord[31]#", 20)#',
						 '#Left("#arrayRecord[32]#", 20)#',
						 '#Left("#arrayRecord[33]#", 20)#',
						 '#Left("#arrayRecord[34]#", 20)#',
						 '#Left("#arrayRecord[35]#", 20)#',
						 '#Left("#arrayRecord[36]#", 20)#',
						 '#Left("#arrayRecord[37]#", 20)#',
						 '#Left("#arrayRecord[38]#", 20)#',
						 '#Left("#arrayRecord[39]#", 20)#',
						 '#Left("#arrayRecord[40]#", 20)#',
						 '#Left("#arrayRecord[41]#", 20)#',
						 '#Left("#arrayRecord[42]#", 20)#',
						 '#Left("#arrayRecord[43]#", 20)#',
						 '#Left("#arrayRecord[44]#", 20)#',
						 '#Left("#arrayRecord[45]#", 20)#',
						 '#Left("#arrayRecord[46]#", 20)#',
						 '#Left("#arrayRecord[47]#", 20)#',
						 '#Left("#arrayRecord[48]#", 20)#',
						 '#Left("#arrayRecord[49]#", 20)#',
						 '#Left("#arrayRecord[50]#", 20)#',
						 '#Left("#arrayRecord[51]#", 20)#',
						 '#Left("#arrayRecord[52]#", 20)#',
						 '#Left("#arrayRecord[53]#", 20)#',
						 '#Left("#arrayRecord[54]#", 20)#',
						 '#Left("#arrayRecord[55]#", 20)#',
	                     '0',
	                     '')
	    </cfquery>	

		<cfmodule template="/util/DumpDebug.cfm" text="inserted into UVImport: #arrayRecord[1]#">
    </cfif>
	
	<!--- clear out the array, just to be sure --->
    <cfset varresult = arrayclear(arrayRecord)>	
    <!--- clear out the line bucket --->
	<cfset vartextline = ''>
	
	<!--- get subsequent records --->
	<cfset linecounter = #linecounter# +1>
    <cfset vartextline = gettoken(varuvcontents, #linecounter#, #delimiter#)>
</cfloop>

<!--- 9/10/99: Delete Used Vehicles belonging to dealerships that are Active--->
<!--- 11/5/99: Added ReynoldsActive field, cuz dealerships kept changing their mind, whether they wanted automatic upload or not. --->
<!--- 4/12/00: cleaned up query.  now it takes 1/10 the time!   I wish I could combine into 1 query, but M$ SQL doesn't allow multiple table deletes.--->
<!--- IMPROVED query, but not good for multiple files/day.
<cfquery name="delUsedVehOptions" datasource="#gDSN#">
	DELETE	UsedVehiclesOptions
	FROM	(DlrXRef 
			INNER JOIN UsedVehicles ON DlrXRef.dealerCode = UsedVehicles.DealerCode)
			INNER JOIN UsedVehiclesOptions ON UsedVehicles.UsedVehicleID = UsedVehiclesOptions.UsedVehicleID
	WHERE	DlrXRef.ReynoldsActive = 'Y'
</cfquery>

<cfquery name="delUsedVehDetails" datasource="#gDSN#">
	DELETE	UVDetails
	FROM	(DlrXRef 
			INNER JOIN UsedVehicles ON DlrXRef.dealerCode = UsedVehicles.DealerCode)
			INNER JOIN UVDetails ON UsedVehicles.UsedVehicleID = UVDetails.UsedVehicleID
	WHERE	DlrXRef.ReynoldsActive = 'Y'
</cfquery>

<cfquery name="delUsedVeh" datasource="#gDSN#">
	DELETE	UsedVehicles
	FROM	(DlrXRef 
			INNER JOIN UsedVehicles ON DlrXRef.dealerCode = UsedVehicles.DealerCode)
	WHERE	DlrXRef.ReynoldsActive = 'Y'
</cfquery>
--->

<!--- TEMPORARY , until we move back to 1 file/day.  We only want to delete the dealers' data that 
is contained in THAT 1 file we're working on (i.e. dealer is in the UVImport table). --->
<!--- linda, 5/15/00: M$ SQL doesn't like inner joins w huge data sets.  it's whimpy. >p  go back to stupid looping.
<cfquery name="delUsedVehOptions" datasource="#gDSN#">
	DELETE	UsedVehiclesOptions
	FROM 	((UVImport 
			INNER JOIN DlrXRef ON UVImport.DealerID = DlrXRef.reynoldsCode)
			INNER JOIN UsedVehicles ON DlrXRef.dealerCode = UsedVehicles.DealerCode)
			INNER JOIN UsedVehiclesOptions ON UsedVehicles.UsedVehicleID = UsedVehiclesOptions.UsedVehicleID
	WHERE	DlrXRef.ReynoldsActive = 'Y'
</cfquery>

<cfmodule template="/util/DumpDebug.cfm" text="Deleted existing UsedVehicleOptions from participating dealerships">

<cfquery name="delUsedVehDetails" datasource="#gDSN#">
	DELETE	UVDetails
	FROM 	((UVImport 
			INNER JOIN DlrXRef ON UVImport.DealerID = DlrXRef.reynoldsCode)
			INNER JOIN UsedVehicles ON DlrXRef.dealerCode = UsedVehicles.DealerCode)
			INNER JOIN UVDetails ON UsedVehicles.UsedVehicleID = UVDetails.UsedVehicleID
	WHERE	DlrXRef.ReynoldsActive = 'Y'
</cfquery>

<cfmodule template="/util/DumpDebug.cfm" text="Deleted existing UsedVehicleDetails from participating dealerships">

<cfquery name="delUsedVeh" datasource="#gDSN#">
	DELETE	UsedVehicles
	FROM 	((UVImport 
			INNER JOIN DlrXRef ON UVImport.DealerID = DlrXRef.reynoldsCode)
			INNER JOIN UsedVehicles ON DlrXRef.dealerCode = UsedVehicles.DealerCode)
	WHERE	DlrXRef.ReynoldsActive = 'Y'
</cfquery>

<cfmodule template="/util/DumpDebug.cfm" text="Deleted existing Used Vehicles from participating dealerships">
 --->
<!--- linda, 5/15/00: stupid, unelegant looping, to break it down into little pieces that M$ SQL can handle. --->
<!--- find all dealers in UVImport table --->
<cfquery name="getUVDealers" datasource="#gDSN#">
	SELECT DISTINCT	DlrXRef.DealerCode
	FROM	UVImport INNER JOIN DlrXRef ON UVImport.DealerID = DlrXRef.reynoldsCode
	WHERE	DlrXRef.ReynoldsActive = 'Y'
</cfquery>

<!--- for each dealer, find their used vehicles.  --->
<cfloop query="getUVDealers">
	<cfquery name="getDealerUV" datasource="#gDSN#">
		SELECT	UsedVehicleID
		FROM	UsedVehicles
		WHERE	DealerCode = '#getUVDealers.DealerCode#'
		<cfif #New# eq "TRUE">
		AND 	NewUsed =  'Y'
		<cfelse>
		AND 	NewUsed =  'N'
		</cfif>
	</cfquery>

	<!--- for each dealer's used vehicle found, delete UVOptions, UVDetails, & UV --->	
	<cfloop query="getDealerUV">
		<cfquery name="delUsedVehOptions" datasource="#gDSN#">
			DELETE	UsedVehiclesOptions
			WHERE	UsedVehicleID = #getDealerUV.UsedVehicleID#
		</cfquery>

		<cfquery name="delUsedVehDetails" datasource="#gDSN#">
			DELETE	UVDetails
			WHERE	UsedVehicleID = #getDealerUV.UsedVehicleID#
		</cfquery>
		
		<cfquery name="delUsedVeh" datasource="#gDSN#">
			DELETE	UsedVehicles
			WHERE	UsedVehicleID = #getDealerUV.UsedVehicleID#
		</cfquery>
	</cfloop>
</cfloop>

<cfmodule template="/util/DumpDebug.cfm" text="Deleted existing Used Vehicles from participating dealerships">

<!--- Find unique Makes in UVImport --->
<cfquery name="getUVImportMakes" datasource="#gDSN#">
	SELECT DISTINCT make
	FROM	UVImport
</cfquery>

<!--- Loop through the UVImport table and populate the UVMakes table --->
<cfloop query="getUVImportMakes">
	<!--- Query to see if Make already exists in the UVMakes table --->
 	<cfquery name="findMake" datasource="#gDSN#">
		SELECT	MakeNumber
      	FROM	UVMakes
     	WHERE	MakeName = '#getUVImportMakes.make#'
	</cfquery>

	<!--- Add Make into the UVMakes table, if it doesn't already exist --->
    <cfif not #findMake.RecordCount#>
		<cfquery name="getMaxMake" datasource="#gDSN#">
			SELECT	MAX(MakeNumber) as MakeNumber
			FROM	UVMakes
		</cfquery>
		
    	<cfquery name="addMake" datasource="#gDSN#">
			INSERT INTO UVMakes (
					MakeNumber, 
					MakeName)
			VALUES	(#incrementvalue(getMaxMake.MakeNumber)#,
					'#getUVImportMakes.make#')
		</cfquery>     			 
		
		<cfmodule template="/util/DumpDebug.cfm" text="Populated UVMakes table: #getUVImportMakes.make#">
	</cfif>
</cfloop>

<cfmodule template="/util/DumpDebug.cfm" text="Done populating UVMakes table.">

<!--- Find unique Models in UVImport --->
<cfquery name="getUVImportModels" datasource="#gDSN#">
	SELECT DISTINCT model, make
	FROM	UVImport
</cfquery>

<!--- Loop through the UVImport table and populate the UVModels table --->
<cfloop query="getUVImportModels">
	<!--- Query to see if Model already exists in the UVModels table 
	(have to cross-reference against UVMakes, cuz there may be several makes with the same modelname.  --->
 	<cfquery name="findModel" datasource="#gDSN#">
		SELECT	UVModels.ModelNumber, 
				UVModels.MakeNumber
		FROM 	UVModels INNER JOIN UVMakes ON UVModels.MakeNumber = UVMakes.MakeNumber
		WHERE 	UVModels.ModelName = '#getUVImportModels.model#' AND UVMakes.MakeName = '#getUVImportModels.make#'
	</cfquery>

	<!--- Add Model into the UVModels table, if it doesn't already exist --->
    <cfif not #findModel.RecordCount#>
		<cfquery name="getMaxModel" datasource="#gDSN#">
			SELECT	MAX(ModelNumber) as ModelNumber
			FROM	UVModels
		</cfquery>
		
	 	<cfquery name="getMake" datasource="#gDSN#">
			SELECT	MakeNumber
	      	FROM	UVMakes
	     	WHERE	MakeName = '#getUVImportModels.make#'
		</cfquery>
		
		<cfif #getMake.RecordCount#>
			<cfquery name="addModel" datasource="#gDSN#">
				INSERT INTO UVModels (
						ModelNumber,
						ModelName,
						MakeNumber)
				VALUES	(#incrementvalue(getMaxModel.ModelNumber)#,
						'#getUVImportModels.model#',
						#getMake.MakeNumber#)
			</cfquery>
			
			<cfmodule template="/util/DumpDebug.cfm" text="Populated UVModels table: #getUVImportModels.model#">
		<cfelse>
			<cfmodule template="/util/DumpDebug.cfm" text="Unable to add Model, #getUVImportModels.model#, because corresponding make, #getUVImportModels.make#, isn't in the UVMakes table yet.">
		</cfif>
	</cfif>
</cfloop>
		
<cfmodule template="/util/DumpDebug.cfm" text="Done populating UVModels table.">

<!---  Query to read the Converted Used Vehicle Data --->
<cfquery name="getUVImportData" datasource="#gDSN#">
	SELECT	DealerID,
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
			vehicleCategory,
			domesticImport,
			brakes,
			climateControl,
			seatingCapacity,
			seatingType,
			sideDoor,
			upholstery,
			wheelDescription,
			engineDisplay<!--- ,
			picture,
			certifications --->
	FROM	UVImport
</cfquery>

<cfmodule template="/util/DumpDebug.cfm" text="got UVImport data">

<!--- Let's loop through the UVImport table and populate the UsedVehicles & UVDetails tables --->
<cfloop query="getUVImportData">
	<cftransaction>
	<!--- get our DealerCode, converting from ReyRey DealerID --->
	<!--- linda, 10/13/99: also, to make sure they're participating in auto upload.  
	If they're not in our DlrXRef table, don't add their records --->
	<!--- 11/5/99: Added ReynoldsActive field, cuz dealerships kept changing their mind, whether they wanted automatic upload or not. --->
	<cfquery name="getDealerCode" datasource="#gDSN#">
		SELECT	DealerCode
		FROM	DlrXRef
		WHERE	reynoldsCode = '#getUVImportData.DealerID#'
		AND		DlrXRef.ReynoldsActive = 'Y'
	</cfquery>

	<cfif not #getdealercode.recordcount#>
		<cfmodule template="/util/DumpDebug.cfm" text="Getting data for non-participating dealership: #getUVImportData.DealerID#">
	<cfelse>
		<!--- Query to find Model# from UVModels table.
		(have to cross-reference against UVMakes, cuz there may be several makes with the same modelname.  --->
	 	<cfquery name="getModel" datasource="#gDSN#">
			SELECT	UVModels.ModelNumber
			FROM 	UVModels INNER JOIN UVMakes ON UVModels.MakeNumber = UVMakes.MakeNumber
			WHERE 	UVModels.ModelName = '#getUVImportData.model#' AND UVMakes.MakeName = '#getUVImportData.make#'
		</cfquery>
	
		<cfquery name="addUsedVehicle" datasource="#gDSN#">
			INSERT INTO UsedVehicles (
					DealerCode,
					VIN,
					ModelName,	<!--- linda, 4/11/00: i wanted to stop using this field, in favor of ModelNumber, but it's a required field, so we have to keep populating it. :(  Alternate: could populate with ' '. --->
					CarYear,
					Features,
					Image,
					intcolor,
					extcolor,
					transmission,
					mileage,
					price,
					stock,
					Make,	<!--- linda,5/9/00: no longer using this field, in favor of ModelNumber, which links to UVModels & UVMakes --->
					doors,
					trim,
					vehicleType,
					bodyStyle,
					vehicleCategory,
					ModelNumber,
					NewUsed
					)
			VALUES (
					'#getDealerCode.DealerCode#',	<!--- Dealer Code --->
					'#getUVImportData.vin#',		<!--- VIN Number --->
					'',							<!--- Model Name --->
					#getUVImportData.year#,			<!--- Model Year --->
					'',								<!--- Features --->
					'N',							<!--- Image Flag --->
					'',								<!--- Interior Color --->
					'#getUVImportData.color#',		<!--- External Color --->
					<!--- linda, 5/10/00: show all the detail now.  Pre-Owned page is sophisticated enough now to handle diversity.
					<cfif #getuvimportdata.transmission# eq 'automatic'
							or #getuvimportdata.transmission# eq 'auto w/od'> 
                              'Automatic',
					<cfelseif #getuvimportdata.transmission# eq 'manual'
							or #getuvimportdata.transmission# eq '4 speed'
							or #getuvimportdata.transmission# eq '5 speed'
							or #getuvimportdata.transmission# eq '6 speed'> 	
						'Manual',
					<cfelse>
					    'other',
					</cfif> --->
					<!--- linda, 5/23/00: RR is sending over some abbreviated data.  Expand the words out. --->
					<cfif #getuvimportdata.transmission# eq 'A'>	<!--- Transmission Type --->
						'Automatic',
					<cfelseif #getuvimportdata.transmission# eq 'M'>
						'Manual',
					<cfelse>
						'#getuvimportdata.transmission#',
					</cfif>
					#getUVImportData.miles#,			<!--- Mileage --->
					#getUVImportData.retailPrice#,		<!--- Price --->
					'#getuvimportdata.stocknumber#',	<!--- Stock Number --->
					'',									<!--- Make --->
					'#getUVImportData.doors#',			<!--- doors --->
					'#getUVImportData.trim#',			<!--- trim --->
					'#getUVImportData.vehicleType#',	<!--- vehicleType --->
					'#getUVImportData.bodyStyle#',		<!--- bodyStyle --->
					'#getUVImportData.vehicleCategory#',<!--- vehicleCategory --->
					#getmodel.ModelNumber#,				<!--- ModelNumber --->
					<cfif #New# eq "TRUE">  			<!---NewUsed : 10/1/00 JC Xceed Consulting --->
					'Y'
					<cfelse>
					'N'
					</cfif>
					)
		</cfquery>
		
        <!--- Now we need to get the UsedVehicleID for the Vehicle we just added from UsedVehicles Table --->
   	    <cfquery name="getMaxID" datasource="#gDSN#">
			SELECT	Max(UsedVehicleID) as UsedVehicleID
            FROM	UsedVehicles
		</cfquery>
		
		<!--- Now we need to add all the details to the UVDetails table --->
		<cfquery name="addDetails" datasource="#gDSN#">
			INSERT INTO	UVDetails(
					UsedVehicleID,
					domesticImport,
					wheelDescription,
					engineSize,
					engineConfig,
					engineCylinders,
					enginePerfType,
					fuelInjection,
					fuelTYpe,
					altFuelType,
					airConditioning,
					airConditioningRear,
					climateControl,
					driveType,
					seatingCapacity,
					seatingType,
					upholstery,
					stereoType,
					stereoRear,
					television,
					cruiseControl,
					powerLocks,
					powerSeats,
					powerSteering,
					powerWindows,
					tiltWheel,
					airbagDriver,
					airbagPassenger,
					brakes,
					tractionControl,
					boxType,
					luggageRack,
					payload,
					raisedRoof,
					runningBoards,
					shell,
					sideDoor,
					slidingWindow,
					towingPackage,
					warranty,
					warrantyMonths,
					warrantyMiles,
					serviceAgreement
					)
			VALUES	(
					#getMaxID.UsedVehicleID#,
					'#getUVImportData.domesticImport#',
					'#getUVImportData.wheelDescription#',
					'#getUVImportData.engineSize#',
					<cfif #getUVImportData.engineConfig# eq 'In-line'>
						'I'
					<cfelse>
						'#getUVImportData.engineConfig#'
					</cfif>,
					'#getUVImportData.engineCylinders#',
					'#getUVImportData.enginePerfType#',  <!--- TBO = turbo --->
					<cfif #getuvimportdata.fuelinjection# eq 'I' or #getuvimportdata.fuelinjection# eq 'S'>
   	    	    	    'Fuel Injection'
					<cfelse>
						'#getuvimportdata.fuelinjection#'
					</cfif>,
					'#getUVImportData.fuelType#',
					'#getUVImportData.optionalFuel#',
					<cfif #getuvimportdata.airconditioning# eq 'S'>'Y'<cfelse>''</cfif>,
					<cfif #getuvimportdata.rearairconditioning# eq 'S'>'Y'<cfelse>''</cfif>,
					<cfif #getuvimportdata.climatecontrol# eq 'S'>'Y'<cfelse>''</cfif>,
					'#getUVImportData.driveType#',
					'#getUVImportData.seatingCapacity#',
					'#getUVImportData.seatingType#',
					'#getUVImportData.upholstery#',
					'#Replace(getUVImportData.stereoType, "Tape", "Cassette")#',
					<cfif #getuvimportdata.rearstereo# eq 'S'>'Y'<cfelse>''</cfif>,
					<cfif #getuvimportdata.television# eq 'S'>'Y'<cfelse>''</cfif>,
					<cfif #getuvimportdata.cruisecontrol# eq 'S'>'Y'<cfelse>''</cfif>,
					<cfif #getuvimportdata.powerlocks# eq 'S'>'Y'<cfelse>''</cfif>,
					<cfif #getuvimportdata.powerseats# eq 'S'>'Y'<cfelse>''</cfif>,
					<cfif #getuvimportdata.powersteering# eq 'S'>'Y'<cfelse>''</cfif>,
					<cfif #getuvimportdata.powerwindows# eq 'S'>'Y'<cfelse>''</cfif>,
					<cfif #getuvimportdata.tiltwheel# eq 'S'>'Y'<cfelse>''</cfif>,
					<cfif #getuvimportdata.driverairbag# eq 'S'>'Y'<cfelse>''</cfif>,
					<cfif #getuvimportdata.passengerairbag# eq 'S'>'Y'<cfelse>''</cfif>,
					'#getUVImportData.brakes#',
					'#getUVImportData.tractioncontrol#',
					'#getUVImportData.boxType#',
					<cfif #getuvimportdata.luggagerack# eq 'S'>'Y'<cfelse>''</cfif>,
					'#getUVImportData.payloadType#',
					<cfif #getuvimportdata.raisedroof# eq 'S'>'Y'<cfelse>''</cfif>,
					<cfif #getuvimportdata.runningboards# eq 'S'>'Y'<cfelse>''</cfif>,
					<cfif #getuvimportdata.shell# eq 'S'>'Y'<cfelse>''</cfif>,
					<cfif #getuvimportdata.sidedoor# eq 'S'>'Y'<cfelse>''</cfif>,
					<cfif #getuvimportdata.slidingwindow# eq 'S'>'Y'<cfelse>''</cfif>,
					<cfif #getuvimportdata.towingpackage# eq 'S'>'Y'<cfelse>''</cfif>,
					'',	<!--- warranty --->
					'',	<!--- warrantyMonths --->
					0,	<!--- warrantyMiles --->
					''	<!--- serviceAgreement --->
					)
		</cfquery>
	</cfif>
	</cftransaction>
</cfloop>
</cfoutput>

<cfmodule template="/util/DumpDebug.cfm" text="Populated UsedVehicles and UVDetails tables">

<!--- delete the file from the c:/temp directory.  Some servers (Karachi, etc.) don't let you overwrite a file.
So when I run it for 5 different files, all named the same, it's actually just rerunning the 1st file 5 times. --->	   
<cffile action="Delete"
        file="#varLocalFile#">	  

<!--- linda, 12/6/99: check against the used car photos.  & set the "Image" field to "Y".
Decided to do separate file, in case we ever want to run it by itself. --->
<!--- linda, 3/21/00: comment out for now.  running it separately, since we have 5 uploads/day, no need to run this 5 times!
<cfinclude template="updPics.cfm"> --->

<cfmodule template="/util/DumpDebug.cfm" text="Done.  Sending email.">

<cfmail to="jweitz@worlddealer.net"
		from="lswanson@sigma6.com"
		subject="WorldDealer Used Vehicle Daily Load"
		server="mail.sigma6.com">
		The daily vehicle <cfif #New# eq "TRUE">used<cfelse>new</cfif> upload has completed.
</cfmail>
<cfmodule template="/util/debug.cfm" text="turn debug messages off">
</body>
</html>
<!--- printtrace: so it prints out --->
<cfmodule template="/util/DumpDebug.cfm" text="end   $RCSfile: uvupload.cfm,v $" printtrace="true">
