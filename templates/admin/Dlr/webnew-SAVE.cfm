<CFINCLUDE template="security.cfm">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>

    <!-- ----------------------------------------------------------- -->
    <!--       Created by sigma6, Detroit       -->
    <!--         Copyright (c) 1997, 1998, 1999 sigma6.              -->
    <!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->

    <!-- ----------------------------------------------------------- -->
    <!--     John Turner for sigma6, interactive media, Detroit      -->
    <!--    jturner@sigma6.com   www.sigma6.com    www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
	<!--- $Id: webnew-SAVE.cfm,v 1.5 1999/11/29 15:30:57 lswanson Exp $ --->

<HEAD>

        <TITLE>WorldDealer | Create a New web</TITLE>
	
	<SCRIPT LANGUAGE="JavaScript">
	<!--
		function phoneevent(which){
		document.StepOne.elements[which + 'Phone'].value=document.StepOne.elements[which + 'Phone1'].value + document.StepOne.elements[which + 'Phone2'].value + document.StepOne.elements[which + 'Phone3'].value;
		}
	//-->
	</SCRIPT>

    <CFIF ParameterExists(URL.dlrcode)>
           <CFSET g_DealerCode = #URL.dlrcode#>
           <CFSET EditMode = TRUE>
           <CFSET NewMode = FALSE>
           <CFSET SaveMode = FALSE>
        <CFELSE>
           <CFSET g_DealerCode = "">
           <CFSET NewMode = TRUE>
           <CFSET EditMode = FALSE>
           <CFSET SaveMode = FALSE>
        </CFIF>
        
        <CFIF ParameterExists(Form.btnSave)>
           <CFSET SaveMode = TRUE>
           <CFSET g_DealerCode = #Form.DealerCode#>
        </CFIF>

    <CFIF ParameterExists(Form.btnCancel)>
           <CFSET CancelMode = TRUE>
           <CFIF Form.DealerCode EQ ''>
               <CFLOCATION URL="webfind.cfm">
       <CFELSE>      
               <CFLOCATION URL="webvrfy.cfm?dlrcode=#Form.DealerCode#">
           </CFIF>
        </CFIF>
        
    <CFIF EditMode>
       <!--- user is coming at this page with a dealer already selected --->
       <CFQUERY NAME="getDealerInfo" datasource="#gDSN#">
              SELECT DMGID as q_DMGID,
                         DealerCode as q_DealerCode,
                         DealershipName as q_DealershipName,
                                 AddressLine1 as q_AddressLine1,
                                 AddressLine2 as q_AddressLine2,
                                 City as q_City,
                                 StateAbbr as q_StateAbbr,
                                 Zip as q_Zip,
                                 ContactName as q_ContactName,
                                 ContactPhone as q_ContactPhone,
                                 Phone as q_Phone,
                                 FaxPhone as q_FaxPhone,
								 Tagline as q_Tagline
                    FROM Dealers
                   WHERE Dealers.DealerCode = '#g_DealerCode#'
           </CFQUERY>

       <CFQUERY NAME="getDMGName" datasource="#gDSN#">
          SELECT Name as q_Name,
                         Description as q_Description
                    FROM DealerMarketingGroups
                   WHERE DealerMarketingGroups.DMGID
                      IN (SELECT DMGID FROM Dealers WHERE Dealers.DealerCode = '#g_DealerCode#')
           </CFQUERY>   

    </CFIF>

    <CFIF SaveMode>
        
           <CFIF g_DealerCode GT ''>

				<!--- Query DB To see if DealershipName has changed --->
				<CFQUERY name="GetInfo" datasource="#gDSN#">
					SELECT DealershipName
					FROM Dealers
					WHERE DealerCode = '#g_dealercode#';
				</CFQUERY>
				
            <!--- we already have a dealer code, so do an update, not an insert --->
		
		<!--- 	<CFQUERY name="UpdateDealerWebs" datasource="#gDSN#">
						UPDATE DealerWebs
						SET DealerCode = '#Form.DealerCodeIN#'
						WHERE DealerCode = '#g_DealerCode#';
						</CFQUERY>ok1 --->
						
                <CFQUERY NAME="updateDLR" datasource="#gDSN#">
                     UPDATE Dealers
                                           SET  DMGID = #Form.DMGName#,
                                                DealershipName = '#Form.DealershipName#',
                                                AddressLine1 = '#Form.Address1#',
                                                AddressLine2 = '#Form.Address2#',
                                                City = '#Form.City#',
                                        StateAbbr = '#Form.StateAbbr#',
                                                Zip = '#Form.Zip#',
                                                ContactName = '#Form.ContactName#',
                                                ContactPhone = '#Form.ContactPhone#',
                                                Phone = '#Form.Phone#',
                                                FaxPhone = '#Form.FaxPhone#',
												TagLine='#Form.Tagline#'
											<!--- 	DealerCode = '#Form.DealerCodeIN#' --->
                                  WHERE Dealers.DealerCode = '#g_DealerCode#'
                        </CFQUERY> ok               
                        
						
						<CFSET #G_DealerCode# = #form.DealerCodeIN#>
						
                   <!--- <CFLOCATION URL=webvrfy.cfm?dlrcode=#Form.DealerCode#> --->
				   
				   <!--- Call Java Image Generator to Create Default Coupon --->
				<CFIF #getInfo.Dealershipname# IS NOT #form.dealershipname#>
				   	<CFLOCATION URL="genexe.cfm?dlrcode=#g_DealerCode#">
				<CFELSE>
					<CFLOCATION URL="webvrfy.cfm?dlrcode=#g_dealercode#">
				</CFIF>
					

       <CFELSE>

                <!--- first, we need to get the next available Dealer Code --->
            <!---
                    <CFQUERY NAME="getMaxDLRCode" datasource="#gDSN#">
                             SELECT MAX(DealerCode) as max_DLRCode
                                   FROM Dealers
                </CFQUERY>
                        --->
        
                <!--- dealer code is a char, so convert to an int, then increment by 1 to get
                      a unique dealer code --->
            <!---
                <CFSET tmp_DLRCode = InputBaseN(getMaxDLRCode.max_DLRCode, 10) + 1>
                    <CFSET g_DealerCode = FormatBaseN(tmp_DLRCode, 10)>
                    --->
                                        
                    <!--- insert the row....use a web state of '5', which means 'In Progress' --->
                <CFQUERY NAME="insertDLR" datasource="#gDSN#">
                     INSERT INTO Dealers ( DealerCode,
                                                       WebStateID,
                                                                           DMGID,
                                                                           DealershipName,
                                                                           AddressLine1,
                                                                           AddressLine2,
                                                                           City,
                                                       StateAbbr,
                                                                           Zip,
                                                                           ContactName,
                                                                           ContactPhone,
                                                                           Phone,
                                                                           FaxPhone)
                                              VALUES ( '#Form.DealerCodeIn#',
                                                                   5,
                                                                           #Form.DMGName#,
                                                                           '#Form.DealershipName#',
                                                                           '#Form.Address1#',
                                                                           '#Form.Address2#',
                                                           '#Form.City#',
                                                                           '#Form.StateAbbr#',
                                                                           '#Form.Zip#',
                                                                           '#Form.ContactName#',
                                                                           '#Form.ContactPhone#',
                                                                           '#Form.Phone#',
                                                                           '#Form.FaxPhone#')
                        </CFQUERY>                                
				   	 <CFLOCATION URL="genexe.cfm?dlrcode=#g_DealerCode#">
                </CFIF>
					
    </CFIF>
        
        <CFQUERY NAME="getDMGNames" datasource="#gDSN#">
                 SELECT DMGID as q_DMGID,
                                Name as q_Name
                           FROM DealerMarketingGroups
        </CFQUERY>
        
        <CFQUERY NAME="getStates" datasource="#gDSN#">
                 SELECT StateAbbr as q_StateAbbr,
                                Description as q_Description
                           FROM States
                   ORDER BY Description
        </CFQUERY>

	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>

<body>
<br><br><br><br><br>

<div align="center">
<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=520 BGCOLOR="FFFFFF">
        <TR><TD>&nbsp;<p></TD></TR>
        <TR ALIGN="center">
                <TD ALIGN="middle"><h3><FONT FACE="Arial,Helvetica">Dealer Administration - Create New Web</FONT></h3></TD>
        </TR>
        <TR ALIGN="center">
                <TD ALIGN="middle"><FONT FACE="Arial,Helvetica">Enter or verify dealership information below, as appropriate.  Required fields are bolded.</FONT></TD>
        </TR>
        <TR><TD>&nbsp;<p></TD></TR>
        <TR>
            <TD>
               <CFFORM NAME="StepOne" ACTION="webnew.cfm" ENABLECAB="Yes">
                <TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0 WIDTH="100%">
                     <TR>
                            <TD ALIGN="right"><b><font face="Arial,Helvetica">Dealer Code</font></b></TD>
                                <TD>&nbsp;&nbsp;&nbsp;</TD>
                                <CFIF EditMode>
                                <TD><CFINPUT TYPE=text
                                             NAME="DealerCodeIn"
                                                         MESSAGE="Please enter a dealer code for this dealership."
                                                         SIZE=6
                                                         VALUE=#getDealerInfo.q_DealerCode#
                                                         MAXLENGTH=6></TD>
                                <CFELSE>
                                <TD><CFINPUT TYPE=text
                                            NAME="DealerCodeIn"
                                                         MESSAGE="Please enter a dealer code for this dealership."
                                                         SIZE=6
                                                         MAXLENGTH=6></TD>
                                </CFIF>
                         </TR>
                   <TR>
                        <TD ALIGN="right"><b><font face="Arial,Helvetica">DMG Name</font></b></TD>
                              <TD>&nbsp;&nbsp;&nbsp;</TD>
                              <CFIF EditMode>
                                    <CFOUTPUT QUERY="getDealerInfo">
                                            <CFSET tmpDMGID = #q_DMGID#>
                                        </CFOUTPUT>
                                <TD><CFSELECT NAME="DMGName"
                                                          MESSAGE="Please select a DMG for this Dealership."
                                                          MULTIPLE="no"
                                                          QUERY="getDMGNames"
                                                          SIZE="1"
                                                          DISPLAY="q_Name"
                                                          SELECTED=#tmpDMGID#

                                                          VALUE="q_DMGID">                         
                                        </CFSELECT></TD>
                                <CFELSE>
                                <TD><CFSELECT NAME="DMGName"
                                                          MESSAGE="Please select a DMG for this Dealership."
                                                          MULTIPLE="no"
                                                          QUERY="getDMGNames"
                                                          SIZE="1"
                                                          DISPLAY="q_Name"
                                                          VALUE="q_DMGID">                         
                                        </CFSELECT></TD>
                                </CFIF>
                         </TR>
                     <TR>
                            <TD ALIGN="right"><b><font face="Arial,Helvetica">Dealership Name</font></b></TD>
                                <TD>&nbsp;&nbsp;&nbsp;</TD>
                                <CFIF EditMode>
                                <TD><CFINPUT TYPE=text

                                             NAME="dealershipname"
                                                         MESSAGE="Please enter a name for this Dealership."
                                                         SIZE=35

                                                         VALUE=#getDealerInfo.q_DealershipName#

                                                         MAXLENGTH=35></TD>
                                <CFELSE>
                                <TD><CFINPUT TYPE=text

                                             NAME="dealershipname"
                                                         MESSAGE="Please enter a name for this Dealership."
                                                         SIZE=35

                                                         MAXLENGTH=35></TD>
                                </CFIF>
                         </TR>
                     <TR>
                            <TD ALIGN="right"><b><font face="Arial,Helvetica">Address 1</font></b></TD>
                                <TD>&nbsp;&nbsp;&nbsp;</TD>
                                <CFIF EditMode>
                                <TD><CFINPUT TYPE=text

                                             NAME="Address1"
                                                         MESSAGE="Please enter an address for this dealership."
                                                         SIZE=40

                                                         VALUE=#getDealerInfo.q_AddressLine1#

                                                         MAXLENGTH=40></TD>
                                <CFELSE>
                                <TD><CFINPUT TYPE=text

                                             NAME="Address1"
                                                         MESSAGE="Please enter an address for this dealership."
                                                         SIZE=40

                                                         MAXLENGTH=40></TD>
                                </CFIF>
                         </TR>
                     <TR>
                            <TD ALIGN="right"><font face="Arial,Helvetica">Address 2</font></TD>
                                <TD>&nbsp;&nbsp;&nbsp;</TD>
                                <CFIF EditMode>
                                    <CFOUTPUT QUERY="getDealerInfo">
                                                <TD><INPUT TYPE=text NAME="Address2" SIZE=40 MAXLENGTH=40 VALUE="#q_AddressLine2#"></TD>
                                        </CFOUTPUT>
                                <CFELSE>
                                <TD><INPUT TYPE=text NAME="Address2" SIZE=40 MAXLENGTH=40 TABINDEX=3></TD>
                                </CFIF>
                         </TR>
                     <TR>
                            <TD ALIGN="right"><b><font face="Arial,Helvetica">City</font></b></TD>
                                <TD>&nbsp;&nbsp;&nbsp;</TD>
                                <CFIF EditMode>
                                <TD><CFINPUT TYPE=text

                                             NAME="City"
                                                         MESSAGE="Please enter a city for this dealership."
                                                         SIZE=35

                                                         VALUE=#getDealerInfo.q_City#

                                                         MAXLENGTH=35></TD>
                                <CFELSE>
                                <TD><CFINPUT TYPE=text

                                             NAME="City"
                                                         MESSAGE="Please enter a city for this dealership."
                                                         SIZE=35

                                                         MAXLENGTH=35></TD>
                                </CFIF>
                         </TR>
                     <TR>
                            <TD ALIGN="right"><b><font face="Arial,Helvetica">State</font></b></TD>
                                <TD>&nbsp;&nbsp;&nbsp;</TD>
                                <CFIF EditMode>
                                    <CFOUTPUT QUERY="getDealerInfo">
                                            <CFSET tmpStateAbbr = #q_StateAbbr#>
                                        </CFOUTPUT>
                                <TD><CFSELECT NAME="StateAbbr"
                                                          MESSAGE="Please select the state where this Dealership is located."
                                                          MULTIPLE="no"
                                                          QUERY="getStates"
                                                          SIZE="1"
                                                          DISPLAY="q_Description"
                                                          SELECTED="#tmpStateAbbr#"
                                                          VALUE="q_StateAbbr">
                                        </CFSELECT></TD>
                                <CFELSE>
                                <TD><CFSELECT NAME="StateAbbr"
                                                          MESSAGE="Please select the state where this Dealership is located."
                                                          MULTIPLE="no"
                                                          QUERY="getStates"
                                                          SIZE="1"
                                                          DISPLAY="q_Description"
                                                          VALUE="q_StateAbbr">
                                        </CFSELECT></TD>
                                </CFIF>
                         </TR>
                     <TR>
                            <TD ALIGN="right"><b><font face="Arial,Helvetica">Zip Code</font></b></TD>
                                <TD>&nbsp;&nbsp;&nbsp;</TD>
                                <CFIF EditMode>
                                <TD><CFINPUT TYPE=text

                                             NAME="Zip"
                                                         MESSAGE="Please enter a valid USPS Zip Code for this Dealership."
                                                         SIZE=10

                                                         VALUE=#getDealerInfo.q_Zip#

                                                         MAXLENGTH=10

                                                         VALIDATE="zipcode">
														 <FONT FACE="arial,helvetica">
														 	&nbsp;<b>XXXXX</b> or <b>XXXXX-XXXX</b>
														</FONT>
								</TD>
                                <CFELSE>
                                <TD><CFINPUT TYPE=text

                                             NAME="Zip"
                                                         MESSAGE="Please enter a valid USPS Zip Code for this Dealership."
                                                         SIZE=10

                                                         MAXLENGTH=10

                                                         VALIDATE="zipcode">&nbsp;<b>XXXXX</b> or <b>XXXXX-XXXX</b></TD>
                                </CFIF>
                         </TR>
                     <TR>
                            <TD ALIGN="right"><b><font face="Arial,Helvetica">Dealership Phone</font></b></TD>
                                <TD>&nbsp;&nbsp;&nbsp;</TD>
                                <CFIF EditMode>
                                <TD>
									<CFIF #Len(getDealerInfo.q_Phone)# eq 10>
									<CFINPUT TYPE=text
										NAME="Phone1"
										MESSAGE="Please enter a valid Phone Number."
										SIZE=3
										VALUE=#RemoveChars(getDealerInfo.q_Phone,4,10)#
										MAXLENGTH=3
										OnChange="phoneevent('');">
									<CFINPUT TYPE=text
										NAME="Phone2"
										MESSAGE="Please enter a valid Phone Number."
										SIZE=3
										VALUE=#Mid(getDealerInfo.q_Phone,4,3)#
										MAXLENGTH=3
										OnChange="phoneevent('');">
									<CFINPUT TYPE=text
										NAME="Phone3"
										MESSAGE="Please enter a valid Phone Number."
										SIZE=4
										VALUE=#RemoveChars(getDealerInfo.q_Phone,1,6)#
										MAXLENGTH=4
										OnChange="phoneevent('');">
									<CFELSE>
									<CFINPUT TYPE=text
										NAME="Phone1"
										MESSAGE="Please enter a valid Phone Number."
										SIZE=3
										MAXLENGTH=3
										OnChange="phoneevent('');">
									<CFINPUT TYPE=text
										NAME="Phone2"
										MESSAGE="Please enter a valid Phone Number."
										SIZE=3
										MAXLENGTH=3
										OnChange="phoneevent('');">
									<CFINPUT TYPE=text
										NAME="Phone3"
										MESSAGE="Please enter a valid Phone Number."
										SIZE=4
										MAXLENGTH=4
										OnChange="phoneevent('');">
									</CFIF>
									<CFOUTPUT QUERY="getDealerInfo">
										<INPUT TYPE="hidden" NAME="Phone" VALUE="#q_phone#">
									</CFOUTPUT>
								</TD>
                                <CFELSE>
                                <TD>
									<CFINPUT TYPE=text
										NAME="Phone1"
										MESSAGE="Please enter a valid Phone Number."
										SIZE=3
										MAXLENGTH=3
										OnChange="phoneevent('');">
									<CFINPUT TYPE=text
										NAME="Phone2"
										MESSAGE="Please enter a valid Phone Number."
										SIZE=3
										MAXLENGTH=3
										OnChange="phoneevent('');">
									<CFINPUT TYPE=text
										NAME="Phone3"
										MESSAGE="Please enter a valid Phone Number."
										SIZE=4
										MAXLENGTH=4
										OnChange="phoneevent('');">
<!--- 									<CFOUTPUT QUERY="getDealerInfo">
										<INPUT TYPE="hidden" NAME="Phone" VALUE="#q_phone#">
									</CFOUTPUT> --->
								</TD>
                                </CFIF>
                         </TR>
                     <TR>
                            <TD ALIGN="right"><b><font face="Arial,Helvetica">Fax Number</font></b></TD>
                                <TD>&nbsp;&nbsp;&nbsp;</TD>
                                <CFIF EditMode>
                                <TD>
									<CFIF #Len(getDealerInfo.q_FaxPhone)# eq 10>
									<CFINPUT TYPE=text
										NAME="FaxPhone1"
										MESSAGE="Please enter a valid Fax Phone Number."
										SIZE=3
										VALUE=#RemoveChars(getDealerInfo.q_FaxPhone,4,10)#
										MAXLENGTH=3
										OnChange="phoneevent('Fax');">
									<CFINPUT TYPE=text
										NAME="FaxPhone2"
										MESSAGE="Please enter a valid Fax Phone Number."
										SIZE=3
										VALUE=#Mid(getDealerInfo.q_FaxPhone,4,3)#
										MAXLENGTH=3
										OnChange="phoneevent('Fax');">
									<CFINPUT TYPE=text
										NAME="FaxPhone3"
										MESSAGE="Please enter a valid Fax Phone Number."
										SIZE=4
										VALUE=#RemoveChars(getDealerInfo.q_FaxPhone,1,6)#
										MAXLENGTH=4
										OnChange="phoneevent('Fax');">
										
									<CFELSE>
									<CFINPUT TYPE=text
										NAME="FaxPhone1"
										MESSAGE="Please enter a valid Fax Phone Number."
										SIZE=3
										MAXLENGTH=3
										OnChange="phoneevent('Fax');">
									<CFINPUT TYPE=text
										NAME="FaxPhone2"
										MESSAGE="Please enter a valid Fax Phone Number."
										SIZE=3
										MAXLENGTH=3
										OnChange="phoneevent('Fax');">
									<CFINPUT TYPE=text
										NAME="FaxPhone3"
										MESSAGE="Please enter a valid Fax Phone Number."
										SIZE=4
										MAXLENGTH=4
										OnChange="phoneevent('Fax');">
									</CFIF>
									<CFOUTPUT QUERY="getDealerInfo">
										<INPUT TYPE="hidden" NAME="FaxPhone" VALUE="#q_Faxphone#">
									</CFOUTPUT>
								</TD>
                                <CFELSE>
                                <TD>
									<CFINPUT TYPE=text
										NAME="FaxPhone1"
										MESSAGE="Please enter a valid Fax Phone Number."
										SIZE=3
										MAXLENGTH=3
										OnChange="phoneevent('Fax');">
									<CFINPUT TYPE=text
										NAME="FaxPhone2"
										MESSAGE="Please enter a valid Fax Phone Number."
										SIZE=3
										MAXLENGTH=3
										OnChange="phoneevent('Fax');">
									<CFINPUT TYPE=text
										NAME="FaxPhone3"
										MESSAGE="Please enter a valid Fax Phone Number."
										SIZE=4
										MAXLENGTH=4
										OnChange="phoneevent('Fax');">
<!--- 									<CFOUTPUT QUERY="getDealerInfo">
										<INPUT TYPE="hidden" NAME="FaxPhone" VALUE="#q_Faxphone#">
									</CFOUTPUT> --->
								</TD>
                                </CFIF>
                         </TR>
                     <TR>
                            <TD ALIGN="right"><b><font face="Arial,Helvetica">Contact Name</font></b></TD>
                                <TD>&nbsp;&nbsp;&nbsp;</TD>
                                <CFIF EditMode>
                                <TD><CFINPUT TYPE=text

                                             NAME="ContactName"
                                                         MESSAGE="Please enter a Contact Name for this Dealership."
                                                         SIZE=35

                                                         VALUE=#getDealerInfo.q_ContactName#

                                                         MAXLENGTH=50></TD>
                                <CFELSE>
                                <TD><CFINPUT TYPE=text

                                             NAME="ContactName"
                                                         MESSAGE="Please enter a Contact Name for this Dealership."
                                                         SIZE=35

                                                         MAXLENGTH=50></TD>
                                </CFIF>
                         </TR>
                     <TR>
                            <TD ALIGN="right"><b><font face="Arial,Helvetica">Contact Phone</font></b></TD>
                                <TD>&nbsp;&nbsp;&nbsp;</TD>
                                <CFIF EditMode>
                                <TD>
									<CFIF #Len(getDealerInfo.q_ContactPhone)# eq 10>
									<CFINPUT TYPE=text
										NAME="ContactPhone1"
										MESSAGE="Please enter a valid Contact Phone Number."
										SIZE=3
										VALUE=#RemoveChars(getDealerInfo.q_ContactPhone,4,10)#
										MAXLENGTH=3
										OnChange="phoneevent('Contact');">
									<CFINPUT TYPE=text
										NAME="ContactPhone2"
										MESSAGE="Please enter a valid Contact Phone Number."
										SIZE=3
										VALUE=#Mid(getDealerInfo.q_ContactPhone,4,3)#
										MAXLENGTH=3
										OnChange="phoneevent('Contact');">
									<CFINPUT TYPE=text
										NAME="ContactPhone3"
										MESSAGE="Please enter a valid Contact Phone Number."
										SIZE=4
										VALUE=#RemoveChars(getDealerInfo.q_ContactPhone,1,6)#
										MAXLENGTH=4
										OnChange="phoneevent('Contact');">
									<CFELSE>
									<CFINPUT TYPE=text
										NAME="ContactPhone1"
										MESSAGE="Please enter a valid Contact Phone Number."
										SIZE=3
										MAXLENGTH=3
										OnChange="phoneevent('Contact');">
									<CFINPUT TYPE=text
										NAME="ContactPhone2"
										MESSAGE="Please enter a valid Contact Phone Number."
										SIZE=3
										MAXLENGTH=3
										OnChange="phoneevent('Contact');">
									<CFINPUT TYPE=text
										NAME="ContactPhone3"
										MESSAGE="Please enter a valid Contact Phone Number."
										SIZE=4
										MAXLENGTH=4
										OnChange="phoneevent('Contact');">
									</CFIF>
									<CFOUTPUT QUERY="getDealerInfo">
										<INPUT TYPE="hidden" NAME="ContactPhone" VALUE="#q_contactphone#">
									</CFOUTPUT>
								</TD>
                                <CFELSE>
                                <TD>
									<CFINPUT TYPE=text
										NAME="ContactPhone1"
										MESSAGE="Please enter a valid Contact Phone Number."
										SIZE=3
										MAXLENGTH=3
										OnChange="phoneevent('Contact');">
									<CFINPUT TYPE=text
										NAME="ContactPhone2"
										MESSAGE="Please enter a valid Contact Phone Number."
										SIZE=3
										MAXLENGTH=3
										OnChange="phoneevent('Contact');">
									<CFINPUT TYPE=text
										NAME="ContactPhone3"
										MESSAGE="Please enter a valid Contact Phone Number."
										SIZE=4
										MAXLENGTH=4
										OnChange="phoneevent('Contact');">
<!--- 									<CFOUTPUT QUERY="getDealerInfo">
										<INPUT TYPE="hidden" NAME="ContactPhone" VALUE="#q_contactphone#">
									</CFOUTPUT> --->
								</TD>
                                </CFIF>
								</TR>
								<TR>
								<TD ALIGN="right"><b><font face="Arial,Helvetica">Tag Line</font></b></TD>
                                <TD>&nbsp;&nbsp;&nbsp;</TD>
								<CFIF Editmode>
								 <TD><CFINPUT TYPE=text
								 			   NAME="TagLine"
											   SIZE="40"
											   VALUE=#getDealerInfo.q_tagline#
											   MAXLENGTH="150">
								</TD>
								<CFELSE>
								<TD><CFINPUT TYPE=text
								 			   NAME="TagLine"
											   SIZE="40"
											   MAXLENGTH="150">
								</TD>
								</CFIF>
								
                         </TR>
             <TR><TD>&nbsp;<p></TD></TR>
                  </TABLE>
                </TD>
        </TR>
        <TR ALIGN="center">
            <TD>
                        <CFOUTPUT>
                            <INPUT TYPE="hidden" NAME="DealerCode" VALUE=#g_DealerCode#>
                                </CFOUTPUT>
                                <INPUT TYPE="hidden" NAME="NextStep" VALUE="webnew_s2.cfm">
                            <INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg" BORDER="0" NAME="btnCancel" VALUE="Cancel">
                &nbsp;&nbsp;
                            <INPUT TYPE="submit" NAME="btnSave" VALUE="Save">
                        </CFFORM>
                    <p>
                    <FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
                            <INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg" Border="0" NAME="BackToMain" VALUE="Back To Main Menu"></FORM></TD>
        </TR>
</TABLE>
<P>
<IMG SRC="</CFOUTPUT>#application.RELATIVE_PATH#<CFOUTPUT>/images/demosite/logo_gra.gif"
		BORDER=0
		WIDTH=175
		HEIGHT=24
</div>

</BODY>
</HTML>