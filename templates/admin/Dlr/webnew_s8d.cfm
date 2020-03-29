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
	<!--- $Id: webnew_s8d.cfm,v 1.7 1999/11/29 15:30:59 lswanson Exp $ --->
	<!--- Offers --->

<HEAD>

    <TITLE>WorldDealer | Verify a Dealer Web</TITLE>
	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">
</HEAD>

<CFIF #IsDefined("Form.btnBack.X")#>
	<CFLOCATION url="webvrfy_s8.cfm?dlrcode=#form.dealercode#">
</CFIF>

<CFIF IsDefined("URL.dlrcode")>		

		<body>
<br><br><br><br><br>
	<div align="center">
	<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
   	     <TR ALIGN="center">
	                <TD ALIGN="middle"><h3><font face="Arial,Helvetica">Dealer Administration - Create a New Web</font></h3></TD>
   	     </TR>
			<TR><TD>&nbsp;</TD></TR>
			<TR><TD Align=Center><FONT FACE="Arial,Helvetica">Your Offer and Disclaimer have been successfully added to the database.<p> Would you like to add another Offer at the time?</TD></TR>
			<TR><TD>&nbsp;&nbsp;</TD></TR>
			<TR><TD align=center><FORM action="webnew_s8d.cfm" method="post">
			<CFOUTPUT>
			<INPUT type="hidden" name="dealercode" value="#URL.dlrcode#">
			</CFOUTPUT>
			<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/back_nav.jpg" BORDER="0" NAME="btnBack" VALUE="< Back">
			&nbsp;&nbsp;
			<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/addoffer.jpg" BORDER="0" name="btnAdd" value="Add Another Offer">&nbsp;&nbsp;&nbsp;<INPUT
			TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next_nav.jpg" BORDER="0" name="btnNext" value="Next">
			</FORM>
			<p>
   	        <FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
   	        <INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg"
			Border="0"
			NAME="BackToMain"
			VALUE="Back To Main Menu">

            </FORM>
			</TD></TR></TABLE>

			</BODY>
			</HTML>
</CFIF>

<CFIF IsDefined ("FORM.btnNext.X")>
	<CFLOCATION url="webvrfy_s9.cfm?dlrcode=#Form.dealercode#">
</CFIF>

<CFIF IsDefined ("Form.btnAdd.X")>
	<CFLOCATION url="webnew_s8.cfm?dlrcode=#form.dealercode#">
</CFIF>