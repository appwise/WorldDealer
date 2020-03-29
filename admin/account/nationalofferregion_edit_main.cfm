<cfquery name="getRegions" datasource="#gDSN#">
	SELECT Makes.MakeName, MakeRegions.RegionName
	FROM MakeRegions INNER JOIN Makes ON MakeRegions.MakeNumber = Makes.MakeNumber
	WHERE MakeRegions.RegionID=#URL.RegionID#
</cfquery>

<table align="center" border="0" cellspacing="0" cellpadding="0">
<form name="FindMake" action="nationalofferregion_save.cfm" method="post">	
	<tr>	
		<td>
			<h4>Edit the name of your region</h4>		
		</td>
	</tr>
	<tr>	
		<td>
			<input type="text" name="RegionName" size=25 maxlength=50 <cfif getregions.recordcount gt 0>value="<cfoutput>#getregions.regionname#</cfoutput>"</cfif>>
			<input type="hidden" name="RegionID" value="<cfoutput>#URL.RegionID#</cfoutput>">
		</td>
	</tr>
	<tr>
		<td align="center">
			<br><input type="image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/save.gif" name="Save" value="Sav" BORDER="0">
		</td>
	</tr>	
	</form>
</table>		