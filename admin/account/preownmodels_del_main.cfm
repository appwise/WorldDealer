<cfset PageAccess = application.sysadmin_access>

                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 14, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: preownmodels_del_main.cfm,v 1.1 2000/05/12 20:37:18 jkrauss Exp $ --->
<!--- Account Intro --->

<cfif IsDefined("Form.delMakes.X")>
	
	<cfif ParameterExists(form.MakeNumber)>
		<cfset vehicles = ArrayNew(1)>
		<cfset vehicles = ListToArray(#form.MakeNumber#)>
		<cfset count = 0>
	</cfif>
	
	<form action="preownmodels_del_action.cfm" method="POST">
	<table border="0" cellpadding="5" cellspacing="0" width="100%">
	<cfif ParameterExists(form.MakeNumber)>
	<tr>
		<td align="center">
			You are about to delete the following Makes from the database.<p>
			<b><font color="Red">WARNING</font></b><p>
			When you delete the makes, you permenantly delete<br>
			the corresponding models from the database as well.	
		</td>
	</tr>
	<tr>
		<td align="CENTER">
		<table border="0" cellspacing="0" cellpadding="2">
		<cfloop index="count" list="#form.MakeNumber#">
			<CFQUERY NAME="getMakes" datasource="#gDSN#">
				SELECT MakeNumber, MakeName
				FROM UVMakes
				WHERE MakeNumber = #count#
			</cfquery>
		<cfoutput>
		<input type="hidden" name="MakeName" value="#count#">
		<tr>
			<td><b>#getMakes.MakeName#</b></td>
		</tr>
		</cfoutput>
		</cfloop>
		</table><p>
		<a href="javascript:history.back()"><img src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/cancel.gif" BORDER="0"></a>&nbsp;&nbsp;
		<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/deletebutton.gif" BORDER="0" NAME="delMakes" VALUE="Delete_Makes">
		</td>
	</tr>
	<cfelse>
	<tr>
		<td align="center">
			You did not select any vehicles to delete.  Please use your back button to return to the previous page and select the vehicle or vehicles you wish to delete.<p>
			<a href="javascript:history.back()"><img src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/cancel.gif" BORDER="0"></a>
		</td>
	</tr>
	</cfif>
	</table>
	</form>

<cfelse>

	<CFQUERY NAME="getMakes" datasource="#gDSN#">
		SELECT MakeNumber, MakeName
		FROM UVMakes
		ORDER BY MakeName
	</cfquery>
	
	<table width="100%" border="0" cellspacing="0" cellpadding="5"><tr><td>
		Select the makes below that you would like to remove.  Then click the delete button at the bottom of the page.
	</td></tr></table><p>
	
	<div align="center">
	<table border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="CENTER" valign="TOP">
			<form action="preownmodels_del.cfm" method="POST">
			<table border="0" cellspacing="0" cellpadding="2">
			<cfloop query="getMakes">
			<cfoutput>
			<tr>
				<td><input type="Checkbox" name="MakeNumber" value="#MakeNumber#"></td>
				<td>#MakeName#</td>
			</tr>
			</cfoutput>
			</cfloop>
			</table><p>
			<a href="javascript:history.back()"><img src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/cancel.gif" BORDER="0"></a>&nbsp;&nbsp;
			<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/deletebutton.gif" BORDER="0" NAME="delMakes" VALUE="Delete_Makes">
			</form>
		</td>
	</tr>
	</table>
	</div>

</cfif>
