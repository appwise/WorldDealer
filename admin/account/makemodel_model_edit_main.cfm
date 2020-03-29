                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <February 25, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!--- $Id: makemodel_model_edit_main.cfm,v 1.7 2000/06/15 17:11:20 jkrauss Exp $ --->
<!--- Maintain Models --->

<cfif isdefined("Form.Save.X")>
	<!----- update existing model data----->
	<cfquery name="updModel" datasource="#gDSN#">
		UPDATE 	Models
		SET		Description = '#Form.Description#',
				ModelName = '#Form.ModelName#',
				GlamourCopy = '#Form.GlamourCopy#',
				Features = '#Form.Features#',
				VehicleType = '#Form.VehicleType#',
				Make = #Form.Make#,
				Year = '#Form.Year#'
		WHERE	ModelID = #Form.ModelID#
	</cfquery>
	<cflocation url="makemodel_model.cfm?make=#form.make#" addtoken="no">
<cfelseif isdefined("Form.Save_New.X")>
	<cfquery name="addModel" datasource="#gDSN#">
		INSERT INTO Models (Description, ModelName, GlamourCopy, Features, VehicleType, Make, Year)
		VALUES ('#Form.Description#', '#Form.ModelName#', '#Form.GlamourCopy#', '#Form.Features#', '#Form.VehicleType#', #Form.Make#, '#Form.Year#')
	</cfquery>
	<cflocation url="makemodel_model.cfm?make=#form.make#" addtoken="no">
</cfif>

<cfif isdefined("url.model")>
	<!--- get what's in the db now --->
	<cfquery name="getModel" datasource="#gDSN#">
		SELECT 	*
		FROM	Models
		WHERE	modelID = #url.model#
	</cfquery>	
	<cfset editMode = "true">
<cfelse>
	<cfset editMode = "false">
</cfif>
	
	
<cfoutput>
<form name="StepOne" action="makemodel_model_edit.cfm" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="5">
<!--- Picture of vehicle --->
<cfif editmode>
	<cfif FileExists("#g_rootdir#\images\vehicles\#getModel.make#\#getModel.modelID#_1.jpg")>
	<tr align="center">
		<td colspan="2">
			<IMG SRC="#application.RELATIVE_PATH#/images/vehicles/#getModel.make#/#getModel.modelID#_1.jpg" BORDER="0" alt="#getModel.Description#">
		</td>
	</tr>
	</cfif>
</cfif>
<tr>
	<td><b>Year of Copy:</b></td>
	<td>
		<input type="text" name="Year" size="5" maxlength="4" value="<cfif editMode>#getModel.Year#</cfif>">
		<input type="hidden" name="Year_required" value="Please enter the year that the Glamour Copy and Features apply to.">
	</td>
</tr>
<tr>
	<td><b>Model:</b></td>
	<td>
		<input type="text" name="Description" size="25" maxlength="35" value="<cfif editMode>#getModel.Description#</cfif>">
		<input type="hidden" name="Description_required" value="Please enter a model name.">
		<input type="hidden" name="make" value="<cfif editMode>#getModel.make#<cfelse>#url.make#</cfif>">
		<input type="hidden" name="modelID" value="<cfif editMode>#getModel.modelID#</cfif>">
	</td>
</tr>
<tr>
	<td><b>Model Code:</b></td>
	<td>
		<input type="text" name="ModelName" size="25" maxlength="10" value="<cfif editMode>#getModel.ModelName#</cfif>">
		<input type="hidden" name="ModelName_required" value="Please enter a unique model abbreviation code.">
	</td>
</tr>
<tr>
	<td><b>Vehicle Type:</b></td>
	<td>
		<select name="VehicleType">
			<option value=""<cfif editMode><cfif #getmodel.vehicletype# is ""> SELECTED</cfif></cfif>>Please Select
			<option value="c"<cfif editMode><cfif #getmodel.vehicletype# is "c"> SELECTED</cfif></cfif>>Car
			<option value="t"<cfif editMode><cfif #getmodel.vehicletype# is "t"> SELECTED</cfif></cfif>>Truck
			<option value="s"<cfif editMode><cfif #getmodel.vehicletype# is "s"> SELECTED</cfif></cfif>>Sport Utility Vehicle
			<option value="v"<cfif editMode><cfif #getmodel.vehicletype# is "v"> SELECTED</cfif></cfif>>Van
		</select>
		<input type="hidden" name="VehicleType_required" value="Please select a vehicle type.">
	</td>
</tr>
<tr>
	<td colspan="2"><b>Glamour Copy:</b></td>
</tr>
<tr>
	<td colspan="2" align="CENTER">
		<textarea name="GlamourCopy" cols="35" rows="10" wrap="PHYSICAL"><cfif editMode>#getModel.GlamourCopy#</cfif></textarea>
	</td>
</tr>
<tr>
	<td colspan="2"><b>Features:</b></td>
</tr>
<tr>
	<td colspan="2" align="CENTER">
		<textarea name="Features" cols="35" rows="10" wrap="PHYSICAL"><cfif editMode>#getModel.Features#</cfif></textarea>
	</td>
</tr>
<!--- Save button --->		
<tr align="center">
	<td colspan="2">
	<cfif editMode>
		<input type="Image" src="#application.RELATIVE_PATH#/images/admin/save.gif" name="Save" value="Save" border="0">
	<cfelse>
		<input type="Image" src="#application.RELATIVE_PATH#/images/admin/save.gif" name="Save_New" value="Save" border="0">
	</cfif>
	&nbsp;&nbsp;<a href="javascript:history.back()"><img src="#application.RELATIVE_PATH#/images/admin/cancel.gif" Border="0"></a>
	</td>
</tr>
</table>
</form>
</cfoutput>
