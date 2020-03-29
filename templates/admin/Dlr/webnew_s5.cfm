<CFSET webnewstep = 5>
<CFINCLUDE template="security.cfm">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>

    <!-- ----------------------------------------------------------- -->
    <!--                 Created by sigma6, Detroit                  -->
    <!--         Copyright (c) 1997, 1998, 1999 sigma6.              -->
    <!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->

    <!-- ----------------------------------------------------------- -->
    <!--     John Turner for sigma6, interactive media, Detroit      -->
    <!--    jturner@sigma6.com   www.sigma6.com    www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
	<!--- $Id: webnew_s5.cfm,v 1.13 1999/12/22 23:42:00 lswanson Exp $ --->
	<!--- Dealership's New URL --->
	
<!--- Linda, 9/30/99: this page needs some more love.  
should be able to see all URLs at once, modify any existing ones, and delete any of them.
The messages should apply to the situation at hand, allowing for existing URLs being transferred.
The buttons should be more generic, take out use of word "Domain"; use Web Address instead. --->

<HEAD>

    <TITLE>WorldDealer | Create a New Web</TITLE>

	<!--- Set DealerCode --->
    <CFIF ParameterExists(URL.dlrcode)>
		<CFSET g_DealerCode = #URL.dlrcode#>
    <CFELSEIF ParameterExists(Form.DealerCode)>
        <CFSET g_DealerCode = #Form.DealerCode#>
	<CFELSE>
        <CFSET g_DealerCode = "">
    </CFIF>

    <CFIF ParameterExists(Form.btnCancel.X)>
        <CFLOCATION URL="webvrfy_s5.cfm?dlrcode=#g_DealerCode#">
    </CFIF>

    <!--- if domainOK = 0, then the whois script has been called, and
	      the domain is available.  --->
		  
    <!--- if domainOK = 1, then the whois script has been called, and
	      the domain is not available.  --->
		  
    <!--- if domainOK = 2, then the whois script has not been called.  --->
	
	<CFOUTPUT>
	<CFIF ParameterExists(URL.domainok)>
		<CFSET DomainOK = #URL.domainok#>
	<CFELSE>
	    <CFSET DomainOK = 2>
	</CFIF>

	<!--- 2nd domain --->
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
	
	<!--- get what's in the db now --->
	<CFQUERY NAME="getURL" datasource="#gDSN#">
		SELECT	URL
		FROM 	Dealers
		WHERE 	DealerCode = '#g_DealerCode#'
	</CFQUERY>
		
	<CFQUERY NAME="getURL2" datasource="#gDSN#">
		SELECT	URL
		FROM 	DealerURL
		WHERE 	DealerCode = '#g_DealerCode#'
	</CFQUERY>

	<!--- Set MODE flags --->
    <CFSET SaveMode = FALSE>
	<CFSET ReallySaveMode = FALSE>

    <CFIF ParameterExists(Form.btnSave.X)>
        <CFSET SaveMode = TRUE>
	    <CFSET Domainok = 999>  <!--- so it doesn't fall into any of the =0, =1, =2 code --->
		<CFSET Domain2ok = 999>
    </CFIF>
	
	<CFIF ParameterExists(Form.btnReallySave.X) OR
		  ParameterExists(URL.ok)>
		<CFSET ReallySaveMode = TRUE>
	</CFIF>
	   
	<!--- Update the DB with the URL(s) & email InterNic --->
    <CFIF ReallySaveMode>
		<CFOUTPUT>
		<CFIF ParameterExists(URL.domainname)>
			<CFSET domainname=#url.domainname#>
		<CFELSEIF ParameterExists(Form.domainname)>
			<CFSET domainname=#form.domainname#>
		</CFIF>
		
		<CFIF ParameterExists(URL.domainname2)>
			<CFSET domainname2=#url.domainname2#>
		<CFELSEIF ParameterExists(Form.domainname2)>
			<CFSET domainname2=#form.domainname2#>
		</CFIF>
		
		<CFIF #domainname# IS NOT "">
		 	<CFQUERY NAME="updateDLRWebs" datasource="#gDSN#">
				UPDATE 	DealerWebs          
        	    SET 	BaseURL = '#domainname#'
            	WHERE 	DealerCode = '#g_dealercode#'
	        </CFQUERY>

		 	<CFQUERY NAME="updateDLR" datasource="#gDSN#">
				UPDATE 	Dealers          
        	    SET 	URL = '#domainname#'
            	WHERE 	DealerCode = '#g_dealercode#'
	        </CFQUERY>
		</cfif>
	
		<CFIF #domainname2# IS NOT "">
			<!--- find secondary URL.  If it exists, update it; if not, add it. --->
			<CFQUERY NAME="getURL2" datasource="#gDSN#">
				SELECT 	URL
				FROM	DealerURL
	            WHERE 	DealerCode = '#g_dealercode#'
			</CFQUERY>
		
			<CFIF #getURL2.RecordCount# GT 0>
		 		<CFQUERY NAME="updateDLRURL" datasource="#gDSN#">
					UPDATE 	DealerURL
	                SET 	URL = '#domainname2#'
    	            WHERE 	DealerCode = '#g_dealercode#'
        		</CFQUERY>
			<CFELSE>
				<CFQUERY NAME="addDLRURL" datasource="#gDSN#">
					INSERT INTO	DealerURL (
								DealerCode,
								URL)
					VALUES		(
								'#g_dealercode#',
								'#domainname2#')
				</CFQUERY>
			</cfif>
		</CFIF>
		</cfoutput>
		
		<!--- this query is used in domain-template.htm --->
        <CFQUERY NAME="getDealerInfo2" datasource="#gDSN#">
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
		</CFQUERY>

		<!--- don't email internic if it's an existing url transfer --->
		<!--- Joel:  12.20.99 -- form.domainxfer is never defined at this point... 
					 12.21.99 -- all the logic is now contained in the domain-template.htm page...--->
		<!--- <cfif (form.domainXfer EQ 0) OR (form.domain2Xfer EQ 0)> --->
			<CFINCLUDE template="domain-template.htm">
		<!--- </cfif> --->
		<cfoutput>
		<CFLOCATION url="webvrfy_s5.cfm?dlrcode=#g_DealerCode#">
		</cfoutput>
    </CFIF>

	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>

<body>
<br><br><br><br><br>

<!--- Web Address is available --->
<CFIF DomainOK EQ 0 AND Domain2OK EQ 0>
	<div align="center">
	<TABLE CELLPADDING=10 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
	    <TR ALIGN="center">
    		<TD ALIGN="middle"><h3>Maintain Your Web Site - Web Address</h3></TD>
	    </TR>
        <TR>
            <TD>
				
				<CFIF #URL.domainname# IS NOT "" AND #URL.domainname2# IS NOT "">
				<!--- if both URLs are filled in --->
					The domains you've requested are available.  Click the <b>Next</b> button below to make them the domains for this dealer.
				<CFELSE>
				<!--- if either one is blank --->
					The domain you've requested is available.  Click the <b>Next</b> button below to make it the domain for this dealer.
				</cfif>
				
			</TD>
        </TR>
        <TR>
            <TD>
				<CFOUTPUT>
                <FORM NAME="StepFive" ACTION="#application.RELATIVE_PATH#/templates/admin/dlr/webnew_s5.cfm" METHOD="post">
				</CFOUTPUT>
                <TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0 WIDTH="100%">
        		   	<TR ALIGN=center>
                	   	<TD>
							<b>Primary Web Address:</b>
	        				<BR><b><CFOUTPUT>#URL.domainname#</CFOUTPUT></b><BR><BR>							
						</TD>
                   	</TR>
        		   	<TR ALIGN=center>
                	   	<TD>
							<b>Secondary Web Address:</b>
	        				<BR><b><CFOUTPUT>#URL.domainname2#</CFOUTPUT></b><BR><BR>							
						</TD>
                   	</TR>
                </TABLE>
            </TD>
        </TR>
        <TR ALIGN="center">
            <TD>
                <CFOUTPUT>
                <INPUT TYPE="hidden" NAME="DealerCode" VALUE=#g_DealerCode#>
				<INPUT type="hidden" name="domainname" value="#URL.domainname#">
				<INPUT type="hidden" name="domainname2" value="#URL.domainname2#">
				<input type="hidden" name="domainXfer" value="#URL.domainXfer#">
				<input type="hidden" name="domain2Xfer" value="#URL.domain2Xfer#">
                </CFOUTPUT>
                <INPUT TYPE="hidden" NAME="NextStep" VALUE="webnew_s6.cfm">
				<INPUT type="hidden" name="mode" value="dealer">
                &nbsp;&nbsp;
                <INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg" BORDER="0" NAME="btnCancel" VALUE="Cancel">
                &nbsp;&nbsp;
                <INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next_nav.jpg" BORDER="0" NAME="btnSave" VALUE="Save">
                </FORM>
                <p>
				<CFOUTPUT>
                <FORM NAME="f_Back" ACTION="#application.RELATIVE_PATH#/templates/admin/dlr/redirect.cfm" METHOD="post">
				</CFOUTPUT>
                <INPUT TYPE="Image"
					SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg"
					Border="0"
					NAME="BackToMain"
					VALUE="Back To Main Menu">
                </FORM>
			</TD>
        </TR>
	</TABLE>
	
	</div>
</CFIF>

<!--- Web Address is NOT available --->
<CFIF DomainOK EQ 1 OR Domain2OK EQ 1>
	<div align="center">
	<TABLE CELLPADDING=10 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
        <TR ALIGN="center">
        	<TD ALIGN="middle"><h3>Maintain Your Web Site - Web Address</h3></TD>
        </TR>
        <TR>
            <TD>
				<CFOUTPUT>
				
				<CFIF DomainOK EQ 1 AND Domain2OK EQ 1>
					The web addresses you've requested, <b>#URL.domainname#</b> and <b>#URL.domainname2#</b>,
					are either unavailable, or the system was unable to determine their availability via the Internet.
				<CFELSE>
					The domain you've requested,
					<CFIF #DomainOK# EQ 1>
						<b>#URL.domainname#</b>, 
					<CFELSE>
						<b>#URL.domainname2#</b>, 
					</cfif>
					is either unavailable, or the system was unable to determine its availability via the Internet.
				</CFIF>	
				<p>Check again later, or click <b>Try Another Domain</b>.
				
				</CFOUTPUT>
			</TD>
        </TR>
        <TR><TD>&nbsp;<p></TD></TR>
		<CFOUTPUT>
        <FORM NAME="StepFive" ACTION="#application.RELATIVE_PATH#/templates/admin/dlr/webnew_s5.cfm" METHOD="post">
		</CFOUTPUT>
        <TR ALIGN="center">
            <TD>
                <CFOUTPUT>
                <INPUT TYPE="hidden" NAME="DealerCode" VALUE=#g_DealerCode#>
				<CFIF #DomainOK# EQ 0>
					<INPUT TYPE="hidden" NAME="gooddomainname" VALUE=#URL.domainname#>
				</cfif>
				<CFIF #Domain2OK# EQ 0>
					<INPUT TYPE="hidden" NAME="gooddomainname2" VALUE=#URL.domainname2#>
				</cfif>
                </CFOUTPUT>
				<INPUT TYPE="hidden" NAME="NextStep" VALUE="webnew_s6.cfm">
				<INPUT type="hidden" name="mode" value="dealer">
                &nbsp;&nbsp;
                <INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg" BORDER="0" NAME="btnCancel" VALUE="Continue">
                &nbsp;&nbsp;
                <INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/tryanotherdomain.jpg" BORDER="0" NAME="btnTry" VALUE="Try Another Domain">
                </FORM>
                <p>
				<CFOUTPUT>
                <FORM NAME="f_Back" ACTION="#application.RELATIVE_PATH#/templates/admin/dlr/redirect.cfm" METHOD="post">
				</CFOUTPUT>
                <INPUT TYPE="Image"
					SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg"
					Border="0"
					NAME="BackToMain"
					VALUE="Back To Main Menu">
                </FORM>
			</TD>
        </TR>
	</TABLE>
	
	</div>
</CFIF>

<!--- Web Address hasn't been checked yet --->
<CFIF DomainOK EQ 2 OR Domain2OK EQ 2>
	<div align="center">
	<TABLE CELLPADDING=10 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
        <TR ALIGN="center">
            <TD ALIGN="middle">
				<h3>Maintain Your Web Site - Web Address</h3>
			</TD>
        </TR>
		<CFOUTPUT>
		<!--- if both URLs are blank & they clicked Check Domain, checkurl_redirect sets the DomainOK vars to 2,
		so they come back to this screen with an additional error message. --->
 		<CFIF ParameterExists(url.domainname) AND ParameterExists(url.domainname2)>
			<CFIF #url.domainname# EQ "" AND #url.domainname2# EQ "">
        		<TR>
		            <TD>
						
						You did not enter a web address before clicking the 'Check Domain' button.
						Click 'Cancel' if you do not wish to change your web address at this time.
						
					</TD>
        		</TR>
			</cfif>
 		</cfif>
		</cfoutput>
        <TR>
            <TD>
				Please enter the prefered web address for this dealer.
				For example, enter superdealer.com.  The domain's availability will be verified.
				If it is unavailable, you will be asked to provide another choice.
				<p>If you already own this domain, check the <b>Existing URL</b> checkbox, and your URL will be updated in our system without being verified.
			</TD>
        </TR>
        <TR>
            <TD>
				<FORM NAME="StepFive" ACTION="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/templates/admin/dlr/checkurl_redirect.cfm" METHOD="post">
                <TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0 WIDTH="100%">
					<CFOUTPUT>
        		   	<TR ALIGN=center>
						<td>
							<b>Existing URL?</b>
						</td>
                	   	<TD valign="bottom">
							<b>Primary Web Address:</b>
						</TD>
                   	</TR>
        		   	<TR ALIGN=center>
						<td>
							<!--- linda, 9/30/99: for some reason, getURL.RecordCount is returning 1, even when there's no URL entered.  so had to evaluate whether the URL field has an empty string or not. huff. --->
							<input type="checkbox" name="domainXfer" value="1"<CFIF #getURL.URL# GT ""> CHECKED</cfif>>
						</td>
                	   	<TD>
							www.<INPUT TYPE="text" NAME="domain" maxlength="30" 
							<CFIF ParameterExists(form.gooddomainname)>
								VALUE="#form.gooddomainname#"
							<CFELSE>
								VALUE="#getURL.URL#"
							</cfif>>
						</td>
					</tr>
					<tr align="center">
						<td>
							&nbsp;
						</td>
						<td>
							<b>Secondary Web Address:</b>
						</td>
					</tr>
        		   	<TR ALIGN=center>
						<td>
							<input type="checkbox" name="domain2Xfer" value="2"<CFIF #getURL2.URL# GT ""> CHECKED</cfif>>
						</td>
                	   	<TD>
	                        www.<INPUT TYPE="text" NAME="domain2" maxlength="40"
							<CFIF ParameterExists(form.gooddomainname2)>
								VALUE="#form.gooddomainname2#"
							<CFELSE>
								VALUE="#getURL2.URL#"
							</cfif>>
						</td>
					</tr>
					</cfoutput>
                </TABLE>
			</TD>
        </TR>
        <TR ALIGN="center">
            <TD>
                <CFOUTPUT>
                <INPUT TYPE="hidden" NAME="DealerCode" VALUE=#g_DealerCode#>
				<!--- for checkurl_redirect.cfm to know where to come back to --->
				<INPUT TYPE="hidden" NAME="returnurl" VALUE="#g_relpath#/templates/admin/dlr/webnew_s5.cfm">
                </CFOUTPUT>
                <INPUT TYPE="hidden" NAME="NextStep" VALUE="webnew_s6.cfm">
				<INPUT type="hidden" name="mode" value="dealer">
                &nbsp;&nbsp;
				<A HREF="webvrfy_s5.cfm?dlrcode=<cfoutput>#g_DealerCode#</cfoutput>"><IMG
					SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg"
					BORDER="0"
					NAME="btnCancel"
					VALUE="Cancel"></A>
                &nbsp;&nbsp;
                <INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/checkdomain.jpg"
					BORDER="0"
					NAME="btnCheck"
					VALUE="Check Web Address">
                </FORM>
			</TD>
        </TR>
	</TABLE>
	
	</div>
</CFIF>

<CFIF SaveMode>
	<!---- Check if a BaseURL is already registered --->
	<CFQUERY name="getURL" datasource="#gDSN#">
		SELECT 	BaseURL
		FROM 	DealerWebs
		WHERE 	DealerCode = '#g_dealercode#';
	</CFQUERY>

	<!---- Check if a Secondary URL is already registered --->
	<CFQUERY NAME="getURL2" datasource="#gDSN#">
		SELECT 	URL
		FROM	DealerURL
        WHERE 	DealerCode = '#g_dealercode#'
	</CFQUERY>

	<!--- if existing url or url2 & trying to add new url or url2, warn 1st --->	
	<CFIF (#getURL.BaseURL# IS NOT 'none' AND #form.domainname# IS NOT "") OR
		(#getURL2.RecordCount# GT 0 AND #form.domainname2# IS NOT "")>
		<div align="center">
		<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
    	<TR><TD>&nbsp;<p></TD></TR>
	    <TR ALIGN="center">
    		<TD ALIGN="middle"><h3>Maintain Your Web Site - Web Address</h3></TD>
	    </TR>
    	<TR ALIGN="center">
			<TD>
				<TABLE BORDER=0 WIDTH=90% BGCOLOR="FFFFFF">
				<TR ALIGN="center">
					<TD BGCOLOR="#FF0000">
						<FONT color="000000" size="+1"><b>CAUTION !</B></font>
					</TD>
				</TR>
				<TR><TD>&nbsp;</TD></TR>
				<TR>
					<TD>
						<CFOUTPUT>
						Your web site is currently registered with the domain 
						<CFIF #getURL.BaseURL# IS NOT 'none' AND #getURL2.RecordCount#>
							names, <b>#getURL.baseurl#</b> and <b>#getURL2.URL#</b>.
						<CFELSE>
							name, 
							<CFIF #getURL.BaseURL# IS NOT 'none'>
								<b>#getURL.baseurl#</b>.
							<CFELSEIF #getURL2.RecordCount#>
								<b>#getURL2.URL#</b>.
							</cfif>
						</cfif>
						<p>You have chosen to register your web site with the new
						<CFIF #form.domainname# IS NOT "" AND #form.domainname2# IS NOT "">
							web addresses, <b>#form.domainname#</b> and <b>#form.domainname2#</b>.
						<CFELSE>
							<CFIF #form.domainname# IS NOT "">
								Primary Web Address, <b>#form.domainname#</b>.
							<CFELSEIF #form.domainname2# IS NOT "">
								Secondary Web Address, <b>#form.domainname2#</b>.
							</cfif>
						</CFIF>
						<p>Please note that changing your web address will cause your web site to become <b>UNAVAILABLE</b>
						for a few days until the web address registration process has been completed.
						<p>Click <b>Save and Continue</b> if you wish to continue, and your new web address
						request will be automatically forwarded to the InterNic Domain Registration Service.
						You will be notified once the new domain 
						<CFIF #form.domainname# IS NOT "" AND #form.domainname2# IS NOT "">
							names, <b>#form.domainname#</b> and <b>#form.domainname2#</b>, have
						<CFELSE>
							 name, 
							<CFIF #form.domainname# IS NOT "">
								<b>#form.domainname#</b>,
							<CFELSEIF #form.domainname2# IS NOT "">
								<b>#form.domainname2#</b>,
							</cfif>
							has
						</CFIF>
						been registered.
						<p>Click <b>Cancel</b> to leave your web address(es) unchanged.
						</CFOUTPUT>
					</TD>
				</TR>
				</TABLE>
			</TD>
		</TR>
		<TR><TD>&nbsp;</TD></TR><!--- ?dlrcode=<cfoutput>#g_dealercode#</cfoutput> --->
    	<FORM NAME="StepFive" ACTION="webnew_s5.cfm" METHOD="post">
	    <TR ALIGN="center">
    	    <TD>
        	    <CFOUTPUT>
            	<INPUT TYPE="hidden" NAME="DealerCode" VALUE=#g_DealerCode#>
				<INPUT type="hidden" name="domainname" value="#form.domainname#">
				<INPUT type="hidden" name="domainname2" value="#form.domainname2#">
				<input type="hidden" name="domainXfer" value="#form.domainXfer#">
				<input type="hidden" name="domain2Xfer" value="#form.domain2Xfer#">
        	    <INPUT TYPE="hidden" NAME="NextStep" VALUE="webnew_s6.cfm">
				<INPUT type="hidden" name="mode" value="dealer">
	            &nbsp;&nbsp;
    	        <INPUT TYPE="Image" SRC="#application.RELATIVE_PATH#/images/admin/cancel_nav.jpg" BORDER="0" NAME="btnCancel" VALUE="Cancel">
        	    &nbsp;&nbsp;
            	<INPUT TYPE="Image" SRC="#application.RELATIVE_PATH#/images/admin/saveandcontinue_nav.jpg" BORDER="0" NAME="btnReallySave" VALUE="Save">
	            </CFOUTPUT>
    	        </FORM>
        	    <p>
            	<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
	            	<INPUT TYPE="Image"
					SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg"
					Border="0"
					NAME="BackToMain"
					VALUE="Back To Main Menu">
	            </FORM>
			</TD>
		</TR>
		</TABLE>
		
		</div>
	<CFELSE>
		<CFLOCATION url="webnew_s5.cfm?dlrcode=#g_dealercode#&ok=yes&domainname=#form.domainname#&domainname2=#form.domainname2#">
	</CFIF>
</CFIF>

</BODY>
</HTML>