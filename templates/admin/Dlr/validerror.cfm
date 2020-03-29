<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>

<!--------------------------------------------------------------------------------
ALL IMAGES ON THIS PAGE MUST CONTAIN RELATIVE PATHS, NOT ABSOLUTE
ALSO NOTICE THE CONSPICUOUS LACK OF INCLUDES
--------------------------------------------------------------------------------->

    <!-- ----------------------------------------------------------- -->
    <!--                Created by sigma6, Detroit                   -->
    <!--         Copyright (c) 1997, 1998, 1999 sigma6.              -->
    <!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->

    <!-- ----------------------------------------------------------- -->
    <!--     John Turner for sigma6, interactive media, Detroit      -->
    <!--    jturner@sigma6.com   www.sigma6.com    www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
	<!--- $Id: validerror.cfm,v 1.6 1999/11/30 21:38:14 lswanson Exp $ --->

<HEAD>
        <TITLE>WorldDealer | Validation Error</TITLE>
	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>

<body>
<br><br><br><br><br>

<div align="center">
<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
<TR>
	<TD ALIGN="center">
		<h3><font face="arial,helvetica">
			Dealer Administration
		</font></h3>
	</TD>
</TR>
<TR><TD>&nbsp;<p></TD></TR>
<TR>
	<TD ALIGN="center">
		<h4><font face="arial,helvetica">
			Validation Error
		</font></h4>
	</TD>
</TR>
<TR><TD>&nbsp;<p></TD></TR>
<TR>
	<TD>
		<FONT FACE="arial,helvetica">
			<H2>Oops</H2>
			<CFOUTPUT>
				<P>Some fields were not completed in the form. The following problems occurred:
				#Error.InvalidFields# 
			</CFOUTPUT>
		</FONT>
	</TD>
</TR>
<TR><TD>&nbsp;<p></TD></TR>
<TR ALIGN="center">
	<TD>
	<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
		<A HREF="#"
			OnMouseOver="self.status='Back';return true"
			OnMouseOut="self.status='';return true"
			OnClick="JavaScript:history.go(-1);"><IMG
				SRC="../../../images/admin/back_nav.jpg"
				Border="0"
				ALT="Back"></A>
				<!--- linda, 11/30/99: for some reason, it doesn't translate the variable path.  so have to hardcode the relative path.
				Since this error file is called from application.cfm, I even moved this call to AFTER application.RELATIVE_PATH is defined.  Still not happy. :(  --->
				<!--- SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/back_nav.jpg" --->
		<BR><BR>
		<INPUT TYPE="Image"
			SRC="../../../images/admin/backtomain_nav.jpg"
			Border="0"
			NAME="BackToMain"
			VALUE="Back To Main Menu">
			<!--- SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg" --->
	</FORM>
	</TD>
</TR>
</TABLE>
</div>

</BODY>
</HTML>