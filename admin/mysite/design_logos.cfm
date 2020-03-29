<cfquery name="getDealerInfo" datasource="#gDSN#">
	SELECT	DisplayName
	FROM 	Dealers 
	WHERE	DealerCode = '#g_dealercode#'
</cfquery>
	
<cfmodule template="genexe.cfm"
		windowtitle="WorldDealer My Site -- Create Logos"
		screentitle="Create Logos"
		nextstep="#application.RELATIVE_PATH#/admin/mysite/design.cfm"
		uniqueid="#g_dealercode#"
		displayname="#getdealerinfo.displayName#">