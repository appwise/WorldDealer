<cfset listmode = "false">

<cfif (ParameterExists(Form.getDealer)) or (ParameterExists(URL.sortby))>
	<cfset listmode = "true">
</cfif>

<cfquery name="getDealersFirst" datasource="#gDSN#">
	Select 	dealercode,
			dealershipname
	from 	dealers
	order by dealershipname
</cfquery>


<cfif listmode>

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

	<cfif ParameterExists(url.DealInv)>
		<cfset WhichDealer = "#URL.DealInv#">
	<cfelse>
		<cfset WhichDealer = "#Form.getDealer#">
	</cfif>

	<cfquery name="getDealers" datasource="#gDSN#">
		Select 	dealershipname
		from 	dealers
		where	dealercode = '#WhichDealer#'
	</cfquery>
	
	<cfquery name="getInventory" datasource="#gDSN#">
		SELECT DISTINCT	
			UsedVehicles.VIN,
			UsedVehicles.UsedVehicleID,
			UVMakes.MakeName, 
			UVModels.ModelName, 
			UsedVehicles.CarYear,
			UsedVehicles.stock,
			UsedVehicles.Image
		FROM 	(UsedVehicles 
				INNER JOIN UVModels ON UsedVehicles.ModelNumber = UVModels.ModelNumber) 
				INNER JOIN UVMakes ON UVModels.MakeNumber = UVMakes.MakeNumber
		WHERE	DealerCode = '#WhichDealer#'
		ORDER BY #sort#
	</cfquery>
	
<!--- 	<cfquery name="getInventory" datasource="#gDSN#">
		select 	*
		from	usedvehicles
		where	dealercode = '#WhichDealer#'
		order by #sort#
	</cfquery> --->

<cfelse>

	<cfquery name="getDealersFirst" datasource="#gDSN#">
		Select 	dealercode,
				dealershipname
		from 	dealers
		order by dealershipname
	</cfquery>
	
</cfif>

<table width="100%" border="0" cellspacing="0" cellpadding="5"><tr><td>
<h4>Select a Dealership</h4>

Select the dealership whose pre-owned inventory you would like to see.  Click continue when you've selected your dealership.<p>

<div align="center">
	<form name="getDealer" action="admin_preowned.cfm" method="post">
		<select name="getDealer">
			<cfloop query="getDealersFirst">
				<cfoutput><option value="#DealerCode#"<cfif isDefined("WhichDealer")><cfif #DealerCode# eq #WhichDealer#> selected</cfif></cfif>>#DealershipName#</cfoutput>
			</cfloop>
		</select><p>
		<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/continue.gif" BORDER="0" NAME="Continue" VALUE="Continue">
	</form>
</div>
</td></tr></table>

<cfif listmode>
	<table width="100%" border="0" cellspacing="0" cellpadding="5"><tr><td>	
	<div align="center">
	
	<h4>Preowned Inventory for <cfoutput>#getDealers.dealershipname#</cfoutput></h4>
	
	<table border="1" cellspacing="0" cellpadding="2">
	<tr bgcolor="Black">
		<td align="CENTER"<cfif sortby eq "make"> bgcolor="Gray"</cfif>>
			<b><a href="admin_preowned.cfm?DealInv=<cfoutput>#WhichDealer#</cfoutput>&sortby=make" class="tabletop"><font size="-1" color="White">Make</font></a></b>
		</td>
		<td align="center"<cfif sortby eq "model"> bgcolor="Gray"</cfif>>
			<b><a href="admin_preowned.cfm?DealInv=<cfoutput>#WhichDealer#</cfoutput>&sortby=model" class="tabletop"><font size="-1" color="White">Model</font></a></b>
		</td>
		<td align="center"<cfif sortby eq "year"> bgcolor="Gray"</cfif>>
			<b><a href="admin_preowned.cfm?DealInv=<cfoutput>#WhichDealer#</cfoutput>&sortby=year" class="tabletop"><font size="-1" color="White">Year</font></a></b>
		</td>
		<td align="CENTER"><font size="-1" color="White"><b>VIN</b></font></td>
		<td align="center"<cfif sortby eq "stock"> bgcolor="Gray"</cfif>>
			<b><a href="admin_preowned.cfm?DealInv=<cfoutput>#WhichDealer#</cfoutput>&sortby=stock" class="tabletop"><font size="-1" color="White">Stock</font></a></b>
		</td>
		<td align="CENTER"><font size="-1" color="White"><b>Image</b></font></td>
	</tr>
	<cfif getInventory.RecordCount gt 0>
		<cfloop query="getInventory">
			<cfoutput>
				<tr>
					<td><font size="-1">#MakeName#</font></td>
					<td><font size="-1">#ModelName#</font></td>
					<td align="CENTER"><font size="-1">#CarYear#</font></td>
					<td><font size="-2">#VIN#</font></td>
					<td align="CENTER"><font size="-2">#stock#</font></td>
					<td align="CENTER"><font<cfif #Image# is "Y"> color="Green"<cfelse> color="Red"</cfif> size="-1"><b>#lcase(Image)#</b></font></td>
				</tr>
			</cfoutput>
		</cfloop>
	<cfelse>
		<tr>
			<td colspan="6" align="CENTER">&nbsp;<br>&nbsp;<br>&nbsp;<br>
			&nbsp;&nbsp;&nbsp;No Pre-Owned Inventory for this Dealership.&nbsp;&nbsp;&nbsp;
			<br>&nbsp;<br>&nbsp;<br>&nbsp;</td>
		</tr>
	</cfif>
	</table>
	</div>
	
	</td></tr></table>	
</cfif>