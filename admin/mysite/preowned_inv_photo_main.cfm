<cfset PageAccess = application.dealer_access>

                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 21, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!--- $Id: preowned_inv_photo_main.cfm,v 1.9 2000/06/15 17:11:21 jkrauss Exp $ --->
<!--- Pre-Owned Vehicle Photo --->

<cfset carImage = false>
<cfif isdefined("form.UsedvehicleID")>
	<cfset editmode = true>
	<cfquery name="CheckImage" datasource="#gDSN#">
		SELECT	Image
		FROM	UsedVehicles
		WHERE	UsedVehicleID = #Form.UsedVehicleID#;
	</cfquery>
	<cfif CheckImage.Image eq "Y">
		<cfset carImage = true>
	</cfif>
<cfelse>
	<cfset editmode = false>
</cfif>

<table border="0" cellpadding="5" cellspacing="0" width="100%">
<form name="PreOwnedPhoto" action="preowned_inv_photo_rusure.cfm" method="post" enctype="multipart/form-data">
<cfif isdefined("Url.Redirect")>
	<input type="hidden" name="FileContents_required" value="<A HREF='Javascript:history.back();'>You must select a file to Upload.</a>">
	<tr align="center">
		<td>
			The image you chose, shown below, is larger than the acceptable size (320 pixels wide by 240 pixels high).
			<br><b>Please choose another image</b>.
			<br><br><br>
		</td>
	</tr>
	<tr align="center">
		<td>
			<img src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/usedvehicles/temp_<cfoutput>#tmpid#</cfoutput>_.jpg">
		</td>
	</tr>
<cfelseif isdefined("URL.mime")>
	<input type="hidden" name="FileContents_required" value="<A HREF='Javascript:history.back();'>You must select a file to Upload.</a>">
	<tr align="center">
		<td>
			The image you chose, shown below, is not a JPEG file (.jpg extension)
			<br><b>Please choose another image.</b>
			<br><br><br>
			<img src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/usedvehicles/temp_<cfoutput>#tmpid#</cfoutput>_.jpg">
		</td>
	</tr>
<cfelse>
	<cfif carImage>
		<tr align="center">
			<td>
				The image below will be displayed with this Used Vehicle.
				<br>
				<i>Note:</i> If the image shown below is incorrect, please click the
				<b>Reload</b> button on your browser.
			</td>
		</tr>
		<tr align="center">
			<td>
				<img src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/usedvehicles/<cfoutput>#form.VIN#</cfoutput>.jpg">
			</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>
		<tr align="center">
			<td>
				If you wish to replace this image, enter the name of the file you wish to upload, or click the <i>Browse</i> button
				to choose from a list of files.
				<br>
				Leave this field blank to continue displaying the image above.
				<br>
				
				<i>Note:</i> The file you upload must be a JPEG file (.jpg file extension) and must be less than 320 pixels wide by 240 pixels high.
			</td>
		</tr>
	<cfelse>
		<input type="hidden" name="FileContents_required" value="<A HREF='Javascript:history.back();'>You must select a file to Upload.</a>">
		<tr align="center">
			<td>
				Enter the name of the file you wish to upload, or click <i>Browse</i> to choose from a list of files.
				<br>
				<i>Note:</i> The file you upload must be a JPEG file (.jpg file extension) and must be less than 320 pixels wide by 240 pixels high.
			</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>
	</cfif>
	<tr>
		<td align="center">
			<i>Note:</i> You must be using Netscape (version 3 or higher) or Microsoft Internet Explorer (version 4 or higher) to upload images.
		</td>
	</tr>
</cfif>
<tr align="center">
	<td>
		<!--- Linda: is there any way to make the default type in the drop-down of "browse" be .jpg?  instead of .html? --->
		<input type="file" name="FileContents">
	</td>
</tr>
<cfoutput>
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
</cfoutput>

<cfloop from=1 to="5" index="count">
	<cfset tmp= evaluate('form.option' & #count#)>
	<input type="hidden" name="option<CFOUTPUT>#count#</cfoutput>" value="<cfoutput>#tmp#</cfoutput>">
</cfloop>
<cfif isdefined("form.UsedVehicleID")>
	<input type="hidden" name="UsedVehicleID" value="<CFOUTPUT>#form.UsedVehicleID#</cfoutput>">
</cfif>

<cfif isdefined("form.NewUsed")>
	<input type="hidden" name="NewUsed" value="<CFOUTPUT>#form.NewUsed#</cfoutput>">
</cfif>

<tr align="center">
	<td>
		<a href="JavaScript:history.back();"
			onmouseover="self.status='Back';return true"
			onmouseout="self.status='';return true"><img
			src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/back.gif" border="0" name="Back" value="Back"></a>
		<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/next.gif" BORDER="0" NAME="Next" VALUE="Next">
		</form>
		<form action="preowned_inv.cfm" method="post">
		<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/cancel.gif" BORDER="0" NAME="Cancel" VALUE="Cancel">
		</form>
	</td>
</tr>
</table>
