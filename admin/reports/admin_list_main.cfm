<cfquery name="getDealers" datasource="#gDSN#">
	Select 	dealercode,
			url,
			dealershipname
	from 	dealers
	order by dealershipname
</cfquery>

<table width="100%" border="0" cellspacing="0" cellpadding="5"><tr><td>

<h4>List of All Dealerships</h4>

<div align="center">
<table border="1" cellspacing="0" cellpadding="2">
<tr bgcolor="Black">
	<td align="CENTER"><font size="-1" color="White"><b>Dealership Name</b></font></td>
	<td align="CENTER"><font size="-1" color="White"><b>DealerCode</b></font></td>
</tr>
<cfloop query="getDealers">
	<cfoutput>
		<tr>
			<td><font size="-1">#dealershipname#</font>
			<cfif #url# is not "">
				<font size="-2"><br><a href="http://www.#url#" target="newwindow" style="color: Red; text-decoration: none;">www.#url#</a></font>
			<cfelse>
				<font size="-2"><br>&nbsp;</font>
			</cfif></td>
			<td><font size="-2">#dealercode#</font></td>
		</tr>
	</cfoutput>
</cfloop>
</table>
</div>

</td></tr></table>