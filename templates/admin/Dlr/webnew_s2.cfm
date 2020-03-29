<CFSET webnewstep = 2>
<CFINCLUDE template="security.cfm">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>

    <!-- ----------------------------------------------------------- -->
    <!--             Created by sigma6, Detroit                      -->
    <!--         Copyright (c) 1997, 1998, 1999 sigma6.              -->
    <!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->

    <!-- ----------------------------------------------------------- -->
    <!--     John Turner for sigma6, interactive media, Detroit      -->
    <!--    jturner@sigma6.com   www.sigma6.com    www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
	<!--- $Id: webnew_s2.cfm,v 1.12 2000/01/05 22:23:51 jkrauss Exp $ --->
	<!--- Dealer Info, Cont'd.  AE, AC, Dealer's Name & email --->

<HEAD>

        <TITLE>WorldDealer | Create a New Web</TITLE>

    	<CFIF ParameterExists(URL.dlrcode)>
           <CFSET g_DealerCode = #URL.dlrcode#>
           <CFSET EditMode = TRUE>
           <CFSET NewMode = FALSE>
        <CFELSE>
           <CFSET g_DealerCode = "">
           <CFSET NewMode = TRUE>
           <CFSET EditMode = FALSE>
        </CFIF>
        
        <CFIF ParameterExists(Form.btnSave.X)>
           <CFSET SaveMode = TRUE>
           <CFSET g_DealerCode = #Form.DealerCode#>
		<CFELSE>
           <CFSET SaveMode = FALSE>		
        </CFIF>

    	<CFIF ParameterExists(Form.btnCancel.X)>
           <CFSET CancelMode = TRUE>
           <CFLOCATION URL="webvrfy_s2.cfm?dlrcode=#Form.DealerCode#">
        </CFIF>

    <CFIF EditMode>

            <CFQUERY NAME="getDealerInfo" datasource="#gDSN#">
                      SELECT *
					  FROM	Dealers
                      WHERE DealerCode = '#g_DealerCode#'
                </CFQUERY>

            <CFQUERY NAME="getAEInfo" datasource="#gDSN#">
                 SELECT AEID,
                        FirstName as AEFirstName,
                        LastName as AELastName
                  FROM  AccountExecs
                  WHERE AccountExecs.AEID
                  IN (SELECT AEID FROM Dealers WHERE Dealers.DealerCode = '#g_DealerCode#')
                </CFQUERY>
        
            <CFQUERY NAME="getACInfo" datasource="#gDSN#">
                 SELECT ACID,
                        FirstName as ACFirstName,
                        LastName as ACLastName
                 FROM AccountCoordinators
                 WHERE AccountCoordinators.ACID
                 IN (SELECT ACID FROM Dealers WHERE Dealers.DealerCode = '#g_DealerCode#')
            </CFQUERY>

        </CFIF>

    <CFIF SaveMode>
	
        <CFQUERY NAME="updateDLR" datasource="#gDSN#">
             UPDATE Dealers
                SET AEID = #Form.AccountExec#,
                    ACID = #Form.AccountCoord#,
                    DealerFirstName = '#Form.DealerFirstName#',
                    DealerLastName = '#Form.DealerLastName#',
                    Email = '#Form.Email#',
                    QuoteEmail = '#Form.QuoteEmail#',
                    QuoteEmail2 = '#Form.QuoteEmail2#',
                    FinanceEmail = '#Form.FinanceEmail#',
                    FinanceEmail2 = '#Form.FinanceEmail2#'
					<!--- If it's not a collection, update Service and Parts emails --->
					<CFIF Mid(g_DealerCode, 6,4) NEQ '0000'>
						,
	                    ServiceEmail = '#Form.ServiceEmail#',
	                    ServiceEmail2 = '#Form.ServiceEmail2#',
    	                PartsEmail = '#Form.PartsEmail#',
    	                PartsEmail2 = '#Form.PartsEmail2#'
					</CFIF>
              WHERE DealerCode = '#Form.DealerCode#'
                </CFQUERY>                
        <CFLOCATION URL="webvrfy_s2.cfm?dlrcode=#Form.DealerCode#">
        </CFIF>

	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>

<body>
<br><br><br><br><br>

<div align="center">
<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=470 BGCOLOR="FFFFFF">
<TR>
	<TD>&nbsp;<P></TD>
</TR>
<TR>
	<TD ALIGN="center">
		<h3>
			Dealer Administration - Create a New Web
		</h3>
	</TD>
</TR>
<TR>
	<TD ALIGN="center">
		<h4>
			Dealer information, continued
		</h4>
	</TD>
</TR>
<TR>
	<TD ALIGN="center">
			Enter the following information.  Required fields are bolded.
	</TD>
</TR>
<TR>
	<TD>&nbsp;<p></TD>
</TR>
<!---
	on every field, check to see if we're coming from a verify...if we are, then
	default to the value already in the database, otherwise initialize each field
--->
<TR>
	<TD>
		<FORM NAME="StepTwo" ACTION="webnew_s2.cfm" METHOD="post">
		<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0 WIDTH="100%">
		<TR><TD>&nbsp;<p></TD></TR>
 		<TR>
			<TD ALIGN="right">
				<b>
					Account Executive
				</b>
			</TD>
			<TD>&nbsp;&nbsp;&nbsp;</TD>
			<CFIF EditMode>
				<CFOUTPUT QUERY="getDealerInfo">
					<CFSET tmpAEID=#AEID#>
					<CFSET tmpACID=#ACID#>
				</CFOUTPUT>
				<TD>
					<SELECT NAME="AccountExec">
						<CFOUTPUT QUERY="getAcctExecs">
							<CFSET tmp_Name =Trim(#q_AELastName#) & ', ' & Trim(#q_AEFirstName#)>
							<CFIF tmp_Name EQ ', '>
								<CFSET tmp_Name = "">
							</CFIF>
							<OPTION VALUE="#q_AEID#"<CFIF tmpAEID EQ #q_AEID#> SELECTED</cfif>>#tmp_Name#
							<CFSET tmp_Name="">
						</CFOUTPUT>
					</SELECT>
				</TD>
			<CFELSE>
				<TD>
					<SELECT NAME="AccountExec">
						<OPTION VALUE="NOT_SELECTED" SELECTED>
						<CFOUTPUT QUERY="getAcctExecs">
							<CFSET tmp_Name =Trim(#q_AELastName#) & ', ' & Trim(#q_AEFirstName#)>
							<CFIF tmp_Name EQ ', '>
								<CFSET tmp_Name = "">
							</CFIF>
							<OPTION VALUE="#q_AEID#">#tmp_Name#
							<CFSET tmp_Name="">
						</CFOUTPUT>
					</SELECT>
				</TD>
			</CFIF>
		</TR>
		<TR>
			<TD ALIGN="right">
				<b>
					Account Coordinator
				</b>
			</TD>
			<TD>&nbsp;&nbsp;&nbsp;</TD>
			<CFIF EditMode>
				<TD>
					<SELECT NAME="AccountCoord">
						<CFOUTPUT QUERY="getAcctCoordinators">
							<CFSET tmp_Name =Trim(#q_ACLastName#) & ', ' & Trim(#q_ACFirstName#)>
							<CFIF tmp_Name EQ ', '>
								<CFSET tmp_Name = "">
							</CFIF>
							<OPTION VALUE="#q_ACID#"<CFIF tmpACID EQ #q_ACID#> SELECTED</CFIF>>#tmp_Name#
							<CFSET tmp_Name="">
						</CFOUTPUT>
					</SELECT>
				</TD>
			<CFELSE>
				<TD>
					<SELECT NAME="AccountCoord">
						<OPTION VALUE="NOT_SELECTED" SELECTED>
						<CFOUTPUT QUERY="getAcctCoordinators">
							<CFSET tmp_Name =Trim(#q_ACLastName#) & ', ' & Trim(#q_ACFirstName#)>
							<CFIF tmp_Name EQ ', '>
								<CFSET tmp_Name = "">
							</CFIF>
							<OPTION VALUE="#q_ACID#">#tmp_Name#
							<CFSET tmp_Name="">
						</CFOUTPUT>
					</SELECT>
				</TD>
			</CFIF>
		</TR>
		<TR>
			<TD ALIGN="right">
				<b>
					Dealer's First Name
				</b>
			</TD>
			<TD>&nbsp;&nbsp;&nbsp;</TD>
			<INPUT type="hidden" name="DealerFirstName_required" value="Please enter the dealer's first name.">
			<TD>
				<cfoutput>
				<INPUT TYPE=text NAME="DealerFirstName" SIZE=20 MAXLENGTH=15 <CFIF EditMode>VALUE="#getDealerInfo.DealerFirstName#"</cfif>>
				</cfoutput>
			</TD>
		</TR>
		<TR>
			<TD ALIGN="right">
				<b>
					Dealer's Last Name
				</b>
			</TD>
			<TD>&nbsp;&nbsp;&nbsp;</TD>
			<INPUT TYPE="hidden" name="DealerLastName_required" value="Please enter the dealer's last name.">
			<TD>
				<cfoutput>
				<INPUT TYPE=text NAME="DealerLastName" SIZE=20 MAXLENGTH=30 <CFIF EditMode>VALUE="#getDealerInfo.DealerLastName#"</cfif>>
				</cfoutput>
			</TD>
		</TR>
		<TR>
			<TD ALIGN="right">
				E-Mail Address
			</TD>
			<TD>&nbsp;&nbsp;&nbsp;</TD>
			<TD>
				<cfoutput>
				<!--- linda, 10/14/99: changed Email to EmailTooShortNotUsed.  Added new Email of length 50 --->
				<INPUT type="text" NAME="EMail" MAXLENGTH=50 SIZE=20 TABINDEX=1 <CFIF EditMode>VALUE="#Trim(getDealerInfo.Email)#"</cfif>>
				</cfoutput>
			</TD>
		</TR>
		<TR>
			<TD ALIGN="right">
				Quote E-Mail Address
			</TD>
			<TD>&nbsp;&nbsp;&nbsp;</TD>
			<TD>
				<cfoutput>
				<INPUT type="text" NAME="QuoteEmail" MAXLENGTH=30 SIZE=20 TABINDEX=1 <CFIF EditMode>VALUE="#Trim(getDealerInfo.QuoteEmail)#"</cfif>>
				</cfoutput>
			</TD>
		</TR>
		<TR>
			<TD ALIGN="right">&nbsp;</TD>
			<TD>&nbsp;&nbsp;&nbsp;</TD>
			<TD>
				<cfoutput>
				<!--- linda, 10/14/99: changed Email to EmailTooShortNotUsed.  Added new Email of length 50 --->
				<INPUT type="text" NAME="QuoteEmail2" MAXLENGTH=50 SIZE=20 TABINDEX=2 <CFIF EditMode>VALUE="#Trim(getDealerInfo.QuoteEmail2)#"</cfif>>
				</cfoutput>
			</TD>
		</TR>
		<TR>
			<TD ALIGN="right">
				Financing E-Mail Address
			</TD>
			<TD>&nbsp;&nbsp;&nbsp;</TD>
			<TD>
				<cfoutput>
				<INPUT type="text" NAME="FinanceEmail" MAXLENGTH=30 SIZE=20 TABINDEX=1 <CFIF EditMode>VALUE="#Trim(getDealerInfo.FinanceEmail)#"</cfif>>
				</cfoutput>
			</TD>
		</TR>
		<TR>
			<TD ALIGN="right">&nbsp;</TD>
			<TD>&nbsp;&nbsp;&nbsp;</TD>
			<TD>
				<cfoutput>
				<!--- linda, 10/14/99: changed Email to EmailTooShortNotUsed.  Added new Email of length 50 --->
				<INPUT type="text" NAME="FinanceEmail2" MAXLENGTH=50 SIZE=20 TABINDEX=2 <CFIF EditMode>VALUE="#Trim(getDealerInfo.FinanceEmail2)#"</cfif>>
				</cfoutput>
			</TD>
		</TR>		
		<!--- If it's not a collection, show Service and Parts emails --->
		<CFIF Mid(g_DealerCode, 6,4) NEQ '0000'>
		<TR>
			<TD ALIGN="right">
				Service E-Mail Address
			</TD>
			<TD>&nbsp;&nbsp;&nbsp;</TD>
			<TD>
				<cfoutput>
				<INPUT type="text" NAME="ServiceEmail" MAXLENGTH=30 SIZE=20 TABINDEX=1 <CFIF EditMode>VALUE="#Trim(getDealerInfo.ServiceEmail)#"</CFIF>>
				</cfoutput>
			</TD>
		</TR>
		<TR>
			<TD ALIGN="right">&nbsp;</TD>
			<TD>&nbsp;&nbsp;&nbsp;</TD>
			<TD>
				<cfoutput>
				<!--- linda, 10/14/99: changed Email to EmailTooShortNotUsed.  Added new Email of length 50 --->
				<INPUT type="text" NAME="ServiceEmail2" MAXLENGTH=50 SIZE=20 TABINDEX=2 <CFIF EditMode>VALUE="#Trim(getDealerInfo.ServiceEmail2)#"</cfif>>
				</cfoutput>
			</TD>
		</TR>
		<TR>
			<TD ALIGN="right">
				Parts E-Mail Address
			</TD>
			<TD>&nbsp;&nbsp;&nbsp;</TD>
			<TD>
				<cfoutput>
				<INPUT type="text" NAME="PartsEmail" MAXLENGTH=30 SIZE=20 TABINDEX=1 <CFIF EditMode>VALUE="#Trim(getDealerInfo.PartsEmail)#"</cfif>>
				</cfoutput>
			</TD>
		</TR>
		<TR>
			<TD ALIGN="right">&nbsp;</TD>
			<TD>&nbsp;&nbsp;&nbsp;</TD>
			<TD>
				<cfoutput>
				<!--- linda, 10/14/99: changed Email to EmailTooShortNotUsed.  Added new Email of length 50 --->
				<INPUT type="text" NAME="PartsEmail2" MAXLENGTH=50 SIZE=20 TABINDEX=2 <CFIF EditMode>VALUE="#Trim(getDealerInfo.PartsEmail2)#"</cfif>>
				</cfoutput>
			</TD>
		</TR>
		</CFIF>
		<TR><TD>&nbsp;<p></TD></TR>
		</TABLE>
	</TD>
</TR>
<TR ALIGN="center">
	<TD ALIGN=center>
    	<CFOUTPUT>
        <INPUT TYPE="hidden" NAME="DealerCode" VALUE=#g_DealerCode#>
        </CFOUTPUT>
        <INPUT TYPE="hidden" NAME="NextStep" VALUE="webnew_s3.cfm">
        <INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/saveandcontinue_nav.jpg"
			BORDER="0"
			NAME="btnSave"
			VALUE="Save">
	</TD>
</TR>
</FORM>
<TR><TD>&nbsp;</TD></TR>
<FORM action="webnew_s2.cfm" method="post">
<TR align="center">
	<TD>
		<cfoutput><INPUT type="hidden" name="dealercode" value="#g_dealercode#"></cfoutput>
        <INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg"
			BORDER="0"
			NAME="btnCancel"
			VALUE="Cancel">
	</TD>
</TR>
</FORM>
<TR><TD>&nbsp;</TD></TR>
<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
<TR align="center">
	<TD>
    	<INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg"
			Border="0"
			NAME="BackToMain"
			VALUE="Back To Main Menu">
	</TD>
</TR>
</FORM>
<TR><TD>&nbsp;</TD></TR>
</TABLE>

</div>

</BODY>
</HTML>