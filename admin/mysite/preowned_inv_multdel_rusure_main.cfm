<cfset PageAccess = application.dealer_access>

                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 10, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: preowned_inv_multdel_rusure_main.cfm,v 1.8 2000/05/11 18:52:51 jkrauss Exp $--->

<cfif ParameterExists(form.UsedVehicleID)>
	<cfset vehicles = ArrayNew(1)>
	<cfset vehicles = ListToArray(#form.UsedVehicleID#)>
	<cfset count = 0>
</cfif>

<form name="selectusedvehicles" action="preowned_inv_multi_del.cfm" method="post">
<table border="0" cellpadding="5" cellspacing="0" width="100%">
<cfif ParameterExists(form.UsedVehicleID)>
<tr>
	<td align="center">
		You are about to permanently Delete the following Pre-Owned Vehicles.  Are you sure you wish to proceed?<br>
	</td>
</tr>
<tr>
	<td align="center">
		<table border="0" cellpadding="5" cellspacing="0">
		<tr>
			<td align="center">
				<b>Make</b>
			</td>
			<td align="center">
				<b>Model</b>
			</td>
			<td align="center">
				<b>Year</b>
			</td>
			<td align="center">
				<b>VIN</b>
			</td>
			<td align="center">
				<b>Stock</b>
			</td>
			<td align="center">
				<img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/camera.gif" border=0 width=16 height=14 alt="Photo">
		</tr>
		<cfloop index="count" list="#form.UsedVehicleID#">
			<cfquery name="selectUsedVehicle" datasource="#gDSN#">
				SELECT	UsedVehicleID, ModelNumber, CarYear, VIN, stock, Image
				FROM	UsedVehicles
				WHERE	UsedVehicleID = #count#
			</cfquery>
			<cfquery name="getMakeModelName" datasource="#gDSN#">
				SELECT a.MakeName, o.ModelName
				FROM UVMakes a, UVModels o
				WHERE o.ModelNumber = #selectUsedVehicle.ModelNumber# AND a.MakeNumber = o.MakeNumber
			</cfquery>
		<cfoutput>
		<input type="hidden" name="UsedVehicleID" value="#count#">
		<tr>
			<td>
				#getMakeModelName.MakeName#
			</td>
			<td>
				#getMakeModelName.ModelName#
			</td>
			<td>
				#selectUsedVehicle.CarYear#
			</td>
			<td>
				#selectUsedVehicle.VIN#
			</td>
			<td>
				#selectUsedVehicle.Stock#
			</td>
			<td align="center">
				#selectUsedVehicle.Image#
			</td>
		</tr>
		</cfoutput>
		</cfloop>
		</table>
	</td>
</tr>
<tr align="center">
	<td>
		<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/deletebutton.gif" BORDER="0" NAME="Delete" VALUE="Delete">
		</form>
	</td>
</tr>
<tr>
	<td align="center">
	<form name="Cancel" action="preowned_inv.cfm" method="post">
	<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/cancel.gif" BORDER="0" NAME="Cancel" VALUE="Cancel">
	</form>
	</td>
</tr>
<cfelse>
<tr>
	<td align="center">
		You did not select any vehicles to delete.  Please use your back button to return to the previous page and select the vehicle or vehicles you wish to delete.<p>
		<a href="javascript:history.back()"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/back.gif" border=0></a>
	</td>
</tr>
</cfif>
</table>
