<CFSET webverifystep = 10>
<CFINCLUDE template="security.cfm">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

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
	<!--- $Id: webvrfy_s10.cfm,v 1.6 1999/11/29 15:31:00 lswanson Exp $ --->
	<!--- Coupon Maintenance --->
	
<HTML>
<HEAD>
	<TITLE>WorldDealer | Create a New Web</TITLE>

	<CFIF ParameterExists(Form.btnBack.X)>
		<CFLOCATION url="webvrfy_s9.cfm?dlrcode=#form.dealercode#">
	</CFIF>
	
    <CFIF ParameterExists(Form.btnNext.X)>
       <CFLOCATION URL="#Form.NextStep#?dlrcode=#Form.DealerCode#">
    </CFIF>
        
    <CFIF ParameterExists(Form.btnModify.X)>
    	<CFLOCATION URL="webnew_s10.cfm?dlrcode=#Form.DealerCode#">
    <CFELSE>
       <CFIF ParameterExists(URL.dlrcode)>
          <CFSET VerifyMode = TRUE>
          <CFSET g_DealerCode = #URL.dlrcode#>
       <CFELSE>
          <CFSET VerifyMode = FALSE>
       </CFIF>
    </CFIF>

	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>

<body>
<br><br><br><br><br>

<CFIF VerifyMode>

  <CFQUERY name="getCoupons" datasource="#gDSN#">
  SELECT Description
  FROM VirtualCoupons
  WHERE Status='A' AND
  DealerWebID IN (SELECT DealerWebID FROM DealerWebs WHERE DealerCode = '#g_DealerCode#');
  </CFQUERY>


<div align="center">
<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
<TR>
	<TD ALIGN="center">
		<h3><font face="Arial,Helvetica">
			Maintain Your Web Site
		</font></h3>
	</TD>
</TR>
<TR>
	<TD ALIGN="center">
		<h4><font face="Arial,Helvetica">
			Coupons
		</font></h4>
	</TD>
</TR>
<CFIF #getCoupons.recordcount# IS NOT 0>
	<TR>
		<TD ALIGN="center">
			<font face="Arial,Helvetica">
				The following Coupons are currently associated with
				this Dealership.  Click the 'Modify' button to make
				changes.
			</font>
		</TD>
	</TR>
	<TR><TD>&nbsp;<p></TD></TR>
	<TR>
		<TD ALIGN="center">
		<TABLE BORDER=0 BGCOLOR=cccccc CELLSPACING=3 CELLPADDING=0 WIDTH="80%">
		<CFLOOP query="getCoupons">
			<CFOUTPUT>
				<CFSET section_break = #Find("<P>",Description,1)#>
				<CFSET how_long = #Len(Description)#>
				<CFSET title = #Mid(Description,1,(section_break-1))#>
				<CFSET coupon_text = #Mid(Description,(section_break + 3),how_long)#>
				<TR>
					<TD ALIGN="center">
						<FONT Face="Arial,Helvetica">
							<h3>#title#</h3>
						<p>
							#coupon_text#
						<BR><BR>
						</FONT>
					</TD>
				</TR>
			</CFOUTPUT>
		</CFLOOP>
		</TABLE>
		</TD>
	</TR>
<CFELSE>
	<TR align=center>
		<TD>
			<FONT Face="arial,Helvetica">
				There are currently NO Coupons Associated with this Dealership.  Click
				the 'Modify' button to make changes.
			</FONT>
		</TD>
	</TR>
</CFIF>
<TR><TD>&nbsp;</TD></TR>
<TR>
	<TD ALIGN=CENTER>
		<FORM name="webvrfy10" action="webvrfy_s10.cfm?dlrcode=<CFOUTPUT>#g_DealerCode#</CFOUTPUT>" method="post">
			<INPUT type="hidden" name="DealerCode" value="<CFOUTPUT>#g_dealercode#</CFOUTPUT>">
			<INPUT type="hidden" name="NextStep" value="webvrfy_s11.cfm">
			<INPUT TYPE="Image"
				SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/back_nav.jpg"
				BORDER="0"
				NAME="btnBack"
				VALUE="Back">
			&nbsp;&nbsp;
			<INPUT TYPE="Image"
				SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/addmodifydelete_nav.jpg"
				BORDER="0"
				NAME="btnModify"
				VALUE="Modify">
			&nbsp;&nbsp;
			<INPUT TYPE="Image"
				SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next_nav.jpg"
				BORDER="0"
				NAME="btnNext"
				VALUE="Next">
		</FORM>
		<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
			<INPUT TYPE="Image"
				SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg"
				Border="0"
				NAME="BackToMain"
				VALUE="Back To Main Menu">
		</FORM>
	</TD>
</TR>
</TABLE>

</div>
 
</BODY>
</HTML>
</CFIF>