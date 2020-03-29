                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 10, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: financing_main_save.cfm,v 1.7 2000/03/03 17:54:26 jkrauss Exp $--->

<cfset PageAccess = application.dealer_access>
<cfinclude template = "../security.cfm">

<cfset save_financefax = #form.financefax1# & #form.financefax2# & #form.financefax3#>

<cfquery name="updateDLR" datasource="#gDSN#">
	UPDATE Dealers
	SET FinanceFax ='#save_financefax#',
		FinanceEmail = '#Form.FinanceEmail#',
		FinanceEmail2 = '#Form.FinanceEmail2#'
	WHERE DealerCode = '#g_dealercode#'
</cfquery>

<cfquery name="getFinText" datasource="#gDSN#">
	UPDATE	Dealerwebs
	SET		financetext = '#form.wordsfinance#'
	WHERE	Dealercode = '#g_dealercode#'
</cfquery>

<cflocation url="financing.cfm" addtoken="No">