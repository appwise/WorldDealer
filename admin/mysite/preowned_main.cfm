<cfset PageAccess = application.dealer_access>

<!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 11, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!--- $Id: preowned_main.cfm,v 1.24 2000/06/22 15:50:46 jkrauss Exp $ --->
<!--- Main preowned content page: Why We're Different, Hours of Operation--->

<cfset nohours = "false">

<!--- Why We're Different --->
<cfquery name="getText" datasource="#gDSN#">
	SELECT	preownedsetaparttext
	FROM	DealerWebs
	WHERE	DealerWebs.DealerCode = '#g_dealercode#'
</cfquery>
<!--- Replace <BR> with Carriage Return --->
<cfset preownedsetaparttext = #replace(gettext.preownedsetaparttext, "<BR>", chr(13), "ALL")#>

<cfif g_dlr>
	<cfquery name="getReyRey" datasource="#gDSN#">
		SELECT	reynoldsActive, reynoldsCode
		FROM	DlrXRef
		WHERE	DealerCode = '#g_dealercode#'
	</cfquery>
	
	<cfquery name="getkbb" datasource="#gDSN#">
		SELECT	kbbActive, kbbCode
		FROM	DlrXRef
		WHERE	DealerCode = '#g_dealercode#'
	</cfquery>

	<!--- Hours of Operation --->
	<cfquery name="getDlrHours" datasource="#gDSN#">
		SELECT HourID as q_HourID,
				DayOfWeek,
				UsedOpen,
				UsedClose
		FROM HoursOfOperation
		WHERE HoursOfOperation.DealerCode = '#g_dealercode#'
		ORDER BY DayOfWeek ASC
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
			<cfset dlrhours[currentrow][1] = #getdlrhours.usedopen#>     
			<cfset dlrhours[currentrow][2] = #getdlrhours.usedclose#>    
		</cfloop>
	</cfif>
</cfif>

<form name="preowned" action="preowned_save.cfm" method="post">
<table cellpadding=5 cellspacing=0 border=0 width="100%">
	<!--- Why We Are Different - preowned --->
	<tr>
		<td><a name="WhyDiff"></a><h4>Why We Are Different</h4></td>
	</tr>
	<tr align="center">
		<td>Please enter a brief profile, describing what makes your pre-owned inventory unique.</td>
	</tr>
	<tr align="center">
		<td>
			<!--- insanely enough, this has to be in one long string, otherwise it puts spaces in front of the text. --->
			<textarea name="preownedsetaparttext" cols="40" rows="10" wrap="PHYSICAL"><cfif gettext.recordcount><cfoutput><cfif #rtrim(preownedsetaparttext)# is not "">#replace(getText.preownedsetaparttext, "<BR>", chr(13), "ALL")#<cfelse>Please enter your text here.</cfif></cfoutput><cfelse>Please enter your text here.</cfif></textarea>
		</td>
	</tr> 
	<cfif not g_col>
		<tr align="center">
			<td>
				<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/save.gif" BORDER="0" NAME="SaveAll" VALUE="Save">
			</td>
		</tr>
	</cfif>
	<cfif g_dlr>
		<!--- <tr>
			<td><a name="kbb"></a><h4>Kelley Blue Book</h4></td>
		</tr>
		<cfif accesslevel GTE application.account_coordinator_access>
			<tr align="center">
				<td>To turn on Kelley Blue Book usage,<br>please select yes and enter a KBB User Code.</td>
			</tr>
			<tr>
				<td align="center">
				<table>
				<tr>
					<td><input type="Radio" name="kbb" value="Y"<cfif #getkbb.kbbActive# eq "Y"> checked</cfif>>Yes &nbsp;&nbsp; <b>KBB User Code</b>&nbsp;&nbsp;<input type="Text" name="kbbcode" value="<cfoutput>#Trim(getkbb.kbbCode)#</cfoutput>" size="8" maxlength="40"></td>
				</tr>
				<tr>
					<td><input type="Radio" name="kbb" value="N"<cfif (#getkbb.kbbActive# eq "N") OR (#trim(getkbb.kbbActive)# is '')> checked</cfif>>No</td>
				</tr>
				</table>			
				</td>
			</tr>		
			<tr>
				<td align="CENTER">
					<table border="0" cellspacing="0" cellpadding="5"><tr><td align="CENTER" bgcolor="#FFF5D9">
					<cfif parameterexists(url.needkbbcode)><font color="Red"><b>ATTENTION:</b></font><br></cfif>
					<b>In order to select "Yes"<br>you must enter a KBB User Code.</b>
					</td></tr></table>
				</td>
			</tr>
			<tr align="center">
				<td>
					<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/save.gif" BORDER="0" NAME="SaveAll" VALUE="Save">
				</td>
			</tr>
		<cfelse>
			<tr><td align="CENTER">
			<cfif (#getKBB.kbbActive# eq "N") OR (#trim(getKBB.kbbActive)# is '')>
				You do not currently have Kelley Blue Book service set up.<br>
				To set up Kelley Blue Book service,<br>
				contact your account representative.
			<cfelse>
				Kelley Blue Book service is active.
			</cfif>
			</td></tr>
		</cfif> --->
		<tr>
			<td><a name="AutoUp"></a><h4>Automatic Uploads</h4></td>
		</tr>
		<cfif accesslevel GTE application.account_coordinator_access>
			<tr align="center">
				<td>To turn on Automatic Uploads of Pre-Owned inventory,<br>please select yes and enter a Reynolds Code.</td>
			</tr>
			<tr>
				<td align="center">
				<table>
				<tr>
					<td><input type="Radio" name="autoUpload" value="Y"<cfif #getReyRey.reynoldsActive# eq "Y"> checked</cfif>>Yes &nbsp;&nbsp; <b>Reynolds Code</b>&nbsp;&nbsp;<input type="Text" name="reynoldsCode" value="<cfoutput>#Trim(getReyRey.reynoldsCode)#</cfoutput>" size="8" maxlength="8"></td>
				</tr>
				<tr>
					<td><input type="Radio" name="autoUpload" value="N"<cfif (#getReyRey.reynoldsActive# eq "N") OR (#trim(getReyRey.reynoldsActive)# is '')> checked</cfif>>No</td>
				</tr>
				</table>			
				</td>
			</tr>		
			<tr>
				<td align="CENTER">
					<table border="0" cellspacing="0" cellpadding="5"><tr><td align="CENTER" bgcolor="#FFF5D9">
					<cfif parameterexists(url.needreycode)><font color="Red"><b>ATTENTION:</b></font><br></cfif>
					<b>In order to select "Yes"<br>you must enter a Reynolds Code.</b>
					</td></tr></table>
				</td>
			</tr>
			<tr align="center">
				<td>
					<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/save.gif" BORDER="0" NAME="SaveAll" VALUE="Save">
				</td>
			</tr>
		<cfelse>
			<tr><td align="CENTER">
			<cfif (#getReyRey.reynoldsActive# eq "N") OR (#trim(getReyRey.reynoldsActive)# is '')>
				You do not currently have Automatic Uploads set up.<br>
				To set up Automatic Uploads,<br>
				contact your account representative.
			<cfelse>
				Automatic Uploads is active.
			</cfif>
			</td></tr>
		</cfif>
	</cfif>
	<!--- doesn't like nested FORMs, so close out last one before we open a new one. --->
	<!--- If no hours of operation yet, we'll show the default hours of operation form later on. --->
	<cfif g_col>
		<cfset nohours = true>
	<cfelseif #getdlrhours.recordcount# eq 0>
		<cfset nohours = true>
	<cfelse>
		<cfset nohours = false>
	</cfif>
	<cfif nohours>
		<tr align="center">
			<td>
				<br>
				<!--- This Save button is just called Save, instead of SaveAll, indicating that the Hours of Operation aren't to be saved, as they don't exist yet. --->
				<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/save.gif" BORDER="0" NAME="Save" VALUE="Save">
				</form>
				<form name="Cancel" action="preowned.cfm" method="post">
				<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/cancel.gif" BORDER="0" NAME="Cancel" VALUE="Cancel">
				</form>
			</td>
		</tr>
	</cfif>	
	<cfif g_dlr>
		<!--- Hours of Operation --->
		<tr>
			<td><a name="Hours"></a><h4>Hours of Operation</h4></td>
		</tr>	
		<cfif #getdlrhours.recordcount# eq 0>
			<!--- if new dealership that hasn't entered any hours yet, allow entry of default hours of operation --->
			<tr align="center">
				<td>
					You currently have no preowned hours selected.<br><br>
					Please enter regular opening and closing times<br>
					(Monday through Friday) for your dealership.<br>
					You will then be able to customize your business hours.<br><br>
					<form name="DefaultHours" action="preowned_hours_def.cfm" method="post">
					<table border="0" cellpadding="3" cellspacing="0">
					<tr>
						<td>Opening Time:</td>
						<td>
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
						</td>
						<td rowspan="2" valign="middle">
							<!--- set default hours of operation --->
							<cfoutput>
							<input type="Image" src="#application.RELATIVE_PATH#/images/admin/save.gif" border="0" name="Save" value="Save">
							</cfoutput>
						</td>
					</tr>
					<tr>
						<td>Closing Time:</td>
						<td>
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
						</td>
					</tr>
					</table>
					</form>
				</td>
			</tr>
		<cfelse>	
			<tr align="center">
				<td>Select your hours of operation from the choices below.</td>
			</tr>
			<tr align="center">
				<td>
					<table cellpadding=5 cellspacing=0 border=1>
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
							<td>
								<!--- Used Open --->
								<select name="X#weekday#SO">
									<cfloop index="HourCount" from=1 to=16>
		 								<option value="#openhoursarray[HourCount]#" <cfif '#openhoursarray[hourcount]#' eq #dlrhours[weekday][1]#>SELECTED</cfif>>#openhoursarray[HourCount]#
									</cfloop>
								</select>
							</td>
							<td>
								<!--- Used Close --->
								<select name="X#weekday#SC">
									<cfloop index="HourCount" from=1 to=28>
		 								<option value="#closehoursarray[HourCount]#" <cfif '#closehoursarray[hourcount]#' eq #dlrhours[weekday][2]#>SELECTED</cfif>>#closehoursarray[HourCount]#
									</cfloop>
								</select>
							</td>
						</tr>
						</cfoutput>
					</cfloop>
					</table>
				</td>
			</tr>
			<tr align="center">
				<td>
					<!--- This Save button is called SaveAll, indicating to preowned_save.cfm that it's ok to save hours of operation too. --->
					<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/save.gif" BORDER="0" NAME="SaveAll" VALUE="Save">
					</form>
					<form name="Cancel" action="preowned.cfm" method="post">
					<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/cancel.gif" BORDER="0" NAME="Cancel" VALUE="Cancel">
					</form>
				</td>
			</tr>
		</cfif>
		<tr>
			<td><h4>InventoryManager&#153;</h4></td>
		</tr>
		<tr align="center">
			<td>
				Manage your Pre-Owned Vehicle Inventory.
				<form name="Continue" action="preowned_inv.cfm" method="post">
					<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/continue.gif" BORDER="0" NAME="Continue" VALUE="Continue">
				</form>
			</td>
		</tr>
	</cfif>
</table>
