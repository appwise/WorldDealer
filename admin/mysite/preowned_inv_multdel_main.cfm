<cfset PageAccess = application.dealer_access>

                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 10, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: preowned_inv_multdel_main.cfm,v 1.6 2000/05/11 18:52:51 jkrauss Exp $--->

<cfquery name="selectUsedVehicle" datasource="#gDSN#">
	SELECT	UsedVehicleID,
			make,
			ModelName,
			CarYear,
			VIN,
			stock,
			Image
	FROM	UsedVehicles
	WHERE	DealerCode = '#g_dealercode#'
	ORDER BY make, modelname, caryear DESC
</cfquery>

<form name="selectusedvehicles" action="preowned_inv_multdel_rusure.cfm" method="post">
<table border="0" cellpadding="5" cellspacing="0" width="100%">
<tr>
	<td align="center">
		Please select the Pre-Owned Vehicles you wish to Delete.
	</td>
</tr>
<tr>
	<td align="center">
		<table border="1" cellpadding="5" cellspacing="0">
		<tr>
			<td>
				&nbsp;
			</td>
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
		<cfoutput query ="selectusedvehicle">
		<tr>
			<td>
				<input name="UsedVehicleID" type="checkbox" value="#UsedVehicleID#">
			</td>
			<td>
				#Make#
			</td>
			<td>
				#ModelName#
			</td>
			<td>
				#CarYear#
			</td>
			<td>
				#VIN#
			</td>
			<td>
				#Stock#
			</td>
			<td align="center">
				#Image#
			</td>
		</tr>
		</cfoutput>
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
</table>
