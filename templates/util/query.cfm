<!---
execute query entered in form...very dangerous but no more so than other
administrative features in production

Copyright (c) 1998, 1999, 2000 Sigma6 Inc.  All rights reserved.
$Id: query.cfm,v 1.2 2000/03/17 23:17:33 lswanson Exp $

ATTRIBUTES:
FNAME - (optional) filename of calling page, defaults to query.cfm
VALID_DATASOURCE_LIST  - (required) which project's database we are querying.
--->

<!--- I am HTML! --->
<HTML>
<HEAD>
	<TITLE>Query Page</TITLE>
	
	<!--- name of file calling this query --->
	<CFPARAM NAME="ATTRIBUTES.FNAME" DEFAULT="query.cfm">
	<!--- name of project's database (required) --->
	<CFPARAM NAME="ATTRIBUTES.VALID_DATASOURCE_LIST">

	<CFPARAM NAME="s" DEFAULT="">
	<CFPARAM NAME="statement" DEFAULT="#s#">
	<CFPARAM NAME="d" DEFAULT="">
	<CFPARAM NAME="datasource" DEFAULT="#d#">
	<CFPARAM NAME="m" DEFAULT="">
	<CFPARAM NAME="maxrows" DEFAULT="#m#">
</HEAD>

<BODY>
	<!--- linda, 3/17/00: this compacts the Source, eliminating extra whitespace & CFLFs --->
	<CFSETTING ENABLECFOUTPUTONLY="NO">
	<FORM ACTION="#ATTRIBUTES.FNAME#" METHOD="GET">
		<P>
			datasource: 
			<SELECT NAME="datasource">
				<CFSETTING ENABLECFOUTPUTONLY="YES">
				<CFLOOP INDEX="option" LIST="#ATTRIBUTES.VALID_DATASOURCE_LIST#"> 
					<CFOUTPUT><OPTION<CFIF datasource EQ option> SELECTED</CFIF>>#option##Chr(10)#</OPTION></CFOUTPUT>
				</CFLOOP>
				<CFSETTING ENABLECFOUTPUTONLY="NO">
			</SELECT><BR>
			maxrows: <INPUT TYPE="TEXT" NAME="maxrows" VALUE="<CFOUTPUT>#maxrows#</CFOUTPUT>"><BR>
			query:<BR>
			<TEXTAREA WRAP="HARD" NAME="statement" ROWS="10" COLS="80"><CFOUTPUT>#statement#</CFOUTPUT></TEXTAREA>
			<INPUT TYPE="SUBMIT">
		</P>
	</FORM>
	<CFIF (Len(Trim(statement)) GT 0) 
			AND (ListFindNoCase(ATTRIBUTES.VALID_DATASOURCE_LIST, datasource) GT 0)>
		<!--- bookmark query --->
		<A HREF="<CFOUTPUT>http://#CGI.HTTP_HOST##CGI.SCRIPT_NAME#?d=#URLEncodedFormat(datasource)#&s=#URLEncodedFormat(statement)#&m=#maxrows#</CFOUTPUT>">bookmark this query</A>

		<!--- run the query --->
		<CFIF IsNumeric(maxrows)>
			<CFQUERY NAME="query" DATASOURCE="#datasource#" MAXROWS="#maxrows#">#PreserveSingleQuotes(statement)#</CFQUERY>
		<CFELSE>
			<CFQUERY NAME="query" DATASOURCE="#datasource#">#PreserveSingleQuotes(statement)#</CFQUERY>
		</CFIF>
		
		<!--- show formatted query output --->
		<CFMODULE TEMPLATE="/util/DumpQuery.cfm" QUERY="query" FORCE="TRUE">
	</CFIF>
</BODY>
</HTML>
