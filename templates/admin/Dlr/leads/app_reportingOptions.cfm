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
<!--- $Id: app_reportingOptions.cfm,v 1.5 1999/12/16 00:20:23 lswanson Exp $ --->

<!---
app_reportingOptions.cfm - query some stuff for lead reporting options
--->

<!--- determine which options optionState to show --->
<CFSET START = 0>
<CFSET BASIC_OPTIONS = 1>
<CFSET CHOOSE_COLLECTION = 2>
<CFSET CHOOSE_DEALER = 4>
<CFSET CHOOSE_ACCOUNT = 6>

<CFSET optionState = START>

<CFIF NOT isError>
	<CFIF FromTemplate EQ "redirect">
		<CFSET optionState = BASIC_OPTIONS>
	<CFELSEIF FromTemplate EQ "dsp_reportingOptions">
		<CFIF FuseAction EQ "submitBasicOptions">		
			<CFIF (Form.reportCoverage EQ "single")
					AND ((#Left(AccessLevel,1)# EQ application.SYSADMIN_ACCESS)
					OR (#Left(AccessLevel,1)# EQ application.ACCOUNT_EXECUTIVE_ACCESS))>
				<CFSET optionState = CHOOSE_COLLECTION>
			<CFELSE>
				<CFSET optionState = CHOOSE_DEALER>
			</CFIF>
		<CFELSEIF FuseAction EQ "limitDealerSearch">
			<CFIF IsDefined("Form.btnBack.X")>
				<CFSET optionState = BASIC_OPTIONS>
			<CFELSE>
				<CFSET optionState = CHOOSE_DEALER>
			</CFIF>
		<CFELSEIF FuseAction EQ "chooseDealer" AND IsDefined("Form.btnBack.X")>
			<CFSET optionState = CHOOSE_COLLECTION>
		</CFIF>
	<CFELSEIF FromTemplate EQ "dsp_leadList">
		<CFIF FuseAction EQ "back">
			<CFSET optionState = BASIC_OPTIONS>
		</CFIF>
	</CFIF>
	
	<CFIF optionState EQ START>
		<CFSET isError = TRUE>
		<CFSET errorString = "error determining which option screen to display">
	</CFIF>
</CFIF>