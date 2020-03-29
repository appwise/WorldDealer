                         <!--- Created by AppNet, Inc., Detroit
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 11, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->            
             <!---$Id: topnav.cfm,v 1.31 2000/06/15 17:11:20 jkrauss Exp $--->
<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: topnav.cfm,v $">

<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="Black">
<tr>
 	<td colspan="3" width="282" height="4">
		&nbsp;
	</td>
</tr>
<!--- Home, My Site, Reports, Help buttons --->
<tr>
	<td width="150"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/mn1_left.gif" border=0 width=150 height=19 alt=""></td>
	<td width="100%" bgcolor="#FFCC00" background="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/mn1_back.gif">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" background="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/mn1_back.gif">
		<tr>
			<td width="25%" align="CENTER"><A href="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/admin/home/index.cfm"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/tnav_home<cfif findnocase('home', cgi.cf_template_path)>_on</cfif>.gif" border=0 width=59 height=19 alt="Home"></a></td>
			<!--- linda, 2-2-2000: alt tag changed from "My Site" to "Edit My Site" per Jon & Mez --->
			<!--- linda, 2-28-2000: if account person & no dealer selected yet, take them right to the Select Another Dealer page. I was getting tired of clicking twice every time. --->
			<td width="25%" align="CENTER"><A href="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/admin/mysite/<cfif (accesslevel gt application.dealer_access) and (not IsDefined("g_dealercode"))>select_dealer.cfm<cfelse>index.cfm</cfif>"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/tnav_mysite<cfif findnocase('mysite', cgi.cf_template_path)>_on</cfif>.gif" border=0 width=65 height=19 alt="Edit My Site"></a></td>
			<td width="25%" align="CENTER"><A href="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/admin/reports/index.cfm"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/tnav_reports<cfif findnocase('reports', cgi.cf_template_path)>_on</cfif>.gif" border=0 width=61 height=19 alt="Reports"></a></td>
			<td width="25%" align="CENTER"><A href="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/admin/help/index.cfm"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/tnav_help<cfif findnocase('help', cgi.cf_template_path)>_on</cfif>.gif" border=0 width=48 height=19 alt="Help"></a></td>
		</tr>
		</table>
	</td>
	<td width="131" align="RIGHT"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/mn1_right.gif" border=0 width=131 height=19 alt=""></td>
</tr>
<!--- WorldDealer logo --->
<tr>
	<td width="150">&nbsp;</td>
	<td width="100%" align="RIGHT">
		<A href="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/admin/home/index.cfm"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/wd_logo.gif" border=0 width=182 height=53 alt="WorldDealer HomeBase"></a>
	</td>
	<td width="131">&nbsp;</td>
</tr>
<!--- Admin and 800 # --->
<tr>
	<td width="150"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/mn2_left.gif" border=0 width=150 height=19 alt=""></td>
	<td width="100%" bgcolor="#FFCC00" background="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/mn2_back.gif">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="25%" align="CENTER">
				<!--- quirky code alignment, so page aligns right --->
				<cfif accesslevel gt application.dealer_access>
					<a href="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/admin/account/dealers.cfm"><img
					src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/tnav_admin<cfif findnocase('account', cgi.cf_template_path)>_on</cfif>.gif" border=0 width=60 height=19 alt="Admin"></a><cfelse><img
				<!--- else --->
					src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/mn2_back.gif" border=0 height=19></cfif></td>
			<td width="75%" align="RIGHT"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/tnav_phone.gif" border=0 width=128 height=19 alt=""></td>

		</tr>
		</table>
	</td>
	<td width="131" align="RIGHT"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/mn2_right.gif" border=0 width=131 height=19 alt=""></td>
</tr>
<tr>
 	<td colspan="3" width="282" height="9" bgcolor="Black">
		&nbsp;
 	</td>
 </tr>
</table>
<cfmodule template="/util/DumpDebug.cfm" text="end   $RCSfile: topnav.cfm,v $">
