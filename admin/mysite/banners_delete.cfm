                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 10, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: banners_delete.cfm,v 1.8 2000/03/21 16:11:01 jkrauss Exp $--->

<cfset PageAccess = application.dealer_access>
<cfinclude template = "../security.cfm">

<cfquery name="DeleteBanner" datasource="#gDSN#">
	UPDATE Banners
	SET Status = '0'
	WHERE SpecPromoID = #form.SpecPromoID#;
</cfquery>

<cflocation url="banners.cfm" addtoken="No">
