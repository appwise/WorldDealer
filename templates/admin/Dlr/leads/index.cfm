<CFSETTING ENABLECFOUTPUTONLY="YES">
<CFINCLUDE TEMPLATE="../security.cfm">
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
<!--- $Id: index.cfm,v 1.4 1999/12/16 00:17:51 lswanson Exp $ --->

<!---
index.cfm - lead reporting FUSEBOX
--->


<!--- lead reporting specific constants --->
<CFSET QUOTE_LEAD = 1>
<CFSET PERSONAL_FINANCE_LEAD = 2>
<CFSET BUSINESS_FINANCE_LEAD = 3>
<CFSET APPOINTMENT_SERVICE_LEAD = 4>
<CFSET PARTS_SERVICE_LEAD = 5>
<CFSET PHONE_NUMBER_LENGTH = 9>
<CFSET RECORDS_PER_PAGE = 10>
<CFSET MAX_JUMPS = 10>

<!--- error checking --->
<CFSET isError = FALSE>
<CFSET errorString = "">

<!--- main redirections --->
<CFIF NOT IsDefined("FromTemplate")>
	<CFMODULE TEMPLATE="default.cfm">
	<CFEXIT>
<CFELSE>
	<!--- XXX: use CFMODULE and caller variables instead of CFINCLUDE --->
	<cfswitch expression="#FromTemplate#">
	<cfcase value="redirect">
		<CFMODULE TEMPLATE="err_reportingOptions.cfm">
		<CFINCLUDE TEMPLATE="app_reportingOptions.cfm">
		<CFINCLUDE TEMPLATE="dsp_reportingOptions.cfm">
		<CFEXIT>
	</cfcase>
	
	<cfcase value="dsp_reportingOptions">
		<CFIF NOT IsDefined("FuseAction")>
			<CFMODULE TEMPLATE="default.cfm">
			<CFEXIT>
		<CFELSE>
			<CFSWITCH expression="#FuseAction#">
				<CFCASE value="submitBasicOptions">
					<!--- determine if we have enough criteria to list leads --->
					<CFIF (Form.reportCoverage EQ "all")
							OR ((Form.reportCoverage EQ "single")
								AND (#Left(AccessLevel,1)# EQ application.DEALER_ACCESS))
							OR ((Form.reportCoverage EQ "account")
								AND ((#Left(AccessLevel,1)# EQ application.ACCOUNT_COORDINATOR_ACCESS)
									OR (#Left(AccessLevel,1)# EQ application.ACCOUNT_EXECUTIVE_ACCESS)))>
						<CFMODULE TEMPLATE="err_leadList.cfm">
						<CFINCLUDE TEMPLATE="app_leadList.cfm">
						<CFINCLUDE TEMPLATE="dsp_leadList.cfm">
						<CFEXIT>
					<CFELSE>
						<CFMODULE TEMPLATE="err_reportingOptions.cfm">
						<CFINCLUDE TEMPLATE="app_reportingOptions.cfm">
						<CFINCLUDE TEMPLATE="dsp_reportingOptions.cfm">
						<CFEXIT>
					</CFIF>
				</cfcase>
				
				<cfcase value="limitDealerSearch">
					<CFMODULE TEMPLATE="err_reportingOptions.cfm">
					<CFINCLUDE TEMPLATE="app_reportingOptions.cfm">
					<CFINCLUDE TEMPLATE="dsp_reportingOptions.cfm">
					<CFEXIT>
				</cfcase>
				
				<cfcase value="chooseDealer">
					<CFMODULE TEMPLATE="err_leadList.cfm">
					<CFINCLUDE TEMPLATE="app_leadList.cfm">
					<CFINCLUDE TEMPLATE="dsp_leadList.cfm">
					<CFEXIT>
				</cfcase>
				
				<cfdefaultcase>
					<CFMODULE TEMPLATE="default.cfm">
					<CFEXIT>
				</cfdefaultcase>
			</cfswitch>
		</CFIF>
	</cfcase>
	
	<cfcase value="dsp_leadList">
		<CFIF IsDefined("Form.btnShowLeadDetail.X")>
			<CFSET FuseAction = "showLeadDetail">
		<CFELSEIF IsDefined("Form.btnBack.X")>
			<CFSET FuseAction = "back">
		</CFIF>
	
		<CFIF NOT IsDefined("FuseAction")>
			<CFMODULE TEMPLATE="default.cfm">
			<CFEXIT>
		<CFELSE>
			<CFSWITCH expression="#FuseAction#">
				<CFCASE value="showLeadDetail">
					<CFMODULE TEMPLATE="err_leadDetail.cfm">
					<CFINCLUDE TEMPLATE="app_leadDetail.cfm">
					<CFINCLUDE TEMPLATE="dsp_leadDetail.cfm">
					<CFEXIT>
				</cfcase>
				
				<cfcase value="back">
					<CFMODULE TEMPLATE="err_reportingOptions.cfm">
					<CFINCLUDE TEMPLATE="app_reportingOptions.cfm">
					<CFINCLUDE TEMPLATE="dsp_reportingOptions.cfm">
					<CFEXIT>
				</cfcase>
				
				<cfcase value="jump">
					<CFMODULE TEMPLATE="err_leadList.cfm">
					<CFINCLUDE TEMPLATE="app_leadList.cfm">
					<CFINCLUDE TEMPLATE="dsp_leadList.cfm">
					<CFEXIT>
				</cfcase>
				
				<cfdefaultcase>
					<CFMODULE TEMPLATE="default.cfm">
					<CFEXIT>
				</cfdefaultcase>
			</cfswitch>
		</CFIF>
	</cfcase>
	
	<cfdefaultcase>
		<CFMODULE TEMPLATE="default.cfm">	<!--- error msg --->
		<CFEXIT>
	</cfdefaultcase>
	</cfswitch>
</cfif>