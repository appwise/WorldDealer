                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 31, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!--- $Id: incentives_main.cfm,v 1.3 2000/06/15 17:11:21 jkrauss Exp $ --->

<!--- List of Makes, Regions, and dealerships within those regions --->
<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: incentives_main.cfm,v $">

<cfquery name="getMakeRegionDlrs" datasource="#gDSN#">
	SELECT	Makes.MakeName, 
			MakeRegions.RegionName, 
			Dealers.Dealercode, 
			Dealers.DealershipName, 
			Dealers.ContactName, 
			Dealers.ContactPhone
	FROM	((Makes 
			LEFT JOIN MakeRegions ON Makes.MakeNumber = MakeRegions.MakeNumber) 
			LEFT JOIN DealerFranchise ON MakeRegions.RegionID = DealerFranchise.RegionID) 
			LEFT JOIN Dealers ON DealerFranchise.Dealercode = Dealers.DealerCode
	ORDER BY MakeName, RegionName
</cfquery>

<div align="center">
<table border="1" cellpadding="2" cellspacing="0">
<br><br>
<tr bgcolor="Black">
	<td align="center">
		<font color="White"><b>Make</b></font>
	</td>
	<td align="center">
		<font color="White"><b>Region</b></font>
	</td>
	<td align="center">
		<font color="White"><b>Dealership</b></font>
	</td>
	<td align="center">
		<font color="White"><b>Contact</b></font>
	</td>
	<td align="center">
		<font color="White"><b>Phone</b></font>
	</td>
</tr>
<cfoutput query="getMakeRegionDlrs">
<tr>
	<td>
		#MakeName#
	</td>
	<td>
		<cfif RegionName neq "">#RegionName#<cfelse>&nbsp;</cfif>
	</td>
	<td>
		<cfif DealershipName neq "">#DealershipName#<cfelse>&nbsp;</cfif>
	</td>
	<td>
		<cfif ContactName neq "">#ContactName#<cfelse>&nbsp;</cfif>
	</td>
	<td>
		<cfif ContactPhone neq "">#ContactPhone#<cfelse>&nbsp;</cfif>
	</td>
</tr>
</cfoutput>
</table>
</div>
<br><br>

<cfmodule template="/util/DumpDebug.cfm" text="end   $RCSfile: incentives_main.cfm,v $">

