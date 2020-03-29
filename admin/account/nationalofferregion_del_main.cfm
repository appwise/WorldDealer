<!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 14, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
									<!---$Id: nationalofferregion_del_main.cfm,v 1.4 2000/05/18 23:53:08 lswanson Exp $--->


<cfquery name="getRegions" datasource="#gDSN#">
	SELECT Makes.MakeName, MakeRegions.RegionName
	FROM MakeRegions INNER JOIN Makes ON MakeRegions.MakeNumber = Makes.MakeNumber
	WHERE MakeRegions.RegionID=#URL.RegionID#
</cfquery>

<table align="center" border="0" cellspacing="0" cellpadding="0">
<form name="FindMake" action="nationalofferregion_del_save.cfm" method="post">	
	<tr>	
		<td>
			<h4>Are your sure you want to delete this region?</h4>		
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
			<br><input type="image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/deletebutton.gif" name="delete" value="delete" BORDER="0">
		</td>
	</tr>	
	</form>
</table>		