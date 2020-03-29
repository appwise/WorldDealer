<cfset PageAccess = application.dealer_access>

                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 10, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: financing_main.cfm,v 1.15 2000/03/21 16:11:01 jkrauss Exp $--->

<cfquery name="getDealerInfo" datasource="#gDSN#">
	SELECT FinanceEmail, FinanceEmail2, FinanceFax
	FROM Dealers
	WHERE DealerCode = '#g_dealercode#'
</cfquery>

<cfquery name="getFinText" datasource="#gDSN#">
	SELECT	financetext
	FROM	Dealerwebs
	WHERE	Dealercode = '#g_dealercode#'
</cfquery>

<table width="100%" border="0" cellspacing="0" cellpadding="5">
<tr>
	<td>
	<h4>Contact Information</h4>
	<form action="financing_main_save.cfm" method="POST">
	<div align="center">
	<table width="100%" border="0" cellspacing="0" cellpadding="8">
	<tr>
		<td align="right">Financing E-Mail 1</td>
		<td><input type="text" name="FinanceEmail" maxlength=30 size=20 tabindex=1 value="<cfoutput>#Trim(getDealerInfo.FinanceEmail)#</cfoutput>"></td>
	</tr>
	<tr>
		<td align="right">Financing E-Mail 2</td>
		<td><input type="text" name="FinanceEmail2" maxlength=50 size=20 tabindex=2 value="<cfoutput>#Trim(getDealerInfo.FinanceEmail2)#</cfoutput>"></td>
	</tr>		
	<tr>
		<td align="right">Finance Fax</td>
		<td>
		<!--- linda, 10/20/99: optimized redundant code, show all data they've typed in, even if it's < 10 digit number --->
		<cfoutput>
		<input type="text" name="FinanceFax1" size=3 maxlength=3 <cfif #len(getdealerinfo.financefax)# gt 0>value="#Trim(Left(getDealerInfo.FinanceFax,3))#"</cfif>>
		<input type="text" name="FinanceFax2" size=3 maxlength=3 <cfif #len(getdealerinfo.financefax)# gt 3>value="#Mid(getDealerInfo.FinanceFax,4,3)#"</cfif>>
		<input type="text" name="FinanceFax3" size=4 maxlength=4 <cfif #len(getdealerinfo.financefax)# gt 6>value="#Mid(getDealerInfo.FinanceFax,7,4)#"</cfif>>
		<cfif (#len(Trim(getdealerinfo.financefax))# gt 0) and (#len(getdealerinfo.financefax)# lt 10)>
			<font color="red">Please enter a 10-digit fax number.</font>
		</cfif>
		<input type="hidden" name="FinanceFax" value="#getDealerInfo.FinanceFax#">
		</cfoutput>
		</td>
	</tr>
	
	
	<tr>
	<td align="right">Place any additional finance text in this box. (E.g. 3.9% 36 month Lease on all...)</td>
	<td>
			<cfoutput> 
					<cfif #rtrim(getFinText.financetext)# is not "">
						<textarea name="wordsfinance" cols="40" rows="10" wrap="PHYSICAL">#getFinText.financetext#
					<cfelse> 
						<textarea name="wordsfinance" cols="40" rows="10" wrap="PHYSICAL">
					 </cfif> 
						</textarea>
			</cfoutput> 
	</td>
	</tr>
	
	<tr>
		<td colspan="3" align="CENTER"><input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/save.gif" BORDER="0" NAME="Save" VALUE="Save"></td>
	</tr>
	</table>
	</div>
	</td>
</tr>
</table>
</form>