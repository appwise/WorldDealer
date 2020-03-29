   <!-- ----------------------------------------------------------- -->
   <!--           Created for WorldDealer by Sigma6, Inc.           -->
   <!--     Copyright (c) 1998, 1999 WorldDealer and Sigma6, Inc.   -->
   <!--         All Rights Reserved.  Used By Permission.           -->
   <!-- ----------------------------------------------------------- -->
   <!-- ----------------------------------------------------------- -->
   <!--           Sigma6, interactive media, Detroit/NYC            -->
   <!--               conceive : construct : connect                -->
   <!--   www.sigma6.com   webmaster@sigma6.com   info@sigma6.com   -->
   <!--                                                             -->
   <!--   Last updated: December 17, 1998                           -->
   <!-- ----------------------------------------------------------- -->
   <!--     Linda Swanson for sigma6, interactive media, Detroit    -->
   <!--    hlevine@sigma6.com   www.sigma6.com    www.s6313.com     -->
   <!--               conceive : construct : connect                -->
   <!-- ----------------------------------------------------------- -->

   <!-- ----------------------------------------------------------- -->
   <!-- Sigma6, s6, and the Sigma6 logos are registered trademarks. -->
   <!-- All other trademarks and servicemarks are the property of   -->
   <!-- their respective owners.                                    -->
   <!-- ----------------------------------------------------------- -->
   <!--- $Id: maintaincollection.cfm,v 1.3 1999/11/29 15:44:31 lswanson Exp $ --->
   <!--- yanked from DMG's webfind.cfm --->

<!--- LINDA: I don't think this is used any more.  Can probably be deleted.  Using Webfind & Webvrfy. --->
<CFSET PageAccess = 0>
<CFINCLUDE template="security.cfm">
<CFIF #Left(AccessLevel,1)# LE 1>
	<!--- AEs only have access to their own collections, so forward to maintaincollection2 --->
	<CFLOCATION url="maintaincollection2.cfm">
</CFIF>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">

<HTML>

<HEAD>

        <TITLE>WDDE | Select A Collection</TITLE>

        <!--- LINDA: webfind has get DMG here, which would be get Collection... --->
        <CFQUERY NAME="getStates" datasource="#gDSN#">
                 SELECT StateAbbr as q_StateAbbr,
                                Description as q_Description
                           FROM States
                          WHERE States.StateAbbr IN (SELECT DISTINCT StateAbbr FROM Dealers)
                   ORDER BY Description
        </CFQUERY>

</HEAD>

<BODY Background="/images/admin/bkg.jpg">

<div align="center">
<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=420 BGCOLOR="FFFFFF">
        <TR><TD>&nbsp;<p></TD></TR>
        <TR ALIGN="center">
                <TD ALIGN="middle"><h3><FONT FACE="Arial,Helvetica">Collection Administration</FONT></h3></TD>
        </TR>
        <TR ALIGN="center">
                <TD ALIGN="middle"><h4><font face="Arial,Helvetica">Choose a Collection</font></h4></TD>
        </TR>
        <TR ALIGN="center">
                <TD ALIGN="middle"><FONT FACE="Arial,Helvetica">Use the fields below to find a collection, or choose the "New Collection" button
                to add collection information from scratch.</FONT></TD>
        </TR>
        <TR><TD>&nbsp;<p></TD></TR>
        <TR>
            <TD>
                  <TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0 WIDTH="100%">
				<!--- LINDA: webfind has Find1: list dealers by this DMG (collection)--->
                     <TR>
                <FORM NAME="Find2" ACTION="maintaincollection2.cfm" METHOD="post">
                            <TD ALIGN="right">
								<b><font face="Arial,Helvetica">List collection by this state:</font></b>
							</TD>
						<TD>&nbsp;&nbsp;&nbsp;</TD>
                                <TD><SELECT name="StateAbbr">
                                       <OPTION VALUE="NOT_SELECTED" SELECTED>
                                       <CFOUTPUT QUERY="getStates">
                                           <OPTION VALUE="#q_StateAbbr#">#q_Description#
                                           </CFOUTPUT>
                                        </SELECT></TD>
                         <TR ALIGN=center>
                <TD COLSPAN=3><INPUT TYPE="image" NAME="btnFind2" VALUE="GO!" SRC="../../../images/admin/go_nav.jpg" BORDER="0"></TD>
                         </TR>
                                </FORM>
             <TR><TD COLSPAN=3>&nbsp;<p></TD></TR>
                     <TR>
                <FORM NAME="Find3" ACTION="maintaincollection2.cfm" METHOD="post">
                            <TD ALIGN="right"><b><font face="Arial,Helvetica">List Collection in this Zip Code:</font></b></TD>
                                <TD>&nbsp;&nbsp;&nbsp;</TD>
                                <TD>
									<font face="Arial,Helvetica">
										<INPUT TYPE=text NAME="ZipCode" SIZE=9 MAXLENGTH=10 TABINDEX=2>
									</FONT>
								</TD>
                         <TR ALIGN=center>
                <TD COLSPAN=3><INPUT TYPE="image" NAME="btnFind3" VALUE="GO!" SRC="../../../images/admin/go_nav.jpg" BORDER="0"></TD>
                         </TR>
                                </FORM>
             <TR><TD>&nbsp;<p></TD></TR>
                  </TABLE>
                </TD>
        </TR>
        <TR ALIGN="center">
            <TD>
                    <p>
                    <FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
                            <INPUT TYPE="image" NAME="btnNew" VALUE="New Collection" SRC="../../../images/admin/newCollection.jpg" BORDER="0">
                <P>
                            <INPUT TYPE="image" NAME="BackToMain" VALUE="Back To Main Menu" SRC="../../../images/admin/backtomain_nav.jpg" BORDER="0">
                        </FORM></TD>
        </TR>
</TABLE>
<P>

</div>

</BODY>
</HTML>