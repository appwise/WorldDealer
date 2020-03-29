                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 14, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: incentives_make_main.cfm,v 1.3 2000/05/18 23:53:08 lswanson Exp $ --->
<!--- Select Make & Region for Incentives --->

<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: incentives_make_main.cfm,v $">

<cfif parameterexists(form.continue.x)>
	<cflocation url="incentives.cfm?MakeNumber=#form.MakeNumber#&RegionID=#form.RegionID#">  
</cfif>
<cfif parameterexists(form.addregion.x)>
	<cflocation url="nationalofferRegion_add.cfm?makenumber=#form.makenumber#">
</cfif>
<cfif parameterexists(form.modifyregion.x)>
	<cflocation url="nationalofferRegion_edit.cfm?RegionID=#form.RegionID#">
</cfif>
<cfif parameterexists(form.deleteregion.x)>
	<cflocation url="nationalofferRegion_del.cfm?RegionID=#form.RegionID#">
</cfif>

<cfquery name="getMakes" datasource="#gDSN#">
	SELECT DISTINCT MakeNumber, MakeName
	FROM Makes
	ORDER BY MakeName
</cfquery>

<cfif isdefined("URL.MakeNumber")>
	<cfquery name="getRegions" datasource="#gDSN#">
		SELECT	RegionID,
				RegionName
		FROM	MakeRegions
		WHERE	MakeNumber = #URL.MakeNumber#
		ORDER BY RegionName
	</cfquery>
</cfif>

<!--- a little script that goes with the onChange attribute of selected Make in drop-down.--->	
<script language="JavaScript">
<!--  
function onMakeChange()
	{
	with(document.forms[0].elements[0])
		selectedMake = options[selectedIndex].value
	
	if (selectedMake > 0)
		location.href = 'incentives_make.cfm?MakeNumber=' + selectedMake;
	else
		// this sets it back to the default.
		location.href = 'incentives_make.cfm';
	}
//-->
</script> 
	
<div align="center">
<table border=0 cellpadding=5 cellspacing=0>
<form name="FindMake" action="incentives_make.cfm" method="post">
<tr align="center">
	<td>
		To maintain incentives, select a Make and Region, then click Continue.<br><br>
	</td>
</tr>
<!--- list of makes & existing regions --->
<tr align="center">
	<td>
		<table border=0 cellpadding=5 cellspacing=0>
		<tr>
			<td>
				<b>Make:</b>
			</td>
			<td><!--- relate(this.selectedIndex); --->
				<select name="MakeNumber" onChange="onMakeChange()">
				<option value="">Select a Make
				<cfoutput query="getMakes">
					<option value="#MakeNumber#"<cfif isdefined("URL.MakeNumber")><cfif url.makenumber eq #makenumber#>SELECTED</cfif></cfif>>#Makename#
				</cfoutput>
				</select>
				<input type="Hidden" name="MakeNumber_required" value="Please select a Make from the list.">
			</td>
		</tr>
		<tr>
			<td>
				<b>Region:</b>
			</td>
			<td>
				<select name="RegionID">
				<cfif isdefined("URL.MakeNumber")>
					<option value="0" selected>National
					<cfoutput query="getRegions">
						<option value="#RegionID#">#Regionname#
					</cfoutput>
				<cfelse>
					<option value="0" selected>Choose a Make first
				</cfif>
				</select>
			</td>

			<td>
				<!--- Continue button takes you to Offers page --->
				<input type="Image" 
					src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/continue.gif" 
					name="Continue"
					value="Continue"
					width="66"
					height="15"
					border="0">
			</td>
		</tr>
		</table>
	</td>
</tr>
<tr align="center">
	<td>
		<br>
		To maintain regions, select a Make and/or Region, then click Add, Modify, or Delete.<br><br>
	</td>
</tr>
<tr align="center">
	<td>
		<!--- Add button: add a new region --->
			<input type="image" 
			src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/add.gif" 
			name="AddRegion" 
			value="Add Region"
			width="47"
			height="15" 
			border="0">
		&nbsp;&nbsp;
		<!--- Modify button: edit existing region --->
		<input type="image" 
			src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/modify.gif" 
			name="ModifyRegion" 
			value="Modify Region" 
			width="47"
			height="15" 
			border="0">
		&nbsp;&nbsp;
		<!--- Delete a Region --->
		<input type="image" 
			src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/deletebutton.gif" 
			name="DeleteRegion" 
			value="Delete Region" 
			width="47"
			height="15" 
			border="0">
	</td>
</tr>
</form>
</table>

</div>
<cfmodule template="/util/DumpDebug.cfm" text="end   $RCSfile: incentives_make_main.cfm,v $">
