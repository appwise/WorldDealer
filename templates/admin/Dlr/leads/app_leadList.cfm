<!---
Created by Sigma6, Inc.
Copyright (c) 1998 Sigma6, Inc.
All Rights Reserved.  Used By Permission.

Sigma6, interactive media, Detroit/NYC
conceive : construct : connect
www.sigma6.com   webmaster@sigma6.com   info@sigma6.com

Last updated: <Jul 30, 1998>

Tim Taylor for sigma6, interactive media, Detroit
ttaylor@sigma6.com   www.sigma6.com    www.s6313.com
conceive : construct : connect

Sigma6, s6, and the Sigma6 logos are registered trademarks.
All other trademarks and servicemarks are the property of
their respective owners.
--->
<!--- $Id: app_leadList.cfm,v 1.4 1999/12/16 00:19:23 lswanson Exp $ --->

<!---
app_leadList.cfm - 
--->

<!--- skip logic if there's an error --->
<CFIF NOT isError>

	<!--- build where clause for select statement to query the general lead table --->
	<CFIF reportCoverage EQ "account">
		<CFIF #Left(AccessLevel,1)# EQ application.ACCOUNT_COORDINATOR_ACCESS>
			<CFSET accountClause = "Dealers.ACID = #RemoveChars(AccessLevel,1,2)#">
		<CFELSEIF #Left(AccessLevel,1)# EQ application.ACCOUNT_EXECUTIVE_ACCESS>
			<CFSET accountClause = "Dealers.AEID = #RemoveChars(AccessLevel,1,2)#">
		<CFELSEIF #Left(AccessLevel,1)# EQ application.SYSADMIN_ACCESS>
			<CFQUERY NAME="selectAccount" DATASOURCE="#gDSN#">
			SELECT
				AccountKey,
				AccountType
			FROM
				Accounts
			WHERE
				RowID = #accountRowID#
			</CFQUERY>
			
			<!--- set the appropriate where clause fragment, ACID = key or AEID = key --->
			<CFSET accountClause = "#selectAccount.AccountType#ID = #selectAccount.AccountKey#">
		<CFELSE>
			
			<!--- FIXME: this will bomb the WHERE clause in the lead query --->
			<CFSET accountClause = "">
		</CFIF>
	</CFIF>
	
	<!--- keep a malformed order direction from killing the query --->
	<CFIF (NOT orderDirection EQ "ASC") OR (NOT orderDirection EQ "DESC")>
		<CFSET orderDirection EQ "ASC">
	</CFIF>
	
	<!--- FIXME: by default, all dealers will be displayed if none of the CFIF conditions are true --->
	<CFQUERY NAME="selectLeadList" DATASOURCE="#gDSN#">
		SELECT
			RequestInfoGeneral.RequestInfoID,
			RequestInfoGeneral.RequestInfoTypeID,
			RequestInfoTypes.Description,
			RequestInfoGeneral.FName,
			RequestInfoGeneral.LName,
			RequestInfoGeneral.WhenSubmitted
		FROM
			RequestInfoGeneral, RequestInfoTypes
		WHERE
			RequestInfoGeneral.RequestInfoTypeID = RequestInfoTypes.RequestInfoTypeID
			AND RequestInfoGeneral.RequestInfoTypeID IN (#leadType#)
			
			<CFIF reportCoverage EQ "single">
			
				<!--- limit to leads from a single dealership --->
				AND RequestInfoGeneral.DealerCode = '#DealerCode#'
				
			<CFELSEIF reportCoverage EQ "account">

				<!--- limit to leads for all dealerships in the appropriate account --->
				AND RequestInfoGeneral.DealerCode IN (
					SELECT
						Dealers.DealerCode
					FROM
						Dealers
					WHERE
						#accountClause#
					)
			</CFIF>
			
		<!--- build order by clause --->
		<CFIF orderBy EQ "date">
			ORDER BY RequestInfoGeneral.WhenSubmitted #orderDirection#
		<CFELSEIF orderBy EQ "leadType">
			ORDER BY RequestInfoGeneral.RequestInfoTypeID #orderDirection#
		<CFELSEIF orderBy EQ "lastName">
			ORDER BY RequestInfoGeneral.LName #orderDirection#
		</CFIF>
	</CFQUERY>

	<!--- initialize start row first time --->
	<CFPARAM NAME="page" DEFAULT="1">
	<CFSET recordCount = selectLeadList.RecordCount>
	<CFSET pageCount = Ceiling(recordCount / RECORDS_PER_PAGE)>
	<CFSET startRow = ((page - 1) * RECORDS_PER_PAGE) + 1>
	<CFSET endRow = startRow + RECORDS_PER_PAGE - 1>
	<CFIF endRow GT recordCount>
		<CFSET endRow = recordCount>
	</CFIF>

	<!--- construct URL to pass query info --->
	<!--- XXX: use CFMODULE to automatically append form contents on URL --->
	<CFSET location = "index.cfm?"
			& "FromTemplate=dsp_leadList"
			& "&reportCoverage="  & reportCoverage
			& "&leadType=" & leadType
			& "&orderBy=" & orderBy
			& "&orderDirection=" & orderDirection>
	<CFIF reportCoverage EQ "single">
		<CFSET location = location & "&DealerCode=" & DealerCode>
	<CFELSEIF reportCoverage EQ "collect">
		<CFSET location = location & "&DealerCode=" & DealerCode>
	<CFELSEIF reportCoverage EQ "account">
		<CFSET location = location & "&accountRowID=" & accountRowID>
	</CFIF>
</CFIF>