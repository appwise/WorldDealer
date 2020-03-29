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
	<!--- $Id: loadfind2.cfm,v 1.3 1999/11/24 22:54:08 lswanson Exp $ --->

<HEAD>
<TITLE>WorldDealer | Select A Dealer</TITLE>
</HEAD>
<BODY Background="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/1/bg.gif">

<CFIF ParameterExists(Form.DealerCode)>
	<CFQUERY NAME="getCollection" datasource="#gDSN#">
		SELECT	Dealercode as q2_Dealercode, 
				DealershipName as q2_DealershipName,
				AEID as q2_AEID,
				ACID as q2_ACID
		FROM Dealers 
		Where Dealercode = '#Form.Dealercode#'
	</CFQUERY>
</CFIF>
	
<CFQUERY NAME="getDealerships" datasource="#gDSN#">
	SELECT	Dealercode as q_Dealercode, 
			DealershipName as q_DealershipName,
			AEID as q_AEID,
			ACID as q_ACID
	FROM Dealers 
	<CFIF VAL(Left(#Accesslevel#,1)) LT 3>
		Where AEID = #variables.sessionUser# or
			  ACID = #variables.sessionUser#
	</CFIF>
		Order BY Dealercode
	</CFQUERY>

<div align="center">

<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=420 BGCOLOR="FFFFFF">
	<TR><TD>&nbsp;<p></TD></TR>
	<TR ALIGN="center">
	<TD ALIGN="middle"><h3><FONT FACE="Arial,Helvetica">Collection/Dealer Administration - Select Collection/Dealer</FONT></h3></TD>
	</TR>
	<!--- Dealer/Collection Query used below --->
		<CFIF Left(#Form.DealerCode#,4) NEQ "0000">			
		<TR ALIGN=center><TD><HR WIDTH="80%"></TD></TR>
			<div align="center">
		<TR>
			<TD><div align="center"><FONT FACE="Arial,Helvetica">Select a <B>Collection</B> from the field below then click <B>Modify</b>.</FONT></div></TD>
		</TR>
		<TR><TD><P>&nbsp;</P></td></tr>
		<TR ALIGN=center>
		<FORM NAME="FindCollection" ACTION="loadnew.cfm?Addtype=Collection" METHOD="post">
		<TD>
			<div align="center">
			<SELECT NAME="DealerCode" SIZE=1>
			<CFOUTPUT QUERY="getCollection">
			<CFIF Mid(#q2_Dealercode#,6,4) IS "0000">
				<OPTION VALUE="#q2_DealerCode#">#q2_DealershipName#
			</CFIF>
			</CFOUTPUT>
			</SELECT>
			<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/modify_nav.jpg" Border="0" NAME="Next" VALUE="Next">
		</TD>
		</TR>
		</FORM>
		</div>
		</CFIF>
	<TR><TD><P>&nbsp;</P></td></tr>	
	<CFIF getDealerships.RecordCount GT 0>
		<TR>
			<TD><div align="center"><FONT FACE="Arial,Helvetica">Select a <B>Dealer</B> from the field below then click <B>Modify</b>.</b></FONT></div></TD>
		</TR>
			<TR><TD><P>&nbsp;</P></td></tr>	
		<TR>
		<FORM NAME="FindDealer" ACTION="loadnew.cfm?Addtype=Dealer" METHOD="post">
			<TD>
			<div align="center">
			<SELECT NAME="DealerCode" SIZE=1>
			<CFOUTPUT QUERY="getDealerships">
			<CFIF Left(q_Dealercode,4) IS Left(Form.Dealercode,4)>
				<CFIF VAL(MID(q_Dealercode,6,4)) GT 0>
					<OPTION VALUE="#q_DealerCode#">#q_DealershipName#
				</CFIF>
			</CFIF>
			</CFOUTPUT>
			</SELECT>
			<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/modify.jpg" Border="0" NAME="Next" VALUE="Next">
			</div>
			</TD>
		</FORM>	
		</TR>
	<CFELSE>
		<TR>
			<TD><div align="center"><FONT FACE="Arial,Helvetica">There were no Dealerships found meeting your Security Requirements</FONT></div></TD>
		</TR>
	</CFIF>
	<TR><TD><P>&nbsp;</P></td></tr>
		<TR><TD><P>&nbsp;</P></td></tr>
	<TR ALIGN="center">
	<TD>
	<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
	<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg" Border="0" NAME="BackToMain" VALUE="Back To Main Menu"></FORM></TD>
	</TR>
	</TABLE>

</div>
</BODY>
</HTML>