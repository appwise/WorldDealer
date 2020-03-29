<cfset PageAccess = application.dealer_access>

                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 10, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: profile_main.cfm,v 1.14 2000/03/21 16:11:02 jkrauss Exp $--->

<cfquery name="getDealerInfo" datasource="#gDSN#">
	SELECT *
	FROM Dealers
	WHERE DealerCode = '#g_dealercode#'
</cfquery>

<cfquery name="getText" datasource="#gDSN#">
	SELECT DealerProfileMainText
	FROM DealerWebs
	WHERE DealerWebs.DealerCode = '#g_dealercode#'
</cfquery>

<cfset mod_dlrprofiletxt = #replace(gettext.dealerprofilemaintext,"<BR>",Chr(13),"ALL")#>
<!--- Remove those funky tilde things --->
<cfset temp = #mod_dlrprofiletxt#>
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
<cfset #mod_dlrprofiletxt# = #temp#>
<!--- Remove those funky tilde things --->

<cfquery name="checkbodyshop" datasource="#gDSN#">
	SELECT	BodyShopYesNo
	FROM	dealerwebs
	WHERE	DealerCode = '#g_dealercode#';
</cfquery>

<cfquery name="getDLRHours" datasource="#gDSN#">
	SELECT	DayOfWeek,
			SalesOpen,
			SalesClose,
			UsedOpen,
			UsedClose,
			ServiceOpen,
			ServiceClose,
			PartsOpen,
			PartsClose
	<cfif checkbodyshop.bodyshopyesno is "Y">,
		BodyShopOpen as BodyShopOpen,
		BodyShopClose as BodyShopClose
	</cfif>
	FROM HoursOfOperation
	WHERE HoursOfOperation.DealerCode = '#g_dealercode#'
	ORDER BY DayOfWeek ASC
</cfquery>


<form action="profile_main_save.cfm" method="POST">
<table border="0" cellspacing="0" cellpadding="3" width="100%">
<tr>
	<td colspan="3">
		<a name="Contact"></a>
		<h4>Contact Information</h4>
	</td>
</tr>
<tr align="center">
	<td colspan="3">To update your Contact Information, please <a href="myinfo.cfm"><b>click here</b></a>.</td>
</tr>
<cfoutput query="getDealerInfo">
<tr>
	<td align="right"><b>Display Name</td>
	<td>&nbsp;&nbsp;&nbsp;</td>
	<td>#DisplayName#</td>
</tr>
<tr>
	<td align="right"><b>Tag Line</b></td>
	<td>&nbsp;&nbsp;&nbsp;</td>
	<td>#TagLine#</td>
</tr>
<tr>
	<td align="right"><b>Address</b></td>
	<td>&nbsp;&nbsp;&nbsp;</td>	
	<td>#AddressLine1#</td>
</tr>
<cfif #trim(addressline2)# neq "">
<tr>
	<td align="right">&nbsp;</td>
	<td>&nbsp;&nbsp;&nbsp;</td>
	<td>#AddressLine2#</td>
</tr>
</cfif>
<tr>
	<td align="right">&nbsp;</td>
	<td>&nbsp;&nbsp;&nbsp;</td>	
	<td>#City#, #stateabbr# &nbsp; #Zip#</td>
</tr>
<tr>
	<td align="right"><b>Dealership Phone</b></td>
	<td>&nbsp;&nbsp;&nbsp;</td>
	<td>
	<cfif #len(phone)# eq 10>
		#RemoveChars(phone,4,10)#-#Mid(phone,4,3)#-#RemoveChars(phone,1,6)#
	<cfelse>
		<font color="red">#phone#</font>
	</cfif>
	</td>
</tr>
<cfif #trim(secondphone)# neq "">
<tr>
	<td align="right" nowrap>2nd Dealership Phone</td>
	<td>&nbsp;&nbsp;&nbsp;</td>
	<td>
	<cfif #len(secondphone)# eq 10>
		#RemoveChars(secondphone,4,10)#-#Mid(secondphone,4,3)#-#RemoveChars(secondphone,1,6)#
	<cfelse>
		<font color="red">#secondphone#</font>
	</cfif>
	</td>
</tr>
</cfif>
<tr>
	<td align="right"><b>Fax Number</b></td>
	<td>&nbsp;&nbsp;&nbsp;</td>	
	<td>
	<cfif #len(faxphone)# eq 10>
		#RemoveChars(FaxPhone,4,10)#-#Mid(FaxPhone,4,3)#-#RemoveChars(FaxPhone,1,6)#
	<cfelse>
		<font color="red">#FaxPhone#</font>
	</cfif>
	</td>
</tr>
<tr>
	<td align="right"><b>E-Mail Address</b></td>
	<td>&nbsp;&nbsp;&nbsp;</td>
	<td>#Email#</td>
</tr>
<tr>
	<td align="right"><b>Contact Name</b></td>
	<td>&nbsp;&nbsp;&nbsp;</td>
	<td>#ContactName#</td>
</tr>
<tr>
	<td align="right"><b>Contact Phone</b></td>
	<td>&nbsp;&nbsp;&nbsp;</td>
	<td>
	<cfif #len(contactphone)# eq 10>
		#RemoveChars(ContactPhone,4,10)#-#Mid(ContactPhone,4,3)#-#RemoveChars(ContactPhone,1,6)#
	<cfelse>
		<font color="red">#ContactPhone#</font>
	</cfif>
	</td>
</tr>
</cfoutput>
<tr>
	<td colspan="3">&nbsp;</td>
</tr>
<tr>
	<td colspan="3">
	<a name="Hours"></a>
	<h4>Hours of Operation</h4>
	</td>
</tr>
<tr align="center">
	<td colspan="3">
	Click on any of the departments below to edit your Hours of Operation.
	</td>
</tr>
<tr>
	<td colspan="3" align="CENTER">
		<table border="1" cellspacing="0" cellpadding="2">
		<tr>
			<td>&nbsp;</td>
			<td align="CENTER"><b><a href="showroom.cfm#Hours">Showroom</a></b></td>
			<td align="CENTER"><b><a href="preowned.cfm#Hours">Pre-Owned</a></b></td>
			<td align="CENTER"><b><a href="service.cfm#Hours">Service</a></b></td>
			<td align="CENTER"><b><a href="service.cfm#Hours">Parts</a></b></td>
			<cfif checkbodyshop.bodyshopyesno is "Y">
				<td align="CENTER"><b><a href="service.cfm#hours">Body Shop</a></b></td>
			</cfif>
		</tr>
		<cfoutput query="getDLRHours" group="DayOfWeek">
			<tr valign=center>
			<td><font size="-1">
				<cfif DayOfWeek eq '1'><b>Mon</b>
				<cfelseif DayOfWeek eq '2'><b>Tue</b>
				<cfelseif DayOfWeek eq '3'><b>Wed</b>
				<cfelseif DayOfWeek eq '4'><b>Thu</b>
				<cfelseif DayOfWeek eq '5'><b>Fri</b>
				<cfelseif DayOfWeek eq '6'><b>Sat</b>
				<cfelseif DayOfWeek eq '7'><b>Sun</b>
				</cfif>
			</font></td>
			<cfif salesopen contains "Closed">
				<td align=center><font size="-1">Closed</font></td>
			<cfelse>
				<td><font size="-1">#SalesOpen# - #SalesClose#</font></td>
			</cfif>
			<cfif usedopen contains "Closed">
				<td align=center><font size="-1">Closed</font></td>
			<cfelse>
				<td><font size="-1">#UsedOpen# - #UsedClose#</font></td>
			</cfif>
			<cfif serviceopen contains "Closed">
				<td align=center><font size="-1">Closed</font></td>
			<cfelse>
				<td><font size="-1">#ServiceOpen# - #ServiceClose#</font></td>
			</cfif>
			<cfif partsopen contains "Closed">
				<td align=center><font size="-1">Closed</font></td>
			<cfelse>
				<td><font size="-1">#PartsOpen# - #PartsClose#</font></td>
			</cfif>
			<cfif checkbodyshop.bodyshopyesno is "Y">
				<cfif bodyshopopen contains "Closed">
					<td align=center><font size="-1">Closed</font></td>
				<cfelse>
					<td><font size="-1">#BodyShopOpen# - #BodyShopClose#</font></td>
				</cfif>
			</cfif>
			</tr>
		</cfoutput>
		</table>
	</td>
</tr>
<tr>
	<td colspan="3">&nbsp;</td>
</tr>
<tr>
	<td colspan="3">
		<a name="Who"></a>
		<h4>Who We Are</h4>
	</td>
</tr>
<tr align="center">
	<td colspan="3">To update your Who We Are text, please make any changes below.</td>
</tr>
<tr>
	<td colspan="3" align="CENTER">
	<textarea name="DealerProfileMainText" cols="40" rows="20" wrap="PHYSICAL"><cfoutput query="getText">#mod_dlrProfileTxt# </cfoutput></textarea>
	</td>
</tr>
<tr>
	<td colspan="3" align="CENTER">
	<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/save.gif" BORDER="0" NAME="Save" VALUE="Save">
	</td>
</tr>
</table>
</form>