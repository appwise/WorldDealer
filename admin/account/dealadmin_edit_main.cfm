                         <!--- Created by AppNet, Inc., Detroit
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 11, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->            
<!--- $Id: dealadmin_edit_main.cfm,v 1.9 2000/05/18 23:53:07 lswanson Exp $ --->

<cfif parameterexists(form.delete.x)>
	<cflocation url="dealadmin_del.cfm?DealerAdministrator=#Form.DealerAdministrator#">
</cfif>

<cfset editmode = "false">
<cfif parameterexists (form.dealeradministrator) or 
	parameterexists (url.dealeradministrator)>
	<cfset editmode = "true">
</cfif>

<cfif editmode>
	<cfquery name="EditDA" datasource="#gDSN#">
		SELECT  LoginID,
			    Name,
				Password,
				accountkey,
				RowID
		FROM    Accounts
		WHERE   AccountType = 'DE'
				<cfif parameterexists (form.dealeradministrator)>
					AND RowID = #form.DealerAdministrator#
				<cfelseif parameterexists (url.dealeradministrator)>
					AND RowID = #url.DealerAdministrator#
				</cfif>
				<cfif parameterexists (form.dealeradministrator)>
					AND RowID = Convert(int, #form.DealerAdministrator#)
				<cfelse>
					AND RowID = Convert(int, #url.DealerAdministrator#)
				</cfif>
	</cfquery>
</cfif>

<div align="center">

<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td>&nbsp;<p></td>
</tr>
<tr align="center">
	<td>
		<h3>Dealer Administrator Maintenance</h3>
	</td>
</tr>
<tr align="center">
	<td>
		Use the fields provided to make changes to a Dealer Administrator.<br>
		Required fields are bolded.<br><br>
	</td>
</tr>
<tr>
	<td align="center">
		<!--- variables required for dealer_select.cfm --->
		<cfif editmode>
			<cfset mode="da_edit">
		<cfelse>
			<cfset mode="da_edit_new">
		</cfif>

		<cfinclude template="../mysite/dealer_select.cfm">
	</td>
</tr>
<tr>
	<td>
		<table border=0 cellpadding=5 cellspacing=0>
		<tr>
			<td align="right"><b>Name</b></td>
			<td>
				<cfoutput>
					<input type=text name="Name" size="30" maxlength="50" value="<cfif editmode>#editda.name#</cfif>">
				</cfoutput>
				<input type="hidden" name="Name_required" value="A name must be entered in the Name field.">
			</td>
		</tr>
		<tr>
			<td align="right"><b>Login ID</b></td>
			<td>
				<cfoutput>
					<input type=text name="LoginID" size="30" maxlength="15" value="<cfif editmode>#editda.LoginID#</cfif>">
				</cfoutput>
				<input type="hidden" name="loginid_required" value="You must enter a loginID">
			</td>
		</tr>
		<tr>
			<td align="right"><b>Password</b></td>
			<td>
				<cfoutput>
					<input type=text name="Password" size="30" maxlength="15" value="<cfif editmode>#editda.Password#</cfif>">
				</cfoutput>
				<input type="hidden" name="password_required" value="You must enter a password">
			</td>
		</tr>
		</table>
	</td>
</tr>
<tr align="center">
	<td>
		<br>
		<a href="dealadmin.cfm"><input type="image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/cancel.gif" name="Cancel" value="Cancel" border="0"></a>
		&nbsp;
		<input type="image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/save.gif" name="Save" value="Save" border="0">
		<cfif editmode>
			<cfoutput query="EditDA">
				<input type="hidden" name="RowID" value="#RowID#">
			</cfoutput>
		</cfif>
		<!--- beginning of form is in dealer_select.cfm --->
		</form>
	</td>
</tr>
</table>
</div>
