<cfset PageAccess = application.sysadmin_access>

                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 14, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: preownmodels_model_main.cfm,v 1.2 2000/05/18 23:53:08 lswanson Exp $ --->
<!--- Account Intro --->

<CFQUERY NAME="getModels" datasource="#gDSN#">
	SELECT *
	FROM UVModels
	WHERE makeNumber = #url.make#
	ORDER BY ModelName
</cfquery>

<cfquery name="getMakes" datasource="#gDSN#">
	SELECT MakeName
	FROM UVMakes
	WHERE MakeNumber = #url.make#
</cfquery>

<table width="100%" border="0" cellspacing="0" cellpadding="5"><tr><td>
	You may edit the following models by clicking the appropriate link below.  If the model you are 
	looking for does not appear in the list, click the add button below to add a new model.  To remove 
	models, simply click the delete button to select the model or models you'd like to remove.
</td></tr></table><p>

<div align="center">
<table border="0" cellspacing="0" cellpadding="0">
<cfif getModels.recordCount eq 0>
	<tr>
		<td align="CENTER"><b>There are no models for this <cfoutput query="getMakes">#MakeName#</cfoutput> in the database.</b><br>&nbsp;</td>
	</tr>
<cfelse>
	<tr>
		<td align="CENTER">
		<b><cfoutput query="getMakes">#MakeName#</cfoutput> Models</b><p>
			<table border="0" cellspacing="0" cellpadding="2">
			<cfloop query="getModels">
			<cfoutput>
			<tr>
				<td>#ModelName#</td>
				<td>&nbsp;&nbsp;</td>
				<td><font size="-1" color="##EEAA00">[<a href="preownmodels_model_edit.cfm?model=#ModelNumber#">edit model</a>]</font></td>
			</tr>
			</cfoutput>
			</cfloop>
			</table><br>
		</td>
	</tr>
</cfif>
<tr>
	<td align="CENTER">
		<table border="0" cellspacing="0" cellpadding="5">
		<tr>
			<td><form action="preownmodels_model_edit.cfm?make=<cfoutput>#url.make#</cfoutput>" method="POST"><input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/add.gif" BORDER="0" NAME="AddMake" VALUE="Add"></form></td>
			<cfif getModels.recordCount gt 0><td><form action="preownmodels_model_del.cfm?make=<cfoutput>#url.make#</cfoutput>" method="POST"><input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/deletebutton.gif" BORDER="0" NAME="DeleteModels" VALUE="Delete"></form></td></cfif>
		</tr>
		<tr>
			<td align="CENTER"<cfif getModels.recordCount gt 0> colspan="2"</cfif>><a href="preownmodels.cfm" style="text-decoration: none;"><img src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/back.gif" BORDER="0" ALT="Back to Makes"></a><br>&nbsp;</td>
		</tr>
		</table>		
	</td>
</tr>
</table>
</div>
