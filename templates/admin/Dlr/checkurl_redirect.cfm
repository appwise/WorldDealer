<!--- $Id: checkurl_redirect.cfm,v 1.6 1999/12/22 23:41:59 lswanson Exp $ --->

<!--- if both are blank, reset the domainOKs --->
<CFIF #Form.domain# IS "" AND #Form.domain2# IS "">
	<CFSET DomainOK = 2>	
	<CFSET Domain2ok = 2>
<CFELSE>
	<!--- check the domain name --->
	<CFIF #Form.domain# IS "">
		<!--- if 1 is blank, say it's OK, so that if 1 is blank and 2 is a changed URL, it'll go thru --->
		<CFSET DomainOK = 0>	
	<CFELSE>
		<!--- if existing URL to be transfered, don't do whois check. --->
		<CFIF ParameterExists(Form.domainXfer)>
			<CFSET DomainOK = 0>			
		<cfelse>
			<CFHTTP METHOD="Post" URL="http://#g_imagegen2#/scripts/whois.pl">
    			<CFHTTPPARAM TYPE="formfield" Name="domain" Value="#form.domain#">
			</CFHTTP>

			<CFIF CFHTTP.FileContent IS "AVAILABLE">
				<CFSET DomainOK = 0>
			<CFELSE>
				<CFSET DomainOK = 1>	
			</CFIF>
		</cfif>
	</cfif>

	<!--- check the 2nd domain name --->
	<CFIF #Form.domain2# IS "">
		<!--- if 2 is blank, say it's OK, so that if 1 is a changed URL & 2 is blank, it'll go thru --->
		<CFSET Domain2ok = 0>
	<CFELSE>
		<!--- if existing URL to be transfered, don't do whois check. --->
		<CFIF ParameterExists(Form.domain2Xfer)>
			<CFSET Domain2OK = 0>			
		<cfelse>
			<CFHTTP METHOD="Post" URL="http://#g_imagegen2#/scripts/whois.pl">
    			<CFHTTPPARAM TYPE="formfield" Name="domain" Value="#form.domain2#"><!--- domain vs. domain2, because whois.pl is expecting domain --->
			</CFHTTP>

			<CFIF CFHTTP.FileContent IS "AVAILABLE">
				<CFSET Domain2ok = 0>
			<CFELSE>
				<CFSET Domain2ok = 1>	
			</CFIF>
		</CFIF>
	</CFIF>
</CFIF>

<!---
  DEBUG INFO:<BR>  
  Requested Name: <CFOUTPUT>#form.domain#</CFOUTPUT><BR>  
  Script to Use: <CFOUTPUT>http://#g_imagegen2#/scripts/whois.pl</CFOUTPUT><BR>  
  CFHTTP File Contents: <CFOUTPUT>#CFHTTP.filecontent#</CFOUTPUT><BR> 
  URL.dlrcode:  <CFOUTPUT>#Form.DealerCode#</CFOUTPUT>
  <CFABORT> 
--->

<CFOUTPUT>
<INPUT TYPE="hidden" NAME="DealerCode" VALUE=#Form.DealerCode#>
<cfif IsDefined ("form.domainXfer")>
	<cfset domxfr = form.domainXfer>
<cfelse>
	<cfset domxfr = 0>
</cfif>
<cfif IsDefined ("form.domain2Xfer")>
	<cfset dom2xfr = form.domain2Xfer>
<cfelse>
	<cfset dom2xfr = 0>
</cfif>
<CFLOCATION URL="#form.returnurl#?dlrcode=#form.DealerCode#&domainok=#Domainok#&domain2ok=#Domain2ok#&domainname=#form.domain#&domainname2=#form.domain2#&domainXfer=#domxfr#&domain2Xfer=#dom2xfr#">
</cfoutput>

<!--- from when there was just 1 domain to check:
<CFOUTPUT>
<CFSET GoodLocation="#form.returnurl#?domainok=0&domainname=#form.domain#&domainname2=#form.domain2#">
<CFSET  BadLocation="#form.returnurl#?domainok=1&domainname=#form.domain#&domainname2=#form.domain2#">
</CFOUTPUT>

<CFIF CFHTTP.FileContent IS "AVAILABLE">
    <CFLOCATION URL=#GoodLocation#>
<CFELSE>
    <CFLOCATION URL=#BadLocation#>
</CFIF> 
--->