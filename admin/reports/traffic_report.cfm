<cfquery name="getURL" datasource="#gDSN#">
	SELECT 	URL, DealershipName
	FROM 	Dealers
	WHERE 	DealerCode = '#form.dealer#'
</cfquery>

<cfif #trim(getURL.URL)# is not "">

	<!--- trim .com or .net from the base url --->
	<cfset urlLen = #Len(Trim(getURL.URL))#>
	<cfset urlLen = urlLen - 4>
	<cfset nocomnet = #Mid(getURL.URL, 1, urlLen)#>

	<cflocation url = "http://logs.sigma6.net/worlddealer/index.cfm?dealer=#nocomnet#" addtoken="no">
<cfelse>

	<html>
	<head>
	<link rel=stylesheet href="../admin.css" type="text/css">
	</head>
	<body>
	<div align="center">
	<table cellpadding="10" bgcolor="White"><tr><td align="CENTER">&nbsp;<br>&nbsp;<br>
	<b><font size="+1"><cfoutput>#getURL.DealershipName#</cfoutput></font><br>
	currently has no URL.</b><p>
	<cfif accesslevel gt application.dealer_access>
		You may proceed to the "My Site" section<br>
	<cfelse>
		Please contact your account coordinator<br>
	</cfif>
		to reserve and set up a web address.<p>
	<a href="javascript:self.close();">Click Here to Close Window</a>&nbsp;<br>&nbsp;<br>&nbsp;
	</td></tr></table>
	</div>
	</body>
	</html>
	
</cfif>