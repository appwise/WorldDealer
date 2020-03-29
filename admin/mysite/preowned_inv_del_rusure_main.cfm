<cfset PageAccess = application.dealer_access>

                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 21, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!--- $Id: preowned_inv_del_rusure_main.cfm,v 1.8 2000/05/11 18:52:51 jkrauss Exp $ --->
<!--- Delete Pre-Owned Vehicles --->

<cfquery name="selectUsedVehicle" datasource="#gDSN#">
	SELECT	UsedVehicleID,
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
			Features
	FROM	UsedVehicles
	WHERE	UsedVehicleID = #URL.UsedVehicleID#
</cfquery>        

<table border="0" cellpadding="5" cellspacing="0" width="100%">
<form name="DelPreowned" action="preowned_inv_del.cfm" method="post">
<tr align="center">
	<td>
		You are about to permanently Delete the following Pre-Owned Vehicle.<br>
		Are you sure you wish to proceed?
	</td>
</tr>
<tr align="center">
	<td>
		<table border="0" cellpadding="5" cellspacing="0">
		<cfoutput query="selectUsedVehicle">
		<tr>
			<td align="right"><b>Make</b></td>
			<td>#make#</td>
		</tr>
		<tr>
			<td align="right"><b>Model</b></td>
			<td>#modelName#</td>
		</tr>
		<tr>
			<td align="right"><b>Year</b></td>
			<td>#caryear#</td>
		</tr>
		<tr>
			<td align="right"><b>Interior Color</b></td>
			<td>#intcolor#</td>
		</tr>
		<tr>
			<td align="right"><b>Exterior Color</b></td>
			<td>#extcolor#</td>
		</tr>
		<tr>
			<td align="right"><b>Transmission</b></td>
			<td>#transmission#</td>
		</tr>
		<tr>
			<td align="right"><b>Mileage</b></td>
			<td>#mileage#</td>
		</tr>
		<tr>
			<td align="right"><b>Price</b></td>
			<td>#DollarFormat(Price)#</td>
		</tr>
		<tr>
			<td align="right"><b>Stock</b></td>
			<td>#stock#</td>
		</tr>								
		<tr>
			<td align="right"><b>VIN</b></td>
			<td>#VIN#</td>
		</tr>
		<tr>
			<td align="right" valign="top"><b>Comments</b></td>
			<td>#Replace(features, chr(13), "<BR>", "ALL")#</td>
		</tr>
		</cfoutput>
	</table>
	</td>
</tr>	
<tr align="center">
	<td>
		<input type="hidden" name="UsedVehicleID" value="<CFOUTPUT>#URL.UsedVehicleID#</cfoutput>">
		<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/deletebutton.gif" BORDER="0" name="Delete" value="Delete">
		</form>
		<form name="Cancel" action="preowned_inv.cfm" method="post">
		<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/cancel.gif" BORDER="0" NAME="Cancel" VALUE="Cancel">
		</form>
	</td>
</tr>
</table>
