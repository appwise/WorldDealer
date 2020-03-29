<cfset PageAccess = application.dealer_access>

                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 14, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: index_main.cfm,v 1.12 2000/06/15 17:11:20 jkrauss Exp $ --->
<!--- My Site Intro --->

<table border="0" cellpadding="5" cellspacing="0">
<tr>
	<td>
		The My Site page links you to the sections of HomeBase 4.0 that enable you to update the information 
		on your dealer Website and create customized coupons and banners.  Use the section links at left to 
		access and manage the specific area of the site you're interested in.  You can return to this page at 
		any time by clicking the "My Site" link that always remains at the top of the screen.
		<cfif g_iamcol>
			<p>
			<div align="center">
			<!--- linda, 5/3/00: changed bgcolor from FFF5D9 to FFFFDD, so it's web safe. --->
			<table border="0" cellspacing="0" cellpadding="2" bgcolor="#FFFFDD">
			<tr>
				<td>
					<font color="Red"><b>Tip:</b></font><br>
					You can only edit one dealership at a time<br>
					per login.  You must log in separately for<br>
					each dealership you wish to edit.
				</td>
			</tr>
			</table>
			</div>
		</cfif>
	  </td>
</tr>
</table>
