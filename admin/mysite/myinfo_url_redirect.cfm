                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 10, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!--- $Id: myinfo_url_redirect.cfm,v 1.7 2000/06/15 17:11:20 jkrauss Exp $ --->

<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: myinfo_url_redirect.cfm,v $">
<cfset PageAccess = application.sysadmin_access>
<cfinclude template = "../security.cfm">

<!--- if both are blank, reset the domainOKs --->
<CFIF #Form.domain# eq "" AND #Form.domain2# eq "">
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

<CFOUTPUT>
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
<CFLOCATION URL="#form.returnurl#?domainok=#Domainok#&domain2ok=#Domain2ok#&domainname=#form.domain#&domainname2=#form.domain2#&domainXfer=#domxfr#&domain2Xfer=#dom2xfr#" ADDTOKEN="no">
</cfoutput>

<cfmodule template="/util/DumpDebug.cfm" text="end   $RCSfile: myinfo_url_redirect.cfm,v $">
