<cfset PageAccess = application.dealer_access>

                        <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 11, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->            
               <!---$Id: calc_main.cfm,v 1.12 2000/03/21 16:11:01 jkrauss Exp $--->

<cfquery name="getcalc" datasource="#gDSN#">
	SELECT calculatorYesNo
	FROM DealerWebs
	WHERE DealerCode = '#g_dealercode#'
</cfquery>

<table border="0" cellpadding="8" cellspacing="0" width="100%">
<form name="selectcalculator" action="calc_save.cfm" method="POST">
<tr align="center">
	<td>
		Would you like to include a Payment Calculator on your Website?<br><br>
		<input type="radio" value="Y" name="Calculatoryesno" <cfif #getcalc.recordcount# eq 0 or #getcalc.calculatoryesno# eq 'y'>CHECKED</cfif>>Yes
		<input type="radio" value="N" name="Calculatoryesno" <cfif #getcalc.calculatoryesno# eq 'n'>CHECKED</cfif>>No
	</td>
</tr>
<tr align="center">		
	<td>
		<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/save.gif" BORDER="0" NAME="Save" VALUE="Save">
		</form>
	</td>
</tr>
</table>
