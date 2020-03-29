<CFSET webverifystep = 5>
<CFINCLUDE template="security.cfm">

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

    <!-- ----------------------------------------------------------- -->
    <!--                Created by sigma6, Detroit                   -->
    <!--           Copyright (c) 1997, 1998, 1999 sigma6.            -->
    <!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->

    <!-- ----------------------------------------------------------- -->
    <!--     John Turner for sigma6, interactive media, Detroit      -->
    <!--    jturner@sigma6.com   www.sigma6.com    www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
	<!--- $Id: webvrfy_s5.cfm,v 1.9 1999/12/22 23:42:00 lswanson Exp $ --->
	<!--- Dealership's New URL --->

<HTML>
<HEAD>

	<TITLE>WorldDealer | Verify a Dealer Web</TITLE>

	<CFIF ParameterExists(Form.btnBack.X)>
		<CFLOCATION URL="#g_relpath#/templates/admin/dlr/webvrfy_s4.cfm?dlrcode=#form.dealercode#">
	</CFIF>
	
    <CFIF ParameterExists(Form.btnNext.X)>
       <CFLOCATION URL="#Form.NextStep#?dlrcode=#Form.DealerCode#">
    </CFIF>
        
    <CFIF ParameterExists(Form.btnModify.X)>
		<CFLOCATION URL="#g_relpath#/templates/admin/dlr/webnew_s5.cfm?dlrcode=#Form.DealerCode#">
    <CFELSE>
       <CFIF ParameterExists(URL.dlrcode)>
			<CFSET VerifyMode = TRUE>
			<CFSET g_DealerCode = #URL.dlrcode#>
       <CFELSE>
			<CFSET VerifyMode = FALSE>
       </CFIF>
    </CFIF>

    <CFIF VerifyMode>
		<CFQUERY NAME="getNameURL" datasource="#gDSN#">
			SELECT	DealershipName,
					URL
			FROM 	Dealers
			WHERE 	DealerCode = '#g_DealerCode#'
		</CFQUERY>
		
		<CFQUERY NAME="getURL2" datasource="#gDSN#">
			SELECT	URL
			FROM 	DealerURL
			WHERE 	DealerCode = '#g_DealerCode#'
		</CFQUERY>
     </CFIF>
        
	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>

<body>
<br><br><br><br><br>

<CFIF VerifyMode>

<div align="center">
<TABLE CELLPADDING=10 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
<TR>
	<TD ALIGN="center">
		<h3><font face="Arial,Helvetica">
			Maintain Your Web Site - Domain Names
		</font></h3>
	</TD>
</TR>
<TR>
	<TD>
		<font face="Arial,Helvetica">
			Verify the information below for the dealer you selected.  To modify
			any of the information, click the 'Modify' button and make your changes.
		</font>
	</TD>
</TR>
<TR>
	<TD>
		<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0 WIDTH="100%">
		<TR>
			<TD ALIGN=center>
				<FONT FACE="arial,helvetica">
				<b>The Primary URL for <CFOUTPUT QUERY="getNameURL">#DealershipName#</CFOUTPUT> is:</B><BR><BR>
				<CFIF #getNameURL.URL# IS "">
					This dealer does not have a Domain or URL.
				<CFELSE>
					<CFOUTPUT QUERY="getNameURL">
						#URL#
					</CFOUTPUT>
				</CFIF>
				</FONT>
				<BR><BR>				
			</TD>
		</TR>
		<TR>
			<TD ALIGN=center>
				<FONT FACE="arial,helvetica">
				<b>The Secondary URL is:</B><BR><BR>
				<CFIF #getURL2.URL# IS "">
					This dealer does not have a Secondary Domain or URL.
				<CFELSE>
					<CFOUTPUT QUERY="getURL2">
						#URL#
					</CFOUTPUT>
				</CFIF>
				</FONT>
				<BR><BR>				
			</TD>
		</TR>
		</TABLE>
	</TD>
</TR>
<TR ALIGN="center">
	<TD>
	<CFOUTPUT>
		<FORM NAME="VrfyFive" ACTION="#g_relpath#/templates/admin/dlr/webvrfy_s5.cfm?dlrcode=#g_DealerCode#" METHOD="post">
			<INPUT TYPE="hidden" NAME="DealerCode" VALUE="#g_DealerCode#">
			<INPUT TYPE="hidden" NAME="NextStep" VALUE="webvrfy_s6.cfm">
			<INPUT TYPE="Image"
				SRC="#application.RELATIVE_PATH#/images/admin/back_nav.jpg"
				BORDER="0"
				NAME="btnBack"
				VALUE="Back">
			&nbsp;&nbsp;
			<INPUT TYPE="Image"
				SRC="#application.RELATIVE_PATH#/images/admin/modify_nav.jpg"
				BORDER="0"
				NAME="btnModify"
				VALUE="Modify">
			&nbsp;&nbsp;
			<INPUT TYPE="Image"
				SRC="#application.RELATIVE_PATH#/images/admin/next_nav.jpg"
				BORDER="0"
				NAME="btnNext"
				VALUE="Next">
		</FORM>
	</CFOUTPUT>
		<FORM NAME="f_Back" ACTION="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/templates/admin/dlr/redirect.cfm" METHOD="post">
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

</BODY>
</HTML>