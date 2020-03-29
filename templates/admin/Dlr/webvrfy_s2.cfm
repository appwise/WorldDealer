<CFSET webverifystep = 2>
<CFINCLUDE template="security.cfm">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">


    <!-- ----------------------------------------------------------- -->
    <!--       Created by sigma6, Detroit                            -->
    <!--         Copyright (c) 1997, 1998, 1999 sigma6.              -->
    <!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->

    <!-- ----------------------------------------------------------- -->
    <!--     John Turner for sigma6, interactive media, Detroit      -->
    <!--    jturner@sigma6.com   www.sigma6.com    www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
	<!--- $Id: webvrfy_s2.cfm,v 1.12 2000/01/06 15:43:05 jkrauss Exp $ --->
	<!--- Dealer Info, Cont'd.  AE, AC, Dealer's Name & email --->

<HTML>
<HEAD>

    <TITLE>WorldDealer | Create a New Web</TITLE>

	<CFIF ParameterExists(Form.btnBack.X)>
		<CFLOCATION url="webvrfy.cfm?dlrcode=#form.Dealercode#">
	</CFIF>
	
    <CFIF ParameterExists(Form.btnNext.X)>
		<!--- If it's a collection, skip s3 & forward it to s4 --->
		<CFIF ParameterExists(URL.dlrcode) AND Mid(URL.dlrcode, 6,4) EQ '0000'>		
		   	<CFLOCATION URL="webvrfy_s4.cfm?dlrcode=#Form.DealerCode#">
		<cfelse>
    		<CFLOCATION URL="#Form.NextStep#?dlrcode=#Form.DealerCode#">
		</cfif>	
	</CFIF>

    <CFIF ParameterExists(Form.btnModify.X)>
    	<CFLOCATION URL="webnew_s2.cfm?dlrcode=#Form.DealerCode#">
    <CFELSEIF ParameterExists(URL.dlrcode)>
    	<CFSET VerifyMode = TRUE>
        <CFSET g_DealerCode = #URL.dlrcode#>
    <CFELSE>
        <CFSET VerifyMode = FALSE>
    </CFIF>

	<CFIF VerifyMode>
		<CFQUERY NAME="getDealerInfo" datasource="#gDSN#">
			SELECT *
			FROM Dealers
			WHERE DealerCode = '#g_DealerCode#'
		</CFQUERY>

		<CFQUERY NAME="getAEInfo" datasource="#gDSN#">
			SELECT AEID as lq_AEID,
				FirstName as lq_AEFirstName,
				LastName as lq_AELastName
			FROM AccountExecs
			WHERE AccountExecs.AEID
				IN (SELECT AEID FROM Dealers WHERE Dealers.DealerCode = '#g_DealerCode#')
		</CFQUERY>
        
		<CFQUERY NAME="getACInfo" datasource="#gDSN#">
			SELECT ACID as lq_ACID,
				FirstName as lq_ACFirstName,
				LastName as lq_ACLastName
			FROM AccountCoordinators
			WHERE AccountCoordinators.ACID
				IN (SELECT ACID FROM Dealers WHERE Dealers.DealerCode = '#g_DealerCode#')
		</CFQUERY>
	</CFIF>

	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>

<body>
<br><br><br><br><br>

<CFIF VerifyMode>

<div align="center">
<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
<TR>
	<TD ALIGN="center">
		<h3>
			Maintain Your Web Site
		</h3>
	</TD>
</TR>
<TR>
	<TD ALIGN="center">
		<h4>
			Dealer Contact Name and Email Address
		</h4>
	</TD>
</TR>
<TR>
	<TD>
			Verify the information below for this dealership.  To change
			an entry, click the <b>'Modify'</b> button..
	</TD>
</TR>
<TR><TD>&nbsp;<p></TD></TR>
<TR ALIGN="center">
	<TD>
	<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0>
	<TR><TD>&nbsp;<p></TD></TR>
	<TR>
		<td align="RIGHT" nowrap>Account Executive:</TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<TD>
			<b>
			<CFOUTPUT QUERY="getAEInfo">
				<CFSET tmp_Name=Trim(#lq_AELastName#) & ', ' & Trim(#lq_AEFirstName#)>
				<CFIF tmp_Name EQ ', '>
					<CFSET tmp_Name = "">
				</CFIF>
				#tmp_Name#
			</CFOUTPUT>
			</b>
		</TD>
	</TR>
	<TR>
		<TD align="RIGHT" nowrap>Account Coordinator:</TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<TD>
			<b>
			<CFOUTPUT QUERY="getACInfo">
				<CFSET tmp_Name=Trim(#lq_ACLastName#) & ', ' & Trim(#lq_ACFirstName#)>
				<CFIF tmp_Name EQ ', '>
					<CFSET tmp_Name = "">
				</CFIF>
				#tmp_Name#
			</CFOUTPUT>
			</b>
		</TD>
	</TR>
	<TR>
		<td align="RIGHT" nowrap>Dealer's First Name:</TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<TD>
			<b>
				<CFOUTPUT QUERY="getDealerInfo">
					#DealerFirstName#
				</CFOUTPUT>
			</b>
		</TD>
	</TR>
	<TR>
		<TD align="RIGHT" nowrap>Dealer's Last Name:</TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<TD>
			<b>
				<CFOUTPUT QUERY="getDealerInfo">
					#DealerLastName#
				</CFOUTPUT>
			</b>
		</TD>
	</TR>
	<TR>
		<TD align="RIGHT" nowrap>E-Mail Address:</TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<TD>
			<b>
				<CFOUTPUT QUERY="getDealerInfo">
					#Email#
				</CFOUTPUT>
			</b>
		</TD>
	</TR>
	<TR>
		<TD align="RIGHT" nowrap>Quote E-Mail Address<cfif #Trim(getDealerInfo.QuoteEmail2)# NEQ "">es</cfif>:</TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<TD>
			<b>
				<CFOUTPUT QUERY="getDealerInfo">
					#QuoteEmail#<cfif #Trim(QuoteEmail2)# NEQ "">, #QuoteEmail2#</cfif>
				</CFOUTPUT>
			</b>
		</TD>
	</TR>
	<TR>
		<TD align="RIGHT" nowrap>Financing E-Mail Address<cfif #Trim(getDealerInfo.FinanceEmail2)# NEQ "">es</cfif>:</TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<TD>
			<b>
				<CFOUTPUT QUERY="getDealerInfo">
					#FinanceEmail#<cfif #Trim(FinanceEmail2)# NEQ "">, #FinanceEmail2#</cfif>
				</CFOUTPUT>
			</b>
		</TD>
	</TR>
	<!--- If it's a collection, skip Service and Parts emails --->
	<CFIF Mid(g_DealerCode, 6,4) EQ '0000'>
		<!--- do nothing --->
	<CFELSE>
	<TR>
		<TD align="RIGHT" nowrap>Service E-Mail Address<cfif #Trim(getDealerInfo.ServiceEmail2)# NEQ "">es</cfif>:</TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<TD>
			<b>
				<CFOUTPUT QUERY="getDealerInfo">
					#ServiceEmail#<cfif #Trim(ServiceEmail2)# NEQ "">, #ServiceEmail2#</cfif>
				</CFOUTPUT>
			</b>
		</TD>
	</TR>
	<TR>
		<TD align="RIGHT" nowrap>Parts E-Mail Address<cfif #Trim(getDealerInfo.PartsEmail2)# NEQ "">es</cfif>:</TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<TD>
			<b>
				<CFOUTPUT QUERY="getDealerInfo">
					#PartsEmail#<cfif #Trim(PartsEmail2)# NEQ "">, #PartsEmail2#</cfif>
				</CFOUTPUT>
			</b>
		</TD>
	</TR>
	</cfif>
	<TR><TD>&nbsp;<p></TD></TR>
	</TABLE>
	</TD>
</TR>
<TR ALIGN="center">
	<TD>
	<CFOUTPUT QUERY="getDealerInfo">
		<FORM NAME="VrfyTwo" ACTION="#g_relpath#/templates/admin/dlr/webvrfy_s2.cfm?dlrcode=#g_DealerCode#" METHOD="post">
			<INPUT TYPE="hidden" NAME="DealerCode" VALUE="#g_DealerCode#">
			<INPUT TYPE="hidden" NAME="NextStep" VALUE="webvrfy_s3.cfm">
			<INPUT TYPE="Image"
				SRC="#application.RELATIVE_PATH#/images/admin/back_nav.jpg"
				Border="0"
				NAME="btnBack"
				VALUE="Back">
			&nbsp;&nbsp;
			<INPUT TYPE="Image"
				SRC="#application.RELATIVE_PATH#/images/admin/modify_nav.jpg"
				Border="0"
				NAME="btnModify"
				VALUE="Modify">
			&nbsp;&nbsp;
			<INPUT TYPE="Image"
				SRC="#application.RELATIVE_PATH#/images/admin/next_nav.jpg"
				Border="0"
				NAME="btnNext"
				VALUE="Next">
		</FORM>
		<FORM NAME="f_Back" ACTION="#application.RELATIVE_PATH#/templates/admin/dlr/redirect.cfm" METHOD="post">
			<INPUT TYPE="Image"
				SRC="#application.RELATIVE_PATH#/images/admin/backtomain_nav.jpg"
				Border="0"
				NAME="BackToMain"
				VALUE="Back To Main Menu">
		</FORM>
	</CFOUTPUT>
	</TD>
</TR>
</TABLE>

</div>
</CFIF>

</BODY>
</HTML>