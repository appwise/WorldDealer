   <!-- ----------------------------------------------------------- -->
   <!--           Created for WorldDealer by Sigma6, Inc.           -->
   <!--     Copyright (c) 1998, 1999 WorldDealer and Sigma6, Inc.   -->
   <!--         All Rights Reserved.  Used By Permission.           -->
   <!-- ----------------------------------------------------------- -->
   <!-- ----------------------------------------------------------- -->
   <!--           Sigma6, interactive media, Detroit/NYC            -->
   <!--               conceive : construct : connect                -->
   <!--   www.sigma6.com   webmaster@sigma6.com   info@sigma6.com   -->
   <!--                                                             -->
   <!--   Last updated: October 13, 1999                            -->
   <!-- ----------------------------------------------------------- -->
   <!--     Joel Krauss for sigma6, interactive media, Detroit      -->
   <!--    jkrauss@sigma6.com   www.sigma6.com    www.s6313.com     -->
   <!--               conceive : construct : connect                -->
   <!-- ----------------------------------------------------------- -->

   <!-- ----------------------------------------------------------- -->
   <!-- Sigma6, s6, and the Sigma6 logos are registered trademarks. -->
   <!-- All other trademarks and servicemarks are the property of   -->
   <!-- their respective owners.                                    -->
   <!-- ----------------------------------------------------------- -->
	<!--- $Id: webvrfy_s3_action.cfm,v 1.3 1999/11/29 15:31:01 lswanson Exp $ --->
	<!--- Set Default Hours of Operation --->


<cfset DealerCode = #Form.DealerCode#>
<cfset SalesOpen = #Form.OpeningTime#>
<cfset SalesClose = #Form.ClosingTime#>
<cfset ServiceOpen = #Form.OpeningTime#>
<cfset ServiceClose = #Form.ClosingTime#>
<cfset PartsOpen = #Form.OpeningTime#>
<cfset PartsClose = #Form.ClosingTime#>
<cfset BodyShopOpen = #Form.OpeningTime#>
<cfset BodyShopClose = #Form.ClosingTime#>
<cfset counter = 1>

<!--- M-F Hours of Operation --->
<cfloop index="counter" from="1" to="5" step="1">
	<cfquery name="initializeDealerHours" datasource="#gDSN#" dbtype="ODBC">
		INSERT into HoursOfOperation
					(DealerCode, DayOfWeek, SalesOpen, SalesClose, ServiceOpen, ServiceClose, PartsOpen, PartsClose, BodyShopOpen, BodyShopClose)
		VALUES ('#DealerCode#', #counter#, '#SalesOpen#', '#SalesClose#', '#ServiceOpen#', '#ServiceClose#', '#PartsOpen#', '#PartsClose#', '#BodyShopOpen#', '#BodyShopClose#')
	</cfquery>
</cfloop>

<!--- Weekend Hours of Op --->
<cfloop index="counter" from="6" to="7" step="1">
	<cfquery name="initializeDealerHoursWE" datasource="#gDSN#" dbtype="ODBC">
		INSERT into HoursOfOperation
					(DealerCode, DayOfWeek, SalesOpen, SalesClose, ServiceOpen, ServiceClose, PartsOpen, PartsClose, BodyShopOpen, BodyShopClose)
		VALUES ('#DealerCode#', #counter#, 'Closed', 'Closed', 'Closed', 'Closed', 'Closed', 'Closed', 'Closed', 'Closed')
	</cfquery>
</cfloop>

<cfoutput>
<cflocation url="webnew_s3.cfm?dlrcode=#DealerCode#" addtoken="No">
</cfoutput>