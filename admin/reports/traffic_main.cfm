<cfset WebTrendsMode = "false">
<cfoutput>
<cfif ParameterExists(g_dealercode)>
	<cfif #getURL.URL# is not "">
		<!--- trim .com or .net from the base url --->
		<cfset urlLen = #Len(Trim(getURL.URL))#>
		<cfset urlLen = urlLen - 4>
		<cfset nocomnet = #Mid(getURL.URL, 1, urlLen)#>
	</cfif>
</cfif>

<cfset mode="webTrends">


<table border="0" cellpadding="5" cellspacing="0">
<tr>
	<td> 
		<b>Traffic Report</b>
		<br><br>
		View an up-to-date report that tells you everything you need to know about your Website. 
		Get an overview, or get as many detailed statistics as you want! Comprehensive graphs 
		tell you how many people visit your site, which sections they like, how long they stay,
		and where they live. We'll help you put that information to work to get the results you
		want from your Website.<p>
		
		<cfif #getUserInfo.PermissionLevel# GT 0>
			From the menus below, please select a dealership to view its WebTrends report.<p>
			<cfinclude template="#application.RELATIVE_PATH#/admin/mysite/dealer_select.cfm">
		<cfelseif g_col>
			From the menus below, please select a dealership to view its WebTrends report.<p>
			<cfinclude template="#application.RELATIVE_PATH#/admin/mysite/dealer_select.cfm">
		<cfelse>
			<div align="center">
			<cfif #trim(getURL.URL)# is not "">
				<a href="http://logs.sigma6.net/worlddealer/index.cfm?dealer=#nocomnet#" target="_blank" onmouseover="status='View the WebTrends Report for #getURL.URL#'; return true"  onmouseout="status=''; return true">Click here to view your Traffic Report</a>
			<cfelse>
				<b>You currently have no URL.</b><p>
				Please contact your account coordinator to reserve and set up a web address.
			</cfif>
			</div><br><br>
		</cfif>
	</td>
</tr>
</table>
</cfoutput>