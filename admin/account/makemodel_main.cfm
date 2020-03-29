                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 14, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: makemodel_main.cfm,v 1.5 2000/05/18 23:53:08 lswanson Exp $ --->
<!--- Account Intro --->

<CFQUERY NAME="getMakes" datasource="#gDSN#">
	SELECT MakeName, MakeNumber
	FROM Makes
	ORDER BY MakeName
</cfquery>

<table width="100%" border="0" cellspacing="0" cellpadding="5"><tr><td>
	You may edit the following makes by clicking the appropriate link below.  If the make you are 
	looking for does not appear in the list, click the add button below to add a new make.  To remove 
	makes, simply click the delete button to select the make or makes you'd like to remove.
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
			<td><font size="-1" color="##EEAA00">[<a href="makemodel_edit.cfm?make=#MakeNumber#">edit make</a>]</font></td>
			<td><font size="-1" color="##EEAA00">[<a href="makemodel_model.cfm?make=#MakeNumber#">edit models</a>]</font></td>
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
		<CFOUTPUT>
			<td><form action="makemodel_edit.cfm" method="POST"><input type="Image" src="#application.RELATIVE_PATH#/images/admin/add.gif" BORDER="0" NAME="AddMake" VALUE="Add"></form></td>
			<td><form action="makemodel_del.cfm" method="POST"><input type="Image" src="#application.RELATIVE_PATH#/images/admin/deletebutton.gif" BORDER="0" NAME="DeleteMakes" VALUE="Delete"></form></td>
		</cfoutput>
		</tr>
		</table>
	</td>
</tr>
</table>
</div>
