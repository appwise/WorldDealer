<CFINCLUDE template="security.cfm">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!--- Created by Sigma6, Inc. (c)1998 --->
<!--- $Id: webvrfy_webcheck.cfm,v 1.6 1999/11/29 15:31:02 lswanson Exp $ --->


<HTML>

<HEAD>
	<TITLE>WorldDealer</TITLE>

	<CFIF NOT IsDefined("URL.dlrcode")>
		<CFLOCATION URL="webfind.cfm">
		<CFABORT>
	<CFELSE>
		<CFSET g_DealerCode = URL.dlrcode>
	</CFIF>
	
	<CFIF IsDefined("FromTemplate")>
		<!--- if genexe_redirect was redirected back here, then we need to generate maps also --->
		<CFIF FromTemplate EQ "genexe_redirect">
		
			<!--- generate maps then go to step 2 --->
			<CFMODULE TEMPLATE="genmap.cfm"
					windowTitle="Dealer Administration, Create Maps"
					screenTitle="Dealer Administration - Create New Web"
					nextStep="#g_relpath#/templates/admin/dlr/webvrfy_s2.cfm?dlrcode=#g_DealerCode#"
					dealerCode="#g_DealerCode#">
			<CFABORT>
		</CFIF>
	</CFIF>
	
	<CFQUERY NAME="selectDealerWebCount" datasource="#gDSN#">
	SELECT COUNT(*) AS dealerWebCount
	FROM
		dealerwebs
	WHERE
		dealercode = '#g_DealerCode#';
	</CFQUERY>
	
	<CFIF selectDealerWebCount.dealerWebCount IS NOT 0>
	
		<!--- dealer already has a dealer web setup --->
		<CFLOCATION URL="webvrfy_s2.cfm?dlrcode=#g_DealerCode#">
	<CFELSE>
	
		<!--- create a new dealer web for this dealer --->
		<CFTRANSACTION>
			<CFQUERY NAME="insertDealerWeb" datasource="#gDSN#">
			INSERT INTO	dealerwebs (
				dealercode,
				webstateid,
				baseURL,
				arttempid,
				CalculatorYesNo,
				BodyShopYesNo
				)
			VALUES	(
				'#g_DealerCode#',
				5,
				'none',
				4,
				'Y',
				'Y'
				);
			</CFQUERY>
	
			<CFQUERY name="selectDealerInfo" datasource="#gDSN#">
			SELECT
				DealerWebs.DealerWebID,
				Dealers.StateAbbr,
				Dealers.DisplayName
			FROM
				DealerWebs,
				Dealers
			WHERE
				Dealers.DealerCode = '#g_DealerCode#'
				AND DealerWebs.DealerCode = Dealers.DealerCode;
			</CFQUERY>
		</CFTRANSACTION>
		
		<!--- generate logos then redirect back here to generate maps --->
		<CFMODULE TEMPLATE="genexe.cfm"
				windowTitle="Dealer Administration, Create Logos"
				screenTitle="Dealer Administration - Create New Web"
				nextStep="#g_relpath#/templates/admin/dlr/webvrfy_webcheck.cfm?dlrcode=#g_DealerCode#"
				uniqueID="#g_DealerCode#"
				displayName="#selectDealerInfo.displayName#">
		<CFABORT>
	</CFIF>

	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>

<body>
<br><br><br><br><br>



</BODY>
</HTML>
