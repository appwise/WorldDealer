                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 10, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: profile_main_save.cfm,v 1.7 2000/03/03 17:54:28 jkrauss Exp $--->

<cfset PageAccess = application.dealer_access>
<cfinclude template = "../security.cfm">

<cfset r_dealerprofilemaintext = #replace(form.dealerprofilemaintext, Chr(13),"<BR>","ALL")#>
	
<cfquery name="UpdateDealer" datasource="#gDSN#">
	UPDATE DealerWebs
	SET <!--- If it's a collection, skip Quote and Service Page sections --->
		<cfif #form.dealerprofilemaintext# is "Please enter your text here.">
			DealerProfileMainText = ''
		<cfelse>
			DealerProfileMainText = '#rtrim(r_DealerProfileMainText)#'
		</cfif>
	WHERE DealerCode='#g_dealercode#'
</cfquery>

<cflocation url="profile.cfm" addtoken="no">