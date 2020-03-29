<!--- Created by AppNet, Inc., Detroit
www.appnet.com
Copyright (c) 1999, 2000 AppNet, Inc. 
All other trademarks and servicemarks are the property of   
their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
Appnet, Inc. logos are registered trademarks.  
Created: <January 11, 2000>
webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: jumpmenu.cfm,v 1.4 2000/02/08 22:54:51 jkrauss Exp $--->

<!---
jumpmenu.cfm - module to do jump menu stuff
pre: maxJumps is a defined attribute and >= 5
pre: currentPage is a defined attribute and > 0
pre: beginPage is a defined attribute and > 0
pre: endPage is a defined attribute and > 0
pre: beginPage <= endPage
pre: location is defined
--->

<!--- check required attributes --->
<cfset iserror = false>
<cfparam name="attributes.maxJumps">
<cfparam name="attributes.currentPage">
<cfparam name="attributes.beginPage">
<cfparam name="attributes.endPage">
<cfparam name="attributes.location">

<cfset maxjumps = attributes.maxjumps>
<cfset currentpage = attributes.currentpage>
<cfset beginpage = attributes.beginpage>
<cfset endpage = attributes.endpage>
<cfset location = attributes.location>

<!--- verify valid attribute values --->
<cfif (not maxjumps gte 5)
		or (not currentpage gt 0)
		or (not beginpage gte 0)
		or (not endpage gt 0)
		or (not beginpage lte endpage)>
	<cfset caller.iserror = true>
	<cfset caller.errorstring = "error: invalid value for an attribute in jumpmenu.cfm">
	<cfexit>
</cfif>

<!--- some vars used --->
<cfset maxwidth = len("#endPage#")>
<cfset pagecount = endpage - beginpage>
<cfset pagesperjump = ceiling(pagecount / maxjumps)>
<cfif pagesperjump eq 0>
	<cfset pagesperjump = 1>
</cfif>

<!--- prepare location URL for a name/value pair --->
<cfif not find("?", location) eq 0>
	<cfset location = location & "&">
<cfelse>
	<cfset location = location & "?">
</cfif>

<!--- 
Given the jump sequence S find a value n such that S(n - 1) < pagesPerJump < S(n)
--->
<!--- XXX: this will find a value for n for the above condition in at most 3 tries --->
<cfset n = ((int(log10(pagesperjump)) + 1) * 3) + 1>
<cfmodule template="jumpsequence.cfm" n="#n#">
<cfloop condition="(s_n GTE pagesPerJump) AND (n GT 0)">
	<cfset n = n - 1>
	<cfset lasts_n = s_n>
	<cfmodule template="jumpsequence.cfm" n="#n#">
</cfloop>
<cfset pagesperjump = lasts_n>

<!--- we need these for the recursion --->
<cfset begin = beginpage>
<cfset end = beginpage + pagesperjump - 1>

<!--- loop for each jump, creating a link for all jumps except the range the current page is in --->
<cfloop from="#Evaluate(beginPage + pagesPerJump - 1)#" to="#endPage#" index="jumpToPage" step="#pagesPerJump#">
	<cfif (currentpage lt jumptopage) or (currentpage gt (jumptopage + pagesperjump - 1))>
		<cfoutput><a href="#location#&FuseAction=jump&page=#jumpToPage#">#jumpToPage#</a>&nbsp;</cfoutput>
	<cfelse>
		<cfset begin = jumptopage + 1>
		<cfset end = jumptopage + pagesperjump>
		<cfoutput>#jumpToPage#&nbsp;</cfoutput>
	</cfif>
</cfloop>
<cfoutput><br></cfoutput>

<!---
recursively call self on smaller ranges of pages unless we're already at the
smallest pages per jump (pages * 10^0), for example: 1, 2, or 5 pages at a time
--->
<cfif int(log10(pagesperjump)) gt 0>

	<!--- ensure begin and end are a valid range --->
 	<cfif begin gt end>
		<cfset begin = end>
	</cfif>
	<cfif end gt endpage>
		<cfset end = endpage>
		<cfset begin = endpage - pagesperjump + 1>
		<cfif begin lte 0>
			<cfset begin = 1>
		</cfif>
	</cfif>
	
	<!--- recurse --->
	<cfsetting enablecfoutputonly="YES">
	<cfmodule template="jumpmenu.cfm"
			beginpage="#begin#"
			endpage="#end#"
			currentpage="#currentPage#"
			maxjumps="#maxJumps#"
			location="#location#">
	<cfsetting enablecfoutputonly="NO">
	
	<!--- propogate any errors --->
	<cfif iserror>
		<cfset caller.iserror = true>
		<cfset caller.errorstring = errorstring>
		<cfexit>
	</cfif>
</cfif>
