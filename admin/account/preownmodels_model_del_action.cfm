<cfset PageAccess = application.sysadmin_access>
<cfinclude template = "../security.cfm">

<cfset vehicles = ArrayNew(1)>
<cfset vehicles = ListToArray(#form.ModelName#)>
<cfset count = 0>

<cfloop index="count" list="#form.ModelName#">
	<cfquery name="KillMake" datasource="#gDSN#">
		DELETE FROM UVModels
		WHERE	ModelNumber = #count#
	</cfquery>
</cfloop>

<cflocation url="preownmodels_model.cfm?make=#form.make#" addtoken="no">