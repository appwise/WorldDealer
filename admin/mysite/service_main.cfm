<cfset PageAccess = application.dealer_access>

                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 10, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: service_main.cfm,v 1.33 2000/03/21 16:11:03 jkrauss Exp $--->

<cfquery name="getDealerInfo" datasource="#gDSN#">
	SELECT *
	FROM Dealers
	WHERE DealerCode = '#g_dealercode#'
</cfquery>

<cfquery name="getText" datasource="#gDSN#">
	SELECT ServiceInqSetApartText2, ServiceMainText
	FROM DealerWebs
	WHERE DealerWebs.DealerCode = '#g_dealercode#'
</cfquery>

<cfif g_dlr>
	<cfset q_serviceinqsetaparttext = #replace(gettext.serviceinqsetaparttext2,"<BR>",Chr(13),"ALL")#>
	<cfset q_servicemaintext = #replace(gettext.servicemaintext,"<BR>",Chr(13),"ALL")#>	
	<!--- Remove those funky tilde things --->
	<cfset temp = #q_servicemaintext#>
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
	<cfset #q_servicemaintext# = #temp#>
	<!--- Remove those funky tilde things --->	
</cfif>

<cfquery name="getCoupons" datasource="#gDSN#">
	SELECT	VirtualCouponID,
			Description,
			ExpirationDate,
			CouponTypeID
	FROM	VirtualCoupons INNER JOIN DealerWebs ON VirtualCoupons.DealerWebID = DealerWebs.DealerWebID
 	WHERE	dealercode = '#g_dealercode#'
	AND		CouponTypeID = 2
	AND		Status='A'
</cfquery>

<CFQUERY name="getDlrArtTemp" datasource="#gDSN#">
	SELECT 	ArtTempID 
	FROM 	DealerWebs
	WHERE 	DealerCode = '#g_dealercode#'
</CFQUERY>

<!--- <cfquery name="getCoupons" datasource="#gDSN#">
	SELECT Description, CouponTypeID
	FROM VirtualCoupons
	WHERE Status='A' AND CouponTypeID=2 AND DealerWebID IN (SELECT DealerWebID FROM DealerWebs WHERE DealerCode = '#g_dealercode#');
</cfquery> --->

<!--- Hours of Operation --->
<cfquery name="getDlrHours" datasource="#gDSN#">
	SELECT HourID as q_HourID,
			DayOfWeek as q_DayOfWeek,
			ServiceOpen as q_ServiceOpen,
			ServiceClose as q_ServiceClose,
			PartsOpen as q_PartsOpen,
			PartsClose as q_PartsClose,
			BodyShopOpen as q_BodyShopOpen,
			BodyShopClose as q_BodyShopClose
	FROM HoursOfOperation
	WHERE HoursOfOperation.DealerCode = '#g_dealercode#'
	ORDER BY DayOfWeek ASC
</cfquery>

<cfquery name="checkbodyshop" datasource="#gDSN#">
	SELECT	BodyShopYesNo
	FROM	dealerwebs
	WHERE	DealerCode = '#g_dealercode#';
</cfquery>

<cfif #getdlrhours.recordcount#>
	<cfset dayoftheweek = arraynew(1)>
	<cfset openhoursarray = arraynew(1)>
	<cfset closehoursarray = arraynew(1)>
	<cfset dlrhours = arraynew(2)>
	    
	<cfset dayoftheweek[1] = 'Mon'>
	<cfset dayoftheweek[2] = 'Tue'>
	<cfset dayoftheweek[3] = 'Wed'>
	<cfset dayoftheweek[4] = 'Thu'>
	<cfset dayoftheweek[5] = 'Fri'>
	<cfset dayoftheweek[6] = 'Sat'>
	<cfset dayoftheweek[7] = 'Sun'>
	    
	<cfset openhoursarray[1] = 'Closed'>
	<cfset openhoursarray[2] = '06:00 AM'>
	<cfset openhoursarray[3] = '06:30 AM'>
	<cfset openhoursarray[4] = '07:00 AM'>
	<cfset openhoursarray[5] = '07:30 AM'>
	<cfset openhoursarray[6] = '08:00 AM'>
	<cfset openhoursarray[7] = '08:30 AM'>
	<cfset openhoursarray[8] = '09:00 AM'>
	<cfset openhoursarray[9] = '09:30 AM'>
	<cfset openhoursarray[10] = '10:00 AM'>
	<cfset openhoursarray[11] = '10:30 AM'>
	<cfset openhoursarray[12] = '11:00 AM'>
	<cfset openhoursarray[13] = '11:30 AM'>
	<cfset openhoursarray[14] = '12:00 PM'>
	<cfset openhoursarray[15] = '12:30 PM'>
	<cfset openhoursarray[16] = '01:00 PM'>
	
	<cfset closehoursarray[1] = 'Closed'>
	<cfset closehoursarray[2] = '11:00 AM'>
	<cfset closehoursarray[3] = '11:30 AM'>
	<cfset closehoursarray[4] = '12:00 PM'>
	<cfset closehoursarray[5] = '12:30 PM'>
	<cfset closehoursarray[6] = '01:00 PM'>
	<cfset closehoursarray[7] = '01:30 PM'>
	<cfset closehoursarray[8] = '02:00 PM'>
	<cfset closehoursarray[9] = '02:30 PM'>
	<cfset closehoursarray[10] = '03:00 PM'>
	<cfset closehoursarray[11] = '03:30 PM'>
	<cfset closehoursarray[12] = '04:00 PM'>
	<cfset closehoursarray[13] = '04:30 PM'>
	<cfset closehoursarray[14] = '05:00 PM'>
	<cfset closehoursarray[15] = '05:30 PM'>
	<cfset closehoursarray[16] = '06:00 PM'>
	<cfset closehoursarray[17] = '06:30 PM'>
	<cfset closehoursarray[18] = '07:00 PM'>
	<cfset closehoursarray[19] = '07:30 PM'>
	<cfset closehoursarray[20] = '08:00 PM'>
	<cfset closehoursarray[21] = '08:30 PM'>
	<cfset closehoursarray[22] = '09:00 PM'>
	<cfset closehoursarray[23] = '09:30 PM'>
	<cfset closehoursarray[24] = '10:00 PM'>
	<cfset closehoursarray[25] = '10:30 PM'>
	<cfset closehoursarray[26] = '11:00 PM'>
	<cfset closehoursarray[27] = '11:30 PM'>
	<cfset closehoursarray[28] = '12:00 AM'>

	<cfloop query="getDLRHours">
		<cfset dlrhours[currentrow][1] = #getdlrhours.q_serviceopen#>     
		<cfset dlrhours[currentrow][2] = #getdlrhours.q_serviceclose#>   
		<cfset dlrhours[currentrow][3] = #getdlrhours.q_partsopen#>     
		<cfset dlrhours[currentrow][4] = #getdlrhours.q_partsclose#>   
		<cfset dlrhours[currentrow][5] = #getdlrhours.q_bodyshopopen#>     
		<cfset dlrhours[currentrow][6] = #getdlrhours.q_bodyshopclose#>    
	</cfloop>
</cfif>

</head>

<body>

<form action="service_main_save.cfm" method="POST">
<table border="0" cellspacing="0" cellpadding="5" width="100%">
<tr>
	<td colspan="3">
		<a name="WhyDiff"></a>
		<h4>Why We Are Different</h4>
	</td>
</tr>
<tr>
	<td colspan="3">Your Service and Parts page describes your Service, Parts and Body Shop departments. It tells visitors about service specials
and allows them to request service appointments and parts requests online. Service and parts request e-mails are delivered
automatically to the e-mail address and fax number listed in My Info, as well as in your Reports section. The "Why We Are
Different" text tells visitors how you stand out from the crowd. Below, describe how your Service and Parts department stands
out. Here are a few examples:

	<ul><li>Highest CSI in the Tri-County Area 
	<li>Free loaner vehicles 
	<li>55 Service Bays 
	<li>Free carwash with any service 
	<li>20 Minute Oil Change</ul>
	</td>
</tr>
<tr>
	<td colspan="3">&nbsp;</td>
</tr>
<tr>
	<td colspan="3"><div align="center"><textarea name="ServiceInqSetApartText" cols="40" rows="10" wrap="PHYSICAL"><cfif gettext.recordcount neq 0><cfoutput query="getText"><cfif #ltrim(#serviceinqsetaparttext2#)# is not "">#ltrim(q_ServiceInqSetApartText)#<cfelse>Please enter your text here.</cfif></cfoutput><cfelse>Please enter your text here.</cfif></textarea></div></td>
</tr>
<tr>
	<td colspan="3">&nbsp;</td>
</tr>
<tr>
	<td colspan="3">
		<a name="WhoWeAre"></a>
		<h4>Who We Are</h4>
	</td>
</tr>
<tr>
	<td colspan="3">
		Your Who We Are text tells customers about your service department -- its history, its employees; anything you'd like customers
		to know about your service department. To update your Who We Are text, please make your changes below.
	</td>
</tr>
<tr>
	<td colspan="3">&nbsp;</td>
</tr>
<tr>
	<td colspan="3"><div align="center"><textarea name="ServiceMainText" cols="40" rows="20" wrap="PHYSICAL"><cfif gettext.recordcount neq 0><cfoutput query="getText"><cfif #ltrim(#servicemaintext#)# is not "">#ltrim(q_ServiceMainText)#<cfelse>Please enter your text here.</cfif></cfoutput><cfelse>Please enter your text here.</cfif></textarea></div></td>
</tr>
<tr>
	<td colspan="3">&nbsp;</td>
</tr>
<tr>
	<td colspan="3">
		<a name="SvcEmailFax"></a>
		<h4>Service Contact Information</h4>
	</td>
</tr>
<tr>
	<td align="right">Service E-mail 1</td>
	<td>&nbsp;&nbsp;&nbsp;</td>
	<td>
		<cfoutput>
		<input type="text" name="ServiceEmail" maxlength=30 size=20 tabindex=1 <cfif gettext.recordcount neq 0>VALUE="#Trim(getDealerInfo.ServiceEmail)#"</cfif>>
		</cfoutput>
	</td>
</tr>
<tr>
	<td align="right">Service E-mail 2</td>
	<td>&nbsp;&nbsp;&nbsp;</td>
	<td>
		<cfoutput>
		<!--- linda, 10/14/99: changed Email to EmailTooShortNotUsed.  Added new Email of length 50 --->
		<input type="text" name="ServiceEmail2" maxlength=50 size=20 tabindex=2 <cfif gettext.recordcount neq 0>VALUE="#Trim(getDealerInfo.ServiceEmail2)#"</cfif>>
		</cfoutput>
	</td>
</tr>
<tr>
	<td align="right">Service Fax</td>
	<td>&nbsp;&nbsp;&nbsp;</td>
	<td>
		<!--- linda, 10/20/99: optimized redundant code, show all data they've typed in, even if it's < 10 digit number --->					
		<cfoutput>
		<input type="text" name="ServiceFax1" size=3 maxlength=3 <cfif gettext.recordcount neq 0><cfif #len(getdealerinfo.servicefax)# gt 0>value="#Trim(Left(getDealerInfo.ServiceFax,3))#"</cfif></cfif>>
		<input type="text" name="ServiceFax2" size=3 maxlength=3 <cfif gettext.recordcount neq 0><cfif #len(getdealerinfo.servicefax)# gt 3>value="#Mid(getDealerInfo.ServiceFax,4,3)#"</cfif></cfif>>
		<input type="text" name="ServiceFax3" size=4 maxlength=4 <cfif gettext.recordcount neq 0><cfif #len(getdealerinfo.servicefax)# gt 6>value="#Mid(getDealerInfo.ServiceFax,7,4)#"</cfif></cfif>>
		<cfif gettext.recordcount neq 0>
			<cfif (#len(Trim(getdealerinfo.servicefax))# gt 0) and (#len(getdealerinfo.servicefax)# lt 10)>
				<font color="red">Please enter a 10-digit fax number.</font>
			</cfif>
		</cfif>
		<cfif gettext.recordcount neq 0><input type="hidden" name="ServiceFax" value="#getDealerInfo.ServiceFax#"></cfif>
		</cfoutput>
	</td>
</tr>
<tr>
	<td colspan="3">&nbsp;</td>
</tr>
<tr>
	<td colspan="3">
		<a name="PrtEmailFax"></a>
		<h4>Parts Contact Information</h4>
	</td>
</tr>
<tr>
	<td align="right">
		Parts E-Mail 1
	</td>
	<td>&nbsp;&nbsp;&nbsp;</td>
	<td>
		<cfoutput>
		<input type="text" name="PartsEmail" maxlength=30 size=20 tabindex=1 <cfif gettext.recordcount neq 0>VALUE="#Trim(getDealerInfo.PartsEmail)#"</cfif>>
		</cfoutput>
	</td>
</tr>
<tr>
	
	<td align="right">
		Parts E-Mail 2
	</td>
	<td>&nbsp;&nbsp;&nbsp;</td>
	<td>
		<cfoutput>
		<!--- linda, 10/14/99: changed Email to EmailTooShortNotUsed.  Added new Email of length 50 --->
		<input type="text" name="PartsEmail2" maxlength=50 size=20 tabindex=2 <cfif gettext.recordcount neq 0>VALUE="#Trim(getDealerInfo.PartsEmail2)#"</cfif>>
		</cfoutput>
	</td>
</tr>
	<tr>
	<td align="right">Parts Fax</td>
	<td>&nbsp;&nbsp;&nbsp;</td>
	<td>
		<!--- linda, 10/20/99: optimized redundant code, show all data they've typed in, even if it's < 10 digit number --->					
		<cfoutput>
		<input type="text" name="PartsFax1" size=3 maxlength=3 <cfif gettext.recordcount neq 0><cfif #len(getdealerinfo.partsfax)# gt 0>value="#Trim(Left(getDealerInfo.PartsFax,3))#"</cfif></cfif>>
		<input type="text" name="PartsFax2" size=3 maxlength=3 <cfif gettext.recordcount neq 0><cfif #len(getdealerinfo.partsfax)# gt 3>value="#Mid(getDealerInfo.PartsFax,4,3)#"</cfif></cfif>>
		<input type="text" name="PartsFax3" size=4 maxlength=4 <cfif gettext.recordcount neq 0><cfif #len(getdealerinfo.partsfax)# gt 6>value="#Mid(getDealerInfo.PartsFax,7,4)#"</cfif></cfif>>
		<cfif gettext.recordcount neq 0>
			<cfif (#len(Trim(getdealerinfo.partsfax))# gt 0) and (#len(getdealerinfo.partsfax)# lt 10)>
				<font color="red">Please enter a 10-digit fax number.</font>
			</cfif>
		</cfif>
		<cfif gettext.recordcount neq 0><input type="hidden" name="PartsFax" value="#getDealerInfo.PartsFax#"></cfif>
		</cfoutput>
	</td>
</tr>
<tr>
	<td colspan="3">&nbsp;</td>
</tr>
<tr>
	<td colspan="3">
		<a name="Coupons"></a>
		<h4>Service Coupons</h4>
	</td>
</tr>
<cfif #getcoupons.recordcount#>
	<tr align="center">
		<td colspan="3">The following Coupons are currently associated with this Dealership.<br><b><a href="coupons.cfm">Click Here</a></b> to make changes.</td>
	</tr>
	<tr>
		<td colspan="3">&nbsp;<p></td>
	</tr>
	<tr>
		<td colspan="3" align="center">
		<table>
			<cfloop query="getCoupons">
			<tr>
				<TD>
					<cfoutput>
					<IMG SRC="#application.RELATIVE_PATH#/images/coupons/#Trim(g_dealerCode)#_#getDlrArtTemp.ArtTempID#_#VirtualCouponID#_coupon.gif">
					</cfoutput>
				</TD>
			</tr>
			</cfloop>
		</table>
		</td>
	</tr>
<cfelse>
	<tr>
		<td colspan="3" align="CENTER">There are currently NO Service Coupons associated with this Dealership.</td>
	</tr>
</cfif>
<cfif #getdlrhours.recordcount# eq 0>
	<tr>
		<td colspan="3" align="center">
			<br>
			<!--- This Save button is just called Save, instead of SaveAll, indicating that the Hours of Operation aren't to be saved, as they don't exist yet. --->
			<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/save.gif" BORDER="0" NAME="Save" VALUE="Save">
			</form>
			<form name="Cancel" action="service.cfm" method="post">
			<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/cancel.gif" BORDER="0" NAME="Cancel" VALUE="Cancel">
			</form>
		</td>
	</tr>
</cfif>
<tr>
	<td colspan="3">&nbsp;</td>
</tr>

<tr>
	<td colspan="3">
		<a name="Hours"></a>
		<h4>Hours of Operation</h4>
	</td>
</tr>
<cfif #getdlrhours.recordcount# eq 0>
		<!--- if new dealership that hasn't entered any hours yet, allow entry of default hours of operation --->
		<tr align="center">
			<td colspan="3">
				You currently have no showroom hours selected.  Please enter regular opening and closing times (Monday through Friday) for your dealership.  You will then be able to customize your business hours.<br><br>
				<form name="DefaultHours" action="service_hours_def.cfm" method="post">
				<div align="center"><table border="0" cellpadding="3" cellspacing="0">
					<tr>
						<td>Opening Time:</td>
						<td><font size="-1">
							<select name="OpeningTime">
							<option value="Closed">Closed
							<option value="06:00 AM">06:00 AM
							<option value="06:30 AM">06:30 AM
							<option value="07:00 AM">07:00 AM
							<option value="07:30 AM">07:30 AM
							<option value="08:00 AM" selected>08:00 AM
							<option value="08:30 AM">08:30 AM
							<option value="09:00 AM">09:00 AM
							<option value="09:30 AM">09:30 AM
							<option value="10:00 AM">10:00 AM
							<option value="10:30 AM">10:30 AM
							<option value="11:00 AM">11:00 AM
							<option value="11:30 AM">11:30 AM
							<option value="12:00 PM">12:00 PM
							<option value="12:30 PM">12:30 PM
							<option value="01:00 PM">01:00 PM
							</select>
						</font></td>
						<td rowspan="2" valign="middle">
							<!--- set default hours of operation --->
							<cfoutput>
							<input type="Image" src="#application.RELATIVE_PATH#/images/admin/continue.gif" border="0" name="Submit" value="Submit">
							</cfoutput>
						</td>
					</tr>
					<tr>
						<td>Closing Time:</td>
						<td><font size="-1">
							<select name="ClosingTime">
							<option value="Closed">Closed
							<option value="01:00 PM">01:00 PM
							<option value="01:30 PM">01:30 PM
							<option value="02:00 PM">02:00 PM
							<option value="02:30 PM">02:30 PM
							<option value="03:00 PM">03:00 PM
							<option value="03:30 PM">03:30 PM
							<option value="04:00 PM">04:00 PM
							<option value="04:30 PM">04:30 PM
							<option value="05:00 PM" selected>05:00 PM
							<option value="05:30 PM">05:30 PM
							<option value="06:00 PM">06:00 PM
							<option value="06:30 PM">06:30 PM
							<option value="07:00 PM">07:00 PM
							<option value="07:30 PM">07:30 PM
							<option value="08:00 PM">08:00 PM
							<option value="08:30 PM">08:30 PM
							<option value="09:00 PM">09:00 PM
							<option value="09:30 PM">09:30 PM
							<option value="10:00 PM">10:00 PM
							<option value="10:30 PM">10:30 PM
							<option value="11:00 PM">11:00 PM
							<option value="11:30 PM">11:30 PM
							<option value="12:00 AM">12:00 AM
							</select>
						</font></td>
					</tr>
				</table>
				</div>
				</form>
			</td>
		</tr>
	<cfelse>	
		<tr align="center">
			<td colspan="3">
				Select your hours of operation from the choices below.<br><br>
			</td>
		</tr>
		<tr>
			<td colspan="3" align="CENTER">
				<table border="1" cellspacing="0" cellpadding="2">
				<tr>
					<td>&nbsp;</td>
					<td colspan="2" align="CENTER"><b>Service</b></td>
					<td colspan="2" align="CENTER"><b>Parts</b></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td align="center"><b>Open</b></td>
					<td align="center"><b>Close</b></td>
					<td align="center"><b>Open</b></td>
					<td align="center"><b>Close</b></td>
				</tr>
				<cfloop index="weekday" from="1" to="7" step="1">
					<cfoutput>
					<tr>
						<td align="center">
							<b>#dayoftheweek[weekday]#</b>
						</td>
						<td><!--- Service Open --->
							<select name="X#weekday#SO">
								<cfloop index="HourCount" from=1 to=16>
	 								<option value="#openhoursarray[HourCount]#" <cfif '#openhoursarray[hourcount]#' eq #dlrhours[weekday][1]#>SELECTED</cfif>>#openhoursarray[HourCount]#
								</cfloop>
							</select>
						</td>
						<td><!--- Service Close --->
							<select name="X#weekday#SC">
								<cfloop index="HourCount" from=1 to=28>
	 								<option value="#closehoursarray[HourCount]#" <cfif '#closehoursarray[hourcount]#' eq #dlrhours[weekday][2]#>SELECTED</cfif>>#closehoursarray[HourCount]#
								</cfloop>
							</select>
						</td>
						<td><!--- Parts Open --->
							<select name="X#weekday#PO">
								<cfloop index="HourCount" from=1 to=16>
	 								<option value="#openhoursarray[HourCount]#" <cfif '#openhoursarray[hourcount]#' eq #dlrhours[weekday][3]#>SELECTED</cfif>>#openhoursarray[HourCount]#
								</cfloop>
							</select>
						</td>
						<td><!--- Parts Close --->
							<select name="X#weekday#PC">
								<cfloop index="HourCount" from=1 to=28>
	 								<option value="#closehoursarray[HourCount]#" <cfif '#closehoursarray[hourcount]#' eq #dlrhours[weekday][4]#>SELECTED</cfif>>#closehoursarray[HourCount]#
								</cfloop>
							</select>
						</td>
					</tr>
					</cfoutput>
				</cfloop>
				<tr>
					<td>&nbsp;</td>
					<td colspan="2" align="CENTER"><b>Body Shop</b></td>
					<td colspan="2" rowspan="9" align="CENTER">
					Would this dealer<br>
					like to include<br>
					Body Shop<br>
					Hours of Operation<br>
					on their Website?<p>
					<input type="radio" value="Y" name="BodyShop" <cfif #checkbodyshop.bodyshopyesno# eq 'Y'>CHECKED</cfif>>Yes&nbsp;&nbsp;<input type="radio" value="N" name="BodyShop" <cfif #checkbodyshop.bodyshopyesno# eq 'N'>CHECKED</cfif>>No
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td align="center"><b>Open</b></td>
					<td align="center"><b>Close</b></td>
				</tr>
				<cfloop index="weekday" from="1" to="7" step="1">
					<cfoutput>
					<tr>
						<td align="center">
							<b>#dayoftheweek[weekday]#</b>
						</td>
						<td><!--- BodyShop Open --->
							<select name="X#weekday#BO">
								<cfloop index="HourCount" from=1 to=16>
	 								<option value="#openhoursarray[HourCount]#" <cfif '#openhoursarray[hourcount]#' eq #dlrhours[weekday][5]#>SELECTED</cfif>>#openhoursarray[HourCount]#
								</cfloop>
							</select>
						</td>
						<td><!--- BodyShop Close --->
							<select name="X#weekday#BC">
								<cfloop index="HourCount" from=1 to=28>
	 								<option value="#closehoursarray[HourCount]#" <cfif '#closehoursarray[hourcount]#' eq #dlrhours[weekday][6]#>SELECTED</cfif>>#closehoursarray[HourCount]#
								</cfloop>
							</select>
						</td>
					</tr>
					</cfoutput>
				</cfloop>
				</table>
			</td>
		</tr>
		<td colspan="3">&nbsp;</td>
		<tr>
			<td colspan="3" align="center">
				<!--- This Save button is called SaveAll, indicating to showroom_save.cfm that it's ok to save hours of operation too. --->
				<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/save.gif" BORDER="0" NAME="SaveAll" VALUE="Save">
				</form>
				<form name="Cancel" action="service.cfm" method="post">
				<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/cancel.gif" BORDER="0" NAME="Cancel" VALUE="Cancel">
				</form>
			</td>
		</tr>
	</cfif>
</table>
</form>
