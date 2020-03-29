                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 11, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->            
                   <!---$Id: leftnav.cfm,v 1.14 2000/03/03 17:54:25 jkrauss Exp $--->
<!--- Help Leftnav --->

<cfif IsDefined("g_dealercode")>
	<cfquery name="getURL" datasource="#gDSN#">
		SELECT 	URL
		FROM 	Dealers
		WHERE 	DealerCode = '#g_dealercode#'
	</cfquery>
</cfif>

<table width="150" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/lnav_1.gif" border=0 width=9 height=10 alt=""></td>
	<td bgcolor="Black"></td>
</tr>
<cfif IsDefined("g_dealercode")>
	<!--- spacer --->
	<tr>
		<td bgcolor="#FCCA00">&nbsp;</td>
		<td bgcolor="Black">&nbsp;</td>
	</tr>
	<!--- View My Site --->
	<tr>
		<td bgcolor="#FCCA00">&nbsp;</td>
		<td bgcolor="Black">
			<a href=<cfif #geturl.URL# neq "">"http://<cfoutput><cfif #right(#geturl.URL#, 16)# eq '.worlddealer.net'>#getURL.URL#<cfelse>www.#getURL.URL#</cfif></cfoutput>"<cfelse>"<cfoutput>#application.RELATIVE_PATH#</cfoutput>/templates/dlr/index.cfm?dealercode=<cfoutput>#g_DealerCode#</cfoutput>"</cfif> target="newWindow"><img
			src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/l_viewmysite.gif" border=0 width=141 height=18 alt="View My Site"></a>
		</td>
	</tr>
</cfif>
<tr>
	<td><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/lnav_btm.gif" border=0 width=9 height=18 alt=""></td>
	<td bgcolor="Black">&nbsp;</td>
</tr>
</table>
