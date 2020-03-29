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
    <!--     Howard Levine for sigma6, interactive media, Detroit    -->
    <!--    hlevine@sigma6.com   www.sigma6.com    www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
	<!--- $Id: uploaderror.cfm,v 1.5 1999/11/29 15:44:33 lswanson Exp $ --->

<HEAD>
        <TITLE>WorldDealer | Create a New Web</TITLE>
		
	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>


<body>
<br><br><br><br><br>
<CFOUTPUT>
#g_dealercode#</CFOUTPUT>
<div align="center">
<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
<TR ALIGN="center">
	<TD ALIGN="middle"><h3><font face="Arial,Helvetica">Dealer Administration - Create a New Web</font></h3></TD>
</TR>
<TR ALIGN="center">
	<TD ALIGN="middle"><h4><font face="Arial,Helvetica">Used Vehicle Mainentance</font></h4></TD>
</TR>
<TR align="center"><TD><FONT FACE="Arial,Helvetica">Sorry, the file you uploaded was invalid.  You must choose a JPEG file (.JPG extension).  
</FONT></TD></TR>
<TR><TD>&nbsp;</TD></TR>
<TR><TD><FONT FACE="Arial,Helvetica">
&nbsp;&nbsp;Click <b>Continue</b> to try again.
<br>
&nbsp;&nbsp;Click <b>Cancel</b> to return to the Pre-Owned vehicles menu.
</FONT></TD></TR>
<TR><TD>&nbsp;</TD></TR>
<FORM action="webnew_s9.cfm" method="post">
<INPUT type="hidden" name="DealerCode" value="#URL.DealerCode#">
<TR align="center"><TD><FONT FACE="Arial,Helvetica">
<INPUT type="submit" name="BtnChooseImage" value="Continue">&nbsp;&nbsp;&nbsp;<INPUT
type="submit" name="BtnCancel" value="Cancel"></FONT>
</TD></TR>
</FORM>
<TR><TD>&nbsp;</TD></TR>
<FORM action="redirect.cfm" method="post">
<TR ALIGN=CENTER><TD>
<FONT SIZE=2 FACE="arial,helvetica">
<INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg"
			Border="0"
			NAME="BackToMain"
			VALUE="Back To Main Menu">

</FONT>
</TD></TR>
</FORM>
<TR><TD>&nbsp;</TD></TR>
</TABLE>
<p>
<IMG SRC="</CFOUTPUT>#application.RELATIVE_PATH#<CFOUTPUT>/images/demosite/logo_gra.gif"
		BORDER=0
		WIDTH=175
		HEIGHT=24
</div>
</BODY>
</HTML>

