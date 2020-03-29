<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: leftnav.cfm,v $">
                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 11, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->            
                   <!---$Id: leftnav.cfm,v 1.23 2000/03/03 17:54:25 jkrauss Exp $--->
<!--- Home Leftnav --->
<cfif IsDefined("g_dealercode")>
	<cfquery name="getURL" datasource="#gDSN#">
		SELECT	URL
		FROM	Dealers
		WHERE 	DealerCode = '#g_dealercode#'
	</cfquery>
</cfif>

<table width="150" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/lnav_1.gif" border=0 width=9 height=10 alt=""></td>
	<td bgcolor="Black"></td>
</tr>
<!--- Welcome Home! --->
<tr>
	<td valign="TOP" bgcolor="#FCCA00"><cfif findnocase('welcome', cgi.cf_template_path)><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/arrow_1.gif" border=0 width=9 height=18 alt=""><cfelse>&nbsp;</cfif></td>
	<td bgcolor="Black">
		<a href="welcome.cfm"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/l_welcome.gif" border=0 width=141 height=20 alt="Welcome Home!"></a>
	</td>
</tr>
<cfif #left(accesslevel,1)# GT application.dealer_access>
	<!--- Login --->
	<tr>
		<td bgcolor="FCCA00" valign=top><cfif findnocase('login', cgi.cf_template_path)><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/arrow_1.gif" border=0 width=9 height=18 alt=""><cfelse>&nbsp;</cfif></td>
		<td bgcolor="Black">
			<a href="login.cfm"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/l_login.gif" border=0 alt="Login" width=141 height=18></a>
		</td>
	</tr>
</cfif>
<!--- Upcoming Events --->
<tr>
	<td valign="TOP" bgcolor="#FCCA00"><cfif findnocase('events', cgi.cf_template_path)><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/arrow_1.gif" border=0 width=9 height=18 alt=""><cfelse>&nbsp;</cfif></td>
	<td bgcolor="Black">
		<a href="events.cfm"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/l_events.gif" border=0 alt="Upcoming Events" width=141 height=18></a>
	</td>
</tr>
<!--- New Features --->
<tr>
	<td valign="TOP" bgcolor="#FCCA00"><cfif findnocase('features', cgi.cf_template_path)><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/arrow_1.gif" border=0 width=9 height=18 alt=""><cfelse>&nbsp;</cfif></td>
	<td bgcolor="Black">
		<a href="features.cfm"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/l_features.gif" border=0 alt="New Features" width=141 height=18></a>
	</td>
</tr>
<!--- Favorites --->
<cfif IsDefined("g_dealercode")>
	<tr>
		<td valign="TOP" bgcolor="#FCCA00">&nbsp;</td>
		<td bgcolor="Black">
			<hr align="CENTER" size="1" width="90%" color="White" noshade>
			<img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/l_favorites.gif">
			<font size=-1>
			<li><a href="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/admin/mysite/showroom_incent.cfm" class="leftnav">&nbsp;IncentivesManager&#153;</a>
			<li><a href="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/admin/mysite/preowned_inv.cfm" class="leftnav">&nbsp;InventoryManager&#153;</a>
			<li><a href="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/admin/reports/leads.cfm" class="leftnav">&nbsp;Leads Reporting</a>
			</font>
		</td>
	</tr>
</cfif>
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

<cfmodule template="/util/DumpDebug.cfm" text="end   $RCSfile: leftnav.cfm,v $">
