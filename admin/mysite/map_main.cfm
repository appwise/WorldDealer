<cfset PageAccess = application.dealer_access>

                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 17, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!--- $Id: map_main.cfm,v 1.10 2000/04/07 18:34:08 lswanson Exp $ --->

<!--- Map: generate/view maps --->

<cfquery name="getAddress" datasource="#gDSN#">
	SELECT	Addressline1,
			Addressline2,
			City,
			StateAbbr,
			Zip
	FROM	Dealers
	WHERE	Dealercode = '#g_dealercode#'
</cfquery>

<cfquery name="getStates" datasource="#gDSN#">
	SELECT	StateAbbr, 
			Description
	FROM 	States
	ORDER BY Description
</cfquery>

<cfquery name="getMapText" datasource="#gDSN#">
	SELECT	maptext
	FROM	Dealerwebs
	WHERE	Dealercode = '#g_dealercode#'
</cfquery>

<cfif isdefined("Url.mapnumber")>
	<cfset whichmap=url.mapnumber>
	<cfif isdefined("Form.ZoomIn.X")>
		<cfset whichmap=whichmap - 1>
	<cfelseif isdefined("Form.ZoomOut.X")>
		<cfset whichmap=whichmap + 1>
	</cfif>
<cfelse>
	<cfset whichmap=6>
</cfif>

<cfx_directorylist directory="#g_rootdir#\images\maps"
	name="map_query"
	sort="type ASC, name ASC">

<cfset thematch = 0>

<cfloop query="map_query">
	<cfset match = #find(g_dealercode, name, 1)#>
	<cfif #match# eq 1> <!--- This file starts with Dealercode --->
		<cfset thematch = 1>
		<cfbreak>
	</cfif>
</cfloop>
		
<table border="0" width="100%" cellpadding="5" cellspacing="0">
<form action="map.cfm?&mapnumber=<CFOUTPUT>#whichMap#</cfoutput>" METHOD="POST">
<tr>
	<td>
		<a name="Map"></a>
		<h4>View Maps</h4>
	</td>
</tr>
<cfif thematch eq 0>
	<tr align="center">
		<td>
			No maps are available yet.  Please enter your address to generate the maps.
		</td>
	</tr>
<cfelse>
	<tr align="center">
		<td>
			The current map range is
			<cfoutput>#Evaluate("#Evaluate("2^(#Evaluate("#whichMap#-6")#)")#*10")#</cfoutput> miles.
			<br><br>
			Click on the appropriate magnifying glass to zoom in or out:
		</td>
	</tr>
	<tr>
		<td align="center">
			<cfif #whichmap# gt 1>
				<input type="IMAGE" name="ZoomIn"
					src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/map_zoomin_nav.gif"
					ALT="ZoomIn"
					BORDER=0>
			</cfif>
			&nbsp;&nbsp;&nbsp;
			<cfif #whichmap# lt 10>
				<input type="IMAGE" name="ZoomOut"
					src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/map_zoomout_nav.gif"
					ALT="ZoomOut"
					BORDER=0>
			</cfif>
		</td>
	</tr>
	<tr align="center">
		<td>
			<cfoutput>
			<img src="#application.RELATIVE_PATH#/images/maps/#g_dealercode#_#whichMap#_map_gra.gif" 
				width = 400
				height = 350
				alt="Map">
			</cfoutput>
		</td>
	</tr>
</cfif>

<!--- Chris Wacker 11/14/2000 2:42 PM
		Here is my Guesstimation of what should be added for driving directions.
		Please add COLUMN DrivingDirections to table getDealerInfo --->

</form>
<tr>
	<td>
		<a name="Address"></a>
		<h4>Change Maps</h4>
	</td>
</tr>
<tr>
	<td>
		<form action="map_gen.cfm?mapnumber=<CFOUTPUT>#whichMap#</cfoutput>" METHOD="POST">
		
		<tr align="center">
		<td>
		<b>Please include driving directions from<br> 
		major landmarks within your city.<br><br></b>
		<cfif #rtrim(getMapText.maptext)# is "">
		<b><font color="Red">RECOMMENDED:  Place directions.</font></b><br>
		</cfif>
			<cfoutput> 
					<cfif #rtrim(getMapText.maptext)# is not "">
						<textarea name="DrivingDirections" cols="40" rows="10" wrap="PHYSICAL">#getMapText.maptext#
					<cfelse> 
						<textarea name="DrivingDirections" cols="40" rows="10" wrap="PHYSICAL">
					 </cfif> 
						</textarea>
			</cfoutput> 
		</td>
	</tr> 
		
		The maps will be automatically generated when you change your address.<br><br>
		<table border="0" cellpadding="0" cellspacing="0" align="center">
		<cfoutput>
		<tr>
			<td>
				Address 1
			</td>
			<td>
				<input type="text" name="Address1" size=25 maxlength=40 value="#getAddress.AddressLine1#">
			</td>
		</tr>
		<tr>
			<td>
				Address 2
			</td>
			<td>
				<input type="text" name="Address2" size=25 maxlength=40 value="#getAddress.AddressLine2#">
			</td>
		</tr>
		<tr>
			<td>
				City
			</td>
			<td>
				<input type="text" name="City" size=25 maxlength=35 value="#getAddress.City#">
			</td>
		</tr>
		</cfoutput>
		<tr>
			<td>
				State
			</td>
			<td>
				<select name="StateAbbr">
				<cfoutput query="getStates">
				<option value="#stateAbbr#" <cfif #getaddress.stateabbr# eq #stateabbr#>SELECTED</cfif>>#Description#</option>
				</cfoutput>                   
				</select>
			</td>
		</tr>
		<cfoutput>
		<tr>
			<td>
				Zip
			</td>
			<td>
				<input type="text" name="zip" size=10 maxlength=10 value="#getAddress.Zip#">
			</td>
		</tr>
		</cfoutput>
		<tr>
			<td colspan="2" align="center">
				<br>
				<input type="hidden" name="nextStep" value="map.cfm">
				<input type="Image" name="Save" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/save.gif" border="0">
				</form>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
