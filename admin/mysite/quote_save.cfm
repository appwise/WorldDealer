                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 10, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: quote_save.cfm,v 1.8 2000/03/03 17:54:28 jkrauss Exp $--->

<cfset PageAccess = application.dealer_access>
<cfinclude template = "../security.cfm">

<cfset r_vehicleinqsetaparttext1 = #replace(form.vehicleinqsetaparttext1, chr(13), "<BR>", "ALL")#>

<cfquery name="UpdateDealer" datasource="#gDSN#">
	UPDATE DealerWebs
	SET 
		<cfif #r_vehicleinqsetaparttext1# is "Please enter your text here.">
			vehicleinqSetApartText1 = ''
		<cfelse>
			vehicleinqSetApartText1 = '#r_vehicleinqSetApartText1#'
		</cfif>
	WHERE DealerCode='#g_dealercode#'
</cfquery>


<cfset save_quotefax = #form.quotefax1# & #form.quotefax2# & #form.quotefax3#>

<cfquery name="updateDLR" datasource="#gDSN#">
	UPDATE Dealers
	SET quoteFax ='#save_quotefax#',
		quoteEmail = '#Form.quoteEmail#',
		quoteEmail2 = '#Form.quoteEmail2#'
	WHERE DealerCode = '#Form.DealerCode#'
</cfquery>

<cfif g_dlr>
	<cflocation url="quote.cfm" addtoken="No">
<cfelse>
	<cflocation url="vehicle.cfm" addtoken="No">
</cfif>
