<font face="Arial, Verdana" size="1">

<cfif isDefined("cookie.pr_compare")>
	<cfset cookieText = #cookie.pr_compare#>
	
	<cfif left(cookieText, 1) is ",">
		<cfset cookieText = removechars(cookieText, 1, 1)>
	</cfif>
	
	<cfif right(cookieText, 1) is ",">
		<cfset cookieText = removechars(cookieText, len(cookieText), 1)>
	</cfif>
</cfif>

<cfif parameterexists(URL.adding)>
	<cfif isDefined("cookieText") and trim(cookieText) is not "">
		<cfif not cookieText contains "#URL.id#">
			<cfset cookieText = cookieText & ",#URL.id#">
		</cfif>
	<cfelse>
		<cfset cookieText = "#URL.id#">
	</cfif>
</cfif>

<cfif parameterexists(URL.removing)>
	<cfif cookieText contains "#URL.id#">
		<cfset cookieText = #replacenocase(cookieText, "#URL.id#", "", "ALL")#>
		<cfset cookieText = #replacenocase(cookieText, ",,", ",", "ALL")#>
	</cfif>
	
	<cfif left(cookieText, 1) is ",">
		<cfset cookieText = removechars(cookieText, 1, 1)>
	</cfif>
	<cfif right(cookieText, 1) is ",">
		<cfset cookieText = removechars(cookieText, len(cookieText), 1)>
	</cfif>
</cfif>

<cfif parameterExists(cookieText)>
	CookieText = <cfoutput>#cookieText#</cfoutput><p>	
	<cfcookie name="pr_compare" value="#cookieText#" expires="100">
</cfif>

<cfif isDefined("cookie.pr_compare") AND trim(cookie.pr_compare) is not "">
	<cfloop index="item" list="#cookie.pr_compare#" delimiters=",">
		<cfoutput><a href="pr_compare.cfm?id=#item#&removing=true">#item#</a><br></cfoutput>
	</cfloop>
<cfelse>
	oops...empty cookie
</cfif>

<p>
<cfif not trim(cookie.pr_compare) is "">
	<a href="pr_compare_remove.cfm">delete cookie</a>
</cfif>

<p>
<cfif isDefined("cookie.pr_compare")>
	<cfoutput>#cookie.pr_compare#</cfoutput>
</cfif>

</font>

<script type="text/javascript" language="JavaScript">
<!--
	opener.location.href=opener.location;
	window.close();
//-->
</script>