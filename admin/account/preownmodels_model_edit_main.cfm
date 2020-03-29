<cfset PageAccess = application.sysadmin_access>

<cfif isdefined("Form.Save.X")>
	<!----- update existing model data----->
	<cfquery name="updModel" datasource="#gDSN#">
		UPDATE 	UVModels
		SET		ModelName = '#Form.ModelName#'
		WHERE	ModelNumber = #Form.ModelNumber#
	</cfquery>
	<cflocation url="preownmodels_model.cfm?make=#form.make#" addtoken="no">
<cfelseif isdefined("Form.Save_New.X")>
	<cfquery name="addModel" datasource="#gDSN#">
		INSERT INTO UVModels (ModelName, ModelNumber, MakeNumber)
		VALUES ('#Form.ModelName#', #Form.ModelNumber#, #Form.Make#)
	</cfquery>
	<cflocation url="preownmodels_model.cfm?make=#form.make#" addtoken="no">
</cfif>

<cfset editMode = "false">

<cfif isdefined("url.model")>
	<!--- get what's in the db now --->
	<cfquery name="getModel" datasource="#gDSN#">
		SELECT 	*
		FROM	UVModels
		WHERE	ModelNumber = #url.model#
	</cfquery>
	<cfset editMode = "true">
<cfelse>
	<cfquery name="findMaxModelNum" datasource="#gDSN#">
		SELECT MAX(ModelNumber) as MaxModel
		FROM UVModels
	</cfquery>
	<cfset MaxModel = findMaxModelNum.MaxModel + 1>
</cfif>

<cfquery name="getMakeName" datasource="#gDSN#">
	SELECT *
	FROM UVMakes
	<cfif parameterexists(url.model)>
		WHERE MakeNumber = #getModel.MakeNumber#
	<cfelse>
		WHERE MakeNumber = #url.make#
	</cfif>
</cfquery>
	
	
<table width="100%" border="0" cellspacing="0" cellpadding="5" bgcolor="White">
<cfoutput>
<tr>
	<td>
		<form name="StepOne" action="preownmodels_model_edit.cfm" method="post">
		<div align="center">
		<table border=0 cellspacing=0 cellpadding=5>
		<tr>
			<td><b>Make:</b></td>
			<td>
				#getMakeName.MakeName#
				<input type="hidden" name="Make" value="<cfif editMode>#getMakeName.MakeNumber#<cfelse>#url.make#</cfif>">
			</td>
		</tr>
		<tr>
			<td><b>Model:</b></td>
			<td>
				<input type="text" name="ModelName" size="20" maxlength="35" value="<cfif editMode>#getModel.ModelName#</cfif>">
				<input type="hidden" name="ModelName_required" value="Please enter a model name.">
				<input type="hidden" name="ModelNumber" value="<cfif editMode>#getModel.ModelNumber#<cfelse>#MaxModel#</cfif>">
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
		</div>
		</form>
	</td>
</tr>
</cfoutput>
</table>

