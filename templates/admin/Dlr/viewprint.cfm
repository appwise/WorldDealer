<CFSET PageAccess = 1>
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
	<!--- $Id: viewprint.cfm,v 1.6 1999/11/29 15:44:34 lswanson Exp $ --->

<HEAD>

        <TITLE>WorldDealer | Select A Dealer</TITLE>

        <CFQUERY NAME="getStates" datasource="#gDSN#">
                 SELECT StateAbbr as q_StateAbbr,
                                Description as q_Description
                           FROM States
                          WHERE States.StateAbbr IN (SELECT DISTINCT StateAbbr FROM Dealers)
                   ORDER BY Description
        </CFQUERY>

	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>

<body>
<br><br><br><br><br>

<div align="center">
<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=420 BGCOLOR="FFFFFF">
        <TR><TD>&nbsp;<p></TD></TR>
        <TR ALIGN="center">
                <TD ALIGN="middle"><h3><FONT FACE="Arial,Helvetica">Dealer Administration - View/Print</FONT></h3></TD>
        </TR>
        <TR ALIGN="center">
                <TD ALIGN="middle"><h4><font face="Arial,Helvetica">Choose a criterion:</font></h4></TD>
        </TR>
        <TR>
            <TD>
                  <TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0 WIDTH="100%">
             <TR><TD COLSPAN=3>&nbsp;<p></TD></TR>
                     <TR>
                <FORM NAME="Find1" ACTION="vpselect.cfm" METHOD="post">
                            <TD ALIGN="right"><b><font face="Arial,Helvetica">View the results in groups of:</font></b></TD>
                                <TD>&nbsp;&nbsp;&nbsp;</TD>
                                <TD><SELECT NAME="GroupBy">
                                       <OPTION VALUE="ALL" SELECTED>All
                                           <OPTION VALUE="10">10
                                           <OPTION VALUE="20">20
                                           <OPTION VALUE="30">30
                                           <OPTION VALUE="40">40
                                           <OPTION VALUE="50">50
                                        </SELECT></TD>
                         </TR>
             <TR><TD COLSPAN=3>&nbsp;<p></TD></TR>
                         <TR ALIGN=center>
                <TD COLSPAN=3><INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/go_nav.jpg" BORDER="0" NAME="btnVP1" VALUE="GO!"></TD>
                         </TR>
             <TR><TD COLSPAN=3>&nbsp;<p></TD></TR>
                     <TR>
                            <TD ALIGN="right"><b><font face="Arial,Helvetica">List dealers by this state:</font></b></TD>
                                <TD>&nbsp;&nbsp;&nbsp;</TD>
                                <TD><SELECT name="StateAbbr">
                                       <CFOUTPUT QUERY="getStates">
                                           <OPTION VALUE="#q_StateAbbr#">#q_Description#
                                           </CFOUTPUT>
                                        </SELECT></TD>
                         </TR>
                         <TR ALIGN=center>
                <TD COLSPAN=3><INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/go_nav.jpg" BORDER="0" NAME="btnVP2" VALUE="GO!"></TD>
                         </TR>
             <TR><TD COLSPAN=3>&nbsp;<p></TD></TR>
                     <TR>
                            <TD ALIGN="right"><b><font face="Arial,Helvetica">List dealers with names like:</font></b></TD>
                                <TD>&nbsp;&nbsp;&nbsp;</TD>
                                <TD><INPUT TYPE="text" NAME="DealershipName" VALUE=""></TD>
                         </TR>
                     <TR>
                            <TD ALIGN="right"><b><font face="Arial,Helvetica">and/ or in this ZipCode:</font></b></TD>
                                <TD>&nbsp;&nbsp;&nbsp;</TD>
                                <TD><INPUT TYPE="text" NAME="ZipCode" VALUE=""></TD>
                         </TR>
                         <TR ALIGN=center>
                <TD COLSPAN=3><INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/go_nav.jpg" BORDER="0" NAME="btnVP3" VALUE="GO!"></TD>
                         </TR>
             </FORM>
             <TR><TD COLSPAN=3>&nbsp;<p></TD></TR>
                  </TABLE>
                </TD>
        </TR>
        <TR><TD>&nbsp;<P></TD></TR>
        <TR ALIGN="center">
            <TD>
                    <p>
                    <FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
                           <!---  <INPUT TYPE="submit" NAME="btnFind" VALUE="Find"> --->
                            <INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg" Border="0" NAME="BackToMain" VALUE="Back To Main Menu"></FORM></TD>
        </TR>
</TABLE>

</div>

</BODY>

</HTML>

 

</BODY>
</HTML>

