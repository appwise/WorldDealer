<cfset PageAccess = application.dealer_access>

                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 10, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: locator_main.cfm,v 1.7 2000/03/21 16:11:02 jkrauss Exp $--->

<cfquery name="getDealerInfo" datasource="#gDSN#">
	SELECT *
	FROM Dealers
	WHERE DealerCode = '#g_dealercode#'
</cfquery>

<cfquery name="getText" datasource="#gDSN#">
	SELECT DealerProfileMainText as q_DealerProfileMainText
	FROM DealerWebs
	WHERE DealerWebs.DealerCode = '#g_dealercode#'
</cfquery>

<cfset q_mod_dlrprofiletxt = #replace(gettext.q_dealerprofilemaintext,"<BR>",Chr(13),"ALL")#>
<!--- Remove those funky tilde things --->
<cfset temp = #q_mod_dlrprofiletxt#>
<cfset start_pos = 1>
<cfloop from=1 to=3 index="count">
	<cfif #start_pos# eq 0>
		<cfbreak>
	</cfif>
	<cfset #start_pos# = #find("~~",temp,start_pos)#>
	<cfif #start_pos#>  <!--- IS NOT 0 --->
		<cfset #temp# = #removechars(temp,start_pos,4)#>
		<cfset #start_pos# = #start_pos# + 4>
	</cfif>
</cfloop>
<cfset #q_mod_dlrprofiletxt# = #temp#>
<!--- Remove those funky tilde things --->


<form action="locator_main_save.cfm" method="POST">
<table width="100%" border="0" cellspacing="0" cellpadding="5">
<tr>
	<td colspan="3"><h4>Who We Are</h4></td>
</tr>
<tr>
	<td colspan="3" align="CENTER">To update your Who We Are text, please make any changes below.</td>
</tr>
<tr>
	<td colspan="3" align="CENTER">
		<textarea name="DealerProfileMainText" cols="40" rows="20" wrap="PHYSICAL"><cfoutput query="getText">#q_mod_dlrProfileTxt# </cfoutput></textarea>
	</td>
</tr>
<tr>
	<td colspan="3" align="CENTER">
	<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/save.gif" BORDER="0" NAME="Save" VALUE="Save">
	</td>
</tr>
</table>
</form>