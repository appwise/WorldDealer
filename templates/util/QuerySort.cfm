<!---  Example of use

<CF_QuerySort
  QUERY="MyQuery"
  SORTCOLUMN="MyColumn"
  SORTORDER="Desc"              <- optional, defaults to Asc
  SORTTYPE="Numeric"            <- optional, defaults to Textnocase
  SORTEDQUERY="MySortedQuery">  <- optional, defaults to "Sorted"

---><CFSETTING ENABLECFOUTPUTONLY="YES">

<!--- COLD FUSION 3.1 OR HIGHER NEEDED --->
<CFIF Val(ListGetAt(Server.ColdFusion.ProductVersion, 1)) &"."& Val(ListGetAt(Server.ColdFusion.ProductVersion, 2)) less than "3.1">This tag only works in Cold Fusion 3.1 and higher.<CFABORT></CFIF>

<!--- REQUIRED PARAMETERS --->
<CFPARAM NAME="Attributes.QUERY">
<CFPARAM NAME="Attributes.SortColumn">
<!--- OPTIONAL PARAMETERS --->
<CFPARAM NAME="Attributes.SortType" DEFAULT="Textnocase">
<CFPARAM NAME="Attributes.SortOrder" DEFAULT="Asc">
<CFPARAM NAME="Attributes.SortedQuery" DEFAULT="Sorted">

<!--- ESTABLISH LOCAL VERSIONS OF QUERIES --->
<CFSET MyArray = ArrayNew(1)>
<CFSET MyQuery = Evaluate("Caller.#Attributes.Query#")>
<CFSET NewQuery = QueryNew(MyQuery.ColumnList)>
<CFIF MyQuery.RecordCount greater than 999999><CFABORT SHOWERROR="Only Queries with less than one million rows can be sorted.  Your Query has #MyQuery.RecordCount# rows."></CFIF>

<!--- ADD ROWNUMBER TO END OF EACH ROW'S VALUE --->
<CFLOOP INDEX="row" FROM="1" TO="#MyQuery.RecordCount#">
	<CFIF (CompareNoCase(attributes.sorttype, "numeric") EQ 0)>
		<CFIF IsNumeric(Evaluate("MyQuery.#Attributes.SortColumn#[row]"))>
			<CFSET MyArray[row] = Evaluate("MyQuery.#Attributes.SortColumn#[row]") & NumberFormat(row, "000009")>
		<CFELSE>
			<CFSET MyArray[row] = "0" & NumberFormat(row, "000009")>
		</CFIF>
	<CFELSE>
		<CFSET MyArray[row] = Evaluate("MyQuery.#Attributes.SortColumn#[row]") & NumberFormat(row, "000009")>
	</CFIF>
	<CFSET Temp = QueryAddRow(NewQuery)>
</CFLOOP>

<!--- SORT ARRAY --->
<CFSET Temp = ArraySort(MyArray, Attributes.SortType, Attributes.SortOrder)>

<!--- POPULATE NEW QUERY, ROW BY ROW, WITH APPROPRIATE ROW OF OLD QUERY --->
<CFLOOP FROM=1 TO=#MyQuery.RecordCount# INDEX="This">
  <CFSET Row = Val(Right(MyArray[This], 6))>
  <CFLOOP LIST="#MyQuery.ColumnList#" INDEX="Col">
    <CFSET Temp = QuerySetCell(NewQuery, Col, Evaluate("MyQuery.#Col#[Row]"), This)>
  </CFLOOP>
</CFLOOP>

<!--- PASS SORTED QUERY BACK TO CALLING TEMPLATE --->
<CFSET "Caller.#Attributes.SortedQuery#" = NewQuery>

<CFSETTING ENABLECFOUTPUTONLY="NO">