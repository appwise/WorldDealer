<cfset PageAccess = application.dealer_access>
                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 10, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: preowned_inv_main.cfm,v 1.17 2000/05/11 18:52:51 jkrauss Exp $--->
<cfif ParameterExists(url.New) eq False>
<cfset new = "N">
</cfif>

<cfif ParameterExists(url.sortby)>
	<cfif url.sortby eq "stock">
		<cfset sort = "UsedVehicles.stock">
		<cfset sortby = "stock">
	<cfelseif url.sortby eq "model">
		<cfset sort = "UVModels.modelname, UsedVehicles.caryear DESC">
		<cfset sortby = "model">
	<cfelseif url.sortby eq "year">
		<cfset sort = "UsedVehicles.caryear DESC, UVMakes.makename, UVModels.modelname">
		<cfset sortby = "year">
	<cfelseif url.sortby eq "make">
		<cfset sort = "UVMakes.makename, UVModels.modelname, UsedVehicles.caryear DESC">
		<cfset sortby = "make">
	</cfif>
<cfelse>
	<cfset sort = "UVMakes.makename, UVModels.modelname, UsedVehicles.caryear DESC">
	<cfset sortby = "make">
</cfif>

<cfquery name="selectUsedVehicle" datasource="#gDSN#">
	SELECT DISTINCT	
		UsedVehicles.VIN,
		UsedVehicles.UsedVehicleID,
		UVMakes.MakeName, 
		UVModels.ModelName, 
		UsedVehicles.CarYear, 
		UsedVehicles.price, 
		UsedVehicles.mileage,
		UsedVehicles.stock,
		UsedVehicles.Image
	FROM 	(UsedVehicles 
			INNER JOIN UVModels ON UsedVehicles.ModelNumber = UVModels.ModelNumber) 
			INNER JOIN UVMakes ON UVModels.MakeNumber = UVMakes.MakeNumber
			<cfif #new# eq 'y'>
				WHERE	DealerCode = '#g_dealercode#' AND NewUsed = 'Y'
			<cfelse>
				WHERE	DealerCode = '#g_dealercode#' AND NewUsed = 'N'
			</cfif>
	
	ORDER BY #sort#
</cfquery>
				
<table border="0" cellpadding="5" cellspacing="0" width="100%">
<cfif #selectusedvehicle.recordcount# eq 0> 
	<tr align="center">
		<td>
			There are currently NO <cfif #new# eq 'y'>New<cfelse>Pre-Owned</cfif> Vehicles associated with this dealership.
		</td>
	</tr>
<cfelse>
	<form name="MultDelVehicle" action="preowned_inv_multdel_rusure.cfm" method="post">
	<tr>
		<td>
			To modify any of the information below, please click on the vehicle.  You may also remove any vehicles by selecting them and clicking on the delete button below.<p>
			You may view these vehicles by vehicle make, model, year, or stock number.  Simply click on the column heading that you wish to sort by.<cfif NOT ParameterExists(url.sortby)>  The vehicles are currently being sorted by <cfoutput>#sortby#</cfoutput>.</cfif><br>&nbsp;
		</td>
	</tr>
	<tr>
		<td>
			<br>
			<FONT SIZE=-1 FACE="arial,helvetica">
					<div align="center">Click here to edit your 
						<cfif #New# eq 'Y'>
							<a href="preowned_inv.cfm">Pre-Owned Vehicle Inventory</a>.
						<CFelse>
							<a href="preowned_inv.cfm?new=y">New Vehicle Inventory</a>.
						</cfif>
					</div>
			</FONT>
		</td>
	</tr>
	<tr align="center">
		<td>
			<table border="1" cellspacing="0" cellpadding="5">
			<tr bgcolor="gray">
				<td align="CENTER">
					&nbsp;
				</td>
				<cfif sortby eq "make">
				<td align="CENTER" bgcolor="Black">
				<cfelse>
				<td align="CENTER">
				</cfif>
					<b><a href="preowned_inv.cfm?sortby=make" class="tabletop"><font color="White">Make</font></a></b>
				</td>
				<cfif sortby eq "model">
				<td align="CENTER" bgcolor="Black">
				<cfelse>
				<td align="CENTER">
				</cfif>
					<b><a href="preowned_inv.cfm?sortby=model" class="tabletop"><font color="White">Model</font></a></b>
				</td>
				<cfif sortby eq "year">
				<td align="CENTER" bgcolor="Black">
				<cfelse>
				<td align="CENTER">
				</cfif>
					<b><a href="preowned_inv.cfm?sortby=year" class="tabletop"><font color="White">Year</font></a></b>
				</td>
				<td align="center">
					<font color="White"><b>VIN</b></font>
				</td>
				<cfif sortby eq "stock">
				<td align="CENTER" bgcolor="Black">
				<cfelse>
				<td align="CENTER">
				</cfif>
					<b><a href="preowned_inv.cfm?sortby=stock" class="tabletop"><font color="White">Stock</font></a></b>
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
					#MakeName#
				</td>
				<td>
					<a href="preowned_inv_edit.cfm?UsedVehicleID=#UsedVehicleID#">#ModelName#</a>
				</td>
				<td>
					#CarYear#
				</td>
				<td>
					#VIN#
				</td>
				<td>
					<cfif trim(stock) is not ''>#Stock#<cfelse>none</cfif>
				</td>
				<td align="center">
					#lcase(Image)#
				</td>
			</tr>
			</cfoutput>
			</table>
		</td>
	</tr>
</cfif>
<tr>    
	<td align="center">
		<table border="0" cellspacing="0" cellpadding="0">
		<tr>
			<cfif #selectusedvehicle.recordcount# neq 0> 
				<td>
				<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/deletebutton.gif" BORDER="0" NAME="Delete" VALUE="Delete">
				</form>
				</td>
				<td>&nbsp;&nbsp;</td>
			</cfif>
			<td>
			<form name="AddVehicle" action="preowned_inv_edit.cfm" method="post">
			<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/add.gif" BORDER="0" NAME="Add" VALUE="Add">
			</form>
			</td>
		</tr>
		</table>
	</td>
</tr>
<tr>
	<td align="center">
	<form name="Cancel" action="preowned.cfm" method="post">
	<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/cancel.gif" BORDER="0" NAME="Cancel" VALUE="Cancel">
	</form>	
	</td>
</tr>
</table>
