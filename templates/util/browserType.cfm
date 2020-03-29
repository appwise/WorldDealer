<CFPARAM NAME="browserVar" DEFAULT="ie"> 		<!--- by default, set so CSS works --->
<CFSET userAgentString = CGI.HTTP_USER_AGENT> <!--- convert userAgent to a more manageable varName --->

<CFIF userAgentString CONTAINS "MSIE"> 			<!--- MSIE --->
	<CFSET browserVar = "ie">
<!--- HACK to make Mozilla 5 (opensource mozilla) get an IE (more standards-compliant) stylesheet --->
<CFELSEIF userAgentString CONTAINS "Mozilla/5"> 	<!--- Mozilla - NS5 or other 5.0 browsers --->
	<CFSET browserVar = "ie">
<CFELSEIF userAgentString CONTAINS "Mozilla">		<!--- anything else that is Mozilla compliant --->
	<CFIF userAgentString CONTAINS "Win">
		<CFSET browserVar = "moz">		<!--- browser on Windows or NT --->
	<CFELSEIF (userAgentString CONTAINS "Mac") or (userAgentString CONTAINS "X11")>
		<CFSET browserVar = "mozNonWin">		<!--- browser on Mac or *nix --->
	<CFELSE>
		<CFSET browserVar = "moz">		<!--- default --->
	</CFIF>
</CFIF>
