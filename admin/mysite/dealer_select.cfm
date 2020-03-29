<cfset PageAccess = application.dealer_access>

                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 17, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: dealer_select.cfm,v 1.12 2000/06/15 17:11:20 jkrauss Exp $ --->
<!--- Home: Select Another Dealer --->

<!---
	goinbacktocali is the filename that refreshes the dealerlist when you select a collection
	noidontthinkso is where it goes to once you click Continue
--->
<cfif isdefined ("url.dealeradministrator")>
	<cfset llcoolj=#url.dealeradministrator#>
<cfelseif isdefined ("form.dealeradministrator")>
	<cfset llcoolj=#form.dealeradministrator#>
<cfelse>
	<cfset llcoolj= "">
</cfif>

<cfif mode eq "webTrends">
	<cfset goinbacktocali = "#application.RELATIVE_PATH#/admin/reports/traffic.cfm">
	<cfset noidontthinkso = "#application.RELATIVE_PATH#/admin/reports/traffic_report.cfm">
<cfelseif mode eq "Leads">
	<cfset goinbacktocali = "#application.RELATIVE_PATH#/admin/reports/leads.cfm">
	<cfset noidontthinkso = "#application.RELATIVE_PATH#/admin/mysite/dealer_select_action.cfm">
<cfelseif mode eq "MySite">
	<cfset goinbacktocali = "#application.RELATIVE_PATH#/admin/mysite/select_dealer.cfm">
	<cfset noidontthinkso = "#application.RELATIVE_PATH#/admin/mysite/dealer_select_action.cfm">
<cfelseif mode eq "Account">
	<cfset goinbacktocali = "#application.RELATIVE_PATH#/admin/account/dealers.cfm">
	<cfset noidontthinkso = "#application.RELATIVE_PATH#/admin/mysite/dealer_select_action.cfm">
<cfelseif mode eq "da_edit">
	<cfset goinbacktocali = "#application.RELATIVE_PATH#/admin/account/dealadmin_edit.cfm?dealeradministrator=#llcoolj#">
	<cfset noidontthinkso = "#application.RELATIVE_PATH#/admin/account/dealadmin_edit_save.cfm">
<cfelseif mode eq "da_edit_new">
	<cfset goinbacktocali = "#application.RELATIVE_PATH#/admin/account/dealadmin_edit.cfm">
	<cfset noidontthinkso = "#application.RELATIVE_PATH#/admin/account/dealadmin_edit_save.cfm">
</cfif>

<!--- if account person, show all collections they can choose from --->
<cfif accesslevel gt application.dealer_access>
	<cfquery name="getCollections" datasource="#gDSN#">
		SELECT DISTINCT 
				Dealers.DealerCode, 
				Dealers.DealershipName
		FROM	Dealers
		WHERE	DealerType = 1
		<cfif accesslevel eq application.account_coordinator_access>
			AND	ACID = #getUserInfo.AccountKey#
		<cfelseif accesslevel eq application.account_executive_access>
			AND	AEID = #getUserInfo.AccountKey#
		</cfif>
		ORDER BY DealershipName
	</cfquery>

	<cfif goodbrowser>
		<cfif mode EQ "da_edit">
		<script language="JavaScript">
		<!--  
		function onCollectionSelection()
			{
			with(document.forms[0].elements[0])
				selectedColl = options[selectedIndex].value
			if (selectedColl != '')
				location.href = '<cfoutput>#goinbacktocali#</cfoutput>&coll=' + selectedColl;
			else
				// this sets it back to the default.
				location.href = '<cfoutput>#goinbacktocali#</cfoutput>';
			}
		//-->
		</script>
		<cfelse>
		<script language="JavaScript">
		<!--  
		function onCollectionSelection()
			{
			with(document.forms[0].elements[0])
				selectedColl = options[selectedIndex].value
			if (selectedColl != '')
				location.href = '<cfoutput>#goinbacktocali#</cfoutput>?coll=' + selectedColl;
			else
				// this sets it back to the default.
				location.href = '<cfoutput>#goinbacktocali#</cfoutput>';
			}
		//-->
		</script>
		</cfif>
	</cfif>
<cfelse>
	<!--- the only other people w access to this page are Collections --->
	<cfquery name="getCollName" datasource="#gDSN#">
		SELECT	DealershipName
		FROM	Dealers
		<cfif g_iamcol>
			WHERE	DealerCode = '#g_collectioncode#'
		<cfelse>
			WHERE	DealerCode = '#g_dealercode#'
		</cfif>
		<cfif accesslevel eq application.account_coordinator_access>
			AND	ACID = #getUserInfo.AccountKey#
		<cfelseif accesslevel eq application.account_executive_access>
			AND	AEID = #getUserInfo.AccountKey#
		</cfif>
	</cfquery>
</cfif>

<cfset CollName2Length = 0>

<cfif isDefined("URL.coll")>
	<cfquery name="getCollName2" datasource="#gDSN#">
		SELECT	DealershipName
		FROM	Dealers
		WHERE	DealerCode = '#URL.coll#'
		<cfif accesslevel eq application.account_coordinator_access>
			AND	ACID = #getUserInfo.AccountKey#
		<cfelseif accesslevel eq application.account_executive_access>
			AND	AEID = #getUserInfo.AccountKey#
		</cfif>
	</cfquery>
	
	<cfset CollName2Length = getCollName2.recordcount>
</cfif>

<cfquery name="getDealers" datasource="#gDSN#">
	SELECT	Dealers.DealerCode, 
			Dealers.DealershipName
	FROM	Dealers
	<cfif isdefined("URL.coll")>
		<!--- get all non-collection dealers --->
		<cfif url.coll eq "no">
			WHERE	Dealers.Dealercode NOT IN (
					SELECT	DealerCode
					FROM	CollectionDealers) AND
					Dealers.Dealercode NOT IN (
					SELECT	Coll_DealerCode
					FROM	CollectionDealers)
		<cfelse>
			<!--- get all dealerships within selected collection --->
			INNER JOIN CollectionDealers ON Dealers.DealerCode = CollectionDealers.DealerCode
			WHERE	CollectionDealers.Coll_DealerCode = '#URL.coll#'
		</cfif>
		<cfif accesslevel eq application.account_coordinator_access>
			AND	ACID = #getUserInfo.AccountKey#
		<cfelseif accesslevel eq application.account_executive_access>
			AND	AEID = #getUserInfo.AccountKey#
		</cfif>
	<cfelseif g_iamcol>
		<!--- get all dealerships for collection dealer --->
		INNER JOIN CollectionDealers ON Dealers.DealerCode = CollectionDealers.DealerCode
		WHERE	CollectionDealers.Coll_DealerCode = '#g_collectioncode#'
	<cfelseif accesslevel eq application.account_coordinator_access>
		WHERE	ACID = #getUserInfo.AccountKey#
	<cfelseif accesslevel eq application.account_executive_access>
		WHERE	AEID = #getUserInfo.AccountKey#
	</cfif>
	ORDER BY	DealershipName
</cfquery>

<cfoutput>
<div align="center">
<table border="0" cellpadding="5" cellspacing="0">
<tr align="center">
	<form action="#noidontthinkso#" method="POST" name="goGetThem"<cfif mode eq "webTrends"> target="newwindow"</cfif>>
	<td align="right">
		<b>Collection:</b>
	</td>
	<td align="left">
		<cfif accesslevel gt application.dealer_access>
			<select name="Collection" <cfif goodbrowser>onChange="onCollectionSelection()"</cfif>>
			<option value="">Select a Collection or Independent Dealership
			<option value="no"
				<cfif isdefined("URL.coll")>
					<cfif #url.coll# eq "no"> selected</cfif>
				</cfif>
				>Dealership Not In A Collection
			<cfloop query="getCollections">
				<option value="#Dealercode#"
				<cfif isdefined("URL.coll")>
					<cfif #dealercode# eq #url.coll#>
						selected
					</cfif>
				</cfif>
				>#DealershipName#</option>
			</cfloop>
			</select>
		<cfelse>
			#getCollName.DealershipName#
		</cfif>
	</td>
</tr>
<tr align="center">
	<input type="hidden" name="mode" value="#mode#">
	<td align="right">
		<b>Dealership:</b>
	</td>
	<td align="left">
		<select name="Dealer">
		<cfif isDefined("url.coll")>
			<cfif (url.coll neq "no")>
			<cfif getCollName2.recordcount>
				<option value="#url.coll#"<cfif mode eq "da_edit"><cfif editda.accountkey EQ '#url.coll#'> selected</cfif></cfif>>#getCollName2.DealershipName# Website
				<cfelse>
					<option value="">Select a Dealer
				</cfif>
			</cfif>
		<cfelse>
			<cfif (g_iamcol)>
			<option value="#g_collectioncode#"<cfif mode eq "da_edit"><cfif editda.accountkey EQ #g_collectioncode#> selected</cfif></cfif>>#getCollName.DealershipName# Website
			<cfelse>
				<option value="">Select a Dealer
			</cfif>
		</cfif>
		<cfloop query="getDealers">
			<option value="#Dealercode#"<cfif mode eq "da_edit"><cfif editda.accountkey EQ #dealercode#> selected</cfif></cfif>>#DealershipName#
		</cfloop>
		</select>
		<input type="hidden" name="Dealer_required" value="Please Select a Dealer">
	</td>
</tr>
</table><br>
<cfif mode eq "Account">
	<a href="dealers_add.cfm"><img src="#application.RELATIVE_PATH#/images/admin/add.gif" border="0" width="47" height="15" alt="Add"></a>
	&nbsp;&nbsp;<input type="Image" src="#application.RELATIVE_PATH#/images/admin/modify.gif" border="0" width="47" height="15" name="Modify" value="Modify">
	&nbsp;&nbsp;<input type="Image" src="#application.RELATIVE_PATH#/images/admin/deletebutton.gif" border="0" width="47" height="15" name="Delete" value="Delete">
</form>
<cfelseif mode eq "da_edit">
<input type="hidden" name="dealedit" Value="modify">
<cfelseif mode eq "da_edit_new">
<input type="hidden" name="dealedit" Value="new">
<cfelse>
	<input type="Image" src="#application.RELATIVE_PATH#/images/admin/continue.gif" BORDER="0" width="66" height="15" NAME="Continue" VALUE="Continue">
</form>
</cfif>
</div>
</cfoutput>

<cfif g_iamcol>
	<p>
	<div align="center">
	<!--- linda, 5/3/00: changed bgcolor from FFF5D9 to FFFFDD, so it's web safe. --->
	<table border="0" cellspacing="0" cellpadding="5" bgcolor="#FFFFDD"><tr><td>
	<font color="Red"><b>Tip:</b></font><br>
	You can only edit one dealership at a time<br>
	per login.  You must log in separately for<br>
	each dealership you wish to edit.
	</td></tr></table>
	</div>
</cfif>