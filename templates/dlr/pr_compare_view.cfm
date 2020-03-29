<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Vehicle Comparison</title>
<div align="center">
<cfif isDefined("cookie.pr_compare")>
	<cfloop index="item" list="#cookie.pr_compare#" delimiters=",">
		<cfquery name="fq#item#" datasource="#gDSN#">
			SELECT	UsedVehicles.*, UVModels.ModelName, UVMakes.MakeName
			FROM	(UsedVehicles 
					INNER JOIN UVModels ON UsedVehicles.ModelNumber = UVModels.ModelNumber) 
					INNER JOIN UVMakes ON UVModels.MakeNumber = UVMakes.MakeNumber
			WHERE 	UsedVehicles.UsedVehicleID = #item#
		</cfquery>
		<cfquery name="sq#item#" datasource="#gDSN#">
			SELECT *
			FROM UVDetails
			WHERE UsedVehicleID = #item#
		</cfquery>
	</cfloop>
	
	<script language="JavaScript">
	<!--
		function compRemove(vehicle){
			newWindow = window.open("pr_compare.cfm?removing=true&id="+vehicle, "", "height=1,width=1,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,screenX=5000,screenY=5000,left=5000,right=5000");
		}
		function gotoDetails(vehicle){
			opener.location.href="main.cfm?section=pr&subsection=details&id="+vehicle;
			opener.focus();
		}
	//-->
	</script>
</cfif>
	
</head>

<CFINCLUDE TEMPLATE="global_#arttempid.arttempid#.htm">
<body onload="focus()">

<div align="center">
<cfif trim(cookie.pr_compare) is not "">
<table border="0" cellspacing="0" cellpadding="5">
<tr>
	<td><font face="Arial,Verdana,Helvetica" size="3" color="<cfoutput>#theothercolor#</cfoutput>"><b>VEHICLE COMPARISON</b></font></td>
</tr>
<tr><td>

	<table border="0" cellspacing="0" cellpadding="2" bgcolor="<cfoutput>#theothercolor#</cfoutput>"><tr><td>
		<table border="1" cellspacing="0" cellpadding="3">
		<tr bgcolor="<cfoutput>#thecolor#</cfoutput>">
			<td rowspan="2" bgcolor="<cfoutput>#thecolor#</cfoutput>"><font face="Arial,Verdana,Helvetica" size="2" color="White">&nbsp;</font></td>
			<cfloop index="item" list="#cookie.pr_compare#" delimiters=",">
				<cfoutput query="fq#item#">				
					<td align="CENTER" bgcolor="#thecolor#" valign="top">
						<font face="Arial,Verdana,Helvetica" size="2" color="#textcolor#"><a href="javascript:gotoDetails('#item#')" style="color: #textcolor#;"><b>#caryear# #makename# #modelname#<cfif #trim(trim)# is not ''> #trim#</cfif></b></a></font><br>
					</td>
				</cfoutput>
			</cfloop>
		</tr>
		<tr bgcolor="<cfoutput>#thecolor#</cfoutput>">
			<cfloop index="item" list="#cookie.pr_compare#" delimiters=",">
				<cfoutput query="fq#item#">				
					<td align="CENTER" bgcolor="#theothercolor#">
						<table border="0" cellspacing="0" cellpadding="2">
						<tr>
							<td><a href="javascript:compRemove('#item#')"><img src="#application.RELATIVE_PATH#/images/common/remove.gif" border="0" alt="remove from comparison list"></a></td>
							<td nowrap><font face="arial,helvetica" size="1" color="#othertextcolor#">&nbsp;<a href="javascript:compRemove('#item#')" style="text-decoration: none; color: #textcolor#;">Remove From Comparison</a></font></td>
						</tr>
						</table>
					</td>
				</cfoutput>
			</cfloop>
		</tr>
		<!--- <tr bgcolor="<cfoutput>#thirdcolor#</cfoutput>"> --->
		<tr bgcolor="<cfoutput>#thirdcolor#</cfoutput>">
			<td><font face="Arial,Verdana,Helvetica" size="2" color="Black"><b>Price</b></font></td>
			<cfloop index="item" list="#cookie.pr_compare#" delimiters=",">
				<cfoutput query="fq#item#">				
					<td align="CENTER"><font face="Arial,Verdana,Helvetica" size="2" color="Black"><cfif #price# lt 10>Please See Dealer for Price<cfelse>#DollarFormat(Price)#</cfif></font></td>
				</cfoutput>
			</cfloop>
		</tr>
		<tr bgcolor="white">
			<td><font face="Arial,Verdana,Helvetica" size="2" color="Black"><b>Mileage</b></font></td>
			<cfloop index="item" list="#cookie.pr_compare#" delimiters=",">
				<cfoutput query="fq#item#">				
					<td align="CENTER"><font face="Arial,Verdana,Helvetica" size="2" color="Black"><cfif #Mileage# GTE 100>#NumberFormat(Mileage)#<cfelse>See Dealer</cfif></font></td>
				</cfoutput>
			</cfloop>
		</tr>
		<tr bgcolor="<cfoutput>#thirdcolor#</cfoutput>">
			<td><font face="Arial,Verdana,Helvetica" size="2" color="Black"><b>Engine</b></font></td>
			<cfloop index="item" list="#cookie.pr_compare#" delimiters=",">
				<cfoutput query="sq#item#">	
					<cfset ESize = false>
					<cfset EOther = false>			
					<cfif trim(enginesize) is not ''>
						<cfset ESize = true>
					</cfif>
					<cfif trim(engineConfig) is not '' AND trim(engineCylinders) is not ''>
						<cfset EOther = true>
					</cfif>
					<td align="CENTER"><font face="Arial,Verdana,Helvetica" size="2" color="Black"><cfif ESize>#engineSize# L </cfif><cfif EOther><cfif engineConfig is 'I'>In-line <cfelse>V</cfif>#engineCylinders#<cfif engineConfig is 'I'> Cylinder</cfif></cfif></font></td>
				</cfoutput>
			</cfloop>
		</tr>
		<tr bgcolor="white">
			<td><font face="Arial,Verdana,Helvetica" size="2" color="Black"><b>Transmission</b></font></td>
			<cfloop index="item" list="#cookie.pr_compare#" delimiters=",">
				<cfoutput query="fq#item#">				
					<td align="CENTER"><font face="Arial,Verdana,Helvetica" size="2" color="Black"><cfif trim(transmission) is not "">#transmission#<cfelse>&nbsp;</cfif></font></td>
				</cfoutput>
			</cfloop>
		</tr>
		<tr bgcolor="<cfoutput>#thirdcolor#</cfoutput>">
			<td><font face="Arial,Verdana,Helvetica" size="2" color="Black"><b>Stereo</b></font></td>
			<cfloop index="item" list="#cookie.pr_compare#" delimiters=",">
				<cfoutput query="sq#item#">				
					<td align="CENTER"><font face="Arial,Verdana,Helvetica" size="2" color="Black"><cfif trim(stereoType) is not "">#stereoType#<cfelse>&nbsp;</cfif></font></td>
				</cfoutput>
			</cfloop>
		</tr>
		<tr bgcolor="white">
			<td><font face="Arial,Verdana,Helvetica" size="2" color="Black"><b>Seating</b></font></td>
			<cfloop index="item" list="#cookie.pr_compare#" delimiters=",">
				<cfoutput query="sq#item#">				
					<td align="CENTER"><font face="Arial,Verdana,Helvetica" size="2" color="Black"><cfif trim(seatingType) is not "">#seatingType#<cfelse>&nbsp;</cfif></font></td>
				</cfoutput>
			</cfloop>
		</tr>
		<tr bgcolor="<cfoutput>#thirdcolor#</cfoutput>">
			<td><font face="Arial,Verdana,Helvetica" size="2" color="Black"><b>Upholstery</b></font></td>
			<cfloop index="item" list="#cookie.pr_compare#" delimiters=",">
				<cfoutput query="sq#item#">				
					<td align="CENTER"><font face="Arial,Verdana,Helvetica" size="2" color="Black"><cfif trim(upholstery) is not "">#upholstery#<cfelse>&nbsp;</cfif></font></td>
				</cfoutput>
			</cfloop>
		</tr>
		<tr bgcolor="white">
			<td><font face="Arial,Verdana,Helvetica" size="2" color="Black"><b>Air Conditioning</b></font></td>
			<cfloop index="item" list="#cookie.pr_compare#" delimiters=",">
				<cfoutput query="sq#item#">				
					<td align="CENTER"><font face="Arial,Verdana,Helvetica" size="2" color="Black"><cfif trim(airConditioning) is "y"><img src="#application.RELATIVE_PATH#/images/common/bullet.gif" border="0"><cfelse>&nbsp;</cfif></font></td>
				</cfoutput>
			</cfloop>
		</tr>
		<tr bgcolor="<cfoutput>#thirdcolor#</cfoutput>">
			<td><font face="Arial,Verdana,Helvetica" size="2" color="Black"><b>Cruise Control</b></font></td>
			<cfloop index="item" list="#cookie.pr_compare#" delimiters=",">
				<cfoutput query="sq#item#">				
					<td align="CENTER"><font face="Arial,Verdana,Helvetica" size="2" color="Black"><cfif trim(cruiseControl) is "y"><img src="#application.RELATIVE_PATH#/images/common/bullet.gif" border="0"><cfelse>&nbsp;</cfif></font></td>
				</cfoutput>
			</cfloop>
		</tr>
		<tr bgcolor="white">
			<td><font face="Arial,Verdana,Helvetica" size="2" color="Black"><b>Driver Air Bag</b></font></td>
			<cfloop index="item" list="#cookie.pr_compare#" delimiters=",">
				<cfoutput query="sq#item#">				
					<td align="CENTER"><font face="Arial,Verdana,Helvetica" size="2" color="Black"><cfif trim(airbagDriver) is "y"><img src="#application.RELATIVE_PATH#/images/common/bullet.gif" border="0"><cfelse>&nbsp;</cfif></font></td>
				</cfoutput>
			</cfloop>
		</tr>
		<tr bgcolor="<cfoutput>#thirdcolor#</cfoutput>">
			<td nowrap><font face="Arial,Verdana,Helvetica" size="2" color="Black"><b>Passenger Air Bag</b></font></td>
			<cfloop index="item" list="#cookie.pr_compare#" delimiters=",">
				<cfoutput query="sq#item#">				
					<td align="CENTER"><font face="Arial,Verdana,Helvetica" size="2" color="Black"><cfif trim(airbagPassenger) is "y"><img src="#application.RELATIVE_PATH#/images/common/bullet.gif" border="0"><cfelse>&nbsp;</cfif></font></td>
				</cfoutput>
			</cfloop>
		</tr>
		<tr bgcolor="white">
			<td><font face="Arial,Verdana,Helvetica" size="2" color="Black"><b>ABS</b></font></td>
			<cfloop index="item" list="#cookie.pr_compare#" delimiters=",">
				<cfoutput query="sq#item#">				
					<td align="CENTER"><font face="Arial,Verdana,Helvetica" size="2" color="Black"><cfif trim(brakes) contains "abs"><img src="#application.RELATIVE_PATH#/images/common/bullet.gif" border="0"><cfelse>&nbsp;</cfif></font></td>
				</cfoutput>
			</cfloop>
		</tr>
		<tr bgcolor="<cfoutput>#thirdcolor#</cfoutput>">
			<td><font face="Arial,Verdana,Helvetica" size="2" color="Black"><b>Wheels</b></font></td>
			<cfloop index="item" list="#cookie.pr_compare#" delimiters=",">
				<cfoutput query="sq#item#">				
					<td align="CENTER"><font face="Arial,Verdana,Helvetica" size="2" color="Black"><cfif trim(wheelDescription) is not "">#wheelDescription#<cfelse>&nbsp;</cfif></font></td>
				</cfoutput>
			</cfloop>
		</tr>
		<tr bgcolor="white">
			<td><font face="Arial,Verdana,Helvetica" size="2" color="Black"><b>Photo</b></font></td>
			<cfloop index="item" list="#cookie.pr_compare#" delimiters=",">
				<cfoutput query="fq#item#">				
					<cfif #image# is "Y">
						<td align="CENTER">
							<a href="pr_photo.cfm?id=#item#" target="newwindow" style="text-decoration: none;">
							<img src="#application.RELATIVE_PATH#/images/usedvehicles/#Trim(VIN)#.jpg" width=150 border=1 vspace=5 hspace=5 alt=""><br>
							<font face="arial, verdana, helvetica" size="1" color="#theothercolor#">click here for larger photo</font></a>
						</td>
					<cfelse>
						<td align="CENTER"><font face="Arial,Verdana,Helvetica" size="2" color="Black">none</font></td>
					</cfif>
				</cfoutput>
			</cfloop>
		</tr>
		</table>
	</td></tr></table>
		
	</td>
</tr>
<tr>
	<td valign="TOP">
		<table>
		<tr>
			<td><a href="pr_compare_remove.cfm"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/common/delete.gif" border="0" alt="delete comparison list"></a></td>
			<td><font face="Arial,Verdana,Helvetica" size="1" color="<cfoutput>#theothercolor#</cfoutput>"><a href="pr_compare_remove.cfm" style="text-decoration: none;">DELETE COMPARISON LIST</a></font></td>
		</tr>
		</table>
	</td>
</tr>
</table><br>

<table border="0" cellspacing="0" cellpadding="0"><tr><td>
<font face="Arial,Verdana,Helvetica" size="2" color="<cfoutput>#theothercolor#</cfoutput>">
We will keep this list active for you for 30 days.<br>
Feel free to check back at any time.
</font>
</td></tr></table><p>
	
	<font face="Arial,Verdana,Helvetica" size="1" color="<cfoutput>#theothercolor#</cfoutput>"><a href="javascript:window.close()" style="text-decoration: none;">CLOSE WINDOW</a></font>
<cfelse>
	<script type="text/javascript" language="JavaScript">
	<!--
		opener.location.href=opener.location;
		window.close();
	//-->
	</script>
</cfif>
</div>

</body>
</html>