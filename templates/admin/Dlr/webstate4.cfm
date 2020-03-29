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
	<!--- $Id: webstate4.cfm,v 1.6 1999/11/29 15:31:00 lswanson Exp $ --->

<HEAD>

	<TITLE>WorldDealer | Altered Web States</TITLE>
        
	<CFQUERY NAME="getdealer" datasource="#gDSN#">
		SELECT  dealershipname, dealerwebs.webstateid, webstates.description
		FROM    dealerwebs, dealers, webstates
		WHERE   dealers.dealercode = '#FORM.dealercode#'
			AND dealers.dealercode = dealerwebs.dealercode
			AND     webstates.webstateid = dealerwebs.webstateid;
	</CFQUERY>

	<CFQUERY NAME="getstates" datasource="#gDSN#">
		SELECT  *
		FROM    webstates
		WHERE   webstateid=#FORM.webstates#;
	</CFQUERY>
    
	<CFQUERY NAME="updatestate" datasource="#gDSN#">
		UPDATE  dealerwebs
		SET webstateid=#FORM.webstates#
		WHERE   dealercode='#FORM.dealercode#';
	</CFQUERY>

	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>

<body>
<br><br><br><br><br>

<div align="center">
<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
<TR><TD>&nbsp;<p></TD></TR>
<TR>
	<TD ALIGN="CENTER">
		<h3><FONT FACE="Arial,Helvetica">
			Update Activity State
		</FONT></h3>
	</TD>
</TR>
<TR>
	<TD ALIGN="CENTER">
		<FONT Face="Arial,Helvetica">
			Web State for
				<CFOUTPUT>
					#getdealer.dealershipname# successfully
					changed from #getdealer.description# to <B>#getstates.description#</B>.
				</CFOUTPUT>
		</FONT>
	</TD>
</TR>
<TR><TD>&nbsp;</TD></TR>
<TR>
	<TD ALIGN=CENTER>
		<FORM NAME="f_back" ACTION="redirect.cfm" METHOD="post">
		<A HREF="JavaScript:history.back();"><IMG
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/back_nav.jpg"
			Border="0"
			NAME="backout"
			VALUE="Back"></A>
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