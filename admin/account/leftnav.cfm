<cfset PageAccess = application.account_coordinator_access>

                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 11, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->            
                   <!---$Id: leftnav.cfm,v 1.25 2000/07/05 22:35:13 lswanson Exp $--->
<!--- Account Leftnav --->
<cfif IsDefined("g_dealercode")>
	<cfquery name="getURL" datasource="#gDSN#">
		SELECT 	URL
		FROM 	Dealers
		WHERE 	DealerCode = '#g_dealercode#'
	</cfquery>
</cfif>
				   
<table width="150" border="0" cellspacing="0" cellpadding="0" bgcolor="Black">
<tr>
	<td><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/lnav_1.gif" border=0 width=9 height=10 alt=""></td>
	<td bgcolor="Black"></td>
</tr>
<tr>
	<td valign="TOP" bgcolor="#FCCA00"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/arrow_0.gif" border=0 width=9 height=18 alt=""></td>
	<td bgcolor="Black"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/l_admin_top.gif" border=0 width=141 height=20 alt="Admin"></td>
</tr>
<tr>
	<td bgcolor="FCCA00" valign=top><cfif findnocase('dealers', cgi.cf_template_path)><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/arrow_1.gif" border=0 width=9 height=18 alt=""><cfelse>&nbsp;</cfif></td>
	<td bgcolor="Black"><a href="dealers.cfm"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/l_maintain_d.gif" border=0 alt="Maintain Dealers" width=141 height=18></a><br>
</tr>
<cfif accesslevel EQ application.sysadmin_access>
	<tr>
		<td valign="TOP" bgcolor="#FCCA00"><cfif findnocase('makemodel', cgi.cf_template_path)><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/arrow_1.gif" border=0 width=9 height=18 alt=""><cfelse>&nbsp;</cfif></td>
		<td bgcolor="Black"><a href="makemodel.cfm"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/l_mm.gif" border=0 alt="Makes and Models" width=141 height=18></a></td>
	</tr>
</cfif>
<tr>

	<td valign="TOP" bgcolor="#FCCA00"><cfif findnocase('preownmodels', cgi.cf_template_path)><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/arrow_1.gif" border=0 width=9 height=18 alt=""><cfelse>&nbsp;</cfif></td>
	<td bgcolor="Black"><a href="preownmodels.cfm"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/l_preowned.gif" border=0 alt="Pre-Owned Models" width=141 height=18></a></td>
</tr>
<tr>

	<td valign="TOP" bgcolor="#FCCA00"><cfif findnocase('accstaff', cgi.cf_template_path) or findnocase('acccoord', cgi.cf_template_path) or findnocase('accexec', cgi.cf_template_path) or findnocase('dealadmin', cgi.cf_template_path)><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/arrow_1.gif" border=0 width=9 height=18 alt=""><cfelse>&nbsp;</cfif></td>
	<td bgcolor="Black"><a href="accstaff.cfm"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/l_staff.gif" border=0 alt="Account Staff" width=141 height=18></a></td>
</tr>
<tr>

	<td valign="TOP" bgcolor="#FCCA00"><cfif findnocase('incentives', cgi.cf_template_path) or findnocase('national', cgi.cf_template_path)><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/arrow_1.gif" border=0 width=9 height=18 alt=""><cfelse>&nbsp;</cfif></td>
	<td bgcolor="Black"><a href="incentives_make.cfm"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/l_incentives.gif" border=0 alt="Incentives" width=141 height=18></a></td>
</tr>
<cfif accesslevel EQ application.sysadmin_access>
	<tr>
		<td valign="TOP" bgcolor="#FCCA00"><cfif findnocase('arttemp', cgi.cf_template_path)><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/arrow_1.gif" border=0 width=9 height=18 alt=""><cfelse>&nbsp;</cfif></td>
		<td bgcolor="Black"><a href="arttemp.cfm"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/l_design.gif" border=0 alt="Design Templates" width=141 height=18></a></td>
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
