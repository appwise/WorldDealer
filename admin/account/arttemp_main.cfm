                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 14, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: arttemp_main.cfm,v 1.1 2000/06/15 17:09:04 jkrauss Exp $--->
<!--- Art Template Default Settings --->

<cfquery name="getTemplates" datasource="#gDSN#">
	Select 	description, arttempid
	from 	arttemplates
</cfquery>

<table width="100%" border="0" cellspacing="0" cellpadding="5"><tr><td>
	You may edit the default settings for the Art Template using this page.  These default settings are used 
	by ImageGenerator to create logos, coupons, and banners for the dealer sites.
</td></tr></table><p>

<div align="center">
<table border="0" cellspacing="0" cellpadding="0">
<tr>
	<td align="CENTER" valign="TOP">
		<table border="0" cellspacing="0" cellpadding="2">
		<cfloop query="getTemplates">
		<cfoutput>
		<tr>
			<td>#description#</td>
			<td>&nbsp;&nbsp;</td>
			<td>[ <a href="arttemp_edit.cfm?arttempid=#arttempid#" style="font-size: small; text-decoration: none; color: ##EEAA00;"><u>edit template</u></a> ]</td>
			<td>[ <a href="arttemp_del.cfm?arttempid=#arttempid#" style="font-size: small; text-decoration: none; color: ##EEAA00;"><u>delete template</u></a> ]</td>
		</tr>
		</cfoutput>
		</cfloop>
		</table>
	</td>
</tr>
</table><p>

<table><tr><td>
<a href="arttemp_edit.cfm"><cfoutput><IMG SRC="#application.RELATIVE_PATH#/images/admin/add.gif" NAME="Add" border="0"></cfoutput></a>
</td></tr></table>
</div>

<p>&nbsp;</p>
