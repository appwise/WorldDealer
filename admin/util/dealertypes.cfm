                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <February 7, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: dealertypes.cfm,v 1.1 2000/03/16 16:09:02 lswanson Exp $--->

<!--- Utility to populate the CollectionDealers table from the Dealers table.
This allows us to do more efficient queries, instead of doing string comparisons (outside of a query) 
on the dealercode to determine whether it's part of a collection & to which collection it belongs. --->

<!doctype html public "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Populate Dealers.DealerType Field</title>
	
	<cfquery name="getDealers" datasource="#gDSN#">
		SELECT	dealercode
		FROM	dealers
		ORDER BY dealercode
	</cfquery>
	
</head>

<cfset TYPE_COLL = 1>
<cfset TYPE_COLLDLR = 2>
<cfset TYPE_INDEPDLR = 3>

<body>
	Populating Dealers.DealerType field.<br>
	<cfloop query="getDealers">
		<cfif left(#dealercode#, 4) eq '0000'>
			<cfset DealerType = TYPE_INDEPDLR>
		<cfelseif mid(#dealercode#, 6, 4) eq '0000'>
			<cfset DealerType = TYPE_COLL>
		<cfelse>
			<cfset DealerType = TYPE_COLLDLR>
		</cfif>
		
		<cfquery name="updDealerType" datasource="#gDSN#">
			UPDATE	Dealers
			SET		DealerType = #DealerType#
			WHERE	Dealercode = '#getDealers.dealercode#'
		</cfquery>

		<cfoutput>Dealercode: #dealercode#.  Type: #DealerType#</cfoutput><br>
	</cfloop>
	Done.
</body>
</html>
