                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 18, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!--- $Id: map_gen.cfm,v 1.6 2000/04/07 18:34:08 lswanson Exp $ --->
<!--- Map: update address, generate maps --->

<cfset PageAccess = application.dealer_access>
<cfinclude template = "../security.cfm">

<!--- get snapshot of address, so we can check if it changed. --->
<cfquery name="getPrevAddress" datasource="#gDSN#">
	SELECT	Addressline1,
			Addressline2,
			City,
			StateAbbr,
			Zip
	FROM	Dealers
	WHERE	Dealercode = '#g_dealercode#'
</cfquery>

<!--- update the new address.  want to do this before mapXSite call, in case map fails, at least db is correct. --->
<cfquery name="updNewAddress" datasource="#gDSN#">
	UPDATE	Dealers
	SET		AddressLine1 = '#Form.Address1#',
			AddressLine2 = '#Form.Address2#',
			City = '#Form.City#',
			StateAbbr = '#Form.StateAbbr#',
			Zip = '#Form.Zip#'
	WHERE	Dealercode = '#g_dealercode#'
</cfquery>

	<!--- Update the DrivingDirections in DealerWebs --->

			<cfquery name="UpdDrivingDirections" datasource="#gDSN#">
				UPDATE DealerWebs
				SET maptext = '#form.DrivingDirections#'
				WHERE DealerCode = '#g_dealercode#';
			</cfquery>


<!--- Try this:
		Chris Wacker 11/09/2000 9:37 AM
		Problem:  Certain Form Fields that were manditory are now optional.  This produces an undesired Session Timeout when attempting to build the map.
		Solution: Fail out of the map building process if #form.so-an-so# is NULL
		This may later be rolled into a CF tag that will set a value as TRUE or FALSE and will check for the condition and EXIT or PROCEED as required.
 --->
<!--- Chris Wacker 11/21/2000 3:00 PM  Remmed out for testing reasons --->	
<cfif (#form.address1# eq "")
	or (#form.city# eq "")
	or (#form.stateabbr# eq "")
	or (#form.zip# eq "")>
	<!--- Abort this module  Exit from the CFinclude --->
	<cfabort> <!--- changed cfexit to cfabort --->
 <cfelseif (#getprevaddress.addressline1# neq #form.address1#)
	or (#getprevaddress.addressline2# neq #form.address2#)
	or (#getprevaddress.city# neq #form.city#)
	or (#getprevaddress.stateabbr# neq #form.stateabbr#)
	or (#getprevaddress.zip# neq #form.zip#)> 
	<!--- generate maps then go back to map.cfm page --->
	<cfmodule template="genmap.cfm"
		windowtitle="WorldDealer My Site -- Create Maps"
		screentitle="Create Maps"
		nextstep="#application.RELATIVE_PATH#/admin/mysite/map.cfm">
	<cfabort>
<cfelse>
	<cflocation url="map.cfm">
</cfif>
