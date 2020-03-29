
                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 10, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: myinfo_main.cfm,v 1.57 2000/06/21 23:25:27 lswanson Exp $--->

<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: myinfo_main.cfm,v $">

<cfif isdefined("URL.FromTemplate")>
	<!--- if genexe_redirect was redirected back here, then we need to generate maps also --->
	<!--- <cfif URL.fromtemplate eq "genexe_redirect">
		<!--- generate maps then come back here --->
		<cfmodule template="genmap.cfm"
			windowtitle="WorldDealer My Site -- Create Maps"
			screentitle="Create Maps"
			nextstep="#application.RELATIVE_PATH#/admin/mysite/myinfo.cfm"
			dealercode="#g_dealercode#">
		<cfabort>
	</cfif> --->
</cfif>

<cfif isdefined("g_dealercode")>
	<cfset editmode = true>
<cfelse>
	<cfset editmode = false>
</cfif>

<cfif editmode>
	<!--- user is coming at this page with a dealer already selected --->
	<cfquery name="getDealerInfo" datasource="#gDSN#">
		SELECT	Dealers.*, WebStates.Description
		FROM 	Dealers 
				INNER JOIN WebStates ON Dealers.WebStateID = WebStates.WebStateID
		WHERE	Dealers.DealerCode = '#g_dealercode#'
	</cfquery>
	
	<!--- query for make logos --->
	<cfquery name="getmakelogo" datasource="#gDSN#">
		SELECT  MakeLogoYN,
				MakeLogoLinkYN,
				maptext				
		FROM DealerWebs
		WHERE DealerCode = '#g_dealercode#'
	</cfquery>
	
	<cfquery name="getDealerMakes" datasource="#gDSN#">
		<!--- LEFT JOIN because we want all Records from DealerFranchise, but only records from MakeRegions that 
		have valid data in them.  i.e. There may be makes without regions. --->
		SELECT 	Makes.MakeNumber,
				Makes.MakeName,
				MakeRegions.RegionID,
				MakeRegions.RegionName
		FROM 	(DealerFranchise
				INNER JOIN Makes ON DealerFranchise.MakeNumber = Makes.MakeNumber)
				LEFT JOIN MakeRegions ON DealerFranchise.RegionID = MakeRegions.RegionID
		WHERE 	DealerFranchise.dealercode = '#g_dealercode#'
		ORDER BY DealerFranchise.RowID		
		<!--- 
		SELECT 	RowID,
				MakeNumber,
				MakeName,
				RegionID
		FROM 	DealerFranchise
		WHERE	DealerFranchise.dealercode = '#g_dealercode#'
		ORDER BY DealerFranchise.RowID
		 --->
	</cfquery>
	
	<cfquery name="getMetaTags" datasource="#gDSN#">
		SELECT	DealerWebsMeta.* 
		FROM 	DealerWebs INNER JOIN DealerWebsMeta ON DealerWebs.DealerWebID = DealerWebsMeta.DealerWebID
		WHERE	DealerWebs.DealerCode = '#g_dealercode#'
	</cfquery>

	<!--- get multiple URLs --->
	<cfquery name="getURL2" datasource="#gDSN#">
		SELECT	URL
		FROM 	DealerURL
		WHERE 	DealerCode = '#g_dealercode#'
	</cfquery>

	<cfquery name="getDealerAdmins" datasource="#gDSN#">
		SELECT Name
		FROM Accounts
		WHERE AccountKey = '#g_dealercode#'
	</cfquery>
</cfif>

<cfquery name="getStates" datasource="#gDSN#">
	SELECT	StateAbbr, 
			Description
	FROM 	States
	ORDER BY Description
</cfquery>

<cfquery name="getAcctExecs" datasource="#gDSN#">
	SELECT	AEID,
			FirstName,
			LastName
	FROM	AccountExecs
	ORDER BY LastName
</cfquery>

<cfquery name="getAcctCoordinators" datasource="#gDSN#">
	SELECT	ACID,
			FirstName,
			LastName
	FROM	AccountCoordinators
	ORDER BY LastName
</cfquery>

<cfquery name="getwebstates" datasource="#gDSN#">
	SELECT	*
	FROM	webstates;
</cfquery>

<cfquery name="getMakes" datasource="#gDSN#">
	SELECT	MakeNumber, 
			MakeName
	FROM	Makes
	ORDER BY MakeName
</cfquery>

<!--- 1st time in, they have to select whether it's a dealership or a collection --->
<cfif not editmode>
	<cfif goodbrowser>
		<script language="JavaScript">
		<!--  
		function onDlrTypeChange()
			{
			if (document.myinfomain.dealertype[0].checked)
				dlrtype = document.myinfomain.dealertype[0].value;
			else if (document.myinfomain.dealertype[1].checked)
				dlrtype = document.myinfomain.dealertype[1].value;
			if (dlrtype != '')
				location.href = 'myinfo.cfm?dlrtype=' + dlrtype;
			else
				// this sets it back to the default.
				location.href = 'myinfo.cfm';
			}
		//-->
		</script>
	</cfif>
	
	<cfif isdefined("URL.dlrtype")>

	<cfif url.dlrtype eq "dlr">
			<cfset g_dlr = true>		
		<cfelseif url.dlrtype eq "col">
			<cfset g_col = true>
		</cfif>
	</cfif>
</cfif>


<form action="myinfo_save.cfm" method="POST" name="myinfomain">
<table border="0" cellpadding="5" cellspacing="0" width="100%">
<tr>
	<td>
		<a name="dealerinfo"></a>
		
		<h4>Dealership Information</h4>
		
	</td>
</tr>
<tr>
	<td>
		<div align="center">
		<table border="0" cellpadding="5" cellspacing="0">
		<cfif not editmode>
			 <tr>
				<td align="right"><b>Add a Collection?</b></td>
				<td><input type="radio" name="dealertype" value="col" <cfif goodbrowser>onClick="onDlrTypeChange()"</cfif> <cfif not isdefined("URL.dlrtype")>checked<cfelseif url.dlrtype eq "col">checked</cfif>></td>
			</tr>
			<tr>
				<td align="right"><b>or Add a Dealership?</b></td>
				<input type="hidden" name="dealertype_required" value="Please choose either Collection or Dealership.">
				<td><input type="radio" name="dealertype" value="dlr" <cfif goodbrowser>onClick="onDlrTypeChange()"</cfif> <cfif isdefined("URL.dlrtype")><cfif url.dlrtype eq "dlr">checked</cfif></cfif>></td>
			</tr> 

			<cfif g_dlr>
				<cfquery name="getCollections" datasource="#gDSN#">
					SELECT DISTINCT 
							Dealers.DealerCode, 
							Dealers.DealershipName
					FROM	Dealers
					WHERE	DealerType = 1
					ORDER BY DealershipName
				</cfquery>
				<tr>
					<td align="right">Member of Collection?</td>
					<td>
						<select name="Collection">
						<option value="0000">None
						<cfoutput query="getCollections">
							<option value="#Left(Dealercode, 4)#">#DealershipName#</option>
						</cfoutput>
						</select>
					</td>
				</tr>
			</cfif>
		</cfif>
		<!--- Chris Wacker 11/13/2000 2:20 PM --->
		 <tr>
			<td align="right"><b>Dealership Name</b></td>
			<input type="hidden" name="dealershipname_required" value="Please enter the dealership's name.">
			<td><input type="text" name="dealershipname" size=25 maxlength=50 <cfif editmode>value="<cfoutput>#getDealerInfo.DealershipName#</cfoutput>"</cfif>></td>
		</tr> 
		
		<!--- ie. if adding a new collection, don't show Dealercode, because it's created automatically --->
		<cfif editmode or g_dlr>
			<tr>
				<td align="right"><b>Dealer Code</b></td>
				<!--- 2/21/00: if adding a new record, allow all account people to enter the dealercode. --->
				<!--- 8/23/99: only allow AA's to change dealercode. --->
				
				<cfif (not editmode) or (accesslevel eq application.sysadmin_access)>
				
					<td>
							<input type="text" name="newDealerCode" size=25 maxlength=<cfif editmode>40<cfelse>10</cfif> <cfif editmode>value="<cfoutput>#getDealerInfo.DealerCode#</cfoutput>"</cfif>>
						<input type="hidden" name="newDealerCode_required" value="Please enter a dealer code.">
						
					</td> 
					
				<cfelse>
					<td>
						<input type="hidden" name="newDealerCode" value="<cfoutput>#getDealerInfo.DealerCode#</cfoutput>">
					</td>
				</cfif>
			</tr>
		</cfif>
		<tr>
		
			
				<td align="right"><b>Display Name</td>
				<input type="hidden" name="DisplayName_required" value="You must enter a Display Name.">
				
				<td><input type="text" name="DisplayName" size="25" maxlength="50" <cfif editmode>value="<cfoutput>#getDealerInfo.DisplayName#</cfoutput>"</cfif>></td>
			
		
		</tr>
		<tr>
		
			
			<td align="right"><b>Tag Line</b></td>
			<input type="hidden" name="TagLine_required" value="Please enter a Tag Line.">
			<td>
			<input type="text" name="TagLine" size=25 maxlength="150" <cfif editmode>value="<cfoutput>#getDealerInfo.TagLine#</cfoutput>"</cfif>>
			</td>
			
		
		</tr>
		<tr>
		
		
			<td align="right"><b>Address 1</b></td>
			<input type="hidden" name="Address1_required" value="Please enter an address.">
			<td><input type="text" name="Address1" size=25 maxlength=40 <cfif editmode>value="<cfoutput>#getDealerInfo.AddressLine1#</cfoutput>"</cfif>></td>
			
		</tr>
		<tr>
			<td align="right">Address 2</td>
			<td><input type="text" name="Address2" size=25 maxlength=40 <cfif editmode>value="<cfoutput>#getDealerInfo.AddressLine2#</cfoutput>"</cfif>></td>
		</tr>
		<tr>
			<td align="right"><b>City</b></td>
			<input type="hidden" name="City_required" value="Please enter a city.">
			<td><input type="text" name="City" size=25  maxlength=35 <cfif editmode>value="<cfoutput>#getDealerInfo.City#</cfoutput>"</cfif>></td>
		
		
		</tr>
		<tr>
<!--- Chris Wacker 11/13/2000 1:35 PM --->
<!--- The following code may not execute properly due to what appears to be improper nesting of the conditional statement (see fix(1)) --->
			<td align="right"><b>State</b></td>
			<input type="hidden" name="StateAbbr_required"  value="Please select a state.">
			<td>
				<select name="StateAbbr">
				<cfoutput query="getStates">
				<option value="#stateAbbr#"<cfif editmode><cfif #getdealerinfo.stateabbr# eq #stateabbr#> SELECTED</cfif></cfif>>#Description#</option>
				</cfoutput>                   
				</select>
			</td> 
			

		
		<tr>
			<td align="right"><b>Zip Code</b></td>
			<input type="hidden" name="Zip_required" value="Please enter a valid USPS Zip Code.">
			<td>
			
			<cfoutput>
			<input type="text" name="Zip" size=10 maxlength=10 <cfif editmode><cfif #getDealerInfo.Zip# NEQ "">value="#getDealerInfo.Zip#"<cfelse>value=""</cfif></cfif>>
			</cfoutput>
			
			
			
			
				<!--- <cfif #getDealerInfo.Zip# NEQ "">
				<input type="text" name="Zip" size=10 maxlength=10 value="#getDealerInfo.Zip#">
				<cfelse>
				<input type="text" name="Zip" size=10 maxlength=10 value="">
				</cfif>
				<font size="-1"> &nbsp;(XXXXX or XXXXX-XXXX)</font> --->
			</td>
		</tr>
		
		 
		<tr>
			<td align="right"><b>Dealership Phone</b></td>
			<input type="hidden" name="Phone1_required" value="Please enter a valid Phone Area Code.">
			<input type="hidden" name="Phone2_required" value="Please enter a valid Phone Number.">
			<input type="hidden" name="Phone3_required" value="Please enter a valid Phone Number.">
			<td>
				<!--- linda, 10/20/99: optimized redundant code, show all data they've typed in, even if it's < 10 digit number --->					
				<!--- 10/21/99: had to add Trim() to the 1st field of phone & fax #s, cuz UPDATE inserts 1 space, instead of just leaving it blank.
				& then when you go to edit it, your cursor is at position 2 & you can only enter 2 of the 3 digits of the area code.
				(unless you realize what's going on & delete the leading space 1st.  ugh.) --->
				<cfoutput>
				<input type="text" name="Phone1" size=3 maxlength=3 <cfif editmode><cfif #len(getdealerinfo.phone)# gt 0>value="#Trim(Left(getDealerInfo.Phone,3))#"</cfif></cfif>>
				<input type="text" name="Phone2" size=3 maxlength=3 <cfif editmode><cfif #len(getdealerinfo.phone)# gt 3>value="#Mid(getDealerInfo.Phone,4,3)#"</cfif></cfif>>
				<input type="text" name="Phone3" size=4 maxlength=4 <cfif editmode><cfif #len(getdealerinfo.phone)# gt 6>value="#Mid(getDealerInfo.Phone,7,4)#"</cfif></cfif>>
				<cfif editmode>
					<cfif (#len(trim(getdealerinfo.phone))# gt 0) and (#len(getdealerinfo.phone)# lt 10)>
						<font color="red">Please enter a 10-digit phone number.</font>
					</cfif>
				</cfif>
				<cfif editmode><input type="hidden" name="Phone" value="#getDealerInfo.Phone#"></cfif>
				</cfoutput>
			</td>
		</tr>
		<tr>
			<td align="right" nowrap>2nd Dealership Phone</td>
			<td>
				<!--- linda, 10/20/99: optimized redundant code, show all data they've typed in, even if it's < 10 digit number --->					
				<cfoutput>
				<input type="text" name="secondPhone1" size=3 maxlength=3 <cfif editmode><cfif #len(getdealerinfo.secondphone)# gt 0>value="#Trim(Left(getDealerInfo.secondPhone,3))#"</cfif></cfif>>
				<input type="text" name="secondPhone2" size=3 maxlength=3 <cfif editmode><cfif #len(getdealerinfo.secondphone)# gt 3>value="#Mid(getDealerInfo.secondPhone,4,3)#"</cfif></cfif>>
				<input type="text" name="secondPhone3" size=4 maxlength=4 <cfif editmode><cfif #len(getdealerinfo.secondphone)# gt 6>value="#Mid(getDealerInfo.secondPhone,7,4)#"</cfif></cfif>>
				<cfif editmode>
					<cfif (#len(trim(getdealerinfo.secondphone))# gt 0) and (#len(getdealerinfo.secondphone)# lt 10)>
						<font color="red">Please enter a 10-digit phone number.</font>
					</cfif>
				</cfif>
				<cfif editmode><input type="hidden" name="secondPhone" value="#getDealerInfo.secondPhone#"></cfif>
				</cfoutput>
			</td>
		</tr>
		<tr>
			<td align="right">Fax Number</td>
			<td>
				<!--- linda, 10/20/99: optimized redundant code, show all data they've typed in, even if it's < 10 digit number --->					
				<cfoutput>
				<input type="text" name="FaxPhone1" size=3 maxlength=3 <cfif editmode><cfif #len(getdealerinfo.faxphone)# gt 0>value="#Trim(Left(getDealerInfo.FaxPhone,3))#"</cfif></cfif>>
				<input type="text" name="FaxPhone2" size=3 maxlength=3 <cfif editmode><cfif #len(getdealerinfo.faxphone)# gt 3>value="#Mid(getDealerInfo.FaxPhone,4,3)#"</cfif></cfif>>
				<input type="text" name="FaxPhone3" size=4 maxlength=4 <cfif editmode><cfif #len(getdealerinfo.faxphone)# gt 6>value="#Mid(getDealerInfo.FaxPhone,7,4)#"</cfif></cfif>>
				<cfif editmode>
					<cfif (#len(trim(getdealerinfo.faxphone))# gt 0) and (#len(getdealerinfo.faxphone)# lt 10)>
						<font color="red">Please enter a 10-digit fax number.</font>
					</cfif>
				</cfif>
				<cfif editmode><input type="hidden" name="FaxPhone" value="#getDealerInfo.FaxPhone#"></cfif>
				</cfoutput>
			</td>
		</tr>
		<tr>
			<td align="right">E-Mail Address</td>
			<td>
				
				<!--- linda, 10/14/99: changed Email to EmailTooShortNotUsed.  Added new Email of length 50 --->
				
				<input type="text" name="EMail" maxlength=50 size=25 tabindex=1 <cfif editmode>VALUE="<cfoutput>#Trim(getDealerInfo.Email)#</cfoutput>"</cfif>>
				
				
			</td>
		</tr>
		<tr>
			<td align="right"><b>Contact Name</b></td>
			<input type="hidden" name="ContactName_required" value="Please enter a Contact Name."> 
			<td><input type="text" name="ContactName" size=25 maxlength=50 <cfif editmode>value="<cfoutput>#getDealerInfo.ContactName#</cfoutput>"</cfif>></td>
		</tr>
		<tr>
			<td align="right"><b>Contact Phone</b></td>
			<input type="hidden" name="ContactPhone1_required" value="Please enter a valid Contact Phone Number.">
			<input type="hidden" name="ContactPhone2_required" value="Please enter a valid Contact Phone Number.">
			<input type="hidden" name="ContactPhone3_required" value="Please enter a valid Contact Phone Number."> 
		
			<td>
				<!--- linda, 10/20/99: optimized redundant code, show all data they've typed in, even if it's < 10 digit number --->					
				<!--- 10/21/99: had to add Trim() to the 1st field of phone & fax #s, cuz UPDATE inserts 1 space, instead of just leaving it blank.
				& then when you go to edit it, your cursor is at position 2 & you can only enter 2 of the 3 digits of the area code.
				(unless you realize what's going on & delete the leading space 1st.  ugh.) --->
				<cfoutput>
				<input type="text" name="ContactPhone1" size=3 maxlength=3 <cfif editmode><cfif #len(getdealerinfo.contactphone)# gt 0>value="#Trim(Left(getDealerInfo.ContactPhone,3))#"</cfif></cfif>>
				<input type="text" name="ContactPhone2" size=3 maxlength=3 <cfif editmode><cfif #len(getdealerinfo.contactphone)# gt 3>value="#Mid(getDealerInfo.ContactPhone,4,3)#"</cfif></cfif>>
				<input type="text" name="ContactPhone3" size=4 maxlength=4 <cfif editmode><cfif #len(getdealerinfo.contactphone)# gt 6>value="#Mid(getDealerInfo.ContactPhone,7,4)#"</cfif></cfif>>
				<cfif editmode>
					<cfif (#len(trim(getdealerinfo.ContactPhone))# gt 0) and (#len(getdealerinfo.ContactPhone)# lt 10)>
						<font color="red">Please enter a 10-digit phone number.</font>
					</cfif>
				</cfif>
				<cfif editmode><input type="hidden" name="Phone" value="#getDealerInfo.ContactPhone#"></cfif>
				</cfoutput>
			</td>
		</tr>
		</table>
		</div>
	</td>
</tr>
<tr>
	<td align="center">
		<br>
		<input type="Image" name="Save" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/save.gif" border="0">
		<br><br>
	</td>
</tr>
<!--- Account Info --->
<cfif accesslevel gt application.dealer_access>
	<!--- AE and AC information can only be changed by AEs and ACs --->
	<tr>
		<td><a name="accountinfo"></a><h4>Account Information</h4></td>
	</tr>
	<tr>
		<td align="center">
			<table>
			<tr>
				<td align="right"><b>Account Executive</b></td>
				
				<td>
					<select name="AccountExec">
						<cfoutput query="getAcctExecs">
							<cfset tmp_name =#trim(lastname)# & ', ' & #trim(firstname)#>
							<option value="#AEID#" SELECTED>#tmp_Name#
						</cfoutput>
					</select>
				
				
					<!--- <select name="AccountExec">
					<cfif not editmode>
						<option value="" selected>
					</cfif>
						<cfoutput query="getAcctExecs">
							<cfset tmp_name =trim(#lastname#) & ', ' & trim(#firstname#)>
								<cfif tmp_name eq ', '>
									<cfset tmp_name = "">
								</cfif>
								<cfif editmode>
									<cfif #aeid# eq #getdealerinfo.aeid#> 
										<option value="#AEID#" SELECTED>#tmp_Name#
									 <cfelse>
										<option value="#AEID#">#tmp_Name#
									</cfif> 
								</cfif>
							<cfset tmp_name="">
						</cfoutput>
					</select> --->
					<!--- <input type="hidden" name="AccountExec_required" value="Please select an Account Executive."> --->
				</td> 
			</tr>
			<tr>
				<td align="right" nowrap><b>Account Coordinator</b></td>
				<td>
				
					<select name="AccountCoord">
						<cfoutput query="getAcctCoordinators">
							<cfset tmp_name =#trim(lastname)# & ', ' & #trim(firstname)#>
							<option value="#ACID#" SELECTED>#tmp_Name#
						</cfoutput>
					</select>
					
					<!--- <select name="AccountCoord">
					<cfif not editmode>
						<option value="" selected>
					</cfif>
						<cfoutput query="getAcctCoordinators">
							<cfset tmp_name =#trim(lastname)# & ', ' & #trim(firstname)#>
							<cfif tmp_name eq ', '>
								<cfset tmp_name = "">
							</cfif>
							<cfif editmode>
								<cfif #acid# eq #getdealerinfo.acid#> 	
								<option value="#ACID#" SELECTED>#tmp_Name#
								 </cfif> 	
							</cfif>
							<cfset tmp_name="">
						</cfoutput>
					</select> --->
					<!--- <input type="hidden" name="AccountCoord_required" value="Please select an Account Coordinator."> --->
				</td>
			</tr>
			<tr>
				<td align="right"><b>Dealer's First Name</b></td>
				<td>
					
					<input type="hidden" name="DealerFirstName_required" value="Please enter the dealer's first name.">
					
					<input type=text name="DealerFirstName" size=20 maxlength=15 <cfif editmode>VALUE="<cfoutput>#getDealerInfo.DealerFirstName#</cfoutput>"</cfif>>
					
					
				</td>
			</tr>
			<tr>
				<td align="right"><b>Dealer's Last Name</b></td>
				<td>
					
					<input type="hidden" name="DealerLastName_required" value="Please enter the dealer's last name.">
					
					<input type=text name="DealerLastName" size=20 maxlength=30 <cfif editmode>VALUE="<cfoutput>#getDealerInfo.DealerLastName#</cfoutput>"</cfif>>
					
					
				</td>
			</tr>
			<tr>
				<td valign="top" align="right" nowrap>Dealer Administrator<cfif editmode><cfif #getDealerAdmins.RecordCount# gt 1>s</cfif></cfif></td> 
				<td> 
					<cfset daexist = false>
					
					<cfif editmode> 
						<cfif getDealerAdmins.RecordCount> 
							<cfset daexist = true> 
							<cfloop query="getDealerAdmins"> 
								<cfoutput><b>#Name#</b></cfoutput><br> 
							</cfloop> 
						</cfif> 
					</cfif>
					
					<cfif not daexist> 
						You currently have no Dealer Administrator.                                               
					</cfif>                                               
				</td>
				</tr> 
				<tr>
				<td colspan="2" align="center" bgcolor="#FFF5D9"> 
				To edit Dealer Administrators, go to the <b>Admin</b><br>
				section, then select <b>Account Staff</b>.
				<!--- linda, 4/4/00: This is only a good idea when they haven't edited anything on that page to be saved.
				Or click <a href="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/admin/account/dealadmin_edit.cfm">here</a>. --->
				</td>                                                
			</tr> 
			</table>
		</td>
	</tr>
	<tr>
		<td align="center">
			<br>
			<input type="Image" name="Save" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/save.gif" border="0">
			<br><br>
		</td>
	</tr>
</cfif>
<cfif g_dlr>
	<!--- Dealership Franchises --->
	<tr>
		<td>
			<a name="franchises"></a>
			<h4>Franchises Offered</h4>
		</td>
	</tr>
	<tr>
		<td align="center">
		<cfif editmode>
			<cfif getdealermakes.recordcount eq 0>
				This dealer currently has no franchises selected.
			<cfelse>
				<table border="0" cellpadding="5" cellspacing="0">
				<tr>
					<td><b>Franchise&nbsp;&nbsp;</b></td>
					<td><b>Region</b></td>
				</tr>
				<cfoutput query="getDealerMakes">
				<tr>
					<td>#MakeName#</td>
					<td>
						<cfif regionname is not "">
							#RegionName#
						<cfelse>
							none selected
						</cfif>
					</td>
				</tr>
				</cfoutput>
				</table>
			</cfif>
		<cfelse>
			This dealer currently has no franchises selected.
		</cfif>
		</td>
	</tr>
	<!--- ACs and AEs should be able to update, but dealers shouldn't. --->
	<cfif accesslevel gt application.dealer_access>
		<tr>
			<td align="center">
				<cfif editmode>
					<p>Click continue below to edit the Franchises and Regions for this dealer.<p>
					<CFOUTPUT>
					<a href="myinfo_brands.cfm"><img src="#application.RELATIVE_PATH#/images/admin/continue.gif" border="0"></a>
					</cfoutput>
				<cfelse>
					(Once you have saved this new dealership, you will be able to edit the Franchises and Regions.)
				</cfif>
			</td>
		</tr>
	</cfif>
</cfif>
<!--- Make Logos --->
<tr>
	<td>
		<a name="makelogos"></a>
		<h4>Make Logos</h4>
	</td>
</tr>
<cfif g_col>
	<tr align="center">
		<td>
			Would you like to have Make logos on your Website?<br><br>
			<cfif editmode>
			<cfif #getmakelogo.makelogoYN# eq 'Y'>
			<input type="radio" value="Y" name="MakeLogoYN" CHECKED>Yes
			<input type="radio" value="N" name="MakeLogoYN">No
			<cfelseif #getmakelogo.makelogoYN# eq 'N'>
			<input type="radio" value="Y" name="MakeLogoYN">Yes
			<input type="radio" value="N" name="MakeLogoYN" CHECKED>No
			</cfif>
			</cfif>
			<cfif not editmode>
			<input type="radio" value="Y" name="MakeLogoYN">Yes
			<input type="radio" value="N" name="MakeLogoYN" CHECKED>No
			</cfif>
		</td>
	</tr>
</cfif>
	<tr align="center">
		<td>
			Would you like to have the Make logos link back to the manufacturer?<br><br>
			<cfif editmode>
			<cfif #getmakelogo.makelogolinkYN# eq 'Y'>
			<input type="radio" value="Y" name="MakeLogolinkYN" CHECKED>Yes
			<input type="radio" value="N" name="MakeLogolinkYN">No
			<cfelseif #getmakelogo.makelogolinkYN# eq 'N'>
			<input type="radio" value="Y" name="MakeLogolinkYN">Yes
			<input type="radio" value="N" name="MakeLogolinkYN" CHECKED>No
			</cfif>
			</cfif>
			<cfif not editmode>
			<input type="radio" value="Y" name="MakeLogolinkYN">Yes
			<input type="radio" value="N" name="MakeLogolinkYN" CHECKED>No
			</cfif>
		</td>
	</tr>
<tr align="center">		
	<td>
		<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/save.gif" BORDER="0" NAME="Save" VALUE="Save">
	</td>
</tr>
<!--- Web Addresses --->
<tr>
	<td>
		<a name="webaddress"></a>
		<h4>Web Addresses</h4>
	</td>
</tr>
<tr>
	<td align="center">
		<table border="0" cellpadding="5" cellspacing="0">
		<tr>
			<td align="right"><b>Web Address</b></td>
			<td>
				<cfif editmode>
					<cfif #getdealerinfo.url# is "">
						You currently have no Web address.
					<cfelse>
						<cfoutput query="getDealerInfo">
							#URL#
						</cfoutput>
					</cfif>
				<cfelse>
					You currently have no Web address.
				</cfif>
			</td>
		</tr>
		<tr>
			<td align="right"><b>Alternate Web Address</b></td>
			<td>
				<cfif editmode>
					<cfif #geturl2.url# is "">
						You currently have no alternate Web address.
					<cfelse>
						<cfoutput query="getURL2">
							#URL#
						</cfoutput>
					</cfif>
				<cfelse>
					You currently have no alternate Web address.
				</cfif>
			</td>
		</tr>
		<!--- Chris Wacker, 11/14/2000 12:42 PM --->
		<!--- <tr>
			<td align="right"><b>Third Web Address</b></td>
			<td>
				<cfif editmode>
					<cfif #geturl3.url# is "">
						You currently have no Third Web address.
					<cfelse>
						<cfoutput query="getURL3">
							#URL#
						</cfoutput>
					</cfif>
				<cfelse>
					You currently have no Third Web address.
				</cfif>
			</td>
		</tr> 
		<td align="right"><b>Fourth Web Address</b></td>
			<td>
				<cfif editmode>
					<cfif #geturl3.url# is "">
						You currently have no Fourth Web address.
					<cfelse>
						<cfoutput query="getURL4">
							#URL#
						</cfoutput>
					</cfif>
				<cfelse>
					You currently have no Fourth Web address.
				</cfif>
			</td>
		</tr>
		<td align="right"><b>Fifth Web Address</b></td>
			<td>
				<cfif editmode>
					<cfif #geturl3.url# is "">
						You currently have no Fifth Web address.
					<cfelse>
						<cfoutput query="getURL5">
							#URL#
						</cfoutput>
					</cfif>
				<cfelse>
					You currently have no Fifth Web address.
				</cfif>
			</td>
		</tr>
		<td align="right"><b>Sixth Web Address</b></td>
			<td>
				<cfif editmode>
					<cfif #geturl3.url# is "">
						You currently have no Sixth Web address.
					<cfelse>
						<cfoutput query="getURL6">
							#URL#
						</cfoutput>
					</cfif>
				<cfelse>
					You currently have no Sixth Web address.
				</cfif>
			</td>
		</tr>
		<td align="right"><b>Seventh Web Address</b></td>
			<td>
				<cfif editmode>
					<cfif #geturl3.url# is "">
						You currently have no Seventh Web address.
					<cfelse>
						<cfoutput query="getURL7">
							#URL#
						</cfoutput>
					</cfif>
				<cfelse>
					You currently have no Seventh Web address.
				</cfif>
			</td>
		</tr>
		<td align="right"><b>Eighth Web Address</b></td>
			<td>
				<cfif editmode>
					<cfif #geturl3.url# is "">
						You currently have no Eighth Web address.
					<cfelse>
						<cfoutput query="getURL8">
							#URL#
						</cfoutput>
					</cfif>
				<cfelse>
					You currently have no Eighth Web address.
				</cfif>
			</td>
		</tr>
		--->
		</table>
	</td>
</tr>
<cfif accesslevel eq application.sysadmin_access>
	<tr>
		<td align="center">
			<CFOUTPUT>
			<cfif editmode>
				<p>Click continue below to edit the Web addresses for this dealer.<p>
				<a href="myinfo_url.cfm"><img src="#application.RELATIVE_PATH#/images/admin/continue.gif" border="0"></a>
			<cfelse>
				(Once you have saved this new dealership, you will be able to edit the Web addresses.)
			</cfif>
			</cfoutput>
		</td>
	</tr>
</cfif>
<!--- Meta Tags --->
<tr>
	<td>
		<a name="metatags"></a>
		<h4>Meta Tags</h4>
	</td>
</tr>
<tr>
	<td align="CENTER">
	<table>
	<tr>
		<td align="RIGHT" valign="TOP"><b>Keywords</b></td>
		<td align="CENTER" valign="TOP">Enter up to 10 key words or phrases<br>
		(separated by commas) that people would<br>
		type in to search for your site.</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td align="CENTER">
			<textarea name="keyMeta" cols="30" rows="5" wrap="VIRTUAL"><cfif editmode><cfoutput><cfif #rtrim(getMetaTags.keyMeta)# is not "">#rtrim(getMetaTags.keyMeta)#</cfif></cfoutput><cfelse>Please enter your keywords here.</cfif></textarea>
		</td>
	</tr>
	<tr>
		<td align="RIGHT" valign="TOP"><b>Short Web Site<br>Description</b></td>
		<td align="CENTER" valign="TOP">Enter a one line description<br>of your Web site.</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td align="CENTER"><input type="text" name="shortMeta" value="<cfif editmode><cfoutput><cfif #getMetaTags.shortMeta# is not "">#getMetaTags.shortMeta#</cfif></cfoutput></cfif>" maxlength=70 size=25></td>
	</tr>
	<tr>
		<td align="RIGHT" valign="TOP"><b>Long Web Site<br>Description</b></td>
		<td align="CENTER" valign="TOP">Enter a two or three line description<br>of your Web site.</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td align="CENTER">
				<textarea name="longMeta" cols="30" rows="5" wrap="VIRTUAL"><cfif editmode><cfoutput><cfif #rtrim(getMetaTags.keyMeta)# is not "">#rtrim(getMetaTags.longMeta)#</cfif></cfoutput><cfelse>Please enter your keywords here.</cfif></textarea>
		</td>
	</tr>
	</table>
	</td>
<tr>
<tr>
	<td align="center">
		<br>
		<input type="Image" name="Save" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/save.gif" border="0">
		<br><br>
	</td>
</tr>
<!--- Web Activity State --->
<cfif accesslevel gt application.dealer_access>
	<!--- activity state is only available to account people --->
	<tr>
		<td>
			<a name="activity"></a>
			<h4>Activity State</h4>
		</td>
	</tr>
	<tr>
		<td align="center">	
			The Website will be visible when the Activity State is set to "Active."
		</td>
	</tr>
	<tr>
		<td align="center">
			<select name="WebState">
				<cfoutput query="getwebstates">
					<option value="#webstateid#" 
					<cfif editmode>
						<cfif #webstateid# eq #getdealerinfo.webstateid#>
							SELECTED
						</cfif>
					<!--- if adding a new one, default = Active --->
					<cfelseif #webstateid# eq 1>
						SELECTED
					</cfif>>#description#
				</cfoutput>
			</select>
		</td>
	</tr>
	<tr>
		<td align="center">
			<br>
			<input type="Image" name="Save" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/save.gif" border="0">
			<br><br>
		</td>
	</tr>
</cfif>
</table>
</form>
<cfmodule template="/util/DumpDebug.cfm" text="end   $RCSfile: myinfo_main.cfm,v $">
