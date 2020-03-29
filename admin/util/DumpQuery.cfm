<!---
NAME:
CF_DumpQuery

DESCRIPTION:
Cold Fusion custom tag to display the columns and contents of a
specified query in an HTML table.

ATTRIBUTES:
QUERY   - (required) query to be displayed.
BORDER  - (optional) table border value (defaults to 0).
MAXROWS - (optional) maximum number of rows to be displayed (defaults
          to all).

NOTES:
This tag displays a simple HTML table containing the columns and
data in a passed query. This tag is useful for debugging query
results.

USAGE:
To use just call <CF_DumpQuery QUERY="queryname"> passing the name
of the query to be displayed. BORDER and MAXROWS may optionally
be specified.

AUTHOR:
Ben Forta (ben@stoneage.com) 8/1/97
--->
<!--- $Id: DumpQuery.cfm,v 1.2 2000/03/22 22:11:11 lswanson Exp $ --->
<CFSETTING ENABLECFOUTPUTONLY="YES">
<CFTRY>
	<!--- name of query in caller's scope (required) --->
	<CFPARAM NAME="attributes.query">
	
	<!--- table border width --->
	<CFPARAM NAME="attributes.border" DEFAULT="0">
	
	<!--- max # rows, default to all --->
	<CFPARAM NAME="attributes.maxrows" DEFAULT="0">
	
	<!--- force output --->
	<CFPARAM NAME="attributes.force" DEFAULT="FALSE">
	
	<!--- get debug level --->
	<CFSET debug = 0>
	<CFIF IsDefined("cookie.debug")>
		<CFSET debug = cookie.debug>
	</CFIF>
	
	<!--- force verbose output? --->
	<CFIF attributes.force>
		<CFSET debug = 2>
	</CFIF>

	<CFIF debug GT 0>
		<!--- define a style sheet if not already done so --->
		<CFIF NOT isDefined("caller.debugPrinter")>
			<CFSET caller.debugPrinter = TRUE>
			<CFOUTPUT><HTML>

<HEAD><LINK REL='StyleSheet' HREF='style.css' TYPE='text/css'></CFOUTPUT>
		</CFIF>
	
		<!--- Build useable query name and columnlist variable --->
		<CFSET queryName = "CALLER." & ATTRIBUTES.query>
		<CFSET columnList = Evaluate("CALLER." & ATTRIBUTES.query & ".ColumnList")>
		
		<!--- Query was passed, check it is a valid query --->
		<CFIF IsQuery(Evaluate(queryName)) IS "No">
			<CFTHROW MESSAGE="#queryName# not a query object">
		</CFIF>
		
		<!--- How many rows are there in this query? --->
		<CFSET maxRows = Evaluate(queryName & ".RecordCount")>
		<CFIF (attributes.maxrows GT 0) AND (attributes.maxrows LT maxRows)>
			<CFSET maxRows = ATTRIBUTES.maxrows>
		</CFIF>
		
		<CFSWITCH EXPRESSION=#debug#>
		
			<CFCASE VALUE=1>
				<CFMODULE TEMPLATE="./DumpDebug.cfm" TEXT="#attributes.query# (#Evaluate(queryName & ".RecordCount")#)" FORCE=#attributes.force#>
			</CFCASE>
			
			<CFCASE VALUE=2>
				<!--- Create table --->
				<CFOUTPUT><DIV CLASS=debug>#Chr(10)#<TABLE BORDER="#attributes.border#">#Chr(10)#</CFOUTPUT>
		
				<!--- print out name of query --->
				<CFOUTPUT><TR><TH COLSPAN="#ListLen(columnList)#">#attributes.query# (#maxRows# of #Evaluate(queryName & ".RecordCount")# records)</TH></TR>#Chr(10)#</CFOUTPUT>
				
				<!--- Write columns names as headers --->
				<!--- Loop through the column list to get column names --->
				<CFSET headerText = "">
				<CFLOOP INDEX="columnName" LIST="#columnList#">
					<CFSET headerText = headerText & '<TH>' & columnName & '</TH>'>
				</CFLOOP>
				<CFOUTPUT><TR>#headerText#</TR>#Chr(10)#</CFOUTPUT>
				
				<!--- Loop through rows in query, gathering column values, then output the row text --->
				<CFLOOP INDEX="row" FROM="1" TO="#maxRows#">
					<CFSET rowText = "">
					<CFLOOP INDEX="columnName" LIST="#columnList#">
						<CFSET columnValue = Evaluate(queryName & "." & columnName & "[" & row & "]")>
		
						<!--- format the value if possible --->
						<CFIF IsNumeric(columnValue)>
							<CFSET rowText = rowText & '<TD ALIGN="RIGHT">' & columnValue & '</TD>'>
						<CFELSE>
							<CFSET rowText = rowText & '<TD>' & columnValue & '</TD>'>
						</CFIF>
					</CFLOOP>
					<CFOUTPUT><TR>#rowText#</TR>#Chr(10)#</CFOUTPUT>
				</CFLOOP>
				<CFOUTPUT></TABLE>#Chr(10)#</DIV>#Chr(10)##Chr(10)#</CFOUTPUT>
			</CFCASE>
		</CFSWITCH>
	</CFIF>
<CFCATCH TYPE="application">
	<CFMODULE TEMPLATE="./DumpDebug.cfm" TEXT="DumpQuery exception: #CFCATCH.message#" FORCE="#attributes.force#">
</CFCATCH>
<!---
<CFCATCH TYPE="any">
	<CFMODULE TEMPLATE="./DumpDebug.cfm" TEXT="DumpQuery exception: #CFCATCH.message##Chr(10)#detail: #CFCATCH.detail#" FORCE="#attributes.force#">
</CFCATCH>
--->
</CFTRY>
<CFSETTING ENABLECFOUTPUTONLY="NO">