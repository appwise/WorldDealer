<CFSET webverifystep = 7>
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
	<!--- $Id: webvrfy_s7.cfm,v 1.7 1999/11/29 15:31:01 lswanson Exp $ --->
	<!--- Why We Are Different - Showroom, Pre-Owned, Quote, Service --->

<HTML>

<HEAD>

        <TITLE>WorldDealer | Why We're Different</TITLE>

	<CFIF ParameterExists(Form.btnBack.X)>
		<!--- If it's a collection, skip s6b & return to s6 --->
		<CFIF ParameterExists(URL.dlrcode) AND Mid(URL.dlrcode, 6,4) EQ '0000'>
	    	<CFLOCATION URL="webvrfy_s6.cfm?dlrcode=#Form.DealerCode#">
		<cfelse>
			<CFLOCATION url="webvrfy_s6b.cfm?dlrcode=#form.dealercode#">
		</cfif>
	</CFIF>
	
    <CFIF ParameterExists(Form.btnNext.X)>
	<!--- If it's a collection, skip s8, s9, s10 & forward it to s11 --->
		<CFIF ParameterExists(URL.dlrcode) AND Mid(URL.dlrcode, 6,4) EQ '0000'>
		   	<CFLOCATION URL="webvrfy_s11.cfm?dlrcode=#Form.DealerCode#">
		<cfelse>
			<CFLOCATION URL="#Form.NextStep#?dlrcode=#Form.DealerCode#">
		</CFIF>
    </CFIF>
        
    <CFIF ParameterExists(Form.btnModify.X)>
    	<CFLOCATION URL="webnew_s7.cfm?dlrcode=#Form.DealerCode#">
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
			SELECT OffersSetApartText as q_OffersSetApartText,
                   VehicleInqSetApartText1 as q_VehicleInqSetApartText,
                   ServiceInqSetApartText2 as q_ServiceInqSetApartText,
				   PreOwnedSetApartText as q_PreOwnedSetApartText
            FROM DealerWebs
            WHERE DealerWebs.DealerCode = '#g_DealerCode#'
        </CFQUERY>
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
		<TD align="center"><h3>Maintain Your Web Site</h3></TD>
	</TR>
    <TR>
    	<TD ALIGN="center">
			<h4>"Why We Are Different" Text</h4>
			To update your "Why We Are Different" text, please select <b>'Modify'</b> below.
		</TD>
    </TR>

	<TR><TD>&nbsp;<p></TD></TR>
    <TR>
    	<TD>
        	<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0 WIDTH="100%">
            <TR>
				<TD ALIGN="center">
					<font face="Arial,Helvetica"><b>Showroom Page</B></FONT>
				</TD>
			</TR>
            <TR><TD>&nbsp;<p></TD></TR>
            <TR ALIGN=center>
            	<TD>
					<TABLE BORDER=0 WIDTH=95%>
					<TR>
						<TD BGCOLOR=ffffff>
							<font face="Arial,Helvetica">
	                    	<CFIF #RTrim(getDLRtext.q_OffersSetApartText)# IS "">
								This dealer does not have text to display on the Showroom page.
							<CFELSE>
								<CFOUTPUT QUERY="getDLRText">
								#q_OffersSetApartText#
								</CFOUTPUT>
							</CFIF>
							</FONT>
						</TD>
					</TR>
					</TABLE>
				</TD>
			</TR>
            <TR><TD>&nbsp;<p></TD></TR>

			<!--- Pre-Owned Set Apart --->
			<TR>
				<TD ALIGN="center">
					<font face="Arial,Helvetica"><b>Pre-Owned Page</B></FONT>
				</TD>
			</TR>
            <TR><TD>&nbsp;<p></TD></TR>
            <TR ALIGN=center>
            	<TD>
					<TABLE BORDER=0 WIDTH=95%>
					<TR>
						<TD BGCOLOR=ffffff>
							<font face="Arial,Helvetica">
	                    	<CFIF #RTrim(getDLRtext.q_PreOwnedSetApartText)# IS "">
								This dealer does not have text to display on the Pre-Owned page.
							<CFELSE>
								<CFOUTPUT QUERY="getDLRText">
								#q_PreOwnedSetApartText#
								</CFOUTPUT>
							</CFIF>
							</FONT>
						</TD>
					</TR>
					</TABLE>
				</TD>
			</TR>
            <TR><TD>&nbsp;<p></TD></TR>

			<!--- If it's a collection, skip Quote and Service Page sections --->
			<CFIF ParameterExists(URL.dlrcode) AND Mid(URL.dlrcode, 6,4) EQ '0000'>
				<!--- do nothing --->
			<CFELSE>
			    <TR>
					<TD ALIGN=middle>
						<font face="Arial,Helvetica">
						<b>Quote Request Page</B>
						</FONT>
					</TD>
				</TR>
            	<TR><TD>&nbsp;<p></TD></TR>
	            <TR ALIGN=center>
    	        	<TD>
						<TABLE BORDER=0 WIDTH=95%>
						<TR>
							<TD BGCOLOR=ffffff>
								<font face="Arial,Helvetica">
	                    		<CFIF #RTrim(getDLRText.q_VehicleInqSetApartText)# IS "">
									This dealer does not have text to display on the Quote page.
								<CFELSE>
									<CFOUTPUT QUERY="getDLRText">
									#q_VehicleInqSetApartText#
									</CFOUTPUT>
								</CFIF>
								</FONT>
							</TD>
						</TR>
						</TABLE>
        	        </TD>
				</TR>
	            <TR><TD>&nbsp;<p></TD></TR>
				<TR>
					<TD ALIGN=middle>
						<font face="Arial,Helvetica">
						<b>Service Page</B>
						</FONT>
					</TD>
				</TR>
    	        <TR><TD>&nbsp;<p></TD></TR>
        	    <TR ALIGN=center>
            		<TD>
						<TABLE BORDER=0 WIDTH=95%>
						<TR>
							<TD BGCOLOR=ffffff>
								<font face="Arial,Helvetica">
		                    	<CFIF #RTrim(getDLRText.q_ServiceInqSetApartText)# IS "">
									This dealer does not have text to display on the Service & Parts page.
								<CFELSE>
									<CFOUTPUT QUERY="getDLRText">
									#q_ServiceInqSetApartText#
									</CFOUTPUT>
								</CFIF>
								</FONT>
							</TD>
						</TR>
						</TABLE>
            	    </TD>
				</TR>
				<TR><TD>&nbsp;<p></TD></TR>
			</CFIF>
			
            </TABLE>
		</TD>
    </TR>
    <TR><TD>&nbsp;<p></TD></TR>
    <TR>
    	<TD>
            <FORM NAME="VrfySeven" ACTION="webvrfy_s7.cfm?dlrcode=<CFOUTPUT>#g_DealerCode#</CFOUTPUT>" METHOD="post">
            <TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0 WIDTH="100%">
            <TR><TD>&nbsp;<p></TD></TR>
            </TABLE>
        </TD>
    </TR>
    <TR ALIGN="center">
    	<TD>
			<INPUT TYPE="hidden" NAME="DealerCode" VALUE="<CFOUTPUT>#g_DealerCode#</CFOUTPUT>">
            <INPUT TYPE="hidden" NAME="NextStep" VALUE="webvrfy_s8.cfm">
			<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/back_nav.jpg" BORDER="0" NAME="btnBack" VALUE="< Back">
			&nbsp;&nbsp;
            <INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/modify_nav.jpg" BORDER="0" NAME="btnModify" VALUE="Modify">
            &nbsp;&nbsp;
            <INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next_nav.jpg" BORDER="0" NAME="btnNext" VALUE="Next">
            </FORM>
            <p>
            
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