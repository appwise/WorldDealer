<cfif isdefined("Form.Save.X")>
	<!----- update existing manuf data----->
	<cfquery name="updMake" datasource="#gDSN#">
		UPDATE 	UVMakes
		SET		MakeName = '#Form.MakeName#'
		WHERE	MakeNumber = #Form.MakeNumber#
	</cfquery>	
	<cflocation url="preownmodels.cfm" addtoken="no">
<cfelseif isdefined("Form.Save_New.X")>
	<!--- Manually increment the MakeNumber --->
	<cfquery name="findMaxMakeNum" datasource="#gDSN#">
		SELECT MAX(MakeNumber) as MaxMake
		FROM UVMakes
	</cfquery>
	<cfquery name="findMaxModelNum" datasource="#gDSN#">
		SELECT MAX(ModelNumber) as MaxModel
		FROM UVModels
	</cfquery>
	
	<cfquery name="newMake" datasource="#gDSN#">
		INSERT INTO UVMakes (MakeNumber, MakeName)
		VALUES (#findMaxMakeNum.MaxMake# +1, '#Form.MakeName#')
	</cfquery>
	<cfquery name="newModel" datasource="#gDSN#">
		INSERT INTO UVModels (MakeNumber, ModelName, ModelNumber)
		VALUES (#findMaxMakeNum.MaxMake# +1, '#Form.ModelName#', #findMaxModelNum.MaxModel# +1)
	</cfquery>
	<cflocation url="preownmodels.cfm" addtoken="no">
</cfif>

<cfset editMode = "false">

<cfif isdefined("url.make")>
	<!--- get updated Make record --->
	<cfquery name="getMake" datasource="#gDSN#">
		SELECT 	*
		FROM	UVMakes
		WHERE	MakeNumber = #url.make#
	</cfquery>
	
	<cfset editMode = "true">
</cfif>
	
<!-----First time through, edit Manuf data ----->
<div align="center">
<table border="0" cellspacing="0" cellpadding="5">
<tr>
	<td>
	<cfif not editmode>
		To add a new make and model, simply fill out the form below<br>
		and click "save" when you are finished.
	<cfelse>
		To edit the make name, simply fill in the form below<br>
		and click "save" when you are finished.
	</cfif>
	</td>
</tr>
<cfoutput>
<tr>
	<td>
	<form name="add_r_edit" action="preownmodels_edit.cfm" method="post">
	<table width="100%" border="0" cellspacing="0" cellpadding="5">
	<tr>
		<td><b>Make:</b></td>
		<td>
			<input type="text" name="MakeName" size="25" maxlength="50" value="<cfif editMode>#getMake.MakeName#</cfif>">
			<input type="hidden" name="MakeName_required" value="Please enter a make name.">
			<input type="hidden" name="MakeNumber" value="<cfif editMode>#getMake.MakeNumber#</cfif>">
		</td>
	</tr>
	<cfif not editmode>
	<tr>
		<td><b>Model:</b></td>
		<td>
			<input type="text" name="ModelName" size="25" maxlength="50" value="">
			<input type="hidden" name="ModelName_required" value="To create a make, you must also provide at least one model.">
		</td>
	</tr>
	</cfif>
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
	</td>
</tr>
</cfoutput>
</table>
