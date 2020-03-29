<CFSET webverifystep = 4>
<CFINCLUDE template="security.cfm">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

    <!-- ----------------------------------------------------------- -->
    <!--              Created by sigma6, Detroit                     -->
    <!--         Copyright (c) 1997, 1998, 1999 sigma6.              -->
    <!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->

    <!-- ----------------------------------------------------------- -->
    <!--     John Turner for sigma6, interactive media, Detroit      -->
    <!--    jturner@sigma6.com   www.sigma6.com    www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
	<!--- $Id: webvrfy_s4.cfm,v 1.7 1999/11/29 15:31:01 lswanson Exp $ --->
	<!--- Select a Template --->

<HTML>

<HEAD>
	<TITLE>WorldDealer | Create a New Web</TITLE>

	<CFIF ParameterExists(Form.btnBack.X)>
		<!--- If it's a collection, skip s3 & return it to s2 --->
		<CFIF ParameterExists(URL.dlrcode) AND Mid(URL.dlrcode, 6,4) EQ '0000'>	
			<CFLOCATION url="webvrfy_s2.cfm?dlrcode=#form.dealercode#">
		<cfelse>
			<CFLOCATION url="webvrfy_s3.cfm?dlrcode=#form.dealercode#">
		</cfif>
	</CFIF>

	<CFIF ParameterExists(Form.btnNext.X)>
		<CFLOCATION URL="#Form.NextStep#?dlrcode=#Form.DealerCode#">
	</CFIF>
       
	<CFIF ParameterExists(Form.btnModify.X)>
		<CFLOCATION URL="webnew_s4.cfm?dlrcode=#Form.DealerCode#">
	<CFELSEIF ParameterExists(URL.dlrcode)> 
		<CFSET VerifyMode = TRUE>
		<CFSET g_DealerCode = #URL.dlrcode#>
	<CFELSE>
		<CFSET VerifyMode = FALSE>
    </CFIF>

    <CFIF VerifyMode>
		<CFQUERY NAME="getTemplate" datasource="#gDSN#">
			SELECT	TemplateLocation,
					Description
			FROM 	ArtTemplates INNER JOIN DealerWebs ON ArtTemplates.TemplateLocation = DealerWebs.ArtTempID
			WHERE 	DealerWebs.DealerCode = '#g_DealerCode#'
		</CFQUERY>
	</CFIF>

	<!--- linda 4/28/99: I think what would be better is, wherever webvrfy_s4.cfm is called, have it only call this 
	for valid templates.  Have IT call CFLOCATION webnew_s4 when it runs out of valid templates. --->
	<!--- i don't think this is a necessary check.
	<CFIF #getTemplate.TemplateLocation# EQ #Application.MaxTemplate#>
		<CFLOCATION url="webnew_s4.cfm?dlrcode=#g_DealerCode#&new=1">
	</CFIF> --->
	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>

<body>
<br><br><br><br><br>

<CFIF VerifyMode>
<div align="center">
<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
<TR><TD>&nbsp;<p></TD></TR>
<TR>
	<TD ALIGN="center">
		<h3><font face="Arial,Helvetica">
			Maintain Your Web Site
		</font></h3>
	</TD>
</TR>
<TR>
	<TD ALIGN="center">
		<h4><font face="Arial,Helvetica">
			Template Selection
		</font></h4>
	</TD>
</TR>

<TR><TD>&nbsp;<p></TD></TR>
<TR ALIGN=middle>
	<TD>
	<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH="100%">
	<TR>
	<CFIF #getTemplate.RecordCount# EQ 0>
		<TD align="center">
			<FONT FACE="Arial,Helvetica">
				A site template has not been selected for this dealer.
			</FONT>
		</TD>
	<CFELSE>
		<CFOUTPUT QUERY="getTemplate">
			<TD align="center">
			<TABLE BORDER=0>
			<TR>
				<TD BGCOLOR=ffffff>
					<FONT FACE="Arial,Helvetica">
						This web site uses the <b>#Trim(Description)#</b> template.  To choose a new template, please select <b>'Modify'</b> below.
					</FONT>
				</TD>
			</TR>
			</TABLE>
			</TD>
		</CFOUTPUT>
	</CFIF>
	</TR>
	</TABLE>
	</TD>
</TR>
<TR><TD>&nbsp;<p></TD></TR>
<TR ALIGN=CENTER>
	<TD>
	<CFOUTPUT>
		<FORM NAME="VrfyFour" ACTION="webvrfy_s4.cfm?dlrcode=#g_DealerCode#" METHOD="post">
			<INPUT TYPE="hidden" NAME="DealerCode" VALUE="#g_DealerCode#">
			<INPUT TYPE="hidden" NAME="NextStep" VALUE="webvrfy_s5.cfm">
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
</CFIF>
</BODY>
</HTML>