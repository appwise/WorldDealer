<cfquery name="getAutoUploadDealers" datasource="#gDSN#">
	SELECT 	dealers.dealershipname,
			dealers.url,
			dealers.dealercode,
			dlrxref.reynoldsactive,
			dlrxref.reynoldscode
	FROM	dealers
	INNER JOIN dlrxref ON dealers.dealercode = dlrxref.dealercode
	ORDER BY dlrxref.reynoldsactive DESC, dealers.dealershipname
</cfquery>

<table width="100%" border="0" cellspacing="0" cellpadding="5"><tr><td>

<h4>Dealerships with Automatic Uploads</h4>

<div align="center">
<table border="1" cellspacing="0" cellpadding="2">
<tr bgcolor="Black">
	<td align="CENTER"><font size="-1" color="White"><b>Dealership Name</b></font></td>
	<td align="CENTER"><font size="-1" color="White"><b>DealerCode</b></font></td>
	<td align="CENTER"><font size="-1" color="White"><b>Reynolds<br>Code</b></font></td>
	<td align="CENTER"><font size="-1" color="White"><b>Active</b></font></td>
</tr>
<cfloop query="getAutoUploadDealers">
	<cfoutput>
		<tr>
			<td><font size="-1">#dealershipname#</font>
			<cfif #url# is not "">
				<font size="-2"><br><a href="http://www.#url#" target="newwindow" style="color: Red; text-decoration: none;">www.#url#</a></font>
			<cfelse>
				<font size="-2"><br>&nbsp;</font>
			</cfif></td>
			<td><font size="-2">#dealercode#</font></td>
			<td align="CENTER"><font size="-2">#reynoldscode#</font></td>
			<td align="CENTER">
			<font<cfif #reynoldsactive# is "Y"> color="Green"<cfelse> color="Red"</cfif> size="-1"><b>#reynoldsactive#</b></font></td>
		</tr>
	</cfoutput>
</cfloop>
</table>
</div>

</td></tr></table>