<cfset PageAccess = application.account_coordinator_access>
<cfinclude template = "../security.cfm">

                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <February 8, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: dealers_del.cfm,v 1.6 2000/03/03 17:54:24 jkrauss Exp $ --->

<cfif g_dlr>
	<!--- Delete selected dealer --->
	<cfinclude template="dealers_delete.cfm">

<cfelseif g_col>
	<!--- Delete selected collection of dealers --->
	
	<!--- Loop through all the Dealerships w/in the collection & delete them 1st --->
	<cfquery name="getCollDlrs" datasource="#gDSN#">
		SELECT	Dealers.dealercode
		FROM	CollectionDealers INNER JOIN Dealers ON CollectionDealers.DealerCode = Dealers.DealerCode
		WHERE 	CollectionDealers.Coll_DealerCode = '#g_dealercode#'
	</cfquery>
	
	<!--- have to use temp var to remember original collection g_dealercode, 
	cuz it gets overwritten for each dealership within collection. --->
	<cfset hold_dealercode = #g_dealercode#>
	
	<cfloop query="getCollDlrs">
		<cfset g_dealercode = #dealercode#>
		<cfset g_col = false>
		<cfset g_dlr = true>
		<cfinclude template="dealers_delete.cfm">
		<cfoutput>deleting #dealercode# now<br></cfoutput>
	</cfloop>	
	
	<!--- Delete the Collection --->
	<!--- reset to the original collection dealercode --->
	<cfset g_dealercode = #hold_dealercode#>
	<cfset g_col = true>
	<cfset g_dlr = false>
	<cfinclude template="dealers_delete.cfm">
</cfif>

<cflocation url="dealers.cfm">
