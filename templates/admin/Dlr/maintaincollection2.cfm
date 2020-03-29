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
   <!--- $Id: maintaincollection2.cfm,v 1.4 1999/11/29 15:44:31 lswanson Exp $ --->
   <!--- yanked from DMG's webfind2.cfm --->

<CFSET webverifystep = 0>
<CFINCLUDE template="security.cfm">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">

<HTML>

<HEAD>

        <TITLE>World Dealer | Select A Collection</TITLE>

    <CFQUERY NAME="countcollection" datasource="#gDSN#">
         SELECT Count(*) as q_collectionCount
                   FROM DMGAdmin
            <CFIF ParameterExists(Form.btnFind2.X)>
                  WHERE DMGAdmin.State = '#Form.StateAbbr#'
                </CFIF>
            <CFIF ParameterExists(Form.btnFind3.X)>
                  WHERE DMGAdmin.Zip LIKE '#Form.ZipCode#%'
                </CFIF>
			<CFIF #Left(AccessLevel, 1)# EQ 1>
				WHERE DMGAdmin.AEID = #RemoveChars(AccessLevel,1,2)#
			</CFIF>
			<CFIF #Left(AccessLevel, 1)# EQ 0>
				WHERE DMGAdmin.DMGCode = '#RemoveChars(AccessLevel,1,2)#'
			</CFIF>


    </CFQUERY>
        
    <CFQUERY NAME="findcollection" datasource="#gDSN#">
         SELECT DMGCode as q_collectionCode,
                        DMG as q_collectionName
                   FROM DMGAdmin
                  WHERE 1 = 1
				  
               <CFIF ParameterExists(Form.btnFind2.X)>
                    AND DMGAdmin.State = '#Form.StateAbbr#'
                </CFIF>
            <CFIF ParameterExists(Form.btnFind3.X)>
                    AND DMGAdmin.Zip LIKE '#Form.ZipCode#%'
                </CFIF>
			<CFIF #Left(AccessLevel, 1)# EQ 1>
				AND DMGAdmin.AEID = #RemoveChars(AccessLevel,1,2)#
			</CFIF>
			<CFIF #Left(AccessLevel, 1)# EQ 0>
				AND DMGAdmin.DMGCode = '#RemoveChars(AccessLevel,1,2)#'
			</CFIF>
			ORDER BY DMG, DMGCode;
    </CFQUERY>

</HEAD>

<BODY Background="/images/admin/bkg.jpg">

<CFIF countcollection.q_collectionCount EQ '0'>
<div align="center">
<TABLE CELLPADDING=5 CELLSPACING=0 BORDER=0 WIDTH=420 BGCOLOR="FFFFFF">
        <TR><TD>&nbsp;<p></TD></TR>
        <TR ALIGN="center">
                <TD ALIGN="middle"><h3><FONT FACE="Arial,Helvetica">Collection Administration</FONT></h3></TD>
        </TR>
        <TR ALIGN="center">
                <TD ALIGN="middle"><h4><font face="Arial,Helvetica">Locate A Collection</font></h4></TD>
        </TR>
        <TR><TD>&nbsp;<p></TD></TR>
        <TR ALIGN="center">
                <TD ALIGN="middle"><h4><font face="Arial,Helvetica">No collections were found using the search criteria you selected.
                Click the 'New Search' button to return to the search form, or click the 'New Collection' button to add a dealer from scratch.</font></h4></TD>
        </TR>
        <TR><TD>&nbsp;<p></TD></TR>
        <TR ALIGN="center">
            <TD>
                    <FORM NAME="NoCollectionFound" ACTION="webnew.cfm" METHOD="post">
                    <input type="Image" name="NewCollection" src="../../../images/admin/newcollection.jpg" border="0">
                        </FORM>
                    <p>
                    <FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
                            <INPUT TYPE="image" NAME="NewSearch" VALUE="New Search" SRC="../../../images/admin/newsearch.jpg" BORDER="0">
                                <p>
                            <INPUT TYPE="image" NAME="BackToMain" VALUE="Back To Main Menu" SRC="../../../images/admin/backtomain_nav.jpg" BORDER="0">
                        </FORM></TD>
        </TR>
</TABLE>
</div>


<CFELSE>
<div align="center">
<TABLE CELLPADDING=5 CELLSPACING=0 BORDER=0 WIDTH=420 BGCOLOR="FFFFFF">
        <TR><TD>&nbsp;<p></TD></TR>
        <TR ALIGN="center">
                <TD ALIGN="middle"><h3><FONT FACE="Arial,Helvetica">Collection Administration</FONT></h3></TD>
        </TR>
        <TR ALIGN="center">
                <TD ALIGN="middle"><h4><font face="Arial,Helvetica">Locate A Collection</font></h4></TD>
        </TR>
        <TR>
                <TD><FONT FACE="Arial,Helvetica">Select a collection below, then click 'Next'.  Click 'New Search' to start over.</FONT></TD>
        </TR>
        <TR><TD>&nbsp;<p></TD></TR>
        <TR ALIGN=center>
            <FORM NAME="FindForm2" ACTION="webvrfy.cfm" METHOD="post">
                <INPUT TYPE="hidden" NAME="NextStep" VALUE="webvrfy.cfm">
				<INPUT type="hidden" name="collectionCode_required" value="You must select a collection.">
                <TD><SELECT NAME="collectionCode" SIZE=5>
               <CFOUTPUT QUERY="findcollection">
                           <OPTION VALUE="#q_collectionCode#">#q_collectionName# (#q_collectionCode#)
                           </CFOUTPUT>
                        </SELECT></TD>
        </TR>
        <TR><TD>&nbsp;<p></TD></TR>
        <TR ALIGN="center">
            <TD>
                    <INPUT TYPE="image" NAME="btnNext" VALUE="Next" SRC="../../../images/admin/next_nav.jpg" BORDER="0">
                        </FORM>
                    <p>
                    <FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
					<CFIF #Left(AccessLevel,1)# GE 2>
                            <INPUT TYPE="image" NAME="NewSearch"  VALUE="New Search" SRC="../../../images/admin/newsearch.jpg" BORDER="0">
					</CFIF>                        
                                <p>
                            <INPUT TYPE="image" NAME="BackToMain" VALUE="Back To Main Menu" SRC="../../../images/admin/backtomain_nav.jpg" BORDER="0">
                        </FORM></TD>
        </TR>
</TABLE>
<P>

</div>

</CFIF>

</BODY>
</HTML>