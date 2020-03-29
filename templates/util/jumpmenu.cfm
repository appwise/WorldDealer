<!---
Created by Sigma6, Inc.
Copyright (c) 1998 Sigma6, Inc.
All Rights Reserved.  Used By Permission.

Sigma6, interactive media, Detroit/NYC
conceive : construct : connect
www.sigma6.com   webmaster@sigma6.com   info@sigma6.com

Last updated: <August 8, 1998>

Tim Taylor for sigma6, interactive media, Detroit
ttaylor@sigma6.com   www.sigma6.com    www.s6313.com
conceive : construct : connect

Sigma6, s6, and the Sigma6 logos are registered trademarks.
All other trademarks and servicemarks are the property of
their respective owners.
--->

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
<CFSET isError = FALSE>
<CFPARAM NAME="attributes.maxJumps">
<CFPARAM NAME="attributes.currentPage">
<CFPARAM NAME="attributes.beginPage">
<CFPARAM NAME="attributes.endPage">
<CFPARAM NAME="attributes.location">

<CFSET maxJumps = attributes.maxJumps>
<CFSET currentPage = attributes.currentPage>
<CFSET beginPage = attributes.beginPage>
<CFSET endPage = attributes.endPage>
<CFSET location = attributes.location>

<!--- verify valid attribute values --->
<CFIF (NOT maxJumps GTE 5)
		OR (NOT currentPage GT 0)
		OR (NOT beginPage GTE 0)
		OR (NOT endPage GT 0)
		OR (NOT beginPage LTE endPage)>
	<CFSET caller.isError = TRUE>
	<CFSET caller.errorString = "error: invalid value for an attribute in jumpmenu.cfm">
	<CFEXIT>
</CFIF>

<!--- some vars used --->
<CFSET maxWidth = Len("#endPage#")>
<CFSET pageCount = endPage - beginPage>
<CFSET pagesPerJump = Ceiling(pageCount / maxJumps)>
<CFIF pagesPerJump EQ 0>
	<CFSET pagesPerJump = 1>
</CFIF>

<!--- prepare location URL for a name/value pair --->
<CFIF NOT Find("?", location) EQ 0>
	<CFSET location = location & "&">
<CFELSE>
	<CFSET location = location & "?">
</CFIF>

<!--- 
Given the jump sequence S find a value n such that S(n - 1) < pagesPerJump < S(n)
--->
<!--- XXX: this will find a value for n for the above condition in at most 3 tries --->
<CFSET n = ((Int(Log10(pagesPerJump)) + 1) * 3) + 1>
<CFMODULE TEMPLATE="jumpsequence.cfm" n="#n#">
<CFLOOP CONDITION="(s_n GTE pagesPerJump) AND (n GT 0)">
	<CFSET n = n - 1>
	<CFSET lastS_n = s_n>
	<CFMODULE TEMPLATE="jumpsequence.cfm" n="#n#">
</CFLOOP>
<CFSET pagesPerJump = lastS_n>

<!--- we need these for the recursion --->
<CFSET begin = beginPage>
<CFSET end = beginPage + pagesPerJump - 1>

<!--- loop for each jump, creating a link for all jumps except the range the current page is in --->
<CFLOOP FROM="#Evaluate(beginPage + pagesPerJump - 1)#" TO="#endPage#" INDEX="jumpToPage" STEP="#pagesPerJump#">
	<CFIF (currentPage LT jumpToPage) OR (currentPage GT (jumpToPage + pagesPerJump - 1))>
		<CFOUTPUT><A HREF="#location#FuseAction=jump&page=#jumpToPage#">#jumpToPage#</A>&nbsp;</CFOUTPUT>
	<CFELSE>
		<CFSET begin = jumpToPage + 1>
		<CFSET end = jumpToPage + pagesPerJump>
		<CFOUTPUT>#jumpToPage#&nbsp;</CFOUTPUT>
	</CFIF>
</CFLOOP>
<CFOUTPUT><BR></CFOUTPUT>

<!---
recursively call self on smaller ranges of pages unless we're already at the
smallest pages per jump (pages * 10^0), for example: 1, 2, or 5 pages at a time
--->
<CFIF Int(Log10(pagesPerJump)) GT 0>

	<!--- ensure begin and end are a valid range --->
 	<CFIF begin GT end>
		<CFSET begin = end>
	</CFIF>
	<CFIF end GT endPage>
		<CFSET end = endPage>
		<CFSET begin = endPage - pagesPerJump + 1>
		<CFIF begin LTE 0>
			<CFSET begin = 1>
		</CFIF>
	</CFIF>
	
	<!--- recurse --->
	<CFSETTING ENABLECFOUTPUTONLY="YES">
	<CFMODULE TEMPLATE="jumpmenu.cfm"
			beginPage="#begin#"
			endPage="#end#"
			currentPage="#currentPage#"
			maxJumps="#maxJumps#"
			location="#location#">
	<CFSETTING ENABLECFOUTPUTONLY="NO">
	
	<!--- propogate any errors --->
	<CFIF isError>
		<CFSET caller.isError = TRUE>
		<CFSET caller.errorString = errorString>
		<CFEXIT>
	</CFIF>
</CFIF>
