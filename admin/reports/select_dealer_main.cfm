                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 17, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: select_dealer_main.cfm,v 1.4 2000/06/15 17:11:21 jkrauss Exp $ --->
<!--- Home: Select Another Dealer --->

<!--- Linda, 1/24/00: this needs to be like the old loadnew.cfm, 
where you select a collection &/or a dealership from drop-down lists. --->

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

	<cfif goodbrowser>
		<cfif mode eq "webTrends">
			<script language="JavaScript">
			<!--  
			function onCollectionSelection()
				{
				with(document.forms[0].elements[0])
					selectedColl = options[selectedIndex].value
				if (selectedColl != '')
					location.href = 'traffic.cfm?coll=' + selectedColl;
				else
					// this sets it back to the default.
					location.href = 'traffic.cfm';
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
					location.href = 'leads.cfm?coll=' + selectedColl;
				else
					// this sets it back to the default.
					location.href = 'leads.cfm';
				}
			//-->
			</script>
		</cfif>
	</cfif>
<cfelse>
	<cfquery name="getCollName" datasource="#gDSN#">
		SELECT	DealershipName
		FROM	Dealers
		WHERE	DealerCode = '#g_dealercode#'
	</cfquery>
</cfif>

<cfif isDefined("URL.coll")>
	<cfquery name="getCollName2" datasource="#gDSN#">
		SELECT	DealershipName
		FROM	Dealers
		WHERE	DealerCode = '#URL.coll#'
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

<cfoutput>
<div align="center">
<table border="0" cellpadding="5" cellspacing="0">
<tr align="center">
	<form name="FindColl" action="select_dealer_edit.cfm" method="post">
	<td align="right">
		<b>Collection:</b>
	</td>
	<td align="left">
		<cfif accesslevel gt application.dealer_access>
			<select name="Collection" <cfif goodbrowser>onChange="onCollectionSelection()"</cfif>>
			<option value="no">Dealership Not In A Collection		
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
	</form>
</tr>
<tr align="center">
	<cfif mode eq "webTrends">
		<form name="getReport" action="traffic_report.cfm" target="newwindow" method="post">
	<cfelse>
		<form name="getLeads" action="leads.cfm" method="post">
	</cfif>
	<td align="right">
		<b>Dealership:</b>
	</td>
	<td align="left">
		<select name="Dealership">
		<cfif isDefined("url.coll")>
			<cfif url.coll neq "no">
				<option value="#url.coll#">#getCollName2.DealershipName# Website
			</cfif>
		<cfelseif (g_col)>
			<option value="#g_dealercode#">#getCollName.DealershipName# Website
		<cfelse>
			<option value="">Select a Dealer
		</cfif>
		<cfloop query="getDealers">
			<option value="#Dealercode#">#DealershipName#
		</cfloop>
		</select>
	</td>
</tr>
</table><br>
<input type="Image" src="#application.RELATIVE_PATH#/images/admin/continue.gif" BORDER="0" NAME="Continue" VALUE="Continue">
</form>
</div>
</cfoutput>