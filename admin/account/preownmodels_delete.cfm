<cfset PageAccess = application.account_coordinator_access>
<cfinclude template = "../security.cfm">

<cfif ParameterExists(form.ModelNumber)>
	<cfset models = ArrayNew(1)>
	<cfset models = ListToArray(#form.ModelNumber#)>
	<cfset count = 0>
</cfif>

<cfloop index="count" list="#form.ModelNumber#">
	<cfquery name="deleteUsedVehicle" datasource="#gDSN#">
		DELETE FROM	UVModels
		WHERE ModelNumber = #count#
	</cfquery>
</cfloop>

<cflocation url="preownmodels.cfm" addtoken="no">