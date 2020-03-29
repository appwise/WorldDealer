    <!-- ----------------------------------------------------------- -->
    <!--       Created by sigma6, Detroit       -->
    <!--         Copyright (c) 1997, 1998, 1999 sigma6.              -->
    <!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->

    <!-- ----------------------------------------------------------- -->
    <!--     John Turner for sigma6, interactive media, Detroit      -->
    <!--    jturner@sigma6.com   www.sigma6.com    www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
	<!--- $Id: dealadmin_main.cfm,v 1.5 2000/05/18 23:53:07 lswanson Exp $ --->


<cfquery name="getDAs" datasource="#gDSN#">
	SELECT  LoginID,
		    Name,
			RowID,
			AccountKey
	FROM    Accounts
	WHERE   AccountType = 'DE'
	ORDER BY Name, LoginID;
</cfquery>

<div align="center">

<table cellpadding=0 cellspacing=0 border=0 width=520 bgcolor="FFFFFF">
	<tr>
		<td>&nbsp;<p></td>
	</tr>
	<tr align="center">
		<td align="middle"><h3><font face="Arial,Helvetica">Dealer Administration<br>Maintain Dealer Administrator List</font></h3></td>
	</tr>
	<tr align="center">
		<td align="middle"><font face="Arial,Helvetica">Choose a Dealer Administrator to Edit or Delete, or select Add Dealer Administrator to add a Dealer Web Site Administrator.</font></td>
	</tr>
	<tr>
		<td>&nbsp;<p></td>
	</tr>
	<tr>
		<td>
			<cfform name="FormOne" action="dealadmin_edit.cfm" enablecab="Yes">
			<table cellspacing=0 cellpadding=0 border=0 width="90%">
				<tr>
					<td align="right"><b><font face="Arial,Helvetica">Dealer<br>Administrator</font></b></td>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><select name="DealerAdministrator">
						<option value="">
						<cfoutput query="getDAs">
							<cfif name is not " ">
								<option value="#RowID#">#Name# (#AccountKey#)
							</cfif>
						</cfoutput>
						</select>
						<input type="hidden" name="DealerAdministrator_required">
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr align="center">
		<td>
			<input type="image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/modify.gif" VALUE="EDIT" NAME="EDIT" BORDER="0">
			&nbsp;&nbsp;&nbsp;

			<input type="image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/deletebutton.gif" value="DELETE" name="DELETE" BORDER="0">
			<P>
			</CFFORM>
			<form name="adddainfo" action="dealadmin_edit.cfm" method="post">
				<input type="image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/add.gif" border="0" name="SaveDAInfo" value="Add Dealer Admin">

			</form>
			<p>
			<form name="f_Back" action="accstaff.cfm" method="post">
				<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/back.gif" Border="0" NAME="BackToMain" VALUE="Back To Main Menu">
			</form>
		</td>
	</tr>
</table>
</div>