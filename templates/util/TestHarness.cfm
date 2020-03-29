<CFHEADER NAME="expires" VALUE="NOW">
<!---
test out scrips in s6/cfml/util

Copyright (c) 1998 Sigma6 Inc.  All rights reserved.
$Id: TestHarness.cfm,v 1.4 1999/07/19 23:08:20 ttaylor Exp $
--->
<html>
<head>
<link rel="stylesheet" href="debug.css" type="text/css">
<style type="text/css">
<!--
body, td, th {
	color: #000000;
	background-color: #ffffff;
}
-->
</style>
<body>

<CFMODULE TEMPLATE="DumpDebug.cfm" TEXT="begin TestHarness.cfm">

<h1>Test Harness for <a href="http://cvs.sigma6.com/cgi-bin/cvsweb/s6/cfml/util/">s6/cfml/util</a></h1>

<h2><a href="http://cvs.sigma6.com/cgi-bin/cvsweb/s6/cfml/util/debug.cfm">debug.cfm</a></h2>

<p>The template <a href="http://cvs.sigma6.com/cgi-bin/cvsweb/s6/cfml/util/debug.cfm">debug.cfm</a> is a sample on how to set the debug cookie, <var>cookie.debug</var>.  It cycles through 3 values, that are hard coded to mean the 
following: 0 = no debug, 1 = debug, 2 = verbose debug.  You'll need to turn debug on (and to verbose in some cases) to view some of the examples below.  You can <a href="debug.cfm">follow this link</a> to cycle through debug values.</p>

<h2><a href="http://cvs.sigma6.com/cgi-bin/cvsweb/s6/cfml/util/DumpDebug.cfm">DumpDebug.cfm</a></h2>
<p>This lets you dump debug output, depending on whether 
<var>cookie.debug</var> is set or the output is being forced (by calling
DumpDebug with the <var>force</var> set to TRUE).  DumpDebug outputs as HTML comments, so you'll need to view the source to see what's actually going on.  The output looks something like this:</p>

<p><samp>[tick: 250ms delta: 16ms] simulated debug output</samp></p>

<p>Aside from the text specified, in this case <samp>simulated debug 
output</samp>, it also outputs some helpfull profiling info: <samp>tick</samp>
is the number of ticks (milliseconds) since the first call to DumpDebug and 
<samp>delta</samp> is the number of ticks since the previous call to DumpDebug.
It follows that if you place a call to DumpDebug at the beginning and the end
of your template execution, you get a rough idea how long the request took.
Strategic placement of DumpDebug allows you to hone in on areas that take the
most processing time.  This has proved extremely usefull in performance tuning
Harmony House, for instance.</p>

<h3>example 1: normal output</h3>
<p>An HTML comment should appear in the source following this text <strong>only</strong> if debug is turned on.
<CFMODULE TEMPLATE="DumpDebug.cfm" TEXT="normal debug output">
</p>

<h3>example 2: forced output</h3>
<p>An HTML comment should <strong>always</strong> appear in the source following this text.
<CFMODULE TEMPLATE="DumpDebug.cfm" TEXT="forced debug output" FORCE="TRUE"></p>

<h3>example 3: trace output</h3>
<p>Every call to DumpDebug, whether debug is on, is appened to the variable <var>caller.s6.trace</var>.  This allows you to periodically dump your trace output by calling DumpDebug with the attribute <var>printtrace</var> set to TRUE.  Usually this done at the last call to DumpDebug.  It can also be used whenever an error occured to get an idea how far things executed before getting into trouble.  Here's the trace upto this point printed.</p>

<CFMODULE TEMPLATE="DumpDebug.cfm" TEXT="print debug trace" FORCE="TRUE" PRINTTRACE="TRUE">

<p><strong>Note:</strong> the use of <var>caller.s6.trace</var> (and <var>caller.s6.starttick</var>) is a kludge and is problematic.  Namely, calling DumpDebug from within a CFMODULE treats the CFMODULE as if it were the beginning of the request.  This results in debug output from anything but the original scope to be missing in the final trace.  The <var>starttick</var> and <var>trace</var> variables should really be session variables, but it was assumed that this would have had more overhead than setting normal variables.</p>

<h2><a href="http://cvs.sigma6.com/cgi-bin/cvsweb/s6/cfml/util/DumpQuery.cfm">DumpQuery.cfm</a></h2>

<p>DumpQuery outputs information on a CF query object.  When <var>cookie.debug</var> is set to 1, DumpQuery just calls DumpDebug with the query name and the number of rows returned.  When <var>cookie.debug</var> is 2 or DumpQuery is called with <var>attributes.force</var> set to TRUE, a table is output for the query.  Formatting via CSS is available in the optional file <a href="http://cvs.sigma6.com/cgi-bin/cvsweb/s6/cfml/util/debug.css">debug.css</a>, or you can use your own style sheet. 

<CFSETTING ENABLECFOUTPUTONLY="TRUE">
<CFSET testQuery = QueryNew("column1,column2,column3")>
<CFLOOP INDEX="row" FROM="1" TO="3">
	<CFSET foo = QueryAddRow(testQuery)>
	<CFLOOP INDEX="column" FROM="1" TO="3">
		<CFMODULE TEMPLATE="DumpDebug.cfm" TEXT="setting row: #row#, column: #column#">
		<CFSET foo = QuerySetCell(testQuery, "column#column#", ((row - 1) * 3) + column, row)>
	</CFLOOP>
</CFLOOP>
<CFSETTING ENABLECFOUTPUTONLY="FALSE">

<h3>example 1: numeric columns</h3>
<p>Dump a query with columns that contain numeric (according to IsNumeric) values.  The default formatting in <a href="http://cvs.sigma6.com/cgi-bin/cvsweb/s6/cfml/util/debug.css">debug.css</a> makes text in any TD with CLASS="numeric" right aligned.  (<a href="debug.cfm">cycle debug</a> to verbose to see the tables)</p>

<CFMODULE TEMPLATE="DumpQuery.cfm" QUERY="testQuery">

<CFSETTING ENABLECFOUTPUTONLY="TRUE">
<CFLOOP INDEX="row" FROM="1" TO="3">
	<CFLOOP INDEX="column" FROM="1" TO="3">
		<CFMODULE TEMPLATE="./DumpDebug.cfm" TEXT="setting row: #row#, column: #column#">
		<CFSET foo = QuerySetCell(testQuery, "column#column#", Chr((Asc('A') - 1) + ((row - 1) * 3) + column), row)>
	</CFLOOP>
</CFLOOP>
<CFSETTING ENABLECFOUTPUTONLY="FALSE">

<h3>example 2: text columns</h3>

<p>Dump a query with columns containing text.  (<a href="debug.cfm">cycle debug</a> to verbose to see the tables)</p>

<CFMODULE TEMPLATE="DumpQuery.cfm" QUERY="testQuery">

<CFMODULE TEMPLATE="DumpDebug.cfm" TEXT="end TestHarness.cfm" PRINTTRACE="TRUE">

</body>
</html>
