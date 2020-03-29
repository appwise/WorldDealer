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
	<!--- $Id: tmpmaint.cfm,v 1.5 1999/11/29 15:44:33 lswanson Exp $ --->

	<!--- linda, 5/11/99: tmpmaint.cfm isn't called from anywhere --->

<HEAD>

        <TITLE>WorldDealer | Altered Web States</TITLE>
        
        <CFQUERY NAME="getArtTemp" datasource="#gDSN#">
                SELECT  TemplateLocation,
                        Description
                FROM    ArtTemplates
        </CFQUERY>

	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>

<body>
<br><br><br><br><br>



<div align="center">
<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
        <TR><TD>&nbsp;<P></TD></TR>
        <TR ALIGN="center">
                <TD ALIGN="CENTER"><h3>Dealer Administration - Site Template Maintenance</h3></TD>
        </TR>
        <TR><TD>&nbsp;<P></TD></TR>
        <FORM NAME="next" ACTION="tmpmaint2.cfm" METHOD="post">
        <TR><TD ALIGN="CENTER">
                Select a Template:
                <BR>
                <SELECT NAME="template">
                        <OPTION>
                        <CFOUTPUT QUERY="getArtTemp">
                                <OPTION VALUE="#TemplateLocation#">#Description#
                        </CFOUTPUT>
                </SELECT>
        </TD></TR>
        <TR><TD>&nbsp;<P></TD></TR>
        <TR><TD ALIGN="CENTER"><INPUT TYPE="submit" NAME="NewTemplate" VALUE="New Template"></TD></TR>
        <TR><TD>&nbsp;<P></TD></TR>
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

