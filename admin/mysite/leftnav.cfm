                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 11, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->            
                   <!---$Id: leftnav.cfm,v 1.51 2000/06/22 15:50:46 jkrauss Exp $--->
<!--- MySite Leftnav --->
				   
<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: leftnav.cfm,v $">

<cfif IsDefined("g_dealercode")>
	<cfquery name="getURL" datasource="#gDSN#">
		SELECT 	URL
		FROM 	Dealers
		WHERE 	DealerCode = '#g_dealercode#'
	</cfquery>
</cfif>

<!--- Overview:
Dealers:
	Showroom
	Pre-Owned
	Quote
	Financing
	Service & Parts
	Dealer Profile
	Map
	Coupons
	Calculator
	
Collections:
	Showroom
	Pre-Owned
	Vehicle Inquiry
	Financing
	Dealer Locator
	Calculator
--->

<table width="150" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/lnav_1.gif" border=0 width=9 height=10 alt=""></td>
	<td bgcolor="Black"></td>
</tr>
<!--- linda, 2/7/2000: only show the inside pages if a dealercode is already selected --->
<cfif IsDefined("g_dealercode")>
	<!--- My Info --->
	<tr>
		<td bgcolor="#FCCA00" valign=top><cfif findnocase('myinfo', cgi.cf_template_path)><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/arrow_1.gif" border=0 width=9 height=18 alt=""><cfelse>&nbsp;</cfif></td>
		<td bgcolor="Black">
			<a href="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/admin/mysite/myinfo.cfm"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/l_myinfo.gif" border=0 alt="My Info" width=141 height=18></a>
		</td>
	</tr>
	<cfif findnocase('myinfo', cgi.cf_template_path)>
		<tr>
			<td bgcolor="#FCCA00" align="top">&nbsp;</td>
			<td bgcolor="Black" valign="top" align="left">
				<font size=-1>
				<li><a href="myinfo.cfm#dealerinfo" class="leftnav">&nbsp;Dealership Info</a>
				<cfif accesslevel GT application.dealer_access>
					<li><a href="myinfo.cfm#accountinfo" class="leftnav">&nbsp;Account Information</a>
				</cfif>
				<cfif g_dlr>
					<li><a href="myinfo.cfm#franchises" class="leftnav">&nbsp;Franchises Offered</a>
				</cfif>
				<li><a href="myinfo.cfm#makelogos" class="leftnav">&nbsp;Make Logos</a>
				<li><a href="myinfo.cfm#webaddress" class="leftnav">&nbsp;Web Addresses</a>
				<li><a href="myinfo.cfm#metatags" class="leftnav">&nbsp;Meta Tags</a>
				<cfif accesslevel GT application.dealer_access>
					<li><a href="myinfo.cfm#activity" class="leftnav">&nbsp;Activity State</a>
				</cfif>
				</font>
			</td>
		</tr>
	</cfif>
	<!--- Banners --->
	<tr>
		<td bgcolor="#FCCA00" valign=top><cfif findnocase('banners', cgi.cf_template_path)><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/arrow_1.gif" border=0 width=9 height=18 alt=""><cfelse>&nbsp;</cfif></td>
		<td bgcolor="Black">
			<a href="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/admin/mysite/banners.cfm"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/l_banners.gif" border=0 alt="Banners" width=141 height=18></a>
		</td>
	</tr>
	<!--- Showroom --->
	<tr>
		<td bgcolor="#FCCA00" valign=top><cfif findnocase('showroom', cgi.cf_template_path)><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/arrow_1.gif" border=0 width=9 height=18 alt=""><cfelse>&nbsp;</cfif></td>
		<td bgcolor="Black">
			<a href="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/admin/mysite/showroom.cfm"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/l_showroom.gif" border=0 alt="Showroom" width=141 height=18></a>
		</td>
	</tr>
	<cfif findnocase('showroom', cgi.cf_template_path)>
		<tr>
			<td bgcolor="#FCCA00" align="top">&nbsp;</td>
			<td bgcolor="Black" valign="top" align="left">
				<font size=-1>
				<li><a href="showroom.cfm#WhyDiff" class="leftnav">&nbsp;Why We're Different</a>
				<cfif g_dlr>
				
					<li><a href="showroom.cfm#chrome" class="leftnav">&nbsp;Web Carbook</a>
					<li><a href="showroom.cfm#Hours" class="leftnav">&nbsp;Hours of Operation</a>
					<li><a href="showroom_incent.cfm" class="leftnav">&nbsp;IncentivesManager&#153;</a>
				</cfif>
				</font>
			</td>
		</tr>
	</cfif>
	<!--- Pre-Owned --->
	<tr>
		<td bgcolor="#FCCA00" valign=top><cfif findnocase('preown', cgi.cf_template_path)><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/arrow_1.gif" border=0 width=9 height=18 alt=""><cfelse>&nbsp;</cfif></td>
		<td bgcolor="Black">
			<a href="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/admin/mysite/preowned.cfm"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/l_preown.gif" border=0 alt="Pre-Owned" width=141 height=18></a>
		</td>
	</tr>
	<cfif findnocase('preown', cgi.cf_template_path)>
		<tr>
			<td bgcolor="#FCCA00" align="top">&nbsp;</td>
			<td bgcolor="Black" valign="top" align="left">
				<font size=-1>
				<li><a href="preowned.cfm#WhyDiff" class="leftnav">&nbsp;Why We're Different</a>
				<cfif g_dlr>
					<cfif #left(accesslevel,1)# EQ application.sysadmin_access>
					<li><a href="preowned.cfm#kbb" class="leftnav">&nbsp;Kelley Blue Book</a>
					
					<li><a href="preowned.cfm#AutoUp" class="leftnav">&nbsp;Automatic Uploads</a>
					</cfif>
					<li><a href="preowned.cfm#Hours" class="leftnav">&nbsp;Hours of Operation</a>
					<li><a href="preowned_inv.cfm" class="leftnav">&nbsp;InventoryManager&#153;</a>
				</cfif>
				</font>
			</td>
		</tr>
	</cfif>
	<cfif g_dlr>
		<!--- Quote - dealers only --->
		<tr>
			<td bgcolor="#FCCA00" valign=top><cfif findnocase('quote', cgi.cf_template_path)><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/arrow_1.gif" border=0 width=9 height=18 alt=""><cfelse>&nbsp;</cfif></td>
			<td bgcolor="Black">
				<a href="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/admin/mysite/quote.cfm"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/l_quote.gif" border=0 alt="Quote" width=141 height=18></a>
			</td>
		</tr>
		<cfif findnocase('quote', cgi.cf_template_path)>
			<tr>
				<td bgcolor="#FCCA00" align="top">&nbsp;</td>
				<td bgcolor="Black" valign="top" align="left">
					<font size=-1>
					<li><a href="quote.cfm#WhyDiff" class="leftnav">&nbsp;Why We're Different</a>
					<li><a href="quote.cfm#EmailFax" class="leftnav">&nbsp;Contact Info</a>
					</font>
				</td>
			</tr>
		</cfif>
	<cfelse>
		<!--- Vehicle Inquiry = collections only --->
		<tr>
			<td bgcolor="#FCCA00" valign=top><cfif findnocase('vehicle', cgi.cf_template_path)><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/arrow_1.gif" border=0 width=9 height=18 alt=""><cfelse>&nbsp;</cfif></td>
			<td bgcolor="Black">
				<a href="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/admin/mysite/vehicle.cfm"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/l_vinquiry.gif" border=0 alt="Vehicle Inquiry" width=141 height=18></a>
			</td>
		</tr>
		<cfif findnocase('vehicle', cgi.cf_template_path)>
			<tr>
				<td bgcolor="#FCCA00" align="top">&nbsp;</td>
				<td bgcolor="Black" valign="top" align="left">
					<font size=-1>
					<li><a href="vehicle.cfm#WhyDiff" class="leftnav">&nbsp;Why We're Different</a>
					<li><a href="vehicle.cfm#EmailFax" class="leftnav">&nbsp;Contact Info</a>
					</font>
				</td>
			</tr>
		</cfif>
	</cfif>
	<!--- Financing --->
	<tr>
		<td bgcolor="#FCCA00" valign=top><cfif findnocase('financing', cgi.cf_template_path)><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/arrow_1.gif" border=0 width=9 height=18 alt=""><cfelse>&nbsp;</cfif></td>
		<td bgcolor="Black">
			<a href="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/admin/mysite/financing.cfm"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/l_financing.gif" border=0 alt="Financing" width=141 height=18></a>
		</td>
	</tr>
	<cfif g_dlr>
		<!--- Service & Parts - dealers only --->
		<tr>
			<td bgcolor="#FCCA00" valign=top><cfif findnocase('service', cgi.cf_template_path)><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/arrow_1.gif" border=0 width=9 height=18 alt=""><cfelse>&nbsp;</cfif></td>
			<td bgcolor="Black">
				<a href="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/admin/mysite/service.cfm"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/l_service.gif" border=0 alt="Service and Parts" width=141 height=18></a>
			</td>
		</tr>
		<cfif findnocase('service', cgi.cf_template_path)>
			<tr>
				<td bgcolor="#FCCA00" align="top">&nbsp;</td>
				<td bgcolor="Black" valign="top" align="left">
					<font size=-1>
					<li><a href="service.cfm#WhyDiff" class="leftnav">&nbsp;Why We're Different</a>
					<li><a href="service.cfm#WhoWeAre" class="leftnav">&nbsp;Who We Are</a>
					<li><a href="service.cfm#SvcEmailFax" class="leftnav">&nbsp;Service Contact Info</a>
					<li><a href="service.cfm#PrtEmailFax" class="leftnav">&nbsp;Parts Contact Info</a>
					<li><a href="service.cfm#Coupons" class="leftnav">&nbsp;Service Coupons</a>
					<li><a href="service.cfm#Hours" class="leftnav">&nbsp;Hours of Operation</a>
					</font>
				</td>
			</tr>
		</cfif>
		<!--- Dealer Profile - dealers only --->
		<tr>
			<td bgcolor="#FCCA00" valign=top><cfif findnocase('profile', cgi.cf_template_path)><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/arrow_1.gif" border=0 width=9 height=18 alt=""><cfelse>&nbsp;</cfif></td>
			<td bgcolor="Black">
				<a href="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/admin/mysite/profile.cfm"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/l_dealer.gif" border=0 alt="Dealer Profile" width=141 height=18></a><br>
			</td>
		</tr>
		<cfif findnocase('profile', cgi.cf_template_path)>
			<tr>
				<td bgcolor="#FCCA00" align="top">&nbsp;</td>
				<td bgcolor="Black" valign="top" align="left">
					<font size=-1>
					<li><a href="profile.cfm#Contact" class="leftnav">&nbsp;Contact Info</a>
					<li><a href="profile.cfm#Hours" class="leftnav">&nbsp;Hours of Operation</a>
					<li><a href="profile.cfm#Who" class="leftnav">&nbsp;Who We Are</a>
					</font>
				</td>
			</tr>
		</cfif>
	<cfelse>
		<!--- Dealer Locator - collections only --->
		<tr>
			<td bgcolor="#FCCA00" valign=top><cfif findnocase('locator', cgi.cf_template_path)><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/arrow_1.gif" border=0 width=9 height=18 alt=""><cfelse>&nbsp;</cfif></td>
			<td bgcolor="Black">
				<a href="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/admin/mysite/locator.cfm"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/l_dlocator.gif" border=0 alt="Dealer Locator" width=141 height=18></a>
			</td>
		</tr>
	</cfif>
	<cfif g_dlr>
		<!--- Map - dealers only --->
		<tr>
			<td bgcolor="#FCCA00" valign=top><cfif findnocase('map', cgi.cf_template_path)><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/arrow_1.gif" border=0 width=9 height=18 alt=""><cfelse>&nbsp;</cfif></td>
			<td bgcolor="Black">
				<a href="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/admin/mysite/map.cfm"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/l_map.gif" border=0 alt="Map" width=141 height=18></a><br>
			</td>
		</tr>
		<cfif findnocase('map', cgi.cf_template_path)>
			<tr>
				<td bgcolor="#FCCA00" align="top">&nbsp;</td>
				<td bgcolor="Black" valign="top" align="left">
					<font size=-1>
					<li><a href="map.cfm#Map" class="leftnav">&nbsp;View Maps</a>
					<li><a href="map.cfm#Address" class="leftnav">&nbsp;Change Maps</a>
					</font>
				</td>
			</tr>
		</cfif>
		<!--- Coupons - dealers only --->
	
		<tr>
			<td bgcolor="#FCCA00" valign=top><cfif findnocase('coupons', cgi.cf_template_path)><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/arrow_1.gif" border=0 width=9 height=18 alt=""><cfelse>&nbsp;</cfif></td>
			<td bgcolor="Black">
				<a href="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/admin/mysite/coupons.cfm"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/l_coupons.gif" border=0 alt="Coupons" width=141 height=18></a><br>
			</td>
		</tr>
</cfif>
	<!--- Calculator --->
	<tr>
		<td bgcolor="#FCCA00" valign=top><cfif findnocase('calc', cgi.cf_template_path)><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/arrow_1.gif" border=0 width=9 height=18 alt=""><cfelse>&nbsp;</cfif></td>
		<td bgcolor="Black">
			<a href="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/admin/mysite/calc.cfm"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/l_calc.gif" border=0 alt="Calculator" width=141 height=18></a><br>
		</td>
	</tr>
	<!--- Template Design --->
	<tr>
		<td bgcolor="#FCCA00" valign=top><cfif findnocase('design', cgi.cf_template_path)><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/arrow_1.gif" border=0 width=9 height=18 alt=""><cfelse>&nbsp;</cfif></td>
		<td bgcolor="Black">
			<a href="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/admin/mysite/design.cfm"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/l_design.gif" border=0 alt="Calculator" width=141 height=18></a><br>
		</td>
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
</cfif>
<!--- only let collections or account people select another dealer --->
<cfif (accesslevel GT application.dealer_access) or (g_iamcol)>
	<!--- Select Another Dealer --->
	<tr>
		<td bgcolor="#FCCA00">&nbsp;</td>
		<td bgcolor="Black">
			<a href="select_dealer.cfm"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/l_select.gif" border=0 width=141 height=18 alt="Select Another Dealer"></a>
		</td>
	</tr>
</cfif>
<tr>
	<td><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/lnav_btm.gif" border=0 width=9 height=18 alt=""></td>
	<td bgcolor="Black">&nbsp;</td>
</tr>
</table>

<cfmodule template="/util/DumpDebug.cfm" text="end   $RCSfile: leftnav.cfm,v $">
