<cfset PageAccess = application.dealer_access>
<cfinclude template = "../security.cfm">

                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 14, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!--- $Id: hours_default.cfm,v 1.5 2000/03/03 17:54:26 jkrauss Exp $ --->
<!--- Set Default Hours of Operation: called by any of 5 sections that have hours of operation.
Sets all 5 departments' default hours, so that when user goes to the next section,
at least their default hours are there, instead of all saying "Closed". --->

<!--- M-F Hours of Operation --->
<cfloop index="counter" from="1" to="5" step="1">
	<cfquery name="initializeDealerHours" datasource="#gDSN#" dbtype="ODBC">
		INSERT INTO HoursOfOperation (
				DealerCode, 
				DayOfWeek, 
				SalesOpen, SalesClose, 
				ServiceOpen, ServiceClose, 
				PartsOpen, PartsClose, 
				UsedOpen, UsedClose, 
				BodyShopOpen, BodyShopClose)
		VALUES ('#g_dealercode#',
				#counter#, 
				'#form.openingtime#', '#form.closingtime#',
				'#form.openingtime#', '#form.closingtime#',
				'#form.openingtime#', '#form.closingtime#',
				'#form.openingtime#', '#form.closingtime#',
				'#form.openingtime#', '#form.closingtime#')
	</cfquery>
</cfloop>

<!--- Weekend Hours of Op --->
<cfloop index="counter" from="6" to="7" step="1">
	<cfquery name="initializeDealerHoursWE" datasource="#gDSN#" dbtype="ODBC">
		INSERT into HoursOfOperation (
				DealerCode, 
				DayOfWeek, 
				SalesOpen, SalesClose, 
				ServiceOpen, ServiceClose, 
				PartsOpen, PartsClose, 
				UsedOpen, UsedClose, 
				BodyShopOpen, BodyShopClose)
		VALUES ('#g_dealercode#',
				#counter#, 
				'Closed', 'Closed',
				'Closed', 'Closed',
				'Closed', 'Closed',
				'Closed', 'Closed',
				'Closed', 'Closed')
	</cfquery>
</cfloop>
