<CFINCLUDE template="security.cfm">

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

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
	<!--- $Id: webvrfy_s6b.cfm,v 1.5 1999/11/29 15:31:01 lswanson Exp $ --->
	<!--- Service Profile --->

<HTML>

<HEAD>

        <TITLE>WorldDealer | Create a New Web</TITLE>

	<CFIF ParameterExists(Form.btnBack.X)>
		<CFLOCATION url="webvrfy_s6.cfm?dlrcode=#form.dealercode#">
	</CFIF>
	
    <CFIF ParameterExists(Form.btnNext.X)>
       <CFLOCATION URL="#Form.NextStep#?dlrcode=#Form.DealerCode#">
    </CFIF>
        
    <CFIF ParameterExists(Form.btnModify.X)>
    	<CFLOCATION URL="webnew_s6b.cfm?dlrcode=#Form.DealerCode#">
    <CFELSE>
       <CFIF ParameterExists(URL.dlrcode)>
          <CFSET VerifyMode = TRUE>
          <CFSET g_DealerCode = #URL.dlrcode#>
       <CFELSE>
          <CFSET VerifyMode = FALSE>
       </CFIF>
    </CFIF>

	<CFIF VerifyMode>
    	<CFQUERY NAME="getDLRText" datasource="#gDSN#">
        	SELECT ServiceMainText as q_ServiceMainText_unformat
            FROM DealerWebs
            WHERE DealerWebs.DealerCode = '#g_DealerCode#'
		</CFQUERY>
		   
		<!--- Remove those funky tilde things --->
		<CFSET temp = #getDLRText.q_ServiceMainText_unformat#>
		<CFSET start_pos = 1>
		<CFLOOP from=1 to=3 index="count">
			<CFIF #start_pos# EQ 0>
				<CFBREAK>
			</CFIF>
			<CFSET #start_pos# = #Find("~~",temp,start_pos)#>
			<CFIF #start_pos#>  <!--- IS NOT 0 --->
				<CFSET #temp# = #RemoveChars(temp,start_pos,4)#>
				<CFSET #start_pos# = #start_pos# + 4>
			</CFIF>
		</CFLOOP>
		<CFSET #q_ServiceMainText# = #temp#>
    </CFIF>
	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>

<body>
<br><br><br><br><br>

<CFIF VerifyMode>
	<div align="center">
    <TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
    <TR ALIGN="center">
    	<TD ALIGN="middle"><h3><font face="Arial,Helvetica">Maintain Your Web Site</font></h3></TD>
    </TR>
	<TR ALIGN="center">
    	<TD ALIGN="middle">
				<font face="Arial,Helvetica">
				<h4> Service Profile</h4>
				</font>
				<font face="Arial,Helvetica">
				Your Service Profile tells customers about your service department -- it's history, its employees; anything you'd like customers to know about your service department and what sets it apart from the rest.  To update your Service Profile, please select <b>'Modify'</b> below.
				</font>
	</TD>
    </TR>
 	<TR>
        <TD>
            <TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0 WIDTH="100%">
			<TR><TD>&nbsp;<p></TD></TR>
            <TR>
				<TD ALIGN=middle>
					<font face="Arial,Helvetica">
					<b>Part B - Service Profile</B>
					</FONT>
				</TD>
			</TR>
			<TR><TD>&nbsp;<p></TD></TR>
			<TR ALIGN=center>
				<TD>
					<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0 WIDTH=80%>
                    <TR>
						<TD BGCOLOR=ffffff><font face="Arial,Helvetica">
							<CFOUTPUT QUERY="getDLRText">
		                    <CFIF #q_ServiceMainText# IS "">
								This dealer does not have a Service Department profile.
							<CFELSE>
								#q_ServiceMainText#
							</CFIF>
							</CFOUTPUT></FONT>
						</TD>
					</TR>
					</TABLE>
				</TD>
			</TR>
            <TR><TD>&nbsp;<p></TD></TR>
            </TABLE>
        </TD>
    </TR>
    <TR><TD>&nbsp;<p></TD></TR>
    <TR>
        <TD>
            <CFOUTPUT>
            <FORM NAME="VrfySixB" ACTION="webvrfy_s6b.cfm?dlrcode=#g_DealerCode#" METHOD="post">
            <TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0 WIDTH="100%">
            <TR><TD>&nbsp;<p></TD></TR>
            </TABLE>
        </TD>
    </TR>
    <TR ALIGN="center">
    	<TD>
            <INPUT TYPE="hidden" NAME="DealerCode" VALUE="#g_DealerCode#">
            <INPUT TYPE="hidden" NAME="NextStep" VALUE="webvrfy_s7.cfm">
			<INPUT TYPE="Image" SRC="#application.RELATIVE_PATH#/images/admin/back_nav.jpg" BORDER="0" NAME="btnBack" VALUE="< Back">
			&nbsp;&nbsp;
            <INPUT TYPE="Image" SRC="#application.RELATIVE_PATH#/images/admin/modify_nav.jpg" BORDER="0" NAME="btnModify" VALUE="Modify">
            &nbsp;&nbsp;
            <INPUT TYPE="Image" SRC="#application.RELATIVE_PATH#/images/admin/next_nav.jpg" BORDER="0" NAME="btnNext" VALUE="Next">
            </FORM>
            <p>
            </CFOUTPUT>
            <FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
            <INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg" Border="0" NAME="BackToMain" VALUE="Back To Main Menu">
			</FORM>
		</TD>
    </TR>
    </TABLE>
	
    </div>
</CFIF>
</BODY>
</HTML>