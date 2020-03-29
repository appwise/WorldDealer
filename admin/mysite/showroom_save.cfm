                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 10, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!--- $Id: showroom_save.cfm,v 1.12 2000/06/22 15:50:46 jkrauss Exp $ --->
<!--- Showroom queries to update dealerwebs info & insert or update Hours of Operation --->

<cfset PageAccess = application.dealer_access>
<cfinclude template = "../security.cfm">

<!--- Why We're Different --->
<cfquery name="UpdateDealer" datasource="#gDSN#">
	UPDATE DealerWebs
	SET 
		<cfif #form.offerssetaparttext# eq "Please enter your text here.">
			OffersSetApartText = ''
		<cfelse>
			OffersSetApartText = '#replace(form.offerssetaparttext, chr(13), "<BR>", "ALL")#'
		</cfif>
	WHERE DealerCode='#g_dealercode#'
</cfquery>

<!--- in showroom_main, there are 2 Save buttons.  
Save = just the Why We're Different text (no Hours of Op yet).  SaveAll = Why Diff and Hours of Op --->
<cfif parameterexists(form.saveall.x)>
	<!--- Hours of Operation --->
	<cfset hoursarray=arraynew(2)>
	
	<cfset hoursarray[1][1]=#form.x1so#>                
	<cfset hoursarray[1][2]=#form.x1sc#>                
	
	<cfset hoursarray[2][1]=#form.x2so#>                
	<cfset hoursarray[2][2]=#form.x2sc#>                
	
	<cfset hoursarray[3][1]=#form.x3so#>                
	<cfset hoursarray[3][2]=#form.x3sc#>                
	
	<cfset hoursarray[4][1]=#form.x4so#>                
	<cfset hoursarray[4][2]=#form.x4sc#>                
	
	<cfset hoursarray[5][1]=#form.x5so#>                
	<cfset hoursarray[5][2]=#form.x5sc#>                
	
	<cfset hoursarray[6][1]=#form.x6so#>                
	<cfset hoursarray[6][2]=#form.x6sc#>                
	
	<cfset hoursarray[7][1]=#form.x7so#>                
	<cfset hoursarray[7][2]=#form.x7sc#>                
	
	<cfloop index="countDays" from="1" to="7">
		<cfquery name="updHour#countDays#" datasource="#gDSN#">
			UPDATE	HoursOfOperation
			SET		SalesOpen = '#HoursArray[countDays][1]#',
					SalesClose = '#HoursArray[countDays][2]#'
			WHERE 	HoursOfOperation.DealerCode = '#g_dealercode#'
			AND 	DayOfWeek = CONVERT(int,#countDays#)
		</cfquery>
	</cfloop>

<!--- 	<cfif form.chrome eq "Y" and form.chromeCode EQ "">
		<cflocation url="showroom.cfm?needchromecode=yes" addtoken="no">
	<cfelseif form.chrome eq "N" and form.chromeCode EQ "">
		<cflocation url="showroom.cfm" addtoken="no">
	<cfelse>
		<cfquery name="getChrome" datasource="#gDSN#">
			SELECT chromeActive, chromeCode
			From DlrXRef
			Where DealerCode = '#g_dealercode#'
		</cfquery>			
		<cfif getChrome.RecordCount eq 1>
			<cfquery name="updateChrome" datasource="#gDSN#">
				UPDATE 	DlrXRef
				SET		chromeCode = '#form.chromeCode#',
						chromeActive = '#form.chrome#'
				WHERE 	DealerCode = '#g_dealercode#'
			</cfquery>
		<cfelse>
			<cfquery name="updateChrome" datasource="#gDSN#">
				INSERT INTO DlrXRef(
					dealerCode,
					chromeCode,
					chromeActive)
				VALUES (
					'#g_dealercode#',
					'#Form.chromeCode#',
					'#Form.chrome#')
			</cfquery>
		</cfif>		
	</cfif> --->
	
	</cfif>

<cflocation url="showroom.cfm" addtoken="no">

