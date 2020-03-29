<cfset PageAccess = application.sysadmin_access>
<cfinclude template = "../security.cfm">

<cfset vehicles = ArrayNew(1)>
<cfset vehicles = ListToArray(#form.MakeName#)>
<cfset count = 0>

<cfloop index="count" list="#form.MakeName#">
	<cfquery name="KillMake" datasource="#gDSN#">
		DELETE FROM Makes
		WHERE MakeNumber = #count#
	</cfquery>
	
	<cfquery name="KillModels" datasource="#gDSN#">
		DELETE FROM Models
		WHERE Make = #count#
	</cfquery>
</cfloop>

<cflocation url="makemodel.cfm" addtoken="no">