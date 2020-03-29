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
	<!--- $Id: tmpmaint3.cfm,v 1.4 1999/11/29 15:44:33 lswanson Exp $ --->

<HEAD>

        <TITLE>WorldDealer | Template Maintenance</TITLE>
        
        <CFQUERY NAME="getdealer" datasource="#gDSN#">
                SELECT  dealershipname, dealerwebs.webstateid, webstates.description
                FROM    dealerwebs, dealers, webstates
                WHERE   dealers.dealercode = '#FORM.dealer#'
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
                WHERE   dealercode='#FORM.dealer#';
        </CFQUERY>

	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>

<body>
<br><br><br><br><br>


<div align="center">
<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
        <TR ALIGN="center">
                <TD ALIGN="CENTER"><h3>Dealer Administration - Alter Dealer Web States</h3></TD>
        </TR>
        
        <TR><TD ALIGN="CENTER">
                Web State for <CFOUTPUT>#getdealer.dealershipname# successfully
                changed from #getdealer.description# to <B>#getstates.description#</B></CFOUTPUT>.
        </TD></TR>
        <FORM NAME="f_back" ACTION="redirect.cfm" METHOD="post">
        <TR ALIGN="center">
            <TD ALIGN=CENTER>
                        <BR>
                    <INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/back_nav.jpg" Border="0" NAME="backout" OnClick="history.go(-1);" VALUE="<< Back">&nbsp;<INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg"
			Border="0"
			NAME="BackToMain"
			VALUE="Back To Main Menu">

                        <BR><BR>
                </TD>
        </TR>
        </FORM>
</TABLE>
</div>



</BODY>

</HTML>

 

</BODY>
</HTML>

