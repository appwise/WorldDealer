                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 14, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: leads_main.cfm,v 1.15 2000/02/22 19:33:00 jkrauss Exp $ --->
<!--- Reports Intro --->

<cfset start = 0>
<cfset basic_options = 1>
<cfset choose_collection = 2>
<cfset choose_dealer = 4>
<cfset choose_account = 6>

<cfif accesslevel gt application.dealer_access>
	<cfquery name="getCollections" datasource="#gDSN#">
		SELECT DISTINCT 
				Dealers.DealerCode, 
				Dealers.DealershipName
		FROM	CollectionDealers INNER JOIN Dealers ON CollectionDealers.Coll_DealerCode = Dealers.DealerCode
		<cfif accesslevel eq application.account_coordinator_access>
			WHERE	ACID = #getUserInfo.AccountKey#
		<cfelseif accesslevel eq application.account_executive_access>
			WHERE	AEID = #getUserInfo.AccountKey#
		</cfif>
		ORDER BY DealershipName
	</cfquery>

<cfelse>
	<cfquery name="getCollName" datasource="#gDSN#">
		SELECT	DealershipName
		FROM	Dealers
		WHERE	DealerCode = '#g_dealercode#'
	</cfquery>
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
	<cfelseif accesslevel eq application.dealer_access>
		<!--- get all dealerships for collection dealer --->
		INNER JOIN CollectionDealers ON Dealers.DealerCode = CollectionDealers.DealerCode
		WHERE	CollectionDealers.Coll_DealerCode = '#g_dealercode#'
	</cfif>
	ORDER BY	DealershipName
</cfquery>

<cfif (accesslevel gt application.dealer_access) AND (not isDefined("url.dealer"))>

	<table>
	<tr>
		<td>
		Your Traffic Report tells you how many people visit your site; to find out how many of those visitors are interested in buying a car, use the Lead Report. This Report is also useful to find out how quickly your sales agents respond to leads.<p>
		<cfif (g_col)>
			Please select a dealership in your collection to see the leads for that dealership.
		<cfelse>
			Please select a collection and dealership to see the leads for that dealership.
		</cfif>
		</td>
	</tr>
	</table><p>

	<cfset mode="Leads">
	<cfinclude template="../mysite/dealer_select.cfm">

<cfelse>

	<!--- select the type of leads available --->
	<cfquery name="selectLeadTypes" datasource="#gDSN#">
	SELECT
		RequestInfoTypeID,
		Description
	FROM
		RequestInfoTypes
	</cfquery>
	
	<cfif isDefined("url.dealer")>
		<cfquery name="getDlrName" datasource="#gDSN#">
			SELECT DealershipName
			FROM Dealers
			WHERE DealerCode = '#url.dealer#'
		</cfquery>
	</cfif>
	
	<cfif (#left(accesslevel,1)# eq application.account_coordinator_access)
			or (#left(accesslevel,1)# eq application.account_executive_access)>
		<cfquery name="selectAccount" datasource="#gDSN#">
		SELECT	RowID
		FROM	Accounts
		WHERE	Accounts.AccountKey = '#RemoveChars(AccessLevel,1,2)#'
			<cfif #left(accesslevel,1)# eq application.account_coordinator_access>
				AND Accounts.AccountType = 'AC'
			<cfelse>
				AND Accounts.AccountType = 'AE'
			</cfif>
		</cfquery>
	</cfif>

	<form name="lead" action="leads_display.cfm" method="POST">	
	<div align="center">
	<table cellpadding="5">
	<tr align="left">
		<td><b>Show report for:</b> 
			<cfif g_iamcol>
				<select name="reportCoverage">
				<cfif accesslevel eq application.dealer_access>
					<cfoutput><option value="#g_collectioncode#">#getCollName.DealershipName# Website</cfoutput>
				</cfif>
				<cfloop query="getDealers">
					<cfoutput><option value="#Dealercode#">#DealershipName#</cfoutput>
				</cfloop>
				</select>
			<cfelseif g_dlr>
				<cfif accesslevel gt application.dealer_access>
					<cfoutput>#getDlrName.DealershipName#</cfoutput>
				<cfelse>
					my dealership
				</cfif>
				<input type="hidden" name="reportCoverage" value="<cfoutput>#g_dealercode#</cfoutput>">
			<cfelse>
				<cfoutput>#getDlrName.DealershipName#
				<input type="hidden" name="reportCoverage" value="#url.dealer#"></cfoutput>
			</cfif>
		
		<br><br><b>Include the following type of leads:</b><br>
		<cfoutput query="selectLeadTypes">
			<input type="Checkbox" name="leadType" value="#selectLeadTypes.RequestInfoTypeID#" checked>#selectLeadTypes.Description#<br>
		</cfoutput>
		<input type="hidden" name="leadType_required" value="Please specify at least one type of lead to report on">
		
		<br><b>Sort by:</b><br>
		<input type="Radio" name="orderBy" value="lastName">last name<br>
		<input type="Radio" name="orderBy" value="leadType">type of lead<br>
		<input type="Radio" name="orderBy" value="date" checked>date submitted<br>
		
		<br><b>Sort direction:</b><br>
		<input type="Radio" name="orderDirection" value="ASC">ascending&nbsp;&nbsp;
		<input type="Radio" name="orderDirection" value="DESC" checked>descending<br>
		
		</td>
	</tr>
	<tr align="center">
		<td>
			<a href="#" OnMouseOver="self.status='Back';return true" OnMouseOut="self.status='';return true" OnClick="history.go(-1);return false"><img src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/back.gif" Border="0" ALT="Back"></a>
			<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/continue.gif" BORDER="0" NAME="Continue" VALUE="Continue"></td>
	</tr>
	</table>
	</div>
	</form>
	
</cfif>