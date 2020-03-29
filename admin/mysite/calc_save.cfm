<!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 11, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!--- $Id: calc_save.cfm,v 1.6 2000/03/03 17:54:25 jkrauss Exp $ --->
<!--- quote queries to update dealers info--->

<cfset PageAccess = application.dealer_access>
<cfinclude template = "../security.cfm">

<!--- Save calculator info --->
<cfquery name="savecalc" datasource="#gDSN#">
	UPDATE DealerWebs
	SET CalculatorYesNo ='#form.calculatorYesNo#'
		
	WHERE DealerCode = '#g_dealercode#'
</cfquery>

<cflocation url="calc.cfm" addtoken="No">