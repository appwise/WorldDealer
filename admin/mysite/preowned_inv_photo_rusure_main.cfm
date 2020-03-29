<cfset PageAccess = application.dealer_access>

                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 21, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!--- $Id: preowned_inv_photo_rusure_main.cfm,v 1.11 2000/06/15 17:11:21 jkrauss Exp $ --->
<!--- Save Pre-Owned Vehicle Photo? --->
<cfoutput>
<cfif form.filecontents eq ''>
	<!--- existing photo, already in VIN.jpg format --->
	<cfset goodfiletype = true>
	<cfset display = #form.vin# & '.jpg'>
	<cfset tmpid = 0>
<cfelse>
	<!--- Find the next available Temp ID --->
	<cfx_directorylist directory="#g_rootdir#\images\usedvehicles"
	        name="image_query"
	        sort="type ASC, name ASC">
	<cfif #image_query.recordcount#>
		<cfset max_id = 0>
		<cfloop query="image_query">
			<cfif #mid(name,1,4)# is 'temp'>
				<cfset the_id = #gettoken(name,2, "_")#>
				<cfif #the_id# gt #max_id#>
					<cfset #max_id# = #the_id#>
				</cfif>
			</cfif> 
		</cfloop>
		<cfset #tmpid# = #max_id# + 1>
	<cfelse>
		<cfset tmpid = '1'>
	</cfif>
	<cfif goodbrowser>
		<form name="redirectinfo" action="preowned_inv_photo.cfm?redirect=yes" method="Post">
		<cfif isdefined("Form.UsedVehicleID")>
			<input type="hidden" name="UsedVehicleID" value="#form.UsedVehicleID#">
		</cfif>
		<input type="hidden" name="ChooseImage">
		<input type="hidden" name="ModelNumber" value="#Form.ModelNumber#">
		<input type="hidden" name="ModelName" value="">
		<input type="hidden" name="CarYear" value="#Trim(Form.CarYear)#">
		<input type="hidden" name="intcolor" value="#Trim(Form.intcolor)#">
		<input type="hidden" name="extcolor" value="#Trim(Form.extcolor)#">
		<input type="hidden" name="transmission" value="#Trim(Form.transmission)#">
		<input type="hidden" name="Mileage" value="#Trim(Form.Mileage)#">
		<input type="hidden" name="price" value="#Trim(Form.price)#">
		<input type="hidden" name="stock" value="#Trim(Form.stock)#">
		<input type="hidden" name="VIN" value="#Trim(Form.VIN)#">
		<input type="hidden" name="Features" value="#Trim(Form.Features)#">
		<input type="hidden" name="image" value="#Form.Image#">
		<cfloop from=1 to="5" index="count">
			<cfset tmp= evaluate('form.option' & #count#)>
			<input type="hidden" name="Option#count#" value="#tmp#">
		</cfloop>
		<input type="hidden" name="tmpid" value="#tmpid#">
		</form>
		<!--<script language="Javascript">
		
		function showImageSize() {
			if(document.checkit.width > 320) {
				parent.document.redirectinfo.submit();  //bounce 'em back to the image page
			}
		}
		
		</script>-->
	</cfif>
	<cferror type="request" template="uploaderror.cfm">
	<cffile action="UPLOAD"
		filefield="FileContents"
		destination="#g_rootdir#\images\usedvehicles\temp_#tmpid#_.jpg"
		nameconflict="Overwrite">

	<cfif #file.clientfileext# is not 'jpg'>
		<cfset goodfiletype = false>
	<cfelse>
		<cfset goodfiletype = true>
	</cfif> 
	
	<cfset display = 'temp_' & #tmpid# & '_.jpg'>
</cfif>

<table border="0" cellpadding="5" cellspacing="0" width="100%">
<cfif goodfiletype>
	<tr align="center">
		<td>
			Do you wish to display the image below with this Pre-Owned Vehicle?
		</td>
	</tr>
<cfelse>
	<tr align="center">
		<td>
			Sorry, the file you uploaded was invalid.  You must choose a JPEG file (.JPG extension).
			<br><br>
			Click <b>Back</b> to try again.
			<br>
			Click <b>Cancel</b> to return to the Pre-Owned vehicles listing.
		</td>
	</tr>
</cfif>
<tr align="center">
	<td>
		<img src="#application.RELATIVE_PATH#/images/usedvehicles/#display#" name="checkit">
		<br><br>
	</td>
</tr>
<tr align="center">
	<td>
		<cfif goodfiletype>
			<form name="GoodFile" action="preowned_inv_save.cfm" method="post">
		<cfelse>
			<form name="BadFile" action="preowned_inv_photo.cfm?mime=#file.clientfileext#" method="post">
		</cfif>
		
		<input type="hidden" name="ModelNumber" value="#Form.ModelNumber#">
	<input type="hidden" name="CarYear" value="#Trim(Form.CarYear)#">
	<input type="hidden" name="intcolor" value="#Trim(Form.intcolor)#">
	<input type="hidden" name="extcolor" value="#Trim(Form.extcolor)#">
	<input type="hidden" name="transmission" value="<cfif parameterexists(Form.transmission)>#Form.transmission#</cfif>">
	<input type="hidden" name="Mileage" value="#Trim(Form.Mileage)#">
	<input type="hidden" name="price" value="#Trim(Form.price)#">
	<input type="hidden" name="stock" value="#Trim(Form.stock)#">
	<input type="hidden" name="VIN" value="#Trim(Form.VIN)#">
	<input type="hidden" name="Features" value="#Trim(Form.Features)#">
	<input type="hidden" name="image" value="<cfif parameterexists(Form.Image)>#Form.Image#</cfif>">
	<input type="hidden" name="vehicleType" value="<cfif parameterexists(Form.vehicleType)>#Form.vehicleType#</cfif>">
	<input type="hidden" name="vehicleCategory" value="<cfif parameterexists(Form.vehicleCategory)>#Form.vehicleCategory#</cfif>">
	<input type="hidden" name="bodyStyle" value="<cfif parameterexists(Form.bodyStyle)>#Form.bodyStyle#</cfif>">
	<input type="hidden" name="doors" value="<cfif parameterexists(Form.doors)>#Form.doors#</cfif>">
	<input type="hidden" name="trim" value="#Form.trim#">
	<input type="hidden" name="tmpid" value="#tmpid#">
	
	<input type="hidden" name="engineSize" value="#Form.engineSize#">
	<input type="hidden" name="engineConfig" value="#Form.engineConfig#">
	<input type="hidden" name="engineCylinders" value="#Form.engineCylinders#">
	<input type="hidden" name="enginePerfType" value="<cfif parameterexists(Form.enginePerfType)>#Form.enginePerfType#</cfif>">
	<input type="hidden" name="driveType" value="<cfif parameterexists(Form.driveType)>#Form.driveType#</cfif>">
	<input type="hidden" name="upholstery" value="<cfif parameterexists(Form.upholstery)>#Form.upholstery#</cfif>">
	<input type="hidden" name="seatingType" value="<cfif parameterexists(Form.seatingType)>#Form.seatingType#</cfif>">
	<input type="hidden" name="amfm" value="<cfif parameterexists(form.amfm)>#Form.amfm#</cfif>">
	<input type="hidden" name="cd" value="<cfif parameterexists(form.cd)>#Form.cd#</cfif>">
	<input type="hidden" name="cassette" value="<cfif parameterexists(form.cassette)>#Form.cassette#</cfif>">
	<input type="hidden" name="cdChanger" value="<cfif parameterexists(form.cdChanger)>#Form.cdChanger#</cfif>">
	<input type="hidden" name="stereoRear" value="<cfif parameterexists(form.stereoRear)>#Form.stereoRear#</cfif>">
	<input type="hidden" name="television" value="<cfif parameterexists(form.television)>#Form.television#</cfif>">
	<input type="hidden" name="airConditioning" value="<cfif parameterexists(form.airConditioning)>#Form.airConditioning#</cfif>">
	<input type="hidden" name="airConditioningRear" value="<cfif parameterexists(form.airConditioningRear)>#Form.airConditioningRear#</cfif>">
	<input type="hidden" name="climateControl" value="<cfif parameterexists(form.climateControl)>#Form.climateControl#</cfif>">
	<input type="hidden" name="cruiseControl" value="<cfif parameterexists(form.cruiseControl)>#Form.cruiseControl#</cfif>">
	<input type="hidden" name="tiltWheel" value="<cfif parameterexists(form.tiltWheel)>#Form.tiltWheel#</cfif>">
	<input type="hidden" name="powerBrakes" value="<cfif parameterexists(form.powerBrakes)>#Form.powerBrakes#</cfif>">
	<input type="hidden" name="powerLocks" value="<cfif parameterexists(form.powerLocks)>#Form.powerLocks#</cfif>">
	<input type="hidden" name="powerSeats" value="<cfif parameterexists(form.powerSeats)>#Form.powerSeats#</cfif>">
	<input type="hidden" name="powerSteering" value="<cfif parameterexists(form.powerSteering)>#Form.powerSteering#</cfif>">
	<input type="hidden" name="powerWindows" value="<cfif parameterexists(form.powerWindows)>#Form.powerWindows#</cfif>">
	<input type="hidden" name="airbagDriver" value="<cfif parameterexists(form.airbagDriver)>#Form.airbagDriver#</cfif>">
	<input type="hidden" name="airbagPassenger" value="<cfif parameterexists(form.airbagPassenger)>#Form.airbagPassenger#</cfif>">
	<input type="hidden" name="ABS" value="<cfif parameterexists(form.ABS)>#Form.ABS#</cfif>">
	<input type="hidden" name="tractionControl" value="<cfif parameterexists(form.tractionControl)>#Form.tractionControl#</cfif>">
	<input type="hidden" name="boxType" value="<cfif parameterexists(Form.boxType)>#Form.boxType#</cfif>">
	<input type="hidden" name="payload" value="<cfif parameterexists(Form.payload)>#Form.payload#</cfif>">
	<input type="hidden" name="warranty" value="<cfif parameterexists(Form.warranty)>#Form.warranty#</cfif>">
	<input type="hidden" name="warrantyMonths" value="#Form.warrantyMonths#">
	<input type="hidden" name="warrantyMiles" value="#Form.warrantyMiles#">
	<input type="hidden" name="wheelDescription" value="<cfif parameterexists(Form.wheelDescription)>#Form.wheelDescription#</cfif>">
	<input type="hidden" name="luggageRack" value="<cfif parameterexists(form.luggageRack)>#Form.luggageRack#</cfif>">
	<input type="hidden" name="runningBoards" value="<cfif parameterexists(form.runningBoards)>#Form.runningBoards#</cfif>">
	<input type="hidden" name="slidingWindow" value="<cfif parameterexists(form.slidingWindow)>#Form.slidingWindow#</cfif>">
	<input type="hidden" name="towingPackage" value="<cfif parameterexists(form.towingPackage)>#Form.towingPackage#</cfif>">
			
		
		<cfloop from=1 to="5" index="count">
			<cfset tmp= evaluate('form.option' & #count#)>
			<input type="hidden" name="Option#count#" value="#tmp#">
		</cfloop>
		<cfif isdefined("form.UsedVehicleID")>
			<input type="hidden" name="UsedVehicleID" value="#form.UsedVehicleID#">
		</cfif>
		
		<cfif isdefined("form.NewUsed")>
			<input type="hidden" name="NewUsed" value="#form.NewUsed#">
		</cfif>
		
		<cfif goodfiletype>
			<input type="Image" src="#application.RELATIVE_PATH#/images/admin/save.gif" border="0" name="Save" value="Save">
		<cfelse>
			<a href="JavaScript:history.back();"
				onmouseover="self.status='Back';return true"
				onmouseout="self.status='';return true"><img
				src="#application.RELATIVE_PATH#/images/admin/back.gif" border="0" name="Back" value="Back"></a>
		</cfif>
		</form>
		<form action="preowned_inv.cfm" method="post">
		<input type="Image" src="#application.RELATIVE_PATH#/images/admin/cancel.gif" border="0" name="Cancel" value="Cancel">
		</form>
	</td>
</tr>
</table>
</cfoutput>