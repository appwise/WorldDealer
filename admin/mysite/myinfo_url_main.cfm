                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 10, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: myinfo_url_main.cfm,v 1.14 2000/03/08 22:54:30 lswanson Exp $--->

<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: myinfo_url_main.cfm,v $">

<CFOUTPUT>
	<CFIF ParameterExists(URL.domainok)>
		<CFSET DomainOK = #URL.domainok#>
	<CFELSE>
		<CFSET DomainOK = 2>
	</CFIF>
	<CFIF ParameterExists(URL.domain2ok)>
		<CFSET Domain2OK = #URL.domain2ok#>
	<CFELSE>
		<CFSET Domain2OK = 2>
	</CFIF>	
</CFOUTPUT>
		
<!--- whether the domain name is being transfered or not --->
<CFIF ParameterExists(URL.domainXfer)>
	<CFSET DomainXfer = #URL.domainXfer#>
<CFELSEIF ParameterExists(Form.domainXfer)>
    <CFSET DomainXfer = #Form.domainXfer#>
</CFIF>

<CFIF ParameterExists(URL.domain2Xfer)>
	<CFSET Domain2Xfer = #URL.domain2Xfer#>
<CFELSEIF ParameterExists(Form.domain2Xfer)>
    <CFSET Domain2Xfer = #Form.domain2Xfer#>
</CFIF>

<cfquery name="getURL" datasource="worlddlr">
	SELECT	URL
	FROM 	Dealers
	WHERE 	DealerCode = '#g_dealercode#'
</cfquery>
	
<cfquery name="getURL2" datasource="worlddlr">
	SELECT	URL
	FROM 	DealerURL
	WHERE 	DealerCode = '#g_dealercode#'
</cfquery>
	
<!--- Web Address is available --->
<cfif domainok eq 0 and domain2ok eq 0>
	<table width="100%" border="0" cellspacing="0" cellpadding="5">
	    <tr>
    		<td>			
			<cfif #url.domainname# is not "" and #url.domainname2# is not "">
			<!--- if both URLs are filled in --->
				The domains you've requested are available.  Click <b>Continue</b> below to make them the domains for this dealer.
			<cfelse>
			<!--- if either one is blank --->
				The domain you've requested is available.  Click <b>Continue</b> below to make it the domain for this dealer.
			</cfif><p>
			
				<div align="center">
				<form action="myinfo_url_save.cfm" method="POST">
				<table cellspacing=0 cellpadding=0 border=0>
				<tr>
					<td align="RIGHT"><b>Primary Web Address:</b></td>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><cfoutput>#URL.domainname#</cfoutput></td>
				</tr>
				<tr>
					<td align="RIGHT"><b>Secondary Web Address:</b></td>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><cfoutput>#URL.domainname2#</cfoutput></td>
				</tr>
                </table><p>
				
                <cfoutput>
                <input type="hidden" name="DealerCode" value=#g_dealercode#>
				<input type="hidden" name="domainname" value="#URL.domainname#">
				<input type="hidden" name="domainname2" value="#URL.domainname2#">
				<input type="hidden" name="domainXfer" value="#URL.domainXfer#">
				<input type="hidden" name="domain2Xfer" value="#URL.domain2Xfer#">
                </cfoutput>
				<input type="hidden" name="mode" value="dealer">
				</div>
			</td>
        </tr>
		<tr>
			<td align="center">&nbsp;<br>
			<input type="Image" name="Save" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/continue.gif" border="0"><br>&nbsp;</td>
		</tr>
		</form>
		<tr>
			<td align="center"><a href="myinfo_url.cfm"><img src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/cancel.gif" border="0"></a></td>
		</tr>
	</table>
</cfif>

<!--- Web Address is NOT available --->
<cfif domainok eq 1 or domain2ok eq 1>
	<div align="center">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
        	<td><b>Maintain Your Website - Web Address</b><p>
			
			<cfoutput>
				
			<cfif domainok eq 1 and domain2ok eq 1>
				The Web addresses you've requested, <b>#URL.domainname#</b> and <b>#URL.domainname2#</b>,
				are either unavailable, or the system was unable to determine their availability via the Internet.
			<cfelse>
				The domain you've requested,
				<cfif #domainok# eq 1>
					<b>#URL.domainname#</b>, 
				<cfelse>
					<b>#URL.domainname2#</b>, 
				</cfif>
				is either unavailable, or the system was unable to determine its availability via the Internet.
			</cfif>	
			<p>Check again later, or click <b>Try Another Domain</b>.
			
			</cfoutput>
			</td>
        </tr>
		<cfoutput>
        <form>
		</cfoutput>
        <tr align="center">
            <td>
                <cfoutput>
                <input type="hidden" name="DealerCode" value=#g_dealercode#>
				<cfif #domainok# eq 0>
					<input type="hidden" name="gooddomainname" value=#url.domainname#>
				</cfif>
				<cfif #domain2ok# eq 0>
					<input type="hidden" name="gooddomainname2" value=#url.domainname2#>
				</cfif>
                </cfoutput>
				<input type="hidden" name="NextStep" value="webnew_s6.cfm">
				<input type="hidden" name="mode" value="dealer">
                &nbsp;&nbsp;
                <input type="button" value="continue">
                &nbsp;&nbsp;
                 <input type="button" value="try another domain">
                </form>
			</td>
        </tr>
	</table>
	
	</div>
</cfif>

<!--- Web Address hasn't been checked yet --->
<cfif domainok eq 2 or domain2ok eq 2>
	<form action="myinfo_url_redirect.cfm" method="post">
	<input type="hidden" name="returnurl" value="myinfo_url.cfm">
	<table width="100%" border="0" cellspacing="0" cellpadding="5">
	<tr>
		<td>
		<!--- if both URLs are blank & they clicked Check Domain, checkurl_redirect sets the DomainOK vars to 2,
		so they come back to this screen with an additional error message. --->
		<cfif parameterexists(url.domainname) and parameterexists(url.domainname2)>
			<cfif #url.domainname# eq "" and #url.domainname2# eq "">	
				You did not enter a Web address before clicking the 'Check Domain' button.  Click 'Cancel' if you do not wish to change your Web address at this time.<p>
			</cfif>
		</cfif>
	
		Please enter the prefered Web address for this dealer.  For example, enter superdealer.com.  The domain's availability will be verified.  If it is unavailable, you will be asked to provide another choice.<p>
		
		If you already own this domain, check the <b>Existing URL</b> checkbox, and your URL will be updated in our system without being verified.<p>
		
			<div align="center">
			<table cellspacing=0 cellpadding=0 border=0>
			<cfoutput>
			<tr align=center>
				<td><b>Existing URL?</b></td>
				<td><b>Primary Web Address:</b></td>
			</tr>
			<tr align=center>
				<td>
					<!--- linda, 9/30/99: for some reason, getURL.RecordCount is returning 1, even when there's no URL entered.  so had to evaluate whether the URL field has an empty string or not. huff. --->
					<input type="checkbox" name="domainXfer" value="1"<cfif #geturl.url# gt ""> CHECKED</cfif>>
				</td>
				<td>
					www.<input type="text" name="domain" maxlength="30" <cfif parameterexists(form.gooddomainname)>VALUE="#form.gooddomainname#"<cfelse>VALUE="#getURL.URL#"</cfif>>
				</td>
			</tr>
			<tr align="center">
				<td>&nbsp;</td>
				<td><b>Secondary Web Address:</b></td>
			</tr>
			<tr align=center>
				<td>
					<input type="checkbox" name="domain2Xfer" value="2"<cfif #geturl2.url# gt ""> CHECKED</cfif>>
				</td>
				<td>
					www.<input type="text" name="domain2" maxlength="40" <cfif parameterexists(form.gooddomainname2)>VALUE="#form.gooddomainname2#"<cfelse>VALUE="#getURL2.URL#"</cfif>>
				</td>
			</tr>
			</cfoutput>
			<tr>
				<td colspan="2" align="center">
					<br>
					<a href="myinfo.cfm"><img src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/back.gif" border="0" width="46" height="15" alt="Back"></a>
					&nbsp;
					<input type="Image" name="CheckDomains" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/continue.gif" border="0">
				</td>
			</tr>
			</form>
			</table>
			</div>		
		</td>
	</tr>
	</table>
</cfif>
<cfmodule template="/util/DumpDebug.cfm" text="end   $RCSfile: myinfo_url_main.cfm,v $">
