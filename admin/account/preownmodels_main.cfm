<CFQUERY NAME="getMakes" datasource="#gDSN#">
	SELECT MakeNumber, MakeName
	FROM UVMakes
	ORDER BY MakeName
</cfquery>

<table width="100%" border="0" cellspacing="0" cellpadding="5"><tr><td>
Select a make from the menu below to see the list of available models for that make.  If the make you are 
looking for does not appear in the menu, click the add button below to add a new make and model.
</td></tr></table><p>
	
<div align="center">
<table border="0" cellspacing="0" cellpadding="0">
<tr>
	<td align="CENTER" valign="TOP">
		<table border="0" cellspacing="0" cellpadding="2">
		<cfloop query="getMakes">
		<cfoutput>
		<tr>
			<td>#MakeName#</td>
			<td>&nbsp;&nbsp;</td>
			<td><font size="-1" color="##EEAA00">[<a href="preownmodels_edit.cfm?make=#MakeNumber#">edit make</a>]</font></td>
			<td><font size="-1" color="##EEAA00">[<a href="preownmodels_model.cfm?make=#MakeNumber#">edit models</a>]</font></td>
		</tr>
		</cfoutput>
		</cfloop>
		</table>
	</td>
</tr>
<tr>
	<td align="CENTER">
		<table border="0" cellspacing="0" cellpadding="5">
		<tr>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td><form action="preownmodels_edit.cfm" method="POST"><input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/add.gif" BORDER="0" NAME="AddMake" VALUE="Add"></form></td>
			<td><form action="preownmodels_del.cfm" method="POST"><input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/deletebutton.gif" BORDER="0" NAME="DeleteMakes" VALUE="Delete"></form></td>
		</tr>
		</table>
	</td>
</tr>
</table>
</div>