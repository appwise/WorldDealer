                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <February 7, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: CollectionDealers.cfm,v 1.1 2000/03/16 16:09:02 lswanson Exp $--->

<!--- Utility to populate the CollectionDealers table from the Dealers table.
This allows us to do more efficient queries, instead of doing string comparisons (outside of a query) 
on the dealercode to determine whether it's part of a collection & to which collection it belongs. --->

<!doctype html public "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Populate CollectionDealers Table</title>
	
	<cfquery name="getDealers" datasource="#gDSN#">
		SELECT	dealercode
		FROM	dealers
		ORDER BY dealercode
	</cfquery>
	
</head>

<body>
	Populating CollectionDealers table from Dealers table.<br>
	<cfloop query="getDealers">
		<cfif mid(#dealercode#, 6, 4) eq '0000'>
			<cfset collection = #dealercode#>
		<cfelseif left(#dealercode#, 4) neq '0000'>
			<!--- make sure the collection & dealership still match up --->
			<cfif left(#collection#, 4) eq left(#dealercode#, 4)>
				<!--- check if this combo already exists --->
				<cfquery name="CollDlrExist" datasource="#gDSN#">
					SELECT	RowID
					FROM	CollectionDealers
					WHERE	Coll_DealerCode = '#collection#'
					AND		DealerCode = '#dealercode#'
				</cfquery>
				
				<cfif CollDlrExist.RecordCount eq 0>
					<cfoutput>adding Collection: #collection#.  Dealer: #dealercode#</cfoutput><br>
					<cfquery name="addCollDlr" datasource="#gDSN#">
						INSERT INTO	CollectionDealers(
								Coll_DealerCode,
								DealerCode)
						VALUES	('#collection#',
								'#dealercode#')
					</cfquery>
				<cfelse>
					<cfoutput>Already Exists: Collection: #collection#.  Dealer: #dealercode#</cfoutput><br>
				</cfif>
			<cfelse>
				<cfoutput>Strange data, missing corresponding collection for this dealer: Last Collection found: #collection#.  Dealer: #dealercode#</cfoutput><br>
			</cfif>
		</cfif>
	</cfloop>
	Done.
</body>
</html>
