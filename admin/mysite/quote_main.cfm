<cfset PageAccess = application.dealer_access>

                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 10, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: quote_main.cfm,v 1.20 2000/03/21 16:11:03 jkrauss Exp $--->
						  
<!--- Why We're Different --->
<cfquery name="getText" datasource="#gDSN#">
	SELECT	VehicleInqSetApartText1
	FROM	DealerWebs
	WHERE	DealerWebs.DealerCode = '#g_dealercode#'
</cfquery>
<!--- Replace <BR> with Carriage Return --->
<cfset vehicleinqsetaparttext1 = #replace(gettext.vehicleinqsetaparttext1, "<BR>", chr(13), "ALL")#>
<form name="quotewhyWAD" action="quote_save.cfm" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="5">
	<!--- Why We Are Different - Quote --->
	<tr>
		<td>
			<a name="WhyDiff"></a>
			<h4>Why We Are Different</h4>
		</td>
	</tr>		
	<tr align="center">
		<td>
			<cfoutput>
			<cfif findnocase('quote', cgi.cf_template_path)>
				Please enter a brief profile, describing what makes your Quote unique.
				<!--- linda, 1/22/00: jon's text.  sounds odd, and not entirely correct.  waiting for rewrite. 
				Your Quote page tells visitors what sets you apart from your competitors.
				The page allows visitors to submit a quote request. Quote request e-mails are
				delivered automatically to the e-mail address and fax number listed in My
				Info, as well as in your Reports section. The "Why We Are Different" text
				tells visitors how you stand out from the crowd.
				--->
			<cfelse>
				Please enter a brief profile, describing what makes your Vehicle Inquiry unique.
			</cfif>
			<br><br>
			</cfoutput>
		</td>
	</tr>		
	<tr>
		<td align="CENTER">
			<!--- insanely enough, this has to be in one long string, otherwise it puts spaces in front of the text. --->
			<textarea name="VehicleInqSetApartText1" cols="40" rows="10" wrap="PHYSICAL"><cfif gettext.recordcount><cfoutput><cfif #rtrim(vehicleinqsetaparttext1)# is not "">#VehicleInqSetApartText1#<cfelse>Please enter your text here.</cfif></cfoutput><cfelse>Please enter your text here.</cfif></textarea><br>&nbsp;
		</td>
	</tr>
</table>
	
<cfquery name="getDealerInfo" datasource="#gDSN#">
	SELECT quoteEmail, quoteEmail2, quoteFax
	FROM Dealers
	WHERE DealerCode = '#g_dealercode#'
</cfquery>
	
<form action="quote_save.cfm" method="POST">
<cfoutput><input type="hidden" name="DealerCode" value="#g_dealercode#"></cfoutput>
<table border="0" cellspacing="0" cellpadding="8" width="100%">
<tr>
	<td colspan="3">
		<a name="EmailFax"></a>
		<h4>Contact Information</h4></td>
</tr>
<tr>
	<td align="right"><cfif findnocase('quote', cgi.cf_template_path)>Quote<cfelse>Vehicle Inquiry</cfif> E-Mail 1</td>
	<td><input type="text" name="quoteEmail" maxlength=30 size=20 tabindex=1 value="<cfoutput>#Trim(getDealerInfo.quoteEmail)#</cfoutput>"></td>
</tr>
<tr>
	<td align="right"><cfif findnocase('quote', cgi.cf_template_path)>Quote<cfelse>Vehicle Inquiry</cfif> E-Mail 2</td>
	<td><input type="text" name="quoteEmail2" maxlength=50 size=20 tabindex=2 value="<cfoutput>#Trim(getDealerInfo.quoteEmail2)#</cfoutput>"></td>
</tr>		
<tr>
	<td align="right"><cfif findnocase('quote', cgi.cf_template_path)>Quote<cfelse>Vehicle Inquiry</cfif> Fax</td>
	<td>
		<!--- linda, 10/20/99: optimized redundant code, show all data they've typed in, even if it's < 10 digit number --->
		<cfoutput>
		<input type="text" name="quoteFax1" size=3 maxlength=3 <cfif #len(getdealerinfo.quotefax)# gt 0>value="#Trim(Left(getDealerInfo.quoteFax,3))#"</cfif>>
		<input type="text" name="quoteFax2" size=3 maxlength=3 <cfif #len(getdealerinfo.quotefax)# gt 3>value="#Mid(getDealerInfo.quoteFax,4,3)#"</cfif>>
		<input type="text" name="quoteFax3" size=4 maxlength=4 <cfif #len(getdealerinfo.quotefax)# gt 6>value="#Mid(getDealerInfo.quoteFax,7,4)#"</cfif>>
		<cfif (#len(Trim(getdealerinfo.quotefax))# gt 0) and (#len(getdealerinfo.quotefax)# lt 10)>
			<font color="red">Please enter a 10-digit fax number.</font>
		</cfif>
		<input type="hidden" name="quoteFax" value="#getDealerInfo.quoteFax#">
		</cfoutput>
	</td>
</tr>
<tr>
	<td colspan="3" align="center">
		<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/save.gif" BORDER="0" NAME="Save" VALUE="Save">
		</form>
		<form name="Cancel" action="quote.cfm" method="post">
		<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/cancel.gif" BORDER="0" NAME="Cancel" VALUE="Cancel">
		</form>
	</td>
</tr>
</table>
</div>
