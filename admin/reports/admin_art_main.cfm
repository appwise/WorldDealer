<cfset listmode = "false">
<cfset getmode = "false">

<cfif ParameterExists(Form.getTemplate)>
	<cfset listmode = "true">
<cfelse>
	<cfset getmode = "true">
</cfif>

<cfquery name="getTemplatesFirst" datasource="#gDSN#">
	SELECT 	ArtTempID,
			description
	FROM 	arttemplates
	ORDER BY ArtTempID
</cfquery>

<cfif listmode>
	<cfquery name="getTemplates" datasource="#gDSN#">
		SELECT 	description
		FROM 	arttemplates
		WHERE	ArtTempID = #form.getTemplate#
	</cfquery>

	<cfquery name="getDealers" datasource="#gDSN#">
		SELECT 	dealers.dealercode,
				dealers.dealershipname,
				dealers.url
		FROM 	dealerwebs INNER JOIN dealers ON dealerwebs.dealercode = dealers.dealercode
		WHERE	dealerwebs.arttempid = #Form.getTemplate#
	</cfquery>
</cfif>

<table width="100%" border="0" cellspacing="0" cellpadding="5">
<tr>
	<td>
		<h4>Select a Template</h4>
		
		Select a template to see the list of dealerships currently using that template.  Click continue when you've selected the template.<p>
		
		<div align="center">
			<form name="getTemplate" action="admin_art.cfm" method="post">
				<select name="getTemplate">
					<cfloop query="getTemplatesFirst">
						<cfoutput><option value="#ArtTempID#"<cfif isDefined("form.getTemplate")><cfif #ArtTempID# eq #form.getTemplate#> selected</cfif></cfif>>#Description#</cfoutput>
					</cfloop>
				</select><p>
				<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/continue.gif" BORDER="0" NAME="Continue" VALUE="Continue">
			</form>
		</div>
	</td>
</tr>
</table>

<cfif listmode>

	<div align="center">
	
	<h4>Dealers using the <b><cfoutput>#getTemplates.description#</cfoutput></b> template</h4>
	
	<table border="1" cellspacing="0" cellpadding="3">
	<tr bgcolor="Black">
		<td align="CENTER"><font color="White"><b>Dealership Name</b></font></td>
		<td align="CENTER"><font color="White"><b>URL</b></font></td>
	</tr>
	<cfif getDealers.RecordCount gt 0>
		<cfloop query="getDealers">
			<cfoutput>
				<tr>
					<td>#dealershipname#</td>
					<!--- <cfif #trim(URL)# eq "">
						<td>none</td>
					<cfelse> --->
						<td>
							<!--- <a href="http://www.#URL#" target="newwindow" style="text-decoration: none; color: Red;">#URL#</a> --->
							<a href=
							<cfif #url# neq "">
								"http://<cfif #right(#geturl.URL#, 16)# eq '.worlddealer.net'>#URL#<cfelse>www.#URL#</cfif>"
							<cfelse>
								"#application.RELATIVE_PATH#/templates/dlr/index.cfm?dealercode=#DealerCode#"
							</cfif>
							target="newwindow" style="text-decoration: none; color: Red;"><cfif #trim(URL)# eq "">Preview site<cfelse>#URL#</cfif></a>
						</td>
					<!--- </cfif> --->
				</tr>
			</cfoutput>
		</cfloop>
	<cfelse>
		<tr>
			<td colspan="2" align="CENTER">
				&nbsp;<br>&nbsp;<br>&nbsp;<br>
				&nbsp;&nbsp;&nbsp;No Dealers are using that template.&nbsp;&nbsp;&nbsp;
				<br>&nbsp;<br>&nbsp;<br>&nbsp;
			</td>
		</tr>
	</cfif>
	</table>
	</div>
	<br><br>
</cfif>