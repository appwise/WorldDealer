<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: DumpQuery.cfm,v $">
<!--- linda, 3/17/00: this compacts the Source, eliminating extra whitespace & CRLFs --->
<CFSETTING ENABLECFOUTPUTONLY="YES">

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
FORCE - force verbose debug output

NOTES:
This tag displays a simple HTML table containing the columns and
data in a passed query. This tag is useful for debugging query
results.

USAGE:
To use just call <CF_DumpQuery QUERY="queryname"> passing the name
of the query to be displayed. BORDER and MAXROWS may optionally
be specified.

AUTHORS:
Ben Forta (ben@stoneage.com) 8/1/97
Tim Taylor (ttaylor@sigma6.com) 
--->
<!--- $Id: DumpQuery.cfm,v 1.7 2000/06/05 19:24:17 ttaylor Exp $ --->

<CFTRY>
	<!--- name of query in caller's scope (required) --->
	<CFPARAM NAME="ATTRIBUTES.query">
	
	<!--- table border width --->
	<CFPARAM NAME="attributes.border" DEFAULT="0">
	
	<!--- max # rows, default to all --->
	<CFPARAM NAME="ATTRIBUTES.maxrows" DEFAULT="0">
	
	<!--- force output --->
	<CFPARAM NAME="ATTRIBUTES.force" DEFAULT="FALSE">
	
	<!--- get debug level --->
	<!---
	XXX: encapsulate debug code into a seperate module to allow each
	project to determine their debug level
	--->
	<CFSET debug = 0>
	<CFIF IsDefined("cookie.debug")>
		<CFSET debug = cookie.debug>
	</CFIF>
	
	<!--- force verbose output? --->
	<CFIF ATTRIBUTES.force>
		<CFSET debug = 2>
	</CFIF>

	<CFIF debug GT 0>
		<!--- define a style sheet if not already done so --->
		<CFIF NOT isDefined("caller.debugPrinter")>
			<CFSET caller.debugPrinter = TRUE>
			<CFOUTPUT>
			<HTML>
			<HEAD>
				<!--- Linda, 5/17/00: The /util/ dir is locked down on production servers.
				Files in /util/ can be called using cfmodule or cfinclude, but cannot be linked to.
				<LINK REL='StyleSheet' HREF='/util/debug.css' TYPE='text/css'> --->
				<style type="text/css">
				<!--
				div.debug td, div.debug th {
					font-size: smaller;
					padding: 0em;
					margin: 0em;
				}
				
				div.debug th {
					font-weight: normal;
					color: ##ffffff;
					background-color: ##000077;
				}
				
				div.debug td {
					color: ##000000;
					background-color: ##cccccc;
				}
				
				div.debug td.numeric {
					text-align: right;
				}
				-->
				</style>
			</HEAD>
			</CFOUTPUT>
		</CFIF>

		<!--- Build useable query name and columnlist variable --->
		<CFSET queryName = "CALLER." & ATTRIBUTES.query>
		<CFSET columnList = Evaluate("CALLER." & ATTRIBUTES.query & ".ColumnList")>
		
		<!--- Query was passed, check if it is a valid query --->
		<CFIF IsQuery(Evaluate(queryName)) IS "No">
			<CFTHROW MESSAGE="#queryName# not a query object">
		</CFIF>
		
		<!--- How many rows are there in this query? --->
		<CFSET maxRows = Evaluate(queryName & ".RecordCount")>
		<CFIF (ATTRIBUTES.maxrows GT 0) AND (ATTRIBUTES.maxrows LT maxRows)>
			<CFSET maxRows = ATTRIBUTES.maxrows>
		</CFIF>
		
		<CFSWITCH EXPRESSION=#debug#>

			<!--- quiet debug output, just some query stats --->
			<CFCASE VALUE=1>
				<CFMODULE TEMPLATE="/util/DumpDebug.cfm" TEXT="#ATTRIBUTES.query# (#Evaluate(queryName & ".RecordCount")#)" FORCE=#ATTRIBUTES.force#>
			</CFCASE>

			<!--- verbose debug output, the entire query represented in a table --->
			<CFCASE VALUE=2>

				<!--- Create table --->
				<CFOUTPUT><div class="debug">#Chr(10)#<TABLE BORDER="#attributes.border#">#Chr(10)#</CFOUTPUT>
		
				<!--- print out name of query --->
				<CFOUTPUT><tr><th colspan="#ListLen(columnList)#">#ATTRIBUTES.query# (#maxRows# of #Evaluate(queryName & ".RecordCount")# records)</th></tr>#Chr(10)#</CFOUTPUT>
				
				<!--- Write columns names as headers --->
				<!--- Loop through the column list to get column names --->
				<CFSET headerText = "">
				<CFLOOP INDEX="columnName" LIST="#columnList#">
					<CFSET headerText = headerText & '<th>' & columnName & '</th>'>
				</CFLOOP>
				<CFOUTPUT><tr>#headerText#</tr>#Chr(10)#</CFOUTPUT>
				
				<!--- Loop through rows in query, gathering column values, then output the row text --->
				<CFLOOP INDEX="row" FROM="1" TO="#maxRows#">
					<CFSET rowText = "">
					<CFLOOP INDEX="columnName" LIST="#columnList#">
						<CFSET columnValue = Evaluate(queryName & "." & columnName & "[" & row & "]")>
		
						<!--- format the value if possible --->
						<CFIF IsNumeric(columnValue)>
							<CFSET rowText = rowText & '<td class="numeric">' & columnValue & '</td>'>
						<CFELSE>
							<CFSET rowText = rowText & '<td>' & columnValue & '</td>'>
						</CFIF>
					</CFLOOP>
					<CFOUTPUT><tr>#rowText#</tr>#Chr(10)#</CFOUTPUT>
				</CFLOOP>
				<CFOUTPUT></table>#Chr(10)#</div>#Chr(10)##Chr(10)#</CFOUTPUT>
			</CFCASE>
		</CFSWITCH>
	</CFIF>
<CFCATCH TYPE="application">
	<CFMODULE TEMPLATE="/util/DumpDebug.cfm" TEXT="DumpQuery exception: #CFCATCH.message#" FORCE="#ATTRIBUTES.force#">
</CFCATCH>
</CFTRY>
<CFSETTING ENABLECFOUTPUTONLY="NO">
<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: DumpQuery.cfm,v $">
