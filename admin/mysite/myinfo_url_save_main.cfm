                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 10, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: myinfo_url_save_main.cfm,v 1.8 2000/06/15 17:11:21 jkrauss Exp $--->

<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: myinfo_url_save_main.cfm,v $">

<cfset savemode = false>

<cfif parameterexists(form.save.x)>
	<cfset savemode = true>
	<!--- so it doesn't fall into any of the =0, =1, =2 code --->
	<cfset domainok = 999>
	<cfset domain2ok = 999>
</cfif>

<cfif savemode>
	<!---- Check if a URL is already registered --->
	<cfquery name="getURL" datasource="#gDSN#">
		SELECT 	URL
		FROM 	Dealers
		WHERE 	DealerCode = '#g_dealercode#';
	</cfquery>

	<!---- Check if a Secondary URL is already registered --->
	<cfquery name="getURL2" datasource="#gDSN#">
		SELECT 	URL
		FROM	DealerURL
        WHERE 	DealerCode = '#g_dealercode#'
	</cfquery>

	<!--- if existing url or url2 & trying to add new url or url2, warn 1st --->	
	<cfif (#geturl.URL# is not 'none' and #form.domainname# is not "") or
		(#geturl2.recordcount# gt 0 and #form.domainname2# is not "")>
		<div align="center">
		<table width="100%" border="0" cellspacing="0" cellpadding="5">
    	<tr align="center">
			<td>
				<table border=0 width=90% bgcolor="FFFFFF">
				<tr align="center">
					<td bgcolor="#FF0000">
						<font color="000000" size="+1"><b>CAUTION !</b></font>
					</td>
				</tr>
				<tr><td>&nbsp;</td></tr>
				<tr>
					<td>
						<cfoutput>
						Your Website is currently registered with the domain 
						<cfif #geturl.URL# is not 'none' and #geturl2.recordcount#>
							names, <b>#getURL.URL#</b> and <b>#getURL2.URL#</b>.
						<cfelse>
							name, 
							<cfif #geturl.URL# is not 'none'>
								<b>#getURL.URL#</b>.
							<cfelseif #geturl2.recordcount#>
								<b>#getURL2.URL#</b>.
							</cfif>
						</cfif>
						<p>You have chosen to register your Website with the new
						<cfif #form.domainname# is not "" and #form.domainname2# is not "">
							web addresses, <b>#form.domainname#</b> and <b>#form.domainname2#</b>.
						<cfelse>
							<cfif #form.domainname# is not "">
								Primary Web Address, <b>#form.domainname#</b>.
							<cfelseif #form.domainname2# is not "">
								Secondary Web Address, <b>#form.domainname2#</b>.
							</cfif>
						</cfif>
						<p>Please note that changing your web address will cause your Website to become <b>UNAVAILABLE</b>
						for a few days until the web address registration process has been completed.
						<p>Click <b>Save and Continue</b> if you wish to continue, and your new web address
						request will be automatically forwarded to the InterNic Domain Registration Service.
						You will be notified once the new domain 
						<cfif #form.domainname# is not "" and #form.domainname2# is not "">
							names, <b>#form.domainname#</b> and <b>#form.domainname2#</b>, have
						<cfelse>
							 name, 
							<cfif #form.domainname# is not "">
								<b>#form.domainname#</b>,
							<cfelseif #form.domainname2# is not "">
								<b>#form.domainname2#</b>,
							</cfif>
							has
						</cfif>
						been registered.
						<p>Click <b>Cancel</b> to leave your web address(es) unchanged.
						</cfoutput>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr><td>&nbsp;</td></tr>
    	<form name="StepFive" action="myinfo_url_save.cfm" METHOD="post">
	    <tr align="center">
    	    <td>
        	    <cfoutput>
            	<input type="hidden" name="DealerCode" value=#g_dealercode#>
				<input type="hidden" name="domainname" value="#form.domainname#">
				<input type="hidden" name="domainname2" value="#form.domainname2#">
				<input type="hidden" name="domainXfer" value="#form.domainXfer#">
				<input type="hidden" name="domain2Xfer" value="#form.domain2Xfer#">
				<input type="hidden" name="mode" value="dealer">
				
            	<input type="Image" src="#application.RELATIVE_PATH#/images/admin/save.gif" border="0" name="SaveMe" value="Save"><p>
				<a href="myinfo_url.cfm"><img src="#application.RELATIVE_PATH#/images/admin/cancel.gif" border="0"></a>
	            </cfoutput>
    	        </form>
			</td>
		</tr>
		</table>
		
		</div>
	<cfelse>
		<cflocation url="myinfo_url.cfm?ok=yes&domainname=#form.domainname#&domainname2=#form.domainname2#">
	</cfif>
<cfelse>
<!--- ReallySave mode --->


	<cfif parameterexists(url.domainname)>
		<cfset domainname=#url.domainname#>
	<cfelseif parameterexists(form.domainname)>
		<cfset domainname=#form.domainname#>
	</cfif>
	
	<cfif parameterexists(url.domainname2)>
		<cfset domainname2=#url.domainname2#>
	<cfelseif parameterexists(form.domainname2)>
		<cfset domainname2=#form.domainname2#>
	</cfif>
	
	<cfif #domainname# is not "">
		<cfquery name="updateDLRWebs" datasource="#gDSN#">
			UPDATE 	DealerWebs          
			SET 	BaseURL = '#domainname#'
			WHERE 	DealerCode = '#g_dealercode#'
		</cfquery>
		
		<cfquery name="updateDLR" datasource="#gDSN#">
			UPDATE 	Dealers          
			SET 	URL = '#domainname#'
			WHERE 	DealerCode = '#g_dealercode#'
		</cfquery>
	</cfif>
	
	<cfif #domainname2# is not "">
		<!--- find secondary URL.  If it exists, update it; if not, add it. --->
		<cfquery name="getURL2" datasource="#gDSN#">
			SELECT 	URL
			FROM	DealerURL
			WHERE 	DealerCode = '#g_dealercode#'
		</cfquery>
		
		<cfif #geturl2.recordcount# gt 0>
			<cfquery name="updateDLRURL" datasource="#gDSN#">
				UPDATE 	DealerURL
				SET 	URL = '#domainname2#'
				WHERE 	DealerCode = '#g_dealercode#'
			</cfquery>
		<cfelse>
			<cfquery name="addDLRURL" datasource="#gDSN#">
				INSERT INTO	DealerURL (DealerCode,URL)
				VALUES		('#g_dealercode#','#domainname2#')
			</cfquery>
		</cfif>
	</cfif>
	
	<!--- this query is used in domain-template.htm --->
	<cfquery name="getDealerInfo2" datasource="#gDSN#">
		SELECT
			DealerCode,
			DealershipName,
			AddressLine1,
			AddressLine2,
			City,
			StateAbbr,
			Zip,
			ContactName,
			ContactPhone,
			Phone,
			FaxPhone
		FROM
			Dealers
		WHERE
			DealerCode = '#g_dealercode#'
	</cfquery>
	
	<!--- don't email internic if it's an existing url transfer --->
	<!--- Joel:  12.20.99 -- form.domainxfer is never defined at this point... 
				 12.21.99 -- all the logic is now contained in the domain-template.htm page...--->
				 
	<cfif (form.domainxfer eq 0) or (form.domain2xfer eq 0)>
		<cfinclude template="domain-template.htm">
	</cfif>
	
	<cflocation url="myinfo_url.cfm" addtoken="no">
</cfif>

<cfmodule template="/util/DumpDebug.cfm" text="end   $RCSfile: myinfo_url_save_main.cfm,v $">
