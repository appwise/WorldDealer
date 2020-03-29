<cfset webnewstep = 1>
<cfinclude template="security.cfm">

<!doctype html public "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
    <!-- ----------------------------------------------------------- -->
    <!--               Created by sigma6, Detroit                    -->
    <!--         Copyright (c) 1997, 1998, 1999 sigma6.              -->
    <!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->

    <!-- ----------------------------------------------------------- -->
    <!--     Tim Taylor for sigma6, interactive media, Detroit       -->
    <!--    ttaylor@sigma6.com   www.sigma6.com    www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
	<!--- $Id: webnew.cfm,v 1.14 2000/01/10 15:29:44 lswanson Exp $ --->
	<!--- Dealership info: name, address, contact, phone, tag line, display name --->

<HEAD>
		<title>WorldDealer | Create a New web</title>
		<!--- so the background doesn't repeat --->
		<link rel=stylesheet href="admin.css" type="text/css">


<!--- Cancel --->
<cfif isdefined("Form.btnCancel.X")>
	<cfif form.dealercode EQ ''>
		<cflocation url="webfind.cfm">
	<cfelse>      
		<cflocation url="webvrfy.cfm?dlrcode=#Form.DealerCode#">
	</cfif>
</cfif>
		
<cfset newmode = false>
<cfset editmode = false>
<cfset savemode = false>

<cfif parameterexists(url.dlrcode)>
	<cfset editmode = true>
	<cfset g_dealercode = url.dlrcode>
<cfelse>
	<cfset newmode = true>
</cfif>

<cfset MaxMakes = 10>

<!--- JOEL:	If URL.Field and URL.MakeNo, we're going to update the database and set the mode to editmode.
			We're going to copy some code from below so that we have the same code copied all over this page. --->
<cfif IsDefined("URL.Field")>
	<!--- get snapshot of existing Makes & Regions --->
	<cfquery name="getDlrMakesRegions" datasource="#gDSN#">
		SELECT 	RowID,
				MakeNumber,
				RegionID
		FROM 	DealerFranchise
		WHERE 	DealerFranchise.DF_Number = #Val(Mid(g_DealerCode,11,3))#
		ORDER BY DealerFranchise.RowID
	</cfquery>
	
	<cfset addNewMake = 0>
	
	<!--- for each of the existing Makes/Regions, compare against newly entered Make/Region --->
	<cfset count = 1>
	<cfloop query="getDlrMakesRegions">
		<!--- if there's no new make # in that spot (1-10), delete existing one. --->
		<cfif count EQ #URL.Count#>
			<cfif #Evaluate("URL.MakeNo")# EQ "">
				<cfquery name="deleteDealerFranchise" datasource="#gDSN#">
					DELETE FROM	
							DealerFranchise
					WHERE	RowID = #RowID#
				</cfquery>
				<cfset addNewMake = 1>
			<cfelseif #Evaluate("URL.MakeNo")# NEQ #MakeNumber#>
				<!--- Update existing Makes & Regions with new ones. --->
				<cfquery name="updateDealerFranchise" datasource="#gDSN#">
					UPDATE	DealerFranchise
					SET		MakeNumber = #Evaluate("URL.MakeNo")#,
							RegionID = 0
					WHERE	RowID = #RowID#
				</cfquery>			
				<cfset addNewMake = 1>
			</cfif>
			<cfbreak>
		</cfif>
		
		<cfset count = count + 1>
	</cfloop>
	
	<!--- now insert any New entries --->
	<cfif addNewMake EQ 0>
		<cfquery name="insertDealerFranchise" datasource="#gDSN#">
			INSERT INTO DealerFranchise(
					DF_Number,
					MakeNumber,
					RegionID)
			VALUES	(#Val(Mid(g_DealerCode,11,3))#,
					#Evaluate("URL.MakeNo")#,
					0)
		</cfquery>
	</cfif>
	<cfset editmode = true>
</cfif>
<!--- JOEL:  Here ends the tomfoolery --->

<cfif isdefined("FromTemplate")>
	<!--- if genexe_redirect was redirected back here, then we need to generate maps also --->
	<cfif fromtemplate EQ "genexe_redirect">
	
		<!--- generate maps then go to step 1 verification --->
		<cfmodule template="genmap.cfm"
				windowtitle="Dealer Administration, Create Maps"
				screentitle="Dealer Administration - Create New Web"
				nextstep="#g_relpath#/templates/admin/dlr/webvrfy.cfm?dlrcode=#g_dealercode#"
				dealercode="#g_dealerCode#">
		<cfabort>
	</cfif>
</cfif>
	        
<cfif isdefined("Form.btnSave.X")>
	<cfset savemode = true>
	<cfset g_dealercode = form.dealercode>
</cfif>

<cfif editmode>
	<!--- user is coming at this page with a dealer already selected --->
	<cfquery name="getDealerInfo" datasource="#gDSN#">
	SELECT *
	FROM Dealers
	WHERE Dealers.DealerCode = '#g_DealerCode#'
	</cfquery>

	<!--- Dealer Makes Query used in drop down list below --->
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
		WHERE 	DealerFranchise.DF_Number = #Mid(g_DealerCode,11,3)#
		ORDER BY DealerFranchise.RowID
	</cfquery>
</cfif>

<cfif savemode>
	<!--- format phone numbers --->
	<cfset save_phone = #form.phone1# & #form.phone2# & #form.phone3#>
	<cfset save_secondphone = #form.secondphone1# & #form.secondphone2# & #form.secondphone3#>
	<cfset save_faxphone = #form.faxphone1# & #form.faxphone2# & #form.faxphone3#>
	<cfset save_quotefax = #form.quotefax1# & #form.quotefax2# & #form.quotefax3#>
	<cfset save_financefax = #form.financefax1# & #form.financefax2# & #form.financefax3#>
	<!--- If it's not a collection, set Service and Parts fax numbers --->
	<CFIF Mid(g_DealerCode, 6,4) NEQ '0000'>
		<cfset save_servicefax = #form.servicefax1# & #form.servicefax2# & #form.servicefax3#>
		<cfset save_partsfax = #form.partsfax1# & #form.partsfax2# & #form.partsfax3#>
	</CFIF>
	<cfset save_contactphone = #form.contactphone1# & #form.contactphone2# & #form.contactphone3#>
	
	<cfif g_dealercode EQ "">
		<cfset r_dlrcode = 'new'>
	<cfelse>
		<cfset r_dlrcode = #g_dealercode#>
	</cfif>

	<!--- if dealercode is changed, check to see if the new dealercode is taken yet. --->		
	<cfif form.newdealercode NEQ g_dealercode>
		<!--- Check if this DealerCode is available (not in Dealers Table) --->
		<cfquery name="CheckDLRCode" datasource="#gDSN#">
			SELECT	DealerCode
			FROM 	Dealers
			WHERE 	DealerCode = '#Form.newDealerCode#';
		</cfquery>

		<cfif (CheckDLRCode.recordcount NEQ 0)>
			<cflocation url="unavailable.cfm?dlrcode=#r_dlrcode#&dlrcodein=#Form.newDealerCode#">
		</cfif>
	</cfif>
		
	<cfif g_dealercode EQ "">
		<!--- New Dealer --->
		<!--- insert the new dealership.  Use a web state of '5', which means 'In Progress' --->
		<cfquery name="insertDLR" datasource="#gDSN#">
		INSERT INTO Dealers (
			DealerCode,
			WebStateID,
			DealershipName,
			AddressLine1,
			AddressLine2,
			City,
			StateAbbr,
			Zip,
			Phone,
			secondPhone,
			FaxPhone,
			QuoteFax,
			FinanceFax,
			ServiceFax,
			PartsFax,
			ContactName,
			ContactPhone,
			TagLine,
			DisplayName
			)
		VALUES (
			'#Form.newDealerCode#',
			5,
			'#Form.DealershipName#',
			'#Form.Address1#',
			'#Form.Address2#',
			'#Form.City#',
			'#Form.StateAbbr#',
			'#Form.Zip#',
			'#save_Phone#',
			'#save_secondPhone#',
			'#save_FaxPhone#',
			'#save_QuoteFax#',
			'#save_FinanceFax#',
			'#save_ServiceFax#',
			'#save_PartsFax#',
			'#Form.ContactName#',
			'#save_ContactPhone#',
			'#Form.TagLine#',
			'#Form.DisplayName#'
			)
		</cfquery>
		
		<!--- redirect to verify screen --->
		<cflocation url="#g_relpath#/templates/admin/dlr/webvrfy.cfm?dlrcode=#Form.newDealerCode#">
	<cfelse>
		<!--- Query DB To see if DisplayName or Address has changed (for Imagegen) --->
		<!--- Leave this query before updateDLR, because it has to get a snapshot of previous info before updating. --->
		<cfquery name="GetInfo" datasource="#gDSN#">
			SELECT	DisplayName,
					AddressLine1,
					AddressLine2,
					City,
					StateAbbr,
					Zip
			FROM 	Dealers
			WHERE 	DealerCode = '#g_dealercode#';
		</cfquery>
				
		<!--- update existing dealership info --->
		<cfquery name="updateDLR" datasource="#gDSN#">
			UPDATE Dealers
			SET	DealershipName = '#Form.DealershipName#',
				AddressLine1 = '#Form.Address1#',
				AddressLine2 = '#Form.Address2#',
				City = '#Form.City#',
				StateAbbr = '#Form.StateAbbr#',
				Zip = '#Form.Zip#',
				Phone = '#save_Phone#',
				secondPhone = '#save_secondPhone#',
				FaxPhone = '#save_FaxPhone#',
				QuoteFax = '#save_QuoteFax#',
				FinanceFax = '#save_FinanceFax#',
				<!--- If it's not a collection, update Service and Parts fax numbers --->
				<CFIF Mid(g_DealerCode, 6,4) NEQ '0000'>
					ServiceFax = '#save_ServiceFax#',
					PartsFax = '#save_PartsFax#',
				</CFIF>
				ContactName = '#Form.ContactName#',
				ContactPhone = '#save_contactphone#',
				TagLine='#Form.Tagline#',
				DisplayName = '#Form.DisplayName#'
			WHERE Dealers.DealerCode = '#g_DealerCode#'
		</cfquery>      

		<!--- Check if this dealer is in DealerWebs yet --->
		<cfquery name="CheckDealerWebs" datasource="#gDSN#">
			SELECT 	Dealercode
			FROM 	DealerWebs
			WHERE 	DealerCode = '#g_DealerCode#';  
		</cfquery>
		
		<!--- dealership doesn't have access to change dealercode, make or region, so skip this portion for dealers --->
		<CFIF #LEFT(ACCESSLEVEL,1)# GT application.DEALER_ACCESS>
			<!--- If it's a dealership (not a collection), update the DealerFranchise table --->
			<cfif #mid(g_dealercode, 6, 4)# NEQ "0000">
				<!--- get snapshot of existing Makes & Regions --->
				<cfquery name="getDlrMakesRegions" datasource="#gDSN#">
					SELECT 	RowID,
							MakeNumber,
							RegionID
					FROM 	DealerFranchise
					WHERE 	DealerFranchise.DF_Number = #Val(Mid(g_DealerCode,11,3))#
					ORDER BY DealerFranchise.RowID
				</cfquery>
			
				<!--- for each of the existing Makes/Regions, compare against newly entered Make/Region --->
				<cfset count = 1>
				<cfloop query="getDlrMakesRegions">
					<!--- if there's no new make # in that spot (1-10), delete existing one. --->
					<cfif #Evaluate("Form.selDealerMake#count#")# EQ "">
						<cfquery name="deleteDealerFranchise" datasource="#gDSN#">
							DELETE FROM	
									DealerFranchise
							WHERE	RowID = #RowID#					
						</cfquery>
					<cfelse>
						<!--- Update existing Makes & Regions with new ones. --->
						<cfif (#MakeNumber# NEQ #Evaluate("Form.selDealerMake#count#")#)
							OR (#RegionID# NEQ #Evaluate("Form.selDealerRegion#count#")#)>
							<CFQUERY NAME="updateDealerFranchise" datasource="#gDSN#">
								UPDATE	DealerFranchise
								SET		MakeNumber = #Evaluate("Form.selDealerMake#count#")#,
										RegionID = <cfif #Evaluate("Form.selDealerRegion#count#")# GT 0>#Evaluate("Form.selDealerRegion#count#")#<cfelse>0</cfif>
								WHERE	RowID = #RowID#
							</CFQUERY>			
						</cfif>
					</cfif>	
					<cfset count = count + 1>
				</cfloop>
			
				<!--- now loop through the rest of the New Makes/Regions, & insert any New entries --->
				<cfloop index="count" from="#count#" to="#maxMakes#">
					<cfif #Evaluate("Form.selDealerMake#count#")# GT "">
						<cfquery name="insertDealerFranchise" datasource="#gDSN#">
							INSERT INTO DealerFranchise(
									DF_Number,
									MakeNumber,
									RegionID)
							VALUES	(#Val(Mid(g_DealerCode,11,3))#,
									#Evaluate("Form.selDealerMake#count#")#,
									<cfif #Evaluate("Form.selDealerRegion#count#")# GT 0>#Evaluate("Form.selDealerRegion#count#")#<cfelse>0</cfif>)
						</cfquery>
					</CFIF>
				</cfloop>
			</cfif>

			<!--- Check if the Dealercode was changed.  If so, we need to update it. --->
			<cfif trim(#g_dealercode#) NEQ trim(#form.newdealercode#)>
				<cfif #checkdealerwebs.recordcount# EQ 0>
					<!--- If this dealer is not yet in dealerwebs, go ahead and update the dealercode ---> 
					<cfquery name="updateDealers" datasource="#gDSN#">
						UPDATE Dealers
						SET DealerCode = '#Form.newDealerCode#'
						WHERE DealerCode = '#g_DealerCode#';
					</cfquery>						
				<cfelse>
					<!--- This dealer is already in Dealerwebs --->
					<!--- Drop the FOREIGN KEY on Dealerwebs.Dealercode --->
					<cfquery name="DropKey" datasource="#gDSN#" username="sa" password="">
						ALTER TABLE DealerWebs
						DROP CONSTRAINT FK_DealerWebs_1__11;
					</cfquery>
	
					<!--- Update the DealerCode in Dealers --->
					<cfquery name="updDealers" datasource="#gDSN#">
						UPDATE Dealers
						SET DealerCode = '#Form.newDealerCode#'
						WHERE DealerCode = '#g_Dealercode#';
					</cfquery>
	
					<!--- Update the Dealercode in DealerWebs --->
					<cfquery name="UpdDealerwebs" datasource="#gDSN#">
						UPDATE DealerWebs
						SET DealerCode = '#Form.newDealerCode#'
						WHERE DealerCode = '#g_DealerCode#';
					</cfquery>
	
					<!--- Restore the Foreign Key --->
					<cfquery name="AddF_Key" datasource="#gDSN#" username="sa" password="">
						ALTER TABLE Dealerwebs
						ADD CONSTRAINT  FK_DealerWebs_1__11 FOREIGN KEY (DealerCode) REFERENCES Dealers(Dealercode);
					</cfquery>
				</cfif>
							
				<!--- Update all images with new DealerCode --->
				<!--- banner images --->
				<cfx_directorylist directory="#g_rootdir#\images\banner"
					name="banner_query"
					sort="type ASC, name ASC">
	
				<cfloop query="banner_query">
					<cfset match = #find(g_dealercode, name, 1)#>
					<cfif #match# EQ 1> <!--- This file starts with g_Dealercode --->
						<cfset new_name = #replace(name, g_dealercode, form.newdealercode)#>
						<cffile action="rename"
								source="#g_rootdir#\images\banner\#name#"
								destination="#g_rootdir#\images\banner\#new_name#">
					</cfif>
				</cfloop>
							
				<!--- coupon images --->
				<cfx_directorylist directory="#g_rootdir#\images\coupons"
						name="coupon_query"
						sort="type ASC, name ASC">

				<cfloop query="coupon_query">
					<cfset match = #find(g_dealercode, name, 1)#>
					<cfif #match# EQ 1> <!--- This file starts with g_Dealercode --->
						<cfset new_name = #replace(name, g_dealercode, form.newdealercode)#>
						<cffile action="rename"
								source="#g_rootdir#\images\coupons\#name#"
								destination="#g_rootdir#\images\coupons\#new_name#">
					</cfif>
				</cfloop>
	
				<!--- leftnav logo images --->
				<cfx_directorylist directory="#g_rootdir#\images\logo"
					name="logo_query"
					sort="type ASC, name ASC">
			
				<cfloop query="logo_query">
					<cfset match = #find(g_dealercode, name, 1)#>
					<cfif #match# EQ 1> <!--- This file starts with g_Dealercode --->
						<cfset new_name = #replace(name, g_dealercode, form.newdealercode)#>
						<cffile action="rename"
								source="#g_rootdir#\images\logo\#name#"
								destination="#g_rootdir#\images\logo\#new_name#">
					</cfif>
				</cfloop>
								
				<!--- map images --->
				<cfx_directorylist directory="#g_rootdir#\images\maps"
					name="maps_query"
					sort="type ASC, name ASC">

				<cfloop query="maps_query">
					<cfset match = #find(g_dealercode, name, 1)#>
					<cfif #match# EQ 1> <!--- This file starts with g_Dealercode --->
						<cfset new_name = #replace(name, g_dealercode, form.newdealercode)#>
						<cffile action="rename"
								source="#g_rootdir#\images\maps\#name#"
								destination="#g_rootdir#\images\maps\#new_name#">
					</cfif>
				</cfloop>
	
				<!--- splash page logo images --->
				<cfx_directorylist directory="#g_rootdir#\images\sp_logo"
					name="sp_logo_query"
					sort="type ASC, name ASC">
			
				<cfloop query="sp_logo_query">
					<cfset match = #find(g_dealercode, name, 1)#>
					<cfif #match# EQ 4> <!--- This file starts with "sp_<g_Dealercode>" --->
						<cfset new_name = #replace(name, g_dealercode, form.newdealercode)#>
						<cffile action="rename"
							source="#g_rootDir#\images\sp_logo\#name#"
							destination="#g_rootdir#\images\sp_logo\#new_name#">
					</cfif>
				</cfloop>
							
				<cfset g_dealercode = #form.newdealercode#>								
			</cfif>
		</cfif>
            
		<!--- Call Java Image Generator to Create Custom Graphics  --->
		<cfset ismodifiedname = false>
		<cfset ismodifiedaddress = false>
		<cfif checkdealerwebs.recordcount NEQ 0>
			<cfif getinfo.displayname NEQ form.displayname>
				<cfset ismodifiedname = true>
			</cfif>
			<cfif (getinfo.addressline1 NEQ form.address1)
					or (getinfo.addressline2 NEQ form.address2)
					or (getinfo.city NEQ form.city)
					or (getinfo.stateabbr NEQ form.stateabbr)
					or (getinfo.zip NEQ form.zip)>
				<cfset ismodifiedaddress = true>
			</cfif>
		</cfif>
		
		<cfif ismodifiedname and ismodifiedaddress>
		
			<!--- generate logos then redirect back to generate maps --->
			<cfmodule template="genexe.cfm"
					windowtitle="Dealer Administration, Create Logos"
					screentitle="Dealer Administration - Create New Web"
					nextstep="#g_relpath#/templates/admin/dlr/webnew.cfm?dlrcode=#g_dealercode#"
					uniqueid="#g_DealerCode#"
					displayname="#Form.displayName#">
			<cfabort>
		<cfelseif ismodifiedname or ismodifiedaddress>
			<cfif ismodifiedname>
	
				<!--- generage logos then go to step 1 verification --->
				<cfmodule template="genexe.cfm"
						windowtitle="Dealer Administration, Create Logos"
						screentitle="Dealer Administration - Create New Web"
						nextstep="#g_relpath#/templates/admin/dlr/webvrfy.cfm?dlrcode=#g_dealercode#"
						uniqueid="#g_DealerCode#"
						displayname="#Form.displayName#">
			<cfelse>
		
				<!--- generate maps then go to step 1 verification --->
				<cfmodule template="genmap.cfm"
						windowtitle="Dealer Administration, Create Maps"
						screentitle="Dealer Administration - Create New Web"
						nextstep="#g_relpath#/templates/admin/dlr/webvrfy.cfm?dlrcode=#g_dealercode#"
						dealercode="#g_dealerCode#">
			</cfif>
			<cfabort>
		<cfelse>
			<cflocation url="webvrfy.cfm?dlrcode=#g_dealercode#">
		</cfif>
	</cfif>
</cfif>
        
<cfif newmode OR editmode>
	<cfquery name="getMakes" datasource="#gDSN#">
		SELECT MakeNumber, MakeName
		FROM Makes
		ORDER BY MakeName
	</cfquery>

	<cfquery name="getStates" datasource="#gDSN#">
		SELECT	StateAbbr, 
				Description
		FROM 	States
		ORDER BY Description
	</cfquery>
	
	<!--- a little script that goes with the onChange attribute of selected Make in drop-down. --->	
	<!--- Linda, 12/30/99: can't figure out how to identify the element that they selected a make from.
	Since the Select boxes are defined in a loop, they use variables.  element[0] is the 1st element.
	So it would seem like element [0] is dealercode and element[1] would be the 1st make drop-down, 
	which would be convenient, cuz that's the same as the looping's count.
	<SCRIPT LANGUAGE="JavaScript">
	<!--
	function onMakeChange(count)
		{
		alert("drop-down box number = " + count);
		
		with(document.StepOne.elements[count])
			selectedMake = options[selectedIndex].value

		alert("make number = " + selectedMake);

		if (selectedMake > 0)
			location.href = 'webnew.cfm?dlrcode=#g_dealercode#&MakeNumber=' + selectedMake;			
		else 
			// this sets it back to the default.
			location.href = 'webnew.cfm?dlrcode=#g_dealercode#';
		}
	//-->
	</SCRIPT> --->
	
	<SCRIPT LANGUAGE="JavaScript">
	<!--
	function onMakeChange(field,value,count){
		
		location.href = 'webnew.cfm?dlrcode=<cfoutput>#g_dealercode#</cfoutput>&Field=' + field + '&MakeNo=' + value + '&Count=' + count;			
		
	}
	//-->
	</SCRIPT>
	
</cfif>

</head>

<body>
<cfif newmode OR editmode>
	<cfoutput>
	<br><br><br><br><br>
	<div align="center">
	<table cellpadding=0 cellspacing=0 border=0 width=600 bgcolor="FFFFFF">
	<tr>
		<td>&nbsp;<p></td>
	</tr>
	<tr align="center">
		<td align="middle">
			<h3>Maintain Your Web Site</h3>
			<br>
			<h4>Update Dealership Information</h4>
		</td>
	</tr>
	<tr align="center">
		<td align="middle">
			Update your dealership information below.  Required fields are listed in <b>bold</b>.
		</td>
	</tr>
	<tr>
		<td>&nbsp;<p></td>
	</tr>
	<tr>
		<td>
			<form name="StepOne" action="webnew.cfm" method="post">
			<table cellspacing=0 cellpadding=0 border=0 width="100%">
			<tr>
				<td align="right"><b>Dealer Code</b></td>
				<td>&nbsp;&nbsp;&nbsp;</td>
				<!--- <CFIF #LEFT(ACCESSLEVEL,1)# GT application.DEALER_ACCESS> --->
				<!--- 8/23/99: only allow AA's to change dealercode. --->
				<cfif #left(accesslevel,1)# EQ application.sysadmin_access>
					<td>
						<input type="text" name="newDealerCode" size=30 MAXLENGTH=40 <cfif editmode>value="#getDealerInfo.DealerCode#"</CFIF>>
						<input type="hidden" name="newDealerCode_required" value="Please enter a dealer code for this dealership.">
					</td>
				<cfelse>
					<td>
						#getDealerInfo.DealerCode#
						<input type="hidden" name="newDealerCode" value="#getDealerInfo.DealerCode#">
					</td>
				</cfif>
			</tr>
			<cfif #mid(g_dealercode, 6, 4)# NEQ "0000">
				<tr>
					<!--- This will be displayed for Dealers Add/Update ---> 		
					<td align="right" valign="top">
						<b>Make and Region</b>
					</td>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td>
						<table border="0" cellpadding="0" cellspacing="5">
						<!--- 11/19/99: per Messner, don't allow dealers to change Dealer Make. --->
						<CFIF #LEFT(ACCESSLEVEL,1)# EQ application.DEALER_ACCESS>
							<cfloop query="getDealerMakes">
							<tr>
								<td>
									#MakeName#
								</td>
								<td>
									#RegionName#
								</td>
							</tr>
							</cfloop>
						<CFELSE>
							<!--- If this is a dealer add, Display the entire list with none selected ---> 		
							<!--- If this is a dealer update, display entire list with DealerMakes selected --->
							<cfif editmode>
								<!--- initialize all the Make & Region variables 1-10 --->
								<cfloop index="count" from="1" to="#MaxMakes#">
									<cfset whatever = SetVariable("DealerMake#count#", 0)>
									<cfset dummyvar = SetVariable("DealerRegion#count#", 0)>
								</cfloop>

								<!--- Populate the Make & Region variables --->
								<cfset count = 0>
								<cfloop query="getDealerMakes">
									<cfset count = count + 1>
									<cfset whatever = SetVariable("DealerMake#count#", #makenumber#)>
									<cfset dummyvar = SetVariable("DealerRegion#count#", #RegionID#)>
								</cfloop>
							</cfif>
							<cfloop index="count" from="1" to="#MaxMakes#">
								<tr>
								<!--- Linda, 12/30/99: can't figure out how to identify the element that they selected a make from.
								Since the Select boxes are defined in a loop, they use variables.  element[0] is the 1st element.
								So it would seem like element [0] is dealercode and element[1] would be the 1st make drop-down, 
								which would be convenient, cuz that's the same as the looping's count. --->
 									<td>
									<cfset selDealerMake = "selDealerMake" & #count#>
									<select name="#selDealerMake#" onChange="onMakeChange('#selDealerMake#',#selDealerMake#.options[selectedIndex].value,#count#)">
										<option value="">Select Make #count#
										<cfloop query="getMakes">
											<option value=#makenumber# 
											<cfif editmode>
												<cfif IsDefined("URL.MakeNumber")>
													<cfif #getmakes.makenumber# EQ #URL.MakeNumber#>
														SELECTED
													</cfif>
												<cfelseif #getmakes.makenumber# EQ #Evaluate("DealerMake#count#")#>
													SELECTED
												</cfif>
											</cfif>
											>#makename#
										</cfloop>
									</select>
									</td>
									<td>
										<cfset selDealerRegion = "selDealerRegion" & #count#>
										
										<select name="#selDealerRegion#">
											<cfif editmode>
												<!--- if a Make is selected, find corresp Regions --->												
												<cfif #Evaluate("DealerMake#count#")#>
													<cfquery name="getRegions" datasource="#gDSN#">
														SELECT	RegionID,
																RegionName
														FROM	MakeRegions
														WHERE	MakeNumber = <cfif IsDefined("URL.MakeNumber")>#URL.MakeNumber#<cfelse>#Evaluate("DealerMake#count#")#</cfif>
														ORDER BY RegionName
													</cfquery>
													<cfif #getRegions.RecordCount# EQ 0>
														<option value="">No Regions Available
													<cfelse>
														<option value="">Select Region #count#
														<cfloop query="getRegions">
															<option value=#RegionID# <cfif editmode><cfif #getRegions.RegionID# EQ #Evaluate("DealerRegion#count#")#>SELECTED</cfif></cfif>>#RegionName#
														</cfloop>
													</cfif>
												<cfelse>
													<option value="">Select Make First
												</cfif>
											<cfelse>
												<option value="">Select Make First
											</cfif>
										</select>
										
									</td>
								</tr>
							</cfloop>
							<input type="hidden" name="selDealerMake1_required" value="Please select a Make."> 					
						</CFIF>
						</table>
					</td>
				</tr>
				</cfif>
				</cfoutput>
				<tr>
					<td align="right"><b>Dealership Name</b></td>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<input type="hidden" name="dealershipname_required" value="Please enter a name for this Dealership.">
					<td><input type="text" name="dealershipname" size=35 maxlength=50 <cfif editmode>value="<CFOUTPUT>#getDealerInfo.DealershipName#</cfoutput>"</cfif>></td>
				</tr>
				<tr>
					<td align="right"><b>Address 1</b></td>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<input type="hidden" name="Address1_required" value="Please enter an address for this dealership.">
					<td><input type="text" name="Address1" size=40 maxlength=40 <cfif editmode>value="<cfoutput>#getDealerInfo.AddressLine1#</cfoutput>"</cfif>></td>
				</tr>
				<tr>
					<td align="right">Address 2</td>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><input type="text" name="Address2" size=40 maxlength=40 <cfif editmode>value="<cfoutput>#getDealerInfo.AddressLine2#</cfoutput>"</cfif>></td>
				</tr>
				<tr>
					<td align="right"><b>City</b></td>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<input type="hidden" name="City_required" value="Please enter a city for this dealership.">
					<td><input type="text" name="City" size=35  maxlength=35 <cfif editmode>value="<cfoutput>#getDealerInfo.City#</cfoutput>"</cfif>></td>
				</tr>
				<tr>
					<td align="right"><b>State</b></td>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<input type="hidden" name="StateAbbr_required"  value="Please select the state where this Dealership is located.">
					<td>
						<select name="StateAbbr">
						<cfoutput query="getStates">
						<option value="#stateAbbr#"<cfif editmode><cfif #getdealerinfo.stateabbr# EQ #stateabbr#> SELECTED</cfif></cfif>>#Description#</option>
						</cfoutput>                   
						</select>
					</td>
				</tr>
				<tr>
					<td align="right"><b>Zip Code</b></td>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<input type="hidden" name="Zip_required" value="Please enter a valid USPS Zip Code for this Dealership.">
					<td>
						<cfoutput>
						<input type="text" name="Zip" size=10 maxlength=10 <cfif editmode>value="#getDealerInfo.Zip#"</cfif>>
						</cfoutput>
						&nbsp;<b>XXXXX</b> or <b>XXXXX-XXXX</b>
					</td>
				</tr>
				<tr>
					<td align="right"><b>Dealership Phone</b></td>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<input type="hidden" name="Phone1_required" value="Please enter a valid Phone Area Code.">
					<input type="hidden" name="Phone2_required" value="Please enter a valid Phone Number.">
					<input type="hidden" name="Phone3_required" value="Please enter a valid Phone Number.">
					<td>
						<!--- linda, 10/20/99: optimized redundant code, show all data they've typed in, even if it's < 10 digit number --->					
						<!--- 10/21/99: had to add Trim() to the 1st field of phone & fax #s, cuz UPDATE inserts 1 space, instead of just leaving it blank.
						& then when you go to edit it, your cursor is at position 2 & you can only enter 2 of the 3 digits of the area code.
						(unless you realize what's going on & delete the leading space 1st.  ugh.) --->
						<cfoutput>
						<input type="text" name="Phone1" size=3 maxlength=3 <cfif editmode><cfif #len(getdealerinfo.Phone)# GT 0>value="#Trim(Left(getDealerInfo.Phone,3))#"</cfif></cfif>>
						<input type="text" name="Phone2" size=3 maxlength=3 <cfif editmode><cfif #len(getdealerinfo.Phone)# GT 3>value="#Mid(getDealerInfo.Phone,4,3)#"</cfif></cfif>>
						<input type="text" name="Phone3" size=4 maxlength=4 <cfif editmode><cfif #len(getdealerinfo.Phone)# GT 6>value="#Mid(getDealerInfo.Phone,7,4)#"</cfif></cfif>>
						<cfif editmode><input type="hidden" name="Phone" value="#getDealerInfo.Phone#"></cfif>
						</cfoutput>
					</td>
				</tr>
			    <tr>
				<tr>
					<td align="right">2nd Dealership Phone</td>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td>
						<!--- linda, 10/20/99: optimized redundant code, show all data they've typed in, even if it's < 10 digit number --->					
						<cfoutput>
						<input type="text" name="secondPhone1" size=3 maxlength=3 <cfif editmode><cfif #len(getdealerinfo.secondPhone)# GT 0>value="#Trim(Left(getDealerInfo.secondPhone,3))#"</cfif></cfif>>
						<input type="text" name="secondPhone2" size=3 maxlength=3 <cfif editmode><cfif #len(getdealerinfo.secondPhone)# GT 3>value="#Mid(getDealerInfo.secondPhone,4,3)#"</cfif></cfif>>
						<input type="text" name="secondPhone3" size=4 maxlength=4 <cfif editmode><cfif #len(getdealerinfo.secondPhone)# GT 6>value="#Mid(getDealerInfo.secondPhone,7,4)#"</cfif></cfif>>
						<cfif editmode><input type="hidden" name="secondPhone" value="#getDealerInfo.secondPhone#"></cfif>
						</cfoutput>
					</td>
				</tr>
			    <tr>
					<td align="right">Fax Number</td>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<!--- Linda, 1/10/99: make fax # optional.
					<input type="hidden" name="FaxPhone1_required" value="Please enter a valid Fax Area Code.">
					<input type="hidden" name="FaxPhone2_required" value="Please enter a valid Fax Number.">
					<input type="hidden" name="FaxPhone3_required" value="Please enter a valid Fax Number.">
					 --->
					 <td>
						<!--- linda, 10/20/99: optimized redundant code, show all data they've typed in, even if it's < 10 digit number --->					
						<cfoutput>
						<input type="text" name="FaxPhone1" size=3 maxlength=3 <cfif editmode><cfif #len(getdealerinfo.FaxPhone)# GT 0>value="#Trim(Left(getDealerInfo.FaxPhone,3))#"</cfif></cfif>>
						<input type="text" name="FaxPhone2" size=3 maxlength=3 <cfif editmode><cfif #len(getdealerinfo.FaxPhone)# GT 3>value="#Mid(getDealerInfo.FaxPhone,4,3)#"</cfif></cfif>>
						<input type="text" name="FaxPhone3" size=4 maxlength=4 <cfif editmode><cfif #len(getdealerinfo.FaxPhone)# GT 6>value="#Mid(getDealerInfo.FaxPhone,7,4)#"</cfif></cfif>>
						<cfif editmode><input type="hidden" name="FaxPhone" value="#getDealerInfo.FaxPhone#"></cfif>
						</cfoutput>
					</td>
				</tr>
			    <tr>
					<td align="right">Quote Fax Number</td>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td>
						<!--- linda, 10/20/99: optimized redundant code, show all data they've typed in, even if it's < 10 digit number --->					
						<cfoutput>
						<input type="text" name="QuoteFax1" size=3 maxlength=3 <cfif editmode><cfif #len(getdealerinfo.QuoteFax)# GT 0>value="#Trim(Left(getDealerInfo.QuoteFax,3))#"</cfif></cfif>>
						<input type="text" name="QuoteFax2" size=3 maxlength=3 <cfif editmode><cfif #len(getdealerinfo.QuoteFax)# GT 3>value="#Mid(getDealerInfo.QuoteFax,4,3)#"</cfif></cfif>>
						<input type="text" name="QuoteFax3" size=4 maxlength=4 <cfif editmode><cfif #len(getdealerinfo.QuoteFax)# GT 6>value="#Mid(getDealerInfo.QuoteFax,7,4)#"</cfif></cfif>>
						<cfif editmode><input type="hidden" name="QuoteFax" value="#getDealerInfo.QuoteFax#"></cfif>
						</cfoutput>
					</td>
				</tr>
			    <tr>
					<td align="right">Finance Fax Number</td>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td>
						<!--- linda, 10/20/99: optimized redundant code, show all data they've typed in, even if it's < 10 digit number --->					
						<cfoutput>
						<input type="text" name="FinanceFax1" size=3 maxlength=3 <cfif editmode><cfif #len(getdealerinfo.FinanceFax)# GT 0>value="#Trim(Left(getDealerInfo.FinanceFax,3))#"</cfif></cfif>>
						<input type="text" name="FinanceFax2" size=3 maxlength=3 <cfif editmode><cfif #len(getdealerinfo.FinanceFax)# GT 3>value="#Mid(getDealerInfo.FinanceFax,4,3)#"</cfif></cfif>>
						<input type="text" name="FinanceFax3" size=4 maxlength=4 <cfif editmode><cfif #len(getdealerinfo.FinanceFax)# GT 6>value="#Mid(getDealerInfo.FinanceFax,7,4)#"</cfif></cfif>>
						<cfif editmode><input type="hidden" name="FinanceFax" value="#getDealerInfo.FinanceFax#"></cfif>
						</cfoutput>
					</td>
				</tr>
				<!--- If it's not a collection, show Service and Parts fax numbers --->
				<CFIF Mid(g_DealerCode, 6,4) NEQ '0000'>
 			    <tr>
					<td align="right">Service Fax Number</td>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td>
						<!--- linda, 10/20/99: optimized redundant code, show all data they've typed in, even if it's < 10 digit number --->					
						<cfoutput>
						<input type="text" name="ServiceFax1" size=3 maxlength=3 <cfif editmode><cfif #len(getdealerinfo.servicefax)# GT 0>value="#Trim(Left(getDealerInfo.ServiceFax,3))#"</cfif></cfif>>
						<input type="text" name="ServiceFax2" size=3 maxlength=3 <cfif editmode><cfif #len(getdealerinfo.servicefax)# GT 3>value="#Mid(getDealerInfo.ServiceFax,4,3)#"</cfif></cfif>>
						<input type="text" name="ServiceFax3" size=4 maxlength=4 <cfif editmode><cfif #len(getdealerinfo.servicefax)# GT 6>value="#Mid(getDealerInfo.ServiceFax,7,4)#"</cfif></cfif>>
						<cfif editmode><input type="hidden" name="ServiceFax" value="#getDealerInfo.ServiceFax#"></cfif>
						</cfoutput>
					</td>
				</tr>
    
 				<tr>
					<td align="right">Parts Fax Number</td>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td>
						<!--- linda, 10/20/99: optimized redundant code, show all data they've typed in, even if it's < 10 digit number --->					
						<cfoutput>
						<input type="text" name="PartsFax1" size=3 maxlength=3 <cfif editmode><cfif #len(getdealerinfo.PartsFax)# GT 0>value="#Trim(Left(getDealerInfo.PartsFax,3))#"</cfif></cfif>>
						<input type="text" name="PartsFax2" size=3 maxlength=3 <cfif editmode><cfif #len(getdealerinfo.PartsFax)# GT 3>value="#Mid(getDealerInfo.PartsFax,4,3)#"</cfif></cfif>>
						<input type="text" name="PartsFax3" size=4 maxlength=4 <cfif editmode><cfif #len(getdealerinfo.PartsFax)# GT 6>value="#Mid(getDealerInfo.PartsFax,7,4)#"</cfif></cfif>>
						<cfif editmode><input type="hidden" name="PartsFax" value="#getDealerInfo.PartsFax#"></cfif>
						</cfoutput>
					</td>
				</tr>
				</cfif>
				<tr>
					<td align="right"><b>Contact Name</b></td>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<input type="hidden" name="ContactName_required" value="Please enter a Contact Name for this Dealership.">
					<cfif editmode>
						<td><input type="text" name="ContactName" size=35 value="<CFOUTPUT>#getDealerInfo.ContactName#</cfoutput>" MAXLENGTH=50></td>
					<cfelse>
						<td><input type="text" name="ContactName" size=35 maxlength=50></td>
					</cfif>
				</tr>
				<tr>
					<td align="right"><b>Contact Phone</b></td>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<input type="hidden" name="ContactPhone1_required" value="Please enter a valid Contact Phone Number.">
					<input type="hidden" name="ContactPhone2_required" value="Please enter a valid Contact Phone Number.">
					<input type="hidden" name="ContactPhone3_required" value="Please enter a valid Contact Phone Number.">
					<td>
						<!--- linda, 10/20/99: optimized redundant code, show all data they've typed in, even if it's < 10 digit number --->					
						<cfoutput>
						<input type="text" name="ContactPhone1" size=3 maxlength=3 <cfif editmode><cfif #len(getdealerinfo.ContactPhone)# GT 0>value="#Trim(Left(getDealerInfo.ContactPhone,3))#"</cfif></cfif>>
						<input type="text" name="ContactPhone2" size=3 maxlength=3 <cfif editmode><cfif #len(getdealerinfo.ContactPhone)# GT 3>value="#Mid(getDealerInfo.ContactPhone,4,3)#"</cfif></cfif>>
						<input type="text" name="ContactPhone3" size=4 maxlength=4 <cfif editmode><cfif #len(getdealerinfo.ContactPhone)# GT 6>value="#Mid(getDealerInfo.ContactPhone,7,4)#"</cfif></cfif>>
						<cfif editmode><input type="hidden" name="ContactPhone" value="#getDealerInfo.ContactPhone#"></cfif>
						</cfoutput>
					</td>
				</tr>
				<tr>
					<td align="right"><b>Tag Line</b></td>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<input type="hidden" name="TagLine_required" value="Please enter a Tag Line.">
					<cfif editmode>
						<td><input type="text" name="TagLine" size="40" value="<CFOUTPUT>#getDealerInfo.tagline#</cfoutput>" MAXLENGTH="150"></td>
					<cfelse>
						<td><input type="text" name="TagLine" size="40" maxlength="150"></td>
					</cfif>
			    </tr>
				<tr>
					<td align="right"><b>Display Name</td>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<input type="hidden" name="DisplayName_required" value="You must enter a Display Name for this Dealership.">
					<cfif editmode>
						<td><input type="text" name="DisplayName" size="40" value="<CFOUTPUT>#GetDealerInfo.DisplayName#</cfoutput>" MAXLENGTH="50"></td>
					<cfelse>
						<td><input type="text" name="DisplayName" size="40" maxlength="50"></td>
					</cfif>
				</tr>
				<tr>
					<td colspan=3 align="center"><i>
					(Dealership name which appears on your custom graphics)
					</i>
					</td>
				</tr>
				<tr>
					<td>&nbsp;<p></td>
				</tr>
			</table>
			</td>
		</tr>
		<tr align="center">
			<td>
			<input type="hidden" name="DealerCode" value="<CFOUTPUT>#g_DealerCode#</cfoutput>">
			<input type="hidden" name="NextStep" value="webnew_s2.cfm">
			<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/saveandcontinue_nav.jpg" Border="0" NAME="btnSave" VALUE="Save">
			</td>
		</tr>
		</form>
		<tr>
			<td>&nbsp;</td>
		</tr>
		<form action="webnew.cfm" method="post">
		<input type="hidden" name="DealerCode" value="<CFOUTPUT>#g_Dealercode#</cfoutput>">
		<tr align="center">
			<td>
			<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/cancel_nav.jpg" Border="0" NAME="btnCancel" VALUE="Cancel">
			</td>
		</tr>
		</form>
		<tr>
			<td>&nbsp;</td>
		</tr>
		<form name="f_Back" action="redirect.cfm" method="post">
		<tr align="center">
			<td>
			<input type="Image"
			src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/backtomain_nav.jpg"
			Border="0"
			NAME="BackToMain"
			VALUE="Back To Main Menu">
			</td>
		</tr>
		</form>
		<tr>
			<td>&nbsp;</td>
		</tr>
	</table>
	
	</div>
</cfif>	
</body>
</html>