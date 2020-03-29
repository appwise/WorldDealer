<CFSETTING ENABLECFOUTPUTONLY=TRUE>
<!---
CFMODULE to print out debugging text if debug is on

Copyright (c) 1998, 1999, 2000 AppNet Inc.  All rights reserved.

$Id: DumpDebug.cfm,v 1.10 2000/02/07 16:37:06 jsturm Exp $
--->

<!--- the text to output (required) --->
<CFPARAM NAME="ATTRIBUTES.text">

<CFPARAM NAME="ATTRIBUTES.force" DEFAULT="FALSE">

<CFPARAM NAME="ATTRIBUTES.printTrace" DEFAULT="FALSE">
<CFSET isPrintTrace = ATTRIBUTES.printTrace>

<CFSET isPrint = ATTRIBUTES.force OR IsDefined("cookie.debug")>
<CFSET tick = GetTickCount()>
<CFIF NOT IsDefined("URL.s6.util.startTick")>
	<CFSET URL.s6.util.startTick = tick>
	<CFSET URL.s6.util.lastTick = tick>
	<CFSET URL.s6.util.trace = "">
</CFIF>
<CFSET delta = tick - URL.s6.util.lastTick>
<CFSET span = tick - URL.s6.util.startTick>
<CFSET text = "[tick: #RJustify(span, 4)#ms    delta: #RJustify(delta, 4)#ms] #ATTRIBUTES.text#">
<CFSET URL.s6.util.trace = URL.s6.util.trace & text & Chr(10)>
<CFIF isPrint>
	<CFOUTPUT>
<!-- #text# --></CFOUTPUT>
	<CFIF isPrintTrace>
		<CFOUTPUT><div class="debug"><pre>#URL.s6.util.trace#</pre></div></CFOUTPUT>
		<!--- reset trace statistics --->
		<CFSET URL.s6.util.startTick = tick>
		<CFSET URL.s6.util.lastTick = tick>
		<CFSET URL.s6.util.trace = "">
	</CFIF>
</CFIF>

<CFSET URL.s6.util.lastTick = tick>

<CFSETTING ENABLECFOUTPUTONLY=FALSE>
