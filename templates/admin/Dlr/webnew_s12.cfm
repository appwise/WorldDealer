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
	<!--- $Id: webnew_s12.cfm,v 1.7 1999/11/29 15:30:57 lswanson Exp $ --->
	<!--- Web State (Active, In Progress, etc.) --->

<HEAD>

	<TITLE>WorldDealer | Create a New Web</TITLE>
        
	<CFQUERY NAME="getdealer" datasource="#gDSN#">
		SELECT  dealershipname, dealerwebs.webstateid, webstates.description
		FROM    dealerwebs, dealers, webstates
		WHERE   dealers.dealercode = '#URL.dlrcode#'
			AND dealers.dealercode = dealerwebs.dealercode
			AND webstates.webstateid = dealerwebs.webstateid;
	</CFQUERY>

	<CFQUERY NAME="getstates" datasource="#gDSN#">
		SELECT  *
		FROM    webstates
		WHERE   webstateid=#url.state#;
	</CFQUERY>
    
	<CFQUERY NAME="updatestate" datasource="#gDSN#">
		UPDATE  dealerwebs
		SET webstateid=#url.state#
		WHERE   dealercode='#URL.dlrcode#';
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
			Dealer Administration - Verify Dealer Info
		</font></h3>
	</TD>
</TR>
<TR>
	<TD ALIGN=CENTER>
		<FONT FACE="arial,helvetica">
			<B>Congratulations!</B>
			<P>
			<CFOUTPUT>
				#getdealer.dealershipname# successfully
                changed to <B>#getstates.description#</B>.
			</CFOUTPUT>
			<P>
			You've completed building the <CFOUTPUT>#getdealer.dealershipname#</CFOUTPUT> web site!<BR>
			<!--- if Active (=1), show web site --->
			<CFOUTPUT>
			<CFIF #getstates.webstateid# EQ 1>
				Click <B><A HREF="#application.RELATIVE_PATH#/templates/dlr/index.cfm?dealercode=#URL.dlrcode#">here</A></B>
				to view the completed site.
			<CFELSE>
				<P>To view the completed site, <BR>change the Web State to <b>Active</b>.
			</cfif>
			</CFOUTPUT>
		</FONT>
		<BR><BR>
	</TD>
</TR>
<TR>
	<TD ALIGN=CENTER>
		<FORM NAME="f_back" ACTION="redirect.cfm" METHOD="post">
			<A HREF="webvrfy_s12.cfm?dlrcode=<CFOUTPUT>#URL.dlrcode#</CFOUTPUT>"><IMG
				SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/back_nav.jpg"
				BORDER="0"
				VALUE="Cancel"></A>
			<P>
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