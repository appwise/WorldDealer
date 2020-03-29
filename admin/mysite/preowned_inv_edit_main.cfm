<a name="top"></a>
<cfset PageAccess = application.dealer_access>

                        <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 20, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: preowned_inv_edit_main.cfm,v 1.12 2000/06/15 17:11:21 jkrauss Exp $--->

<!--- if Delete, redirect to delete form --->
<cfif #isdefined("form.Delete.X")#>
	<cflocation url="preowned_inv_del_rusure.cfm?UsedVehicleID=#URL.UsedVehicleID#">
</cfif>

<cfset detailsExist = false>

<cfoutput>
<!--- get existing used vehicle info --->
<cfif #isdefined("URL.UsedVehicleID")#>
	<cfquery name="getUsedVehicle" datasource="#gDSN#">
		SELECT *
		FROM UsedVehicles
		WHERE UsedVehicleID = #URL.UsedVehicleID#
	</cfquery>
	
	<cfquery name="getUVDetails" datasource="#gDSN#">
		SELECT *
		FROM UVDetails
		WHERE UsedVehicleID = #URL.UsedVehicleID#
	</cfquery>
	
	<cfif getUVDetails.recordcount gt 0>
		<cfset detailsExist = true>
	</cfif>
	
	<cfquery name="getVehicleMake" datasource="#gDSN#">
		SELECT MakeNumber
		FROM UVModels
		WHERE ModelNumber = #getUsedVehicle.ModelNumber#
	</cfquery>
	
	<cfquery name="getExtraOptions" datasource="#gDSN#">
		SELECT	RowID,
				Options
		FROM	UsedVehiclesOptions
		WHERE	UsedVehicleID = #URL.UsedVehicleID#
	</cfquery>
	
	<cfset editmode = true>
<cfelse>
	<cfset editmode = false>
</cfif>

<!--- get Makes for drop-down --->
<cfquery name="getMakes" datasource="#gDSN#">
	SELECT *
	FROM UVMakes
	ORDER BY MakeName
</cfquery>

<!--- get Models for drop-down, based on selected make --->
<cfif editmode or isdefined("URL.Make")>
	 <!--- linda, 1/27/2000: have to "undo" urlencoding that was required for javascript's use of the make in the URL
	 		joel 4/11/2000: not any more...we're sending make number now ... not name ... 4.0 rulez!!
	<cfif isdefined("URL.Make")>
		<cfset URL.make = #Replace("#URL.make#", "%20", " ", "ALL")#>
	</cfif> --->
	<cfquery name="getModels" datasource="#gDSN#">
		SELECT ModelNumber, ModelName
		FROM UVModels
		<cfif editmode>
			WHERE	MakeNumber = #getVehicleMake.MakeNumber#
		<cfelseif isdefined("URL.Make")>
			WHERE	MakeNumber = #URL.make#
		</cfif>
		ORDER BY ModelName;
	</cfquery>
</cfif>

<cfif goodbrowser>
	<script language="JavaScript">
	<!--  
	function onMakeChange()
		{
		with(document.forms[0].MakeNumber)
			selectedMake = options[selectedIndex].value
		
		if (selectedMake != '')
			location.href = 'preowned_inv_edit.cfm?make=' + selectedMake;
		else
			// this sets it back to the default.
			location.href = 'preowned_inv_edit.cfm';
		}
	//-->
	</script>
</cfif>

<!--- pale yellow-ish background     bgcolor="##FCCA00" --->
<table width="100%" border="0" cellspacing="0" cellpadding="3" bgcolor="White">
<tr>
	<td colspan="2" align="center">

		<table border="0" cellspacing="0" cellpadding="3">
		<form name="EditPreOwned" action="preowned_inv_photo.cfm" method="post">
		<tr align="center">
			<td colspan="4">
			Enter the following information. Required fields are bolded.<p>
			<font size="-1"><a href="##veh">vehicle description</a>  |  <a href="##perf">performance</a>  |  <a href="##opt">options</a>  |  <a href="##comm">comments</a>  |  <a href="##photo">photo</a></font>
			</td>
		</tr>
		<tr bgcolor="##FCCA00">
			<td colspan="3"><a name="perf"></a><b>Vehicle Description</b></td>
			<td align="RIGHT"><font size="-1"><a href="##top" style="color: Black;">back to top</a></font></td>
		</tr>
		<tr>
			<td align="right"><font size="-1"><b>Make:</b></font></td>
			<td>
				<font size="-1">
				<!--- if they select a make, change the models that are shown in the models drop-down --->
				<select name="MakeNumber" <cfif #goodbrowser#>onChange="onMakeChange()"</cfif>>
				<option value="">Select a make</option>
				<cfloop query="getMakes">
					<!--- linda, 12/30/99: need to urlencode, cuz javascript generates a URL param out of it.  i.e., 'AM General' failed before. --->
					<!--- have to decode before using in a query: replace '%20' with ' ' --->
					<option value="#MakeNumber#" 
					<cfif editmode>
						<cfif MakeNumber eq #getVehicleMake.MakeNumber#>
							selected
						</cfif>
					<cfelseif isdefined("URL.make")>
						<cfif (MakeNumber eq url.make)>
							selected
						</cfif>
					</cfif>
					>#MakeName#</option>
				</cfloop>
				</select>
				<input type="hidden" name="MakeNumber_required">
				</font>
			</td>
			<td align="right"><font size="-1">Mileage:</font></td>
			<td>
				<input type="text" name="mileage" <cfif editmode>value="#rtrim(getUsedVehicle.mileage)#"</cfif> size=11 maxlength=7>
				<!--- force them to enter a numeric value for mileage --->
				<input type="hidden" name="mileage_integer">
			</td>
		</tr>
		<tr bgcolor="##FFFAE6">
			<td align="right"><font size="-1"><b>Model:</b></font></td>
			<td>
				<font size="-1">
				<select name="ModelNumber">
				<cfif isdefined("getModels.RecordCount")>
					<option value="">Select a model</option>
					<cfloop query="getModels">
						<option value="#ModelNumber#" <cfif editmode><cfif #ModelNumber# eq rtrim(#getusedvehicle.ModelNumber#)>SELECTED</cfif></cfif>>#ModelName#</option>
					</cfloop>
				<cfelse>
					<option value="">Please select a make first</option>
				</cfif>
				</select>
				</font>
			</td>
			<td align="right"><font size="-1">Price:</font></td>
			<td>
				<input type="text" name="price" value="<cfif editmode>#DollarFormat(rtrim(getUsedVehicle.price))#</cfif>" size=11 maxlength=11>
				<!--- force them to enter a numeric value for price --->
				<input type="hidden" name="price_integer">
			</td>
		</tr>
		<tr>
			<td align="right"><font size="-1"><b>Year:</b></font></td>
			<td colspan="3">
				<input type="Text" name="CarYear" size="4" maxlength="4" value="<cfif editmode>#rtrim(getUsedVehicle.Caryear)#</cfif>">
				<input type="hidden" name="CarYear_required">
			</td>
		</tr>
		<tr bgcolor="##FFFAE6">
			<td align="right"><font size="-1"><b>VIN:</b></font></td>
			<td colspan="3">
				<input type="text" name="VIN" value="<cfif editmode>#rtrim(getUsedVehicle.VIN)#</cfif>" size="17" maxlength="17">
				<input type="hidden" name="VIN_required"> 
			</td>
		</tr>
		<tr>
			<td align="right"><font size="-1">Stock:</font></td>
			<td colspan="3">
				<input type="text" name="stock" value="<cfif editmode>#rtrim(getUsedVehicle.stock)#</cfif>" size=15 maxlength=15>
			</td>
		</tr>
		<tr bgcolor="##FFFAE6">
			<td align="right"><font size="-1">Exterior Color:</font></td>
			<td colspan="3">
				<input type="text" name="extcolor" value="<cfif editmode>#rtrim(getUsedVehicle.extcolor)#</cfif>" size=10 maxlength=20>
			</td>
		</tr>
		<tr>
			<td align="right"><font size="-1">Interior Color:</font></td>
			<td colspan="3">
				<input type="text" name="intcolor" value="<cfif editmode>#rtrim(getUsedVehicle.intcolor)#</cfif>" size=10 maxlength=20>
			</td>
		</tr>
		<tr bgcolor="##FFFAE6"> 
			<td align="right"><font size="-1"><b></b>Pre-Owned:</b></Font></td>
			<td colspan="3" valign="TOP">
				<table border="0" cellspacing="0" cellpadding="0">
				<td valign="TOP">
					<font size="-1">
						<input type="Radio" name="NewUsed" value="N" <cfif editmode><cfif #getUsedVehicle.NewUsed# is 'N'>checked<cfelseif #trim(getUsedVehicle.NewUsed)# is ''>checked</cfif><cfelse>checked</cfif>>Pre-Owned<br>
					</font>
				</td>
				<td width="20">&nbsp;</td>
				<td valign="TOP">
					<font size="-1">
					<input type="Radio" name="NewUsed" value="Y" <cfif editmode><cfif #getUsedVehicle.NewUsed# is 'Y'>checked</cfif></cfif>>New Vehicle<br>
					</font>
				</td>	
				</Table>
			</td>
		</tr>
		<tr>
			<td align="RIGHT" valign="TOP"><font size="-1">Vehicle Type:</font></td>
			<td colspan="3" valign="TOP">
				<table border="0" cellspacing="0" cellpadding="0">
					<td valign="TOP">
						<font size="-1">
						<input type="Radio" name="vehicleType" value="Car" <cfif editmode><cfif #getUsedVehicle.vehicleType# is 'Car'>checked</cfif></cfif>>Car<br>
						<input type="Radio" name="vehicleType" value="Sport Utility" <cfif editmode><cfif #getUsedVehicle.vehicleType# contains 'Sport'>checked</cfif></cfif>>SUV<br>
						<input type="Radio" name="vehicleType" value="Truck" <cfif editmode><cfif #getUsedVehicle.vehicleType# is 'Truck'>checked</cfif></cfif>>Truck
						</font>
					</td>
					<td width="20">&nbsp;</td>
					<td valign="TOP">
						<font size="-1">
						<input type="Radio" name="vehicleType" value="Van" <cfif editmode><cfif #getUsedVehicle.vehicleType# is 'Van'>checked</cfif></cfif>>Van<br>
						<input type="Radio" name="vehicleType" value="Motorcycle" <cfif editmode><cfif #getUsedVehicle.vehicleType# is 'Motorcycle'>checked</cfif></cfif>>Motorcycle<br>
						<input type="Radio" name="vehicleType" value="" <cfif editmode><cfif #trim(getUsedVehicle.vehicleType)# is ''>checked</cfif><cfelse>checked</cfif>>Other
						</font>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr bgcolor="##FFFAE6">
			<td align="RIGHT" valign="TOP"><font size="-1">Vehicle Category:</font></td>
			<td colspan="3" valign="TOP">
				<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="TOP">
						<font size="-1">
						<input type="Radio" name="vehicleCategory" value="Luxury" <cfif editmode><cfif #getUsedVehicle.vehicleCategory# is 'Luxury'>checked</cfif></cfif>>Luxury<br>
						<input type="Radio" name="vehicleCategory" value="Full-Size" <cfif editmode><cfif #getUsedVehicle.vehicleCategory# is 'Full-Size'>checked</cfif></cfif>>Full-size<br>
						<input type="Radio" name="vehicleCategory" value="Mid-Size" <cfif editmode><cfif #getUsedVehicle.vehicleCategory# is 'Mid-Size'>checked</cfif></cfif>>Mid-size<br>
						<input type="Radio" name="vehicleCategory" value="Sport" <cfif editmode><cfif #getUsedVehicle.vehicleCategory# is 'Sport'>checked</cfif></cfif>>Sport
						</font>
					</td>
					<td width="20">&nbsp;</td>
					<td valign="TOP">
						<font size="-1">
						<input type="Radio" name="vehicleCategory" value="Compact" <cfif editmode><cfif #getUsedVehicle.vehicleCategory# is 'Compact'>checked</cfif></cfif>>Compact<br>
						<input type="Radio" name="vehicleCategory" value="Subcompact" <cfif editmode><cfif #getUsedVehicle.vehicleCategory# is 'Subcompact'>checked</cfif></cfif>>Subcompact<br>
						<input type="Radio" name="vehicleCategory" value="Minivan" <cfif editmode><cfif #lcase(getUsedVehicle.vehicleCategory)# contains 'mini'>checked</cfif></cfif>>Minivan<br>
						<input type="Radio" name="vehicleCategory" value="" <cfif editmode><cfif #trim(getUsedVehicle.vehicleCategory)# is ''>checked</cfif><cfelse>checked</cfif>>Other
						</font>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="right" valign="TOP"><font size="-1">Body Style:</font></td>
			<td colspan="3" valign="TOP">
				<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="TOP">
						<font size="-1">
						<input type="Radio" name="bodyStyle" value="Sedan" <cfif editmode><cfif #getUsedVehicle.bodyStyle# is 'Sedan'>checked</cfif></cfif>>Sedan<br>
						<input type="Radio" name="bodyStyle" value="Coupe" <cfif editmode><cfif #getUsedVehicle.bodyStyle# is 'Coupe'>checked</cfif></cfif>>Coupe<br>
						<input type="Radio" name="bodyStyle" value="Convertible" <cfif editmode><cfif #getUsedVehicle.bodyStyle# is 'Convertible'>checked</cfif></cfif>>Convertible<br>
						<input type="Radio" name="bodyStyle" value="Hatchback" <cfif editmode><cfif #getUsedVehicle.bodyStyle# is 'Hatchback'>checked</cfif></cfif>>Hatchback
						</font>
					</td>
					<td width="20">&nbsp;</td>
					<td valign="TOP">
						<font size="-1">
						<input type="Radio" name="bodyStyle" value="Wagon" <cfif editmode><cfif #getUsedVehicle.bodyStyle# is 'Wagon'>checked</cfif></cfif>>Wagon<br>
						<input type="Radio" name="bodyStyle" value="Extended" <cfif editmode><cfif #getUsedVehicle.bodyStyle# is 'Extended'>checked</cfif></cfif>>Extended<br>
						<input type="Radio" name="bodyStyle" value="" <cfif editmode><cfif #trim(getUsedVehicle.bodyStyle)# is ''>checked</cfif><cfelse>checked</cfif>>Other
						</font>
					</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr bgcolor="##FFFAE6">
			<td align="right" valign="TOP"><font size="-1">Doors:</font></td>
			<td colspan="3" valign="TOP">
				<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="TOP">
					<td valign="TOP">
						<font size="-1">
						<input type="Radio" name="doors" value="2 Door" <cfif editmode><cfif #getUsedVehicle.doors# contains '2'>checked</cfif></cfif>>2 Doors<br>
						<input type="Radio" name="doors" value="3 Door" <cfif editmode><cfif #getUsedVehicle.doors# contains '3'>checked</cfif></cfif>>3 Doors
						</font>
					</td>
					<td width="20">&nbsp;</td>
					<td valign="TOP">
						<font size="-1">
						<input type="Radio" name="doors" value="4 Door" <cfif editmode><cfif #getUsedVehicle.doors# contains '4'>checked</cfif></cfif>>4 Doors<br>
						<input type="Radio" name="doors" value="" <cfif editmode><cfif #trim(getUsedVehicle.doors)# is ''>checked</cfif><cfelse>checked</cfif>>Other
						</font>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="right"><font size="-1">Trim:</font></td>
			<td colspan="3">
				<input type="text" name="trim" value="<cfif editmode>#rtrim(getUsedVehicle.trim)#</cfif>" size=10 maxlength=20> <font size="-1">(LE, LT, SE, etc.)</font>
			</td>
		</tr>
		<tr>
			<td colspan="4">&nbsp;</td>
		</tr>
		<tr bgcolor="##FCCA00">
			<td colspan="3"><a name="perf"></a><b>Performance</b></td>
			<td align="RIGHT"><font size="-1"><a href="##top" style="color: Black;">back to top</a></font></td>
		</tr>
		<tr>
			<td align="right"><font size="-1">Engine:</font></td>
			<td colspan="3">
				<font size="-1">
				<input type="Text" name="engineSize" size="4" maxlength="4" value="<cfif editmode><cfif detailsExist>#rtrim(getUVDetails.engineSize)#</cfif></cfif>"> L 
				<select name="engineConfig">
					<option value="">
					<option value="I" <cfif editmode><cfif detailsExist><cfif getUVDetails.engineConfig is 'I'>selected</cfif></cfif></cfif>>I
					<option value="V" <cfif editmode><cfif detailsExist><cfif getUVDetails.engineConfig is 'V'>selected</cfif></cfif></cfif>>V
				</select>
				<select name="engineCylinders">
					<option value="">
					<option value="3" <cfif editmode><cfif detailsExist><cfif getUVDetails.engineCylinders is '3'>selected</cfif></cfif></cfif>>3
					<option value="4" <cfif editmode><cfif detailsExist><cfif getUVDetails.engineCylinders is '4'>selected</cfif></cfif></cfif>>4
					<option value="6" <cfif editmode><cfif detailsExist><cfif getUVDetails.engineCylinders is '6'>selected</cfif></cfif></cfif>>6
					<option value="8" <cfif editmode><cfif detailsExist><cfif getUVDetails.engineCylinders is '8'>selected</cfif></cfif></cfif>>8
					<option value="10" <cfif editmode><cfif detailsExist><cfif getUVDetails.engineCylinders is '10'>selected</cfif></cfif></cfif>>10
					<option value="12" <cfif editmode><cfif detailsExist><cfif getUVDetails.engineCylinders is '12'>selected</cfif></cfif></cfif>>12
				</select> (ex -- 3.0L V6)
				</font>
			</td>
		</tr>
		<tr bgcolor="##FFFAE6">
			<td align="right" valign="TOP"><font size="-1">Performance:</font></td>
			<td colspan="3" valign="TOP">
				<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="TOP" nowrap>
						<font size="-1">
						<input type="Radio" name="enginePerfType" value="High Output" <cfif editmode><cfif detailsExist><cfif #getUVDetails.enginePerfType# is 'High Output'>checked</cfif></cfif></cfif>>High Output<br>
						<input type="Radio" name="enginePerfType" value="Super High Output" <cfif editmode><cfif detailsExist><cfif #getUVDetails.enginePerfType# is 'Super High Output'>checked</cfif></cfif></cfif>>Super High Output
						</font>
					</td>
					<td width="20">&nbsp;</td>
					<td valign="TOP">
						<font size="-1">
						<input type="Radio" name="enginePerfType" value="Turbo Charged" <cfif editmode><cfif detailsExist><cfif #getUVDetails.enginePerfType# is 'Turbo Charged'>checked</cfif></cfif></cfif>>Turbo Charged<br>
						<input type="Radio" name="enginePerfType" value="" <cfif editmode><cfif detailsExist><cfif #trim(getUVDetails.enginePerfType)# is ''>checked</cfif><cfelse>checked</cfif><cfelse>checked</cfif>>Other
						</font>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="right" valign="TOP"><font size="-1">Transmission:</font></td>
			<td colspan="3" valign="TOP">
				<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="TOP" nowrap>
						<font size="-1">
						<input type="Radio" name="transmission" value="3 Speed Manual" <cfif editmode><cfif #getUsedVehicle.transmission# contains '3'>checked</cfif></cfif>>3 Speed Manual<br>
						<input type="Radio" name="transmission" value="4 Speed Manual" <cfif editmode><cfif #getUsedVehicle.transmission# contains '4'>checked</cfif></cfif>>4 Speed Manual<br>
						<input type="Radio" name="transmission" value="5 Speed Manual" <cfif editmode><cfif #getUsedVehicle.transmission# contains '5'>checked</cfif></cfif>>5 Speed Manual<br>
						<input type="Radio" name="transmission" value="6 Speed Manual" <cfif editmode><cfif #getUsedVehicle.transmission# contains '6'>checked</cfif></cfif>>6 Speed Manual<br>
						</font>
					</td>
					<td width="20">&nbsp;</td>
					<td valign="TOP">
						<font size="-1">
						<input type="Radio" name="transmission" value="Automatic" <cfif editmode><cfif #getUsedVehicle.transmission# is 'Automatic'>checked</cfif></cfif>>Automatic<br>
						<input type="Radio" name="transmission" value="Automatic w/OD" <cfif editmode><cfif #getUsedVehicle.transmission# contains 'w/OD'>checked</cfif></cfif>>Automatic w/OD<br>
						<input type="Radio" name="transmission" value="" <cfif editmode><cfif #trim(getUsedVehicle.transmission)# is ''>checked</cfif><cfelse>checked</cfif>>Other
						</font>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr bgcolor="##FFFAE6">
			<td align="right" valign="TOP"><font size="-1">Drive:</font></td>
			<td colspan="3" valign="TOP">
				<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="TOP" nowrap>
						<font size="-1">
						<input type="Radio" name="driveType" value="All wheel" <cfif editmode><cfif detailsExist><cfif #getUVDetails.driveType# is 'All wheel'>checked</cfif></cfif></cfif>>All Wheel<br>
						<input type="Radio" name="driveType" value="Front wheel" <cfif editmode><cfif detailsExist><cfif #getUVDetails.driveType# is 'Front wheel'>checked</cfif></cfif></cfif>>Front Wheel<br>
						<input type="Radio" name="driveType" value="Rear wheel" <cfif editmode><cfif detailsExist><cfif #getUVDetails.driveType# is 'Rear wheel'>checked</cfif></cfif></cfif>>Rear Wheel
						</font>
					</td>
					<td width="20">&nbsp;</td>
					<td valign="TOP">
						<font size="-1">
						<input type="Radio" name="driveType" value="4 wheel" <cfif editmode><cfif detailsExist><cfif #getUVDetails.driveType# is '4 wheel'>checked</cfif></cfif></cfif>>4 wheel<br>
						<input type="Radio" name="driveType" value="" <cfif editmode><cfif detailsExist><cfif #trim(getUVDetails.driveType)# contains '2'>checked<cfelseif #trim(getUVDetails.driveType)# is ''>checked</cfif><cfelse>checked</cfif><cfelse>checked</cfif>>Other
						</font>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="4">&nbsp;</td>
		</tr>
		<tr bgcolor="##FCCA00">
			<td colspan="3"><a name="opt"></a><b>Options</b> <font size="-1">(check all that apply)</font></td>
			<td align="RIGHT"><font size="-1"><a href="##top" style="color: Black;">back to top</a></font></td>
		</tr>
		<tr>
			<td colspan="4"><font size="-1"><b>Comfort</b></font></td>
		</tr>
		<tr>
			<td align="RIGHT" valign="TOP"><font size="-1">Seating:</font></td>
			<td colspan="3">
				<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="TOP" nowrap>
						<font size="-1">
						<input type="Radio" name="upholstery" value="Leather" <cfif editmode><cfif detailsExist><cfif #getUVDetails.upholstery# is 'Leather'>checked</cfif></cfif></cfif>>Leather<br>
						<input type="Radio" name="upholstery" value="Premium Cloth" <cfif editmode><cfif detailsExist><cfif #getUVDetails.upholstery# is 'Premium Cloth'>checked</cfif></cfif></cfif>>Premium Cloth<br>
						<input type="Radio" name="upholstery" value="Cloth" <cfif editmode><cfif detailsExist><cfif #getUVDetails.upholstery# is 'Cloth'>checked</cfif></cfif></cfif>>Cloth
						</font>
					</td>
					<td width="20">&nbsp;</td>
					<td valign="TOP">
						<font size="-1">
						<input type="Radio" name="upholstery" value="Vinyl" <cfif editmode><cfif detailsExist><cfif #getUVDetails.upholstery# is 'Vinyl'>checked</cfif></cfif></cfif>>Vinyl<br>
						<input type="Radio" name="upholstery" value="" <cfif editmode><cfif detailsExist><cfif #trim(getUVDetails.upholstery)# is ''>checked</cfif><cfelse>checked</cfif><cfelse>checked</cfif>>Other
						</font>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="RIGHT" valign="TOP"><font size="-1">Seat Type:</font></td>
			<td colspan="3">
				<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="TOP" nowrap>
						<font size="-1">
						<input type="Radio" name="seatingType" value="Bucket" <cfif editmode><cfif detailsExist><cfif #getUVDetails.seatingType# is 'Bucket'>checked</cfif></cfif></cfif>>Buckets<br>
						<input type="Radio" name="seatingType" value="Split Bench" <cfif editmode><cfif detailsExist><cfif #getUVDetails.seatingType# is 'Split Bench'>checked</cfif></cfif></cfif>>Split Bench
						</font>
					</td>
					<td width="20">&nbsp;</td>
					<td valign="TOP">
						<font size="-1">
						<input type="Radio" name="seatingType" value="Bench" <cfif editmode><cfif detailsExist><cfif #getUVDetails.seatingType# is 'Bench'>checked</cfif></cfif></cfif>>Bench<br>
						<input type="Radio" name="seatingType" value="" <cfif editmode><cfif detailsExist><cfif #trim(getUVDetails.seatingType)# is ''>checked</cfif><cfelse>checked</cfif><cfelse>checked</cfif>>Other
						</font>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="RIGHT" valign="TOP"><font size="-1">Other:</font></td>
			<td colspan="3">
				<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<font size="-1">
						<input type="Checkbox" name="amfm" value="Y" <cfif editmode><cfif detailsExist><cfif #getUVDetails.stereoType# contains 'am/fm'>checked</cfif></cfif></cfif>>AM/FM<br>
						<input type="Checkbox" name="cassette" value="Y" <cfif editmode><cfif detailsExist><cfif #getUVDetails.stereoType# contains 'cassette'>checked</cfif></cfif></cfif>>Cassette<br>
						<input type="Checkbox" name="cd" value="Y" <cfif editmode><cfif detailsExist><cfif #getUVDetails.stereoType# contains 'cd'>checked</cfif></cfif></cfif>>Compact Disc<br>
						<input type="Checkbox" name="cdChanger" value="Y" <cfif editmode><cfif detailsExist><cfif #getUVDetails.stereoType# contains 'changer'>checked</cfif></cfif></cfif>>CD Changer<br>
						<input type="Checkbox" name="stereoRear" value="Y" <cfif editmode><cfif detailsExist><cfif #getUVDetails.stereoRear# is 'y'>checked</cfif></cfif></cfif>>Rear Stereo Controls
						</font>
					</td>
					<td width="20">&nbsp;</td>
					<td valign="TOP">
						<font size="-1">
						<input type="Checkbox" name="television" value="Y" <cfif editmode><cfif detailsExist><cfif #getUVDetails.television# is 'y'>checked</cfif></cfif></cfif>>Television<br>
						<input type="Checkbox" name="airConditioning" value="Y" <cfif editmode><cfif detailsExist><cfif #getUVDetails.airConditioning# is 'y'>checked</cfif></cfif></cfif>>Air Conditioning<br>
						<input type="Checkbox" name="airConditioningRear" value="Y" <cfif editmode><cfif detailsExist><cfif #getUVDetails.airConditioningRear# is 'y'>checked</cfif></cfif></cfif>>Rear Air Conditioning<br>
						<input type="Checkbox" name="climateControl" value="Y" <cfif editmode><cfif detailsExist><cfif #getUVDetails.climateControl# is 'y'>checked</cfif></cfif></cfif>>Climate Control
						</font>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr bgcolor="##FFFAE6">
			<td colspan="4"><font size="-1"><b>Convenience</b></font></td>
		</tr>
		<tr bgcolor="##FFFAE6">
			<td>&nbsp;</td>
			<td colspan="3">
				<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<font size="-1">
						<input type="Checkbox" name="cruiseControl" value="Y" <cfif editmode><cfif detailsExist><cfif #getUVDetails.cruiseControl# is 'y'>checked</cfif></cfif></cfif>>Cruise Control<br>
						<input type="Checkbox" name="tiltWheel" value="Y" <cfif editmode><cfif detailsExist><cfif #getUVDetails.cruiseControl# is 'y'>checked</cfif></cfif></cfif>>Tilt Wheel<br>
						<input type="Checkbox" name="powerBrakes" value="Y" <cfif editmode><cfif detailsExist><cfif #getUVDetails.brakes# contains 'power'>checked</cfif></cfif></cfif>>Power Brakes<br>
						<input type="Checkbox" name="powerLocks" value="Y" <cfif editmode><cfif detailsExist><cfif #getUVDetails.powerLocks# is 'y'>checked</cfif></cfif></cfif>>Power Locks<br>
						</font>
					</td>
					<td width="20">&nbsp;</td>
					<td valign="TOP">
						<font size="-1">
						<input type="Checkbox" name="powerSeats" value="Y" <cfif editmode><cfif detailsExist><cfif #getUVDetails.powerSeats# is 'y'>checked</cfif></cfif></cfif>>Power Seats<br>
						<input type="Checkbox" name="powerSteering" value="Y" <cfif editmode><cfif detailsExist><cfif #getUVDetails.powerSteering# is 'y'>checked</cfif></cfif></cfif>>Power Steering<br>
						<input type="Checkbox" name="powerWindows" value="Y" <cfif editmode><cfif detailsExist><cfif #getUVDetails.powerWindows# is 'y'>checked</cfif></cfif></cfif>>Power Windows
						</font>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="4"><font size="-1"><b>Safety</b></font></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td colspan="3">
				<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="TOP">
						<font size="-1">
						<input type="Checkbox" name="airbagDriver" value="Y" <cfif editmode><cfif detailsExist><cfif #getUVDetails.airbagDriver# is 'y'>checked</cfif></cfif></cfif>>Driver Side Air Bag<br>
						<input type="Checkbox" name="airbagPassenger" value="Y" <cfif editmode><cfif detailsExist><cfif #getUVDetails.airbagPassenger# is 'y'>checked</cfif></cfif></cfif>>Passenger Side Air Bag
						</font>
					</td>
					<td width="20">&nbsp;</td>
					<td valign="TOP">
						<font size="-1">
						<input type="Checkbox" name="ABS" value="Y" <cfif editmode><cfif detailsExist><cfif #getUVDetails.brakes# contains 'abs'>checked</cfif></cfif></cfif>>ABS<br>
						<input type="Checkbox" name="tractionControl" value="Y" <cfif editmode><cfif detailsExist><cfif #getUVDetails.tractionControl# is 'y'>checked</cfif></cfif></cfif>>Traction Control
						</font>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr bgcolor="##FFFAE6">
			<td colspan="4"><font size="-1"><b>Trucks</b></font></td>
		</tr>
		<tr bgcolor="##FFFAE6">
			<td align="RIGHT" valign="TOP"><font size="-1">Box Type:</font></td>
			<td colspan="3" valign="TOP">
				<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="TOP" nowrap>
						<font size="-1">
						<input type="Radio" name="boxType" value="Long" <cfif editmode><cfif detailsExist><cfif #getUVDetails.boxType# is 'Long'>checked</cfif></cfif></cfif>>Long Bed<br>
						<input type="Radio" name="boxType" value="Short" <cfif editmode><cfif detailsExist><cfif #getUVDetails.boxType# is 'Short'>checked</cfif></cfif></cfif>>ShortBed<br>
						<input type="Radio" name="boxType" value="Fleetside" <cfif editmode><cfif detailsExist><cfif #getUVDetails.boxType# is 'Fleetside'>checked</cfif></cfif></cfif>>Feetside
						</font>
					</td>
					<td width="20">&nbsp;</td>
					<td valign="TOP">
						<font size="-1">
						<input type="Radio" name="boxType" value="Flareside" <cfif editmode><cfif detailsExist><cfif #getUVDetails.boxType# is 'Flareside'>checked</cfif></cfif></cfif>>Flareside<br>
						<input type="Radio" name="boxType" value="Sportside" <cfif editmode><cfif detailsExist><cfif #getUVDetails.boxType# is 'Sportside'>checked</cfif></cfif></cfif>>Sportside<br>
						<input type="Radio" name="boxType" value="" <cfif editmode><cfif detailsExist><cfif #trim(getUVDetails.boxType)# is ''>checked</cfif><cfelse>checked</cfif><cfelse>checked</cfif>>Other
						</font>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr bgcolor="##FFFAE6">
			<td align="RIGHT" valign="TOP"><font size="-1">Payload:</font></td>
			<td colspan="3" valign="TOP">
				<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="TOP" nowrap>
						<font size="-1">
						<input type="Radio" name="payload" value="1/2 Ton" <cfif editmode><cfif detailsExist><cfif #getUVDetails.payload# is '1/2 Ton'>checked</cfif></cfif></cfif>>1/2 ton<br>
						<input type="Radio" name="payload" value="3/4 Ton" <cfif editmode><cfif detailsExist><cfif #getUVDetails.payload# is '3-4 Ton'>checked</cfif></cfif></cfif>>3/4 ton<br>
						</font>
					</td>
					<td width="20">&nbsp;</td>
					<td valign="TOP">
						<font size="-1">
						<input type="Radio" name="payload" value="1 Ton" <cfif editmode><cfif detailsExist><cfif #getUVDetails.payload# is '1 Ton'>checked</cfif></cfif></cfif>>1 ton<br>
						<input type="Radio" name="payload" value="" <cfif editmode><cfif detailsExist><cfif #trim(getUVDetails.payload)# is ''>checked</cfif><cfelse>checked</cfif><cfelse>checked</cfif>>Other
						</font>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="4"><font size="-1"><b>Warranty</b></font></td>
		</tr>
		<tr>
			<td align="RIGHT" valign="TOP"><font size="-1">Warranty:</font></td>
			<td colspan="3" valign="TOP">
				<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td rowspan="2" valign="TOP">
					<font size="-1">
					<input type="Radio" name="warranty" value="Y" <cfif editmode><cfif detailsExist><cfif #getUVDetails.warranty# is 'y'>checked</cfif></cfif></cfif>>yes
					<input type="Radio" name="warranty" value="" <cfif editmode><cfif detailsExist><cfif #trim(getUVDetails.warranty)# is ''>checked</cfif><cfelse>checked</cfif><cfelse>checked</cfif>>no
					</font>
					</td>
					<td width="20">&nbsp;</td>
					<td align="RIGHT"><font size="-1">Months: </font></td>
					<td><font size="-1"><input type="text" name="warrantyMonths" size=6 maxlength=2 value="<cfif editmode><cfif detailsExist>#rtrim(getUVDetails.warrantyMonths)#</cfif></cfif>"></font></td>
				</tr>
				<tr>
					<td width="20">&nbsp;</td>
					<td align="RIGHT"><font size="-1">Miles: </font></td>
					<td><font size="-1"><input type="text" name="warrantyMiles" size=6 maxlength=6 value="<cfif editmode><cfif detailsExist><cfif getUVDetails.warrantyMiles neq 0>#rtrim(getUVDetails.warrantyMiles)#</cfif></cfif></cfif>"></font></td>
				</tr>
				</table>
			</td>
		</tr>
		<tr bgcolor="##FFFAE6">
			<td colspan="4"><font size="-1"><b>Miscellaneous</b></font></td>
		</tr>
		<tr bgcolor="##FFFAE6">
			<td align="RIGHT" valign="TOP"><font size="-1">Wheels:</font></td>
			<td colspan="3">
				<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="TOP" nowrap>
						<font size="-1">
						<input type="Radio" name="wheelDescription" value="Styled" <cfif editmode><cfif detailsExist><cfif #getUVDetails.wheelDescription# is 'Styled'>checked</cfif></cfif></cfif>>Styled<br>
						<input type="Radio" name="wheelDescription" value="Alloy" <cfif editmode><cfif detailsExist><cfif #getUVDetails.wheelDescription# is 'Alloy'>checked</cfif></cfif></cfif>>Alloy<br>
						<input type="Radio" name="wheelDescription" value="Steel" <cfif editmode><cfif detailsExist><cfif #getUVDetails.wheelDescription# is 'Steel'>checked</cfif></cfif></cfif>>Steel
						</font>
					</td>
					<td width="20">&nbsp;</td>
					<td valign="TOP">
						<font size="-1">
						<input type="Radio" name="wheelDescription" value="Deluxe Cover" <cfif editmode><cfif detailsExist><cfif #getUVDetails.wheelDescription# contains 'Deluxe'>checked</cfif></cfif></cfif>>Deluxe Covers<br>
						<input type="Radio" name="wheelDescription" value="" <cfif editmode><cfif detailsExist><cfif #trim(getUVDetails.wheelDescription)# is ''>checked</cfif><cfelse>checked</cfif><cfelse>checked</cfif>>Other
						</font>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr bgcolor="##FFFAE6">
			<td align="RIGHT" valign="TOP"><font size="-1">Other:</font></td>
			<td colspan="3">
				<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<font size="-1">
						<input type="Checkbox" name="luggageRack" value="Y" <cfif editmode><cfif detailsExist><cfif #getUVDetails.luggageRack# is 'y'>checked</cfif></cfif></cfif>>Luggage Rack<br>
						<input type="Checkbox" name="runningBoards" value="Y" <cfif editmode><cfif detailsExist><cfif #getUVDetails.runningBoards# is 'y'>checked</cfif></cfif></cfif>>Running Boards
						</font>
					</td>
					<td width="20">&nbsp;</td>
					<td valign="TOP">
						<font size="-1">
						<input type="Checkbox" name="slidingWindow" value="Y" <cfif editmode><cfif detailsExist><cfif #getUVDetails.slidingWindow# is 'y'>checked</cfif></cfif></cfif>>Sliding Rear Window<br>
						<input type="Checkbox" name="towingPackage" value="Y" <cfif editmode><cfif detailsExist><cfif #getUVDetails.towingPackage# is 'y'>checked</cfif></cfif></cfif>>Towing Package
						</font>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr bgcolor="##FFFAE6">
			<td align="right" valign="top"><font size="-1">Extra Features:</font></td>
			<td colspan="3">
				<!--- loop thru 20 possible Extra Features.  If there's an option found in the query whose
				CurrentRow matches the Option # we're on, show it. --->
				<cfset maxoptions = 5>
				<cfif editmode>
					<!--- initialize all the Options variables 1-20 --->
					<cfloop index="count" from="1" to="#MaxOptions#">
						<cfset whatever = setvariable("Option#count#", 0)>
					</cfloop>
		
					<!--- Populate the Options variables --->
					<cfset count = 0>
					<cfloop query="getExtraOptions">
						<cfset count = count + 1>
						<cfset whatever = setvariable("Option#count#", #options#)>
					</cfloop>
				</cfif>
				<cfloop index="count" from="1" to="#MaxOptions#">
					<input type="text" name="Option#count#"
					<cfif editmode>
						<cfloop query="getExtraOptions">
							<cfif #getextraoptions.currentrow# eq #count#>
								value="#rtrim(getExtraOptions.Options)#"
								<cfbreak>
							</cfif>
						</cfloop>
					</cfif>
					size="20" maxlength="100">
					<br>
				</cfloop>
			</td>
		</tr>
		<tr>
			<td colspan="4">&nbsp;</td>
		</tr>
		<tr bgcolor="##FCCA00">
			<td colspan="3"><a name="comm"></a><b>Comments</b></td>
			<td align="RIGHT"><font size="-1"><a href="##top" style="color: Black;">back to top</a></font></td>
		</tr>
		<tr>
			<td colspan="4" align="CENTER">
				<textarea name="Features" rows="5" cols="30" wrap="virtual"><cfif editmode>#rtrim(getUsedVehicle.Features)#</cfif></textarea>
			</td>
		</tr>
		<tr>
			<td colspan="4">&nbsp;</td>
		</tr>
		<tr bgcolor="##FCCA00">
			<td colspan="3"><a name="photo"></a><b>Photo</b></td>
			<td align="RIGHT"><font size="-1"><a href="##top" style="color: Black;">back to top</a></font></td>
		</tr>
		<tr>
			<td colspan="4" align="center">
				Would you like to include a photo of this vehicle?
			</td>
		</tr>
		<tr>
			<td colspan="4" align="center">
				<input type="radio" name="image" value="Y" <cfif editmode><cfif #getusedvehicle.image# is 'y'>checked</cfif></cfif>>Yes
				<input type="radio" name="image" value="N" <cfif editmode><cfif #getusedvehicle.image# is 'n'>checked</cfif><cfelse>checked</cfif>>No
			</td>
		</tr>
		</table>
		
	</td>
</tr>
<tr align="center">
	<td>
		<cfif isdefined("URL.UsedVehicleID")>
			<input type="hidden" name="UsedVehicleID" value="#URL.UsedVehicleID#">
		</cfif>
		<input type="Image" src="#application.RELATIVE_PATH#/images/admin/next.gif" border="0" name="Next" value="Next">
		</form>
	</td>
</tr>
<tr>
	<td colspan="2" align="center">
		<form name="Cancel" action="preowned_inv.cfm" method="post">
		<input type="Image" src="#application.RELATIVE_PATH#/images/admin/cancel.gif" border="0" name="Cancel" value="Cancel">
		</form>
	</td>
</tr>
</table>
</cfoutput>
