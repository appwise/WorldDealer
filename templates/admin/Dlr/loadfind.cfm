<CFSET PageAccess = 2>
<CFINCLUDE template="security.cfm">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
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
	<!--- $Id: loadfind.cfm,v 1.3 1999/11/24 22:54:08 lswanson Exp $ --->

<HEAD>
<TITLE>WorldDealer | Select A Dealer</TITLE>
</HEAD>
<BODY Background="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/1/bg.gif">
<div align="center">

<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=420 BGCOLOR="FFFFFF">
<TR><TD>&nbsp;<p></TD></TR>
<TR ALIGN="center">
	<TD ALIGN="middle"><h3><FONT FACE="Arial,Helvetica">Collection/Dealer Administration - Enter Information</FONT></h3></TD>
</TR>
<!--- Dealer/Collection Query used below --->

<CFQUERY NAME="getCollections" datasource="#gDSN#">
	SELECT	Dealercode as q2_Dealercode, 
			DealershipName as q2_DealershipName,
			AEID as q2_AEID,
			ACID as q2_ACID
	FROM Dealers 
	<CFIF VAL(Left(#Accesslevel#,1)) LT 3>
	Where AEID = #variables.sessionUser# or
		  ACID = #variables.sessionUser#
	</CFIF>
	Order BY Dealercode
</CFQUERY>

<TR ALIGN=center><TD><HR WIDTH="80%"></TD></TR>
<div align="center">
	<TABLE CELLPADDING=5 CELLSPACING=0 BORDER=0 WIDTH=420 BGCOLOR="FFFFFF">
		<TR>
			<TD><div align="center"><FONT FACE="Arial,Helvetica">Select a <B>Collection</B> from the field below then click <B>Next</b>.</FONT></div></TD>
		</TR>
		<TR ALIGN=center>
			<FORM NAME="FindCollection" ACTION="loadfind2.cfm" METHOD="post">
				<TD>
					<div align="center">
					<SELECT NAME="DealerCode" SIZE=1>
					<OPTION VALUE="0000">No Collection
					<CFOUTPUT QUERY="getCollections">
					<CFIF getCollections.RecordCount GT 0>
						<CFIF Mid(#q2_Dealercode#,6,4) IS "0000">
							<OPTION VALUE="#q2_DealerCode#">#q2_DealershipName#
						</CFIF>
					</CFIF>
					</CFOUTPUT>
					</SELECT>
				</TD>
		</TR>
		<TR><TD><P>&nbsp;</P></TD></TR>
		<TR>
		<TD>
		<div align="center">
			<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next_nav.jpg" Border="0" NAME="Next" VALUE="Find a Dealer">
		</div>
		</TD>
		</FORM></div>
		</TR>
		<TR ALIGN="center">
		<TD><P>&nbsp;</P></TD>
		<TR ALIGN="center">
		<TD>
			<div align="center">
			<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
			<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg" Border="0" NAME="BackToMain" VALUE="Back To Main Menu">
			</FORM>
			</div>
		</TD>
	</TR>
	</TABLE>

</div>

</BODY>

</HTML>


