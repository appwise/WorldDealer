<cfset PageAccess = application.dealer_access>
<cfinclude template = "../security.cfm">

                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 11, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!--- $Id: showroom_incent_type_chosen.cfm,v 1.4 2000/03/03 17:54:29 jkrauss Exp $ --->
<!--- Showroom: Vehicle Incentives, Redirect based on Type of Incentive (National, Regional, Custom) selected --->

<!--- Depending on which Incentive type they chose, redirect to National & Regional offers or to add Custom Incentive --->
<cfoutput>
<cfswitch expression="#form.OfferType#">
	<cfcase value="1, 5">
		<!--- National or Regional Incentive --->
		<cflocation url="showroom_incent_add_natreg.cfm?OfferType=#form.OfferType#">
	</cfcase>

	<cfcase value="2">
		<!--- Custom (Dealer) Incentive --->
		<cflocation url="showroom_incent_edit.cfm">
	</cfcase>
</cfswitch>
</cfoutput>
