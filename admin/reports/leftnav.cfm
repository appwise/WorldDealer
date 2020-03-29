                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 11, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->            
                   <!---$Id: leftnav.cfm,v 1.24 2000/04/07 19:03:07 lswanson Exp $--->
<!--- Reports Leftnav --->

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
<!--- Traffic Reporting --->
<tr>
	<td bgcolor="FCCA00" valign=top><cfif findnocase('traffic', cgi.cf_template_path)><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/arrow_1.gif" border=0 width=9 height=18 alt=""><cfelse>&nbsp;</cfif></td>
	<td bgcolor="Black">
		<a href="traffic.cfm"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/l_r_traffic.gif" border=0 alt="Traffic Reporting" width=141 height=18></a>
	</td>
</tr>
<!--- Leads Reporting --->
<tr>
	<td valign="TOP" bgcolor="#FCCA00"><cfif findnocase('leads', cgi.cf_template_path)><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/arrow_1.gif" border=0 width=9 height=18 alt=""><cfelse>&nbsp;</cfif></td>
	<td bgcolor="Black">
		<a href="leads.cfm"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/l_r_leads.gif" border=0 alt="Leads Reporting" width=141 height=18></a>
	</td>
</tr>
<cfif #left(accesslevel,1)# EQ application.sysadmin_access>
	<tr>
		<td bgcolor="#FCCA00">&nbsp;</td>
		<td bgcolor="Black">&nbsp;</td>
	</tr>
	<tr>
		<td bgcolor="#FCCA00" align="top">&nbsp;</td>
		<td bgcolor="Black" valign="top" align="left">
			<font size="-1" color="White">&nbsp;<b>Admin Reports</b></font>
			<font size=-1>
			<!---<li><a href="admin.cfm" class="leftnav">&nbsp;Makes</a>
			<li><a href="admin.cfm" class="leftnav">&nbsp;Models</a>
			<li><a href="admin.cfm" class="leftnav">&nbsp;Specific Model</a>
			<li><a href="admin_preowned.cfm" class="leftnav">Incentives Regions</a> --->
			<li><a href="admin_list.cfm" class="leftnav">Dealers<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(complete list)</a>
			<li><a href="admin_art.cfm" class="leftnav">Dealers<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(by art template)</a>
			<li><a href="admin_auto.cfm" class="leftnav">Dealers<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(w/ auto upload)</a>
			<li><a href="admin_preowned.cfm" class="leftnav">Pre-Owned Inventory</a>
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