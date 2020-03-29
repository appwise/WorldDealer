<CFIF #IsDefined ("URL.ID")#>
	<CFSET Variables.ID = #URL.ID#>
</CFIF>

<CFQUERY name="getdisclaimer" datasource="#gDSN#">
SELECT DisclaimerText
FROM CustomDisclaimers
WHERE DisclaimerID=#ID#;
</CFQUERY>

<CFSET #display_text# = #Replace(getDisclaimer.DisclaimerText,Chr(13),"<BR>","ALL")#>

<CFOUTPUT query="getdisclaimer">#display_text#</CFOUTPUT>
