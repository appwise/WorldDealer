<CFSET PageAccess = 1>
<CFINCLUDE template="security.cfm">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
    <!-- ----------------------------------------------------------- -->
    <!--               Created by sigma6, Detroit                    -->
    <!--         Copyright (c) 1997, 1998, 1999 sigma6.              -->
    <!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->

    <!-- ----------------------------------------------------------- -->
    <!--     John Turner for sigma6, interactive media, Detroit      -->
    <!--    jturner@sigma6.com   www.sigma6.com    www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
	<!--- $Id: webvrfy_s12.cfm,v 1.6 1999/11/29 15:31:00 lswanson Exp $ --->
	<!--- Web State (Active, In Progress, etc.) --->
	
<HTML>

<CFIF ParameterExists(Form.btnBack.X)>
	<CFLOCATION url="webvrfy_s11.cfm?dlrcode=#form.dealercode#">
</CFIF>

<CFIF ParameterExists(Form.btnModify.X)>
	<CFLOCATION url="webnew_s12.cfm?dlrcode=#form.dealercode#&state=#form.webstates#">
</CFIF>

<HEAD>
	<TITLE>WorldDealer | Create a New Web</TITLE>

	<CFQUERY NAME="getdealer" datasource="#gDSN#">
		SELECT  dealershipname, webstates.description, webstates.webstateid
		FROM    dealerwebs, dealers, webstates
		WHERE   dealers.dealercode = '#URL.dlrcode#'
			AND dealers.dealercode = dealerwebs.dealercode
			AND dealerwebs.webstateid = webstates.webstateid;
	</CFQUERY>

	<CFQUERY NAME="getstates" datasource="#gDSN#">
		SELECT *
		FROM webstates;
	</CFQUERY>
	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>

<body>
<br><br><br><br><br>

<div align="center">
<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
<TR>
	<TD ALIGN="center">
		<h3><font face="Arial,Helvetica">
			Maintain Your Web Site
		</font></h3>
	</TD>
</TR>
<TR>
	<TD ALIGN="CENTER">
		<FONT FACE="arial,helvetica" SIZE=2>
			<h4>Web Site Activity State</h4><br>
			
			Your Web Site,
			<CFOUTPUT>#getdealer.dealershipname#, is currently <b>#getdealer.description#</b></CFOUTPUT>
			.  Your customers will be able to view your Web Site when the Activity State is set to "Active."
			Use the dialog box below to change the Activity State of your Web Site.
			<FORM NAME="next" ACTION="webvrfy_s12.cfm" METHOD="post">
				<SELECT NAME="webstates">
					<OPTION VALUE="<CFOUTPUT>#getdealer.webstateid#</CFOUTPUT>">
						<CFOUTPUT QUERY="getstates">
							<OPTION VALUE="#webstateid#" <CFIF #webstateid# IS #getdealer.webstateid#>SELECTED</CFIF>>#description#
                        </CFOUTPUT>
                </SELECT>
			<INPUT type="hidden" name="dealercode" value="<CFOUTPUT>#url.dlrcode#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="dealer" VALUE="<CFOUTPUT>#getdealer.dealershipname#</CFOUTPUT>">
		</FONT>
	</TD>
</TR>
<TR><TD>&nbsp;</TD></TR>
<TR>
	<TD ALIGN=CENTER>
		<INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/back_nav.jpg"
			BORDER="0"
			NAME="btnBack"
			VALUE="Back">
		&nbsp;&nbsp;
		<INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/modify_nav.jpg"
			BORDER="0"
			NAME="btnModify"
			VALUE="Modify">
		</FORM>
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

</BODY>
</HTML>