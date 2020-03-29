<CFINCLUDE template="security.cfm">
<!--- Standard disclaimer: MSRP. Title and taxes extra. --->
<!--- $Id: di_form_1.cfm,v 1.3 1999/11/24 22:54:03 lswanson Exp $ --->

<!---- No User Custom text in this Disclaimer,  --->
<!--- Forward to next step ---->
<CFIF #IsDefined("variables.national_offer")#>
	<CFSET #variables.dealercode# = 'flag'>
	<CFINCLUDE template="nationaloffers.cfm">
<CFELSE>
	<CFINCLUDE template="di_template3.cfm">
</CFIF>