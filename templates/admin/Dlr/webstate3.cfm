<CFSET PageAccess = 2>
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
	<!--- $Id: webstate3.cfm,v 1.5 1999/11/29 15:31:00 lswanson Exp $ --->

<HEAD>

        <TITLE>WorldDealer | Altered Web States</TITLE>
        
        <CFQUERY NAME="getdealer" datasource="#gDSN#">
                SELECT  dealershipname, webstates.description, webstates.webstateid
                FROM    dealerwebs, dealers, webstates
                WHERE   dealers.dealercode = '#FORM.dealercode#'
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
	
</TR>
<TR><TD>&nbsp;</TD></TR>
<TR>
	<TD ALIGN="center">
		<h3><font face="Arial,Helvetica">
			Update Activity State
		</font></h3>
	</TD>
</TR>
<TR>
	<TD ALIGN="CENTER">
		<FONT FACE="arial,helvetica" SIZE=2>
			<br>
			
			Your Web Site,
			<CFOUTPUT>#getdealer.dealershipname#, is currently <b>#getdealer.description#</b></CFOUTPUT>
			.  Your customers will be able to view your Web Site when the Activity State is set to "Active."
			Use the dialog box below to change the Activity State of your Web Site.
		</FONT>
		<FORM NAME="next" ACTION="webstate4.cfm" METHOD="post">
			<SELECT NAME="webstates">
				<OPTION VALUE="<CFOUTPUT>#getdealer.webstateid#</CFOUTPUT>">
				<CFOUTPUT QUERY="getstates">
					<OPTION VALUE="#webstateid#" <CFIF webstateid IS getdealer.webstateid>SELECTED</CFIF>>#description#
				</CFOUTPUT>
			</SELECT>
			<INPUT TYPE="hidden" NAME="dealercode" VALUE="<CFOUTPUT>#FORM.dealercode#</CFOUTPUT>">
		<BR><BR>
	</TD>
</TR>
<TR>
	<TD ALIGN=CENTER>
		<A HREF="javascript:history.go(-1);"><IMG
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/back_nav.jpg"
			Border="0"
			NAME="backout"
			VALUE="Back"></a>
		&nbsp;&nbsp;
		<INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next_nav.jpg"
			Border="0"
			NAME="onwiththeshow"
			VALUE="GO!">
		</FORM>
	</TD>
</TR>   
</TABLE>

</div>
</BODY>
</HTML>