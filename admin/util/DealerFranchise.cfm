<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Convert DealerFranchise</title>
	
	<!--- get all the dealerships --->
	<cfquery name="getDlr" datasource="#gDSN#">
		SELECT	Dealercode
		FROM	Dealers
	</cfquery>
	
	<cfloop query="getDlr">
		<!--- for each dealer, find all the dealerfranchise records --->
		<cfoutput>found dealer: #dealercode#<br></cfoutput>
		<cfquery name="getDlrFranchise" datasource="#gDSN#">
			SELECT	RowID,
					DF_Number
			FROM	DealerFranchise
			WHERE	DealerFranchise.DF_Number = #Mid(dealercode, 11, 3)#
		</cfquery>
		<cfset tempDlr = #dealercode#>
		<cfif getDlrFranchise.RecordCount>
			<cfoutput>found #getDlrFranchise.RecordCount# franchises for this dealer: #tempDlr#<br></cfoutput>
			<cfloop query="getDlrFranchise">
				<cfoutput>DF_Number: #DF_Number#, dealercode: #tempDlr#<br></cfoutput>
				<cfquery name="updDlrcode" datasource="#gDSN#">
					UPDATE	DealerFranchise
					SET		Dealercode = '#tempDlr#'
					WHERE	RowID = #RowID#
				</cfquery>
			</cfloop>
		</cfif>
	</cfloop>
</head>

</html>
