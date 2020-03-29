<CFSETTING ENABLECFOUTPUTONLY=TRUE>
<CFMODULE TEMPLATE="/util/DumpDebug.cfm" TEXT="begin $RCSfile: StockGrabber.cfm,v $">
<!---
NAME:           CF_StockGrabber
FILE:			StockGrabber.cfm
CREATED:		09/20/1997
LAST MODIFIED:	06/02/1998
VERSION:	    2.0
AUTHOR:         Rob Bilson (rbils@amkor.com)
DESCRIPTION:    This tag queries Yahoo with a list of ticker symbols.
			    The results are parsed and presented to the user as
			    variables.  These variables can be used in a wide varity
			    of ways such as sending the quotes in an e-mail,  to a
			    pager's e-mail address, in a table, inserted into a query,
			    stored in a database, or as a text file.  Error handling
				is built into the tag.	This tag makes use of CFHttp and
				requires Cold Fusion 3.01 or later to ensure reliability.
NEW THIS VER:   The following are new additions in this version:
					1.  Added support for Canadian exchanges.
					2.  Added support for indexes such as the Dow Jones
					    Industrial Index (^DJI)
					3.  Added support for mutual funds
					4.  Fixed a small bug that caused the tag to crash
					    if an invalid ticker symbol was passed
					5.  Added additional variable:  Exchange
					6.  Added more control over custom error pages
COPYRIGHT:		Copyright (C) 1997-1998 by Rob Bilson, All Rights Reserved
				This program is free software; you can redistribute it
				and/or modify it under the terms of the GNU General Public
				License as published by the Free Software Foundation;
				either version 2 of the License, or any later version.

				This program is distributed in the hope that it will be
				useful, but WITHOUT ANY WARRANTY; without even the implied
				warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
				PURPOSE.  See the GNU General Public License for more
				details.

				You should have received a copy of the GNU General Public
				License along with this program; if not, write to the Free
				Software Foundation, Inc., 59 Temple Place - Suite 330,
				Boston, MA  02111-1307, USA.
KNOWN ISSUES:   None
--->

<!---
		CHECKS TO SEE IF A LIST OF SYMBOLS WAS PASSED, AND IF SO,
		STRIPS THE COMMA DELIMITERS AND ADDS THE + SIGN INSTEAD
		SO THAT IT CAN BE PASSED TO YAHOO IN A URL.  IF NO SYMBOLS
		ARE PASSED, CF_STOCKGRABBER WILL STILL EXECUTE, USING
		YAHOO'S SYMBOL :-)
--->
<CFPARAM NAME="ATTRIBUTES.TickerSymbols">
<CFSET TickerSymbols =
	Replace(ATTRIBUTES.TickerSymbols, ",", " ", "All")>

<CFPARAM NAME="ATTRIBUTES.QueryName" DEFAULT="GetQuotes">
<CFSET QueryName = ATTRIBUTES.QueryName>

<CFPARAM NAME="ATTRIBUTES.timeout" DEFAULT="60">
<CFSET timeout = ATTRIBUTES.timeout>

<!---
		Using CFHttp, go out to Yahoo's site, query the
		server for the desired quotes, returning the results
		as a comma seperated list, parsing the list into
		variables, and returning them to the user.
--->

<!--- Get the Us/Canada quotes --->
<CFSET quoteURL = "http://quote.yahoo.com/download/quotes.csv?symbols=" &
	URLEncodedFormat(TickerSymbols) & "&format=sl1d1t1c1ohgv&ext=.csv">
<CFHTTP METHOD="GET"
	URL=#quoteURL#
	NAME="MyQuery"
	COLUMNS="Symbol,Last_Traded_Price,Last_Traded_Date,Last_Traded_Time,Change,Opening_Price,Days_High,Days_Low,Volume"
	DELIMITER=","
	TEXTQUALIFIER=""
	TIMEOUT=#timeout#>

<CFIF IsDefined("MyQuery")>
	<!--- RECREATE QUERY --->
	<CFSET MyArray = ArrayNew(1)>
	<CFSET NewQuery = QueryNew(ListAppend(#MyQuery.ColumnList#, "EXCHANGE"))>

	<!--- ADD ROWNUMBER TO END OF EACH ROW'S VALUE --->
	<CFLOOP QUERY="MyQuery">
		<CFSET MyArray[CurrentRow] = NumberFormat(CurrentRow, "000009")>
		<CFSET Temp = QueryAddRow(NewQuery)>
	</CFLOOP>

	<!--- POPULATE THE NEW QUERY WITH THE INFO FROM THE OLD ONE,
		BUT WITH ALL QUOTES REMOVED --->
	<CFLOOP FROM=1 TO=#Evaluate("MyQuery.RecordCount")# INDEX="This">
		<CFSET Row = Val(Right(MyArray[This], 6))>
		<CFLOOP LIST=#MyQuery.ColumnList# INDEX="Col">

			<CFIF RIGHT(MyQuery.Symbol[Row],3) IS ".M""">
		  		<CFSET Exch="Montreal">
		 	<CFELSEIF RIGHT(MyQuery.Symbol[Row],3) IS ".V""">
		  		<CFSET Exch="Vancouver">
			<CFELSEIF RIGHT(MyQuery.Symbol[Row],4) IS ".TO""">
				<CFSET Exch="Toronto">
			<CFELSEIF RIGHT(MyQuery.Symbol[Row],4) IS ".AL""">
				<CFSET Exch="Alberta">
			<CFELSE>
				<CFSET Exch="US">
			</CFIF>

			<CFSET Temp = QuerySetCell(NewQuery, Col,
				Replace(Evaluate("MyQuery." & Col & "[" & Row & "]"),
					"""","","All"), This)>
		</CFLOOP>
		<CFSET Temp = QuerySetCell(NewQuery, "EXCHANGE", Exch, this)>
	</CFLOOP>

	<CFMODULE TEMPLATE="/util/DumpQuery.cfm" QUERY="NewQuery">

	<!--- PASS QUERY WITH QUOTATION MARKS REMOVED BACK TO CALLING TEMPLATE --->
	<CFSET "CALLER.#QueryName#" = NewQuery>
</CFIF>

<CFMODULE TEMPLATE="/util/DumpDebug.cfm" TEXT="end   $RCSfile: StockGrabber.cfm,v $">
<CFSETTING ENABLECFOUTPUTONLY=FALSE>
