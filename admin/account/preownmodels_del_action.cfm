<cfset PageAccess = application.sysadmin_access>
<cfinclude template = "../security.cfm">

<cfset vehicles = ArrayNew(1)>
<cfset vehicles = ListToArray(#form.MakeName#)>
<cfset count = 0>

<cfloop index="count" list="#form.MakeName#">
	<cfquery name="KillMake" datasource="#gDSN#">
		DELETE FROM UVMakes
		WHERE	MakeNumber = #count#
	</cfquery>
	
	<cfquery name="KillModels" datasource="#gDSN#">
		DELETE FROM UVModels
		WHERE	MakeNumber = #count#
	</cfquery>
</cfloop>

<cflocation url="preownmodels.cfm" addtoken="no">