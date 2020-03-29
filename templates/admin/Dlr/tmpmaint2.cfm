<CFINCLUDE template="security.cfm">
<!--- Linda, 4/29/99: I don't see that this is called from anywhere. --->

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
	<!--- $Id: tmpmaint2.cfm,v 1.6 1999/11/29 15:44:33 lswanson Exp $ --->

<HEAD>

        <TITLE>WorldDealer | Template Maintenance</TITLE>
        
        <CFIF ParameterExists(Form.NewTemplate)>
            <CFLOCATION URL="newtemplatet.htm">
        </CFIF>
        
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
        <TR ALIGN="center">
                <TD ALIGN="CENTER"><h3>Dealer Administration - Alter Dealer Web States</h3></TD>
        </TR>
        <FORM NAME="next" ACTION="webstate3.cfm" METHOD="post">
        <TR><TD ALIGN="CENTER">
                Change Web State for <CFOUTPUT>#getdealer.dealershipname# from #getdealer.description#</CFOUTPUT> to:
                <BR>
                <SELECT NAME="webstates">
                        <OPTION VALUE="<CFOUTPUT>#getdealer.webstateid#</CFOUTPUT>">
                        <CFOUTPUT QUERY="getstates">
                                <OPTION VALUE="#webstateid#">#description#
                        </CFOUTPUT>
                </SELECT>
                <INPUT TYPE="hidden" NAME="dealer" VALUE="<CFOUTPUT>#FORM.dealer#</CFOUTPUT>">
        </TD></TR>
        <TR ALIGN="center">
            <TD ALIGN=CENTER>
                    <INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/back_nav.jpg" Border="0" NAME="backout" OnClick="history.go(-1);" VALUE="<< Back">&nbsp;<INPUT TYPE="submit" NAME="Onwiththeshow" VALUE="Next >>">
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

