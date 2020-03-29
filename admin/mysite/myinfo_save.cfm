                        <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 10, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: myinfo_save.cfm,v 1.14 2000/06/16 02:18:46 lswanson Exp $--->

<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: myinfo_save.cfm,v $">
<cfinclude template = "../security.cfm">

<cfif isdefined("URL.FromTemplate")>
	<!--- if genexe_redirect was redirected back here, then we need to generate maps also --->
	<!--- <cfif URL.fromtemplate eq "genexe_redirect">
		<!--- generate maps then come back here --->
		<cfmodule template="genmap.cfm"
			windowtitle="WorldDealer My Site -- Create Maps"
			screentitle="Create Maps"
			nextstep="#application.RELATIVE_PATH#/admin/mysite/myinfo.cfm"> 
		<cfabort>
	</cfif> --->
</cfif> 

<cfset save_phone = #form.phone1# & #form.phone2# & #form.phone3#>
<cfset save_secondphone = #form.secondphone1# & #form.secondphone2# & #form.secondphone3#>
<cfset save_faxphone = #form.faxphone1# & #form.faxphone2# & #form.faxphone3#>
<cfset save_contactphone = #form.contactphone1# & #form.contactphone2# & #form.contactphone3#>

<cfif isdefined("g_dealercode")>
	<cfset editmode = true>
<cfelse>
	<cfset editmode = false>
</cfif>

<cfif not editmode>
	<!--- Add a new dealership or collection --->
	<cftransaction><!--- this ensures that if one of these queries fails, the queries that did work are rolled back.  all or nothing. --->

	<cfquery name="getMaxDealer" datasource="#gDSN#">
    	SELECT	Dealercode 
	    FROM 	Dealers
		<cfif form.dealertype eq "dlr">
			Where 	Dealercode > '#Form.Collection#'
		</cfif>
		ORDER BY Dealercode Desc
	</cfquery>
	
	<!--- 0000-0000-000-00-0000000000 --->
	<!--- NewCollection - NewDealerNum - NewDealerType - NewDealerTot - NewDealerSuffix --->
	<cfset newcollection= "0000">
	<cfset newdealernum = "0000">
	<!--- <cfset newdealertype = "000"> ---> <!--- no longer used --->
	<!--- <cfset newdealertot = "00"> ---> <!--- no longer used --->

	<cfif form.dealertype eq "col">
		<!--- find the highest collection #, then increment it --->
		<cfset newcollection = Right("0000" & incrementvalue(#left(getmaxdealer.dealercode,4)#), 4)>
		<cfset newdealersuffix = "0000000000">
	<cfelseif form.dealertype eq "dlr">
		<cfset newcollection=#form.collection#>
		<!--- get the highest dealer number # increment it (this works for either the indep. dlrs or collection dealers) --->
		<cfloop query="GetMaxDealer">
			<cfif left(getmaxdealer.dealercode,4) eq #form.collection#>
		    	<cfif mid(getmaxdealer.dealercode,6,4) gt "0000">
					<cfset newdealernum = val(mid(getmaxdealer.dealercode,6,4))>
					<cfbreak>
				</cfif>
        	</cfif>
		</cfloop>
		<cfset newdealernum = Right("0000" & (incrementvalue(#newdealernum#)), 4)>
		<cfset newdealersuffix = #trim(form.newdealercode)#>
	</cfif>

	<cfset #newDealerCode# = newcollection & "-" & newdealernum & "-000-00-" &  newdealersuffix>
	
	<cfif left(#newDealerCode#, 4) eq '0000'>
		<cfset DealerType = TYPE_INDEPDLR>
	<cfelseif mid(#newDealerCode#, 6, 4) eq '0000'>
		<cfset DealerType = TYPE_COLL>
	<cfelse>
		<cfset DealerType = TYPE_COLLDLR>
	</cfif>

	<!--- New Dealer --->
	<!--- insert the new dealership. --->
	<cfquery name="insertDLR" datasource="#gDSN#">
		INSERT INTO Dealers (
				DealershipName,
				DealerCode,
				DisplayName,
				TagLine,
				AddressLine1,
				AddressLine2,
				City,
				StateAbbr,
				Zip,
				Phone,
				secondPhone,
				FaxPhone,
				Email,
				ContactName,
				ContactPhone,
				AEID,
				ACID,
				DealerFirstName,
				DealerLastName,
				WebStateID,
				DealerType
		
				)
		VALUES (
				'#Form.DealershipName#',
				'#newDealerCode#',
				'#Form.DisplayName#',
				'#Form.TagLine#',
				'#Form.Address1#',
				'#Form.Address2#',
				'#Form.City#',
				'#Form.StateAbbr#',
				'#Form.Zip#',
				'#save_Phone#',
				'#save_secondPhone#',
				'#save_FaxPhone#',
				'#Form.Email#',
				'#Form.ContactName#',
				'#save_ContactPhone#',
				#Form.AccountExec#,
				#Form.AccountCoord#,
				'#Form.DealerFirstName#',
				'#Form.DealerLastName#',
				#Form.WebState#,
				#DealerType#
						
				
				)
	</cfquery>
	
	<!--- Create a new DealerWebs record for this dealer --->
	<cfquery name="addDlrWebs" datasource="#gDSN#">
		INSERT INTO DealerWebs (
				Dealercode,
				WebStateID,
				BaseURL,
				ArtTempID,
				CalculatorYesNo,
				BodyShopYesNo,
				MakelogoLinkYN
			<cfif g_col>,
				MakeLogoYN
			</cfif>
				)
		VALUES	(
				'#newDealerCode#',
				#form.WebState#,
				'none',
				12,
				'Y',
				'Y',
				'#form.MakeLogolinkYN#'<!--- I think the problem was form.MakelogoLinkYN --->
			<cfif g_col>,				<!--- Chris Wacker 11/21/2000 9:44 AM --->
				'#form.MakeLogoYN#'
			</cfif>
				)
	</cfquery>
		
	<!--- if dealership is part of a collection, add a new CollectionDealers record --->
	<cfif (Left(newDealerCode, 4) neq "0000") and (mid(newDealerCode, 6, 4) gt "0000")>
		<cfquery name="getColl" datasource="#gDSN#">
			SELECT	Dealercode
			FROM	Dealers
			WHERE	Dealercode < '#newDealerCode#'
		</cfquery>
		
		<cfloop query="getColl">
			<cfif (left(dealercode, 4) eq left(newDealerCode, 4)) and (mid(dealercode, 6, 4) eq "0000")>
				<cfset parentcollection = #Trim(dealercode)#>
				<cfbreak>
			</cfif>
		</cfloop>
		
		<cfif IsDefined("parentcollection")>
			<cfquery name="addCollDlr" datasource="#gDSN#">
				INSERT INTO	CollectionDealers (
						Coll_DealerCode,
						Dealercode
						)
				VALUES	(
						'#parentcollection#',
						'#newDealerCode#'
						)
			</cfquery>
		</cfif>
	</cfif>
	
	<!--- reset the AccountSecurity dealercode, so it remembers which dealer you just created --->
	<cfquery name="getSessionID" datasource="#gDSN#">
		SELECT	SessionID
		FROM	AccountSecurity
		WHERE	UserID = #getUserInfo.RowID#
		ORDER BY SessionID DESC
	</cfquery>
	
	<cfquery name="updLastDlrSelected" datasource="#gDSN#">
		UPDATE	AccountSecurity
		SET		Dealercode = '#newDealerCode#'
		WHERE	SessionID = #getSessionID.SessionID#
	</cfquery>
	
	<cfset g_dealercode = #newdealercode#>
	</cftransaction>
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
		UPDATE	Dealers
		SET		DealershipName = '#Form.DealershipName#',
				DisplayName = '#Form.DisplayName#',
				TagLine='#Form.Tagline#',
				AddressLine1 = '#Form.Address1#',
				AddressLine2 = '#Form.Address2#',
				City = '#Form.City#',
				StateAbbr = '#Form.StateAbbr#',
				Zip = '#Form.Zip#',
				Phone = '#save_Phone#',
				secondPhone = '#save_secondPhone#',
				FaxPhone = '#save_FaxPhone#',
				Email = '#Form.Email#',
				ContactName = '#Form.ContactName#',
				ContactPhone = '#save_contactphone#'
				<cfif accesslevel gt application.dealer_access>
					,
					DealerFirstName = '#Form.DealerFirstName#',
					DealerLastName = '#Form.DealerLastName#',
					WebStateID = #Form.WebState#,
					ACID = #Form.AccountCoord#,
					AEID = #Form.AccountExec#
				</cfif>
		WHERE	Dealers.DealerCode = '#g_dealercode#'
	</cfquery>
	
	<!--- Check if this dealer is in DealerWebs yet --->
	<cfquery name="CheckDealerWebs" datasource="#gDSN#">
		SELECT 	Dealercode
		FROM 	DealerWebs
		WHERE 	DealerCode = '#g_DealerCode#';  
	</cfquery>

	<cfif (accesslevel gt application.dealer_access) and (#checkdealerwebs.recordcount#)>
	 	<cfquery name="updatestate" datasource="#gDSN#">
			UPDATE	dealerwebs
			SET		webstateid = #Form.WebState#,
					MakeLogoLinkYN ='#form.MakeLogoLinkYN#'
			<cfif g_col>,
					MakeLogoYN = '#form.MakeLogoYN#'
			</cfif>		
			WHERE	dealercode = '#g_dealercode#';
		</cfquery>
	</cfif>
	
	<!--- Check if the Dealercode was changed.  If so, we need to update it in all the tables where there's a dealercode. --->
	<cfif trim(#g_dealercode#) neq trim(#form.newdealercode#)>
		<!--- if someone changes the dealercode manually, check that it doesn't already exist. --->
		<cfquery name="dupDlrCode" datasource="#gDSN#">
			SELECT	DealerCode
			FROM 	Dealers
			WHERE 	DealerCode = '#form.newdealercode#';
		</cfquery>
		
		<cfif (dupDlrCode.recordcount)>
			<cflocation url="myinfo_unavail.cfm?orig=#g_dealercode#&new=#form.newdealercode#">
		</cfif>

		<!--- Now start changing the dealercode in all the tables --->
		<cfif #checkdealerwebs.recordcount# eq 0>
			<!--- If this dealer is not yet in dealerwebs, go ahead and update the dealercode ---> 
			<cfquery name="updateDealers" datasource="#gDSN#">
				UPDATE Dealers
				SET DealerCode = '#Form.newDealerCode#'
				WHERE DealerCode = '#g_dealercode#';
			</cfquery>
		<cfelse>
			<!--- This dealer is already in Dealerwebs --->
			<!--- linda, 3/6/00: in the future, we can drop this constraint manually, 
			then take out the dropping & adding of constraints & move it to the rest of the code, 
			inside the cftransaction. (need access to FTP, so I can ensure that both happen at the same time.) --->
			<!--- Drop the FOREIGN KEY on Dealerwebs.Dealercode --->
			<cfquery name="DropKey" datasource="#gDSN#" username="sa" password="">
				ALTER TABLE DealerWebs
				DROP CONSTRAINT FK_DealerWebs_1__11;
			</cfquery>
			
			<!--- Update the DealerCode in Dealers --->
			<cfquery name="updDealers" datasource="#gDSN#">
				UPDATE	Dealers
				SET		DealerCode = '#Form.newDealerCode#'
				WHERE	DealerCode = '#g_dealercode#';
			</cfquery>
			
			<!--- Update the Dealercode in DealerWebs --->
			<cfquery name="UpdDealerwebs" datasource="#gDSN#">
				UPDATE DealerWebs
				SET DealerCode = '#Form.newDealerCode#'
				WHERE DealerCode = '#g_dealercode#';
			</cfquery>
			
			<!--- Restore the Foreign Key --->
			<cfquery name="AddF_Key" datasource="#gDSN#" username="sa" password="">
				ALTER TABLE Dealerwebs
				ADD CONSTRAINT  FK_DealerWebs_1__11 FOREIGN KEY (DealerCode) REFERENCES Dealers(Dealercode);
			</cfquery>
		</cfif>
		
		<!--- this ensures that if one of these queries fails, the queries that did work are rolled back.  all or nothing. 
		linda, 2/25/00: i had it above this before, but it didn't like the multiple instances of the WorldDealer database.
		It didn't like that we had referenced it with a un & pw & then the next statement, not use it.--->
		<cftransaction>

		<!--- Accounts --->
		<cfquery name="updAccounts" datasource="#gDSN#">
			UPDATE	Accounts
			SET		AccountKey = '#form.newdealercode#'
			WHERE	AccountKey = '#g_dealercode#'
		</cfquery>
		
		<!--- AccountSecurity --->
		<cfquery name="getSessionID" datasource="#gDSN#">
			SELECT	SessionID
			FROM	AccountSecurity
			WHERE	UserID = #getUserInfo.RowID#
			ORDER BY SessionID DESC
		</cfquery>
		
		<cfquery name="updLastDlrSelected" datasource="#gDSN#">
			UPDATE	AccountSecurity
			SET		Dealercode = '#form.newdealercode#'
			WHERE	SessionID = #getSessionID.SessionID#
		</cfquery>
		
		<!--- CollectionDealers --->
		<cfif g_col>
			<cfquery name="updCollectionDealers" datasource="#gDSN#">
				UPDATE	CollectionDealers
				SET		Coll_Dealercode = '#form.newdealercode#'
				WHERE	Coll_Dealercode = '#g_dealercode#'
			</cfquery>
		<cfelseif g_dlr>
			<cfquery name="updCollectionDealers" datasource="#gDSN#">
				UPDATE	CollectionDealers
				SET		Dealercode = '#form.newdealercode#'
				WHERE	Dealercode = '#g_dealercode#'
			</cfquery>
		</cfif>
		
		<cfif g_dlr>
			<!--- DealerFranchise --->
			<cfquery name="updDealerFranchise" datasource="#gDSN#">
				UPDATE	DealerFranchise
				SET		Dealercode = '#form.newdealercode#'
				WHERE	Dealercode = '#g_dealercode#'
			</cfquery>
		</cfif>

		<cfif g_col>
			<!--- DealersNonWD --->
			<cfquery name="updDealersNonWD" datasource="#gDSN#">
				UPDATE	DealersNonWD
				SET		GroupDealerCode = '#form.newdealercode#'
				WHERE	GroupDealerCode = '#g_dealercode#'
			</cfquery>
		</cfif>
		
		<!--- DealerURL --->
		<cfquery name="updDealerURL" datasource="#gDSN#">
			UPDATE	DealerURL
			SET		Dealercode = '#form.newdealercode#'
			WHERE	Dealercode = '#g_dealercode#'
		</cfquery>

		<cfif g_dlr>
			<!--- DlrXRef --->
			<cfquery name="updDlrXRef" datasource="#gDSN#">
				UPDATE	DlrXRef
				SET		Dealercode = '#form.newdealercode#'
				WHERE	Dealercode = '#g_dealercode#'
			</cfquery>
			
			<!--- HoursofOperation --->
			<cfquery name="updHoursofOperation" datasource="#gDSN#">
				UPDATE	HoursofOperation
				SET		Dealercode = '#form.newdealercode#'
				WHERE	Dealercode = '#g_dealercode#'
			</cfquery>
		</cfif>
		
		<!--- RequestInfoGeneral --->
		<cfquery name="updRequestInfoGeneral" datasource="#gDSN#">
			UPDATE	RequestInfoGeneral
			SET		Dealercode = '#form.newdealercode#'
			WHERE	Dealercode = '#g_dealercode#'
		</cfquery>

		<cfif g_dlr>
			<!--- UsedVehicles --->
			<cfquery name="updUsedVehicles" datasource="#gDSN#">
				UPDATE	UsedVehicles
				SET		Dealercode = '#form.newdealercode#'
				WHERE	Dealercode = '#g_dealercode#'
			</cfquery>
		</cfif>

		<!--- Update all images with new DealerCode --->
		<!--- banner images --->
		<cfx_directorylist directory="#g_rootdir#\images\banner" name="banner_query" sort="type ASC, name ASC">
		
		<cfloop query="banner_query">
			<cfset match = #find(g_dealercode, name, 1)#>
			<cfif #match# eq 1> <!--- This file starts with g_dealercode --->
				<cfset new_name = #replace(name, g_dealercode, form.newdealercode)#>
				<cffile action="rename" source="#g_rootdir#\images\banner\#name#" destination="#g_rootdir#\images\banner\#new_name#">
			</cfif>
		</cfloop>

		<!--- coupon images --->
		<cfx_directorylist directory="#g_rootdir#\images\coupons" name="coupon_query" sort="type ASC, name ASC">

		<cfloop query="coupon_query">
			<cfset match = #find(g_dealercode, name, 1)#>
			<cfif #match# eq 1> <!--- This file starts with g_dealercode --->
				<cfset new_name = #replace(name, g_dealercode, form.newdealercode)#>
				<cffile action="rename" source="#g_rootdir#\images\coupons\#name#" destination="#g_rootdir#\images\coupons\#new_name#">
			</cfif>
		</cfloop>

		<!--- leftnav logo images --->
		<cfx_directorylist directory="#g_rootdir#\images\logo" name="logo_query" sort="type ASC, name ASC">

		<cfloop query="logo_query">
			<cfset match = #find(g_dealercode, name, 1)#>
			<cfif #match# eq 1> <!--- This file starts with g_dealercode --->
				<cfset new_name = #replace(name, g_dealercode, form.newdealercode)#>
				<cffile action="rename" source="#g_rootdir#\images\logo\#name#" destination="#g_rootdir#\images\logo\#new_name#">
			</cfif>
		</cfloop>

		<!--- map images --->
		<cfx_directorylist directory="#g_rootdir#\images\maps" name="maps_query" sort="type ASC, name ASC">
		
		<cfloop query="maps_query">
			<cfset match = #find(g_dealercode, name, 1)#>
			<cfif #match# eq 1> <!--- This file starts with g_dealercode --->
				<cfset new_name = #replace(name, g_dealercode, form.newdealercode)#>
				<cffile action="rename" source="#g_rootdir#\images\maps\#name#" destination="#g_rootdir#\images\maps\#new_name#">
			</cfif>
		</cfloop>
		
		<!--- splash page logo images --->
		<cfx_directorylist directory="#g_rootdir#\images\sp_logo" name="sp_logo_query" sort="type ASC, name ASC">
		
		<cfloop query="sp_logo_query">
		<cfset match = #find(g_dealercode, name, 1)#>
			<cfif #match# eq 4> <!--- This file starts with "sp_<g_dealercode>" --->
				<cfset new_name = #replace(name, g_dealercode, form.newdealercode)#>
				<cffile action="rename" source="#g_rootDir#\images\sp_logo\#name#" destination="#g_rootdir#\images\sp_logo\#new_name#">
			</cfif>
		</cfloop>
		<cfset g_dealercode = #form.newdealercode#>
		</cftransaction>
	</cfif>
</cfif>

<!--- Meta tags --->
<cfquery name="getDealerWebID" datasource="#gDSN#">
	SELECT	DealerWebID
	FROM	DealerWebs
	WHERE	DealerCode = '#g_dealercode#'
</cfquery>

<cfquery name="getMetaTags" datasource="#gDSN#">
	SELECT	DealerWebsMeta.*
	FROM 	DealerWebs INNER JOIN DealerWebsMeta ON DealerWebs.DealerWebID = DealerWebsMeta.DealerWebID
	WHERE	DealerWebs.DealerCode = '#g_dealercode#'
</cfquery>

<cfif getMetaTags.recordcount>
	<!--- Update the dealer's existing DealerWebMeta entry --->
	<cfquery name="UpdateMeta" datasource="#gDSN#">
		UPDATE	DealerWebsMeta
		SET		shortMeta = '#Form.shortMeta#',
				longMeta = <cfif form.longMeta is "Please enter your long description here.">''<cfelse>'#form.longMeta#'</cfif>,
				keyMeta = <cfif form.keyMeta is "Please enter your keywords here.">''<cfelse>'#form.keyMeta#'</cfif>
		WHERE	DealerWebID = #getDealerWebID.DealerWebID#
	</cfquery>
<cfelse>
	<!-- Create a new DealerWebsMeta record for this dealer --->
	<!--- first check to see whether at least one of the 3 Meta fields are filled in --->
	<cfif (Trim(form.shortMeta) neq "") or
		(form.longMeta neq "Please enter your long description here.") or
		(form.keyMeta neq "Please enter your keywords here.")>
	
		<cfquery name="addDlrWebsMeta" datasource="#gDSN#">
			INSERT INTO DealerWebsMeta (
				DealerWebID,
				ShortMeta,
				LongMeta,
				keyMeta)
			VALUES (
				#getDealerWebID.DealerWebID#,
				'#form.shortMeta#',
				<cfif form.longMeta is "Please enter your long description here.">''<cfelse>'#form.longMeta#'</cfif>,
				<cfif form.keyMeta is "Please enter your keywords here.">''<cfelse>'#form.keyMeta#'</cfif>
				)
		</cfquery>		
	</cfif>
</cfif>

<!--- Call Java Image Generator to Create Custom Graphics  --->
<cfset ismodifiedname = "false">
<cfset ismodifiedaddress = "false">

<cfif editmode>
	<cfif getinfo.recordcount>
		<cfif getinfo.displayname neq form.displayname>
			<cfset ismodifiedname = "true">
		</cfif>
		<cfif (getinfo.addressline1 neq form.address1)
			or (getinfo.addressline2 neq form.address2)
			or (getinfo.city neq form.city)
			or (getinfo.stateabbr neq form.stateabbr)
			or (getinfo.zip neq form.zip)>
			<cfset ismodifiedaddress = "true">
		</cfif>
	</cfif>
<cfelse>
	<cfset ismodifiedname = "true">
	<cfset ismodifiedaddress = "true">
</cfif>

<cfif ismodifiedname and ismodifiedaddress>
	<!--- generate logos then redirect back to generate maps --->
	<cfmodule template="genexe.cfm"
		windowtitle="WorldDealer My Site -- Create Logos"
		screentitle="Create Logos"
		nextstep="#application.RELATIVE_PATH#/admin/mysite/myinfo_save.cfm"
		uniqueid="#g_dealercode#"
		displayname="#Form.displayName#">
	<!--- linda, 4/7/00: this is sooo whack!  i don't know if it's a cfmodule quirk or what, 
	but cfmodules apparently don't continue from where they're called, so you have to pass a nextstep 
	variable, so they know where to go next.  Then put a cfabort after it's being called, so the code 
	after it doesn't get called.  I tried to get around it, but then the images failed to get created. :(
	So, to call logos, then maps, we need to call myinfo_save when we're done w logos, which, at the top,
	1st thing, generates the maps. --->
<!--- 	
	<cfmodule template="genmap.cfm"
			windowtitle="WorldDealer My Site -- Create Maps"
			screentitle="Create Maps"
			nextstep="#application.RELATIVE_PATH#/admin/mysite/myinfo.cfm">
 --->	
 	<cfabort>
<cfelseif ismodifiedname or ismodifiedaddress>
	<cfif ismodifiedname>
		<cfmodule template="genexe.cfm"
			windowtitle="WorldDealer My Site -- Create Logos"
			screentitle="Create Logos"
			nextstep="#application.RELATIVE_PATH#/admin/mysite/myinfo.cfm"
			uniqueid="#g_dealercode#"
			displayname="#Form.displayName#">
	
	<!--- This pesky piece of code has been breaking my back for 2 days.  I got you now my pretty!
	Chris Wacker 11/22/2000 2:34 PM --->
	
	
	<cfelse>
	<cflocation url="#application.RELATIVE_PATH#/admin/mysite/myinfo.cfm" addtoken="No">
	<!--- 
		<cfmodule template="genmap.cfm"
			windowtitle="WorldDealer My Site -- Create Maps"
			screentitle="Create Maps"
			nextstep="#application.RELATIVE_PATH#/admin/mysite/myinfo.cfm"> --->
	</cfif>
	<cfabort>
<cfelse>
	<cflocation url="#application.RELATIVE_PATH#/admin/mysite/myinfo.cfm" addtoken="No">
</cfif>

<cfmodule template="/util/DumpDebug.cfm" text="end   $RCSfile: myinfo_save.cfm,v $">