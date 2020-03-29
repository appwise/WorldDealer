<CFSET webverifystep = 9>
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
	<!--- $Id: webvrfy_s9.cfm,v 1.4 1999/11/29 15:31:02 lswanson Exp $ --->
	<!--- Used Vehicles --->
	
<HTML>

<HEAD>
	<TITLE>WorldDealer | Create a New Web</TITLE>

	<CFIF ParameterExists(Form.btnBack.X)>
		<CFLOCATION url="webvrfy_s8.cfm?dlrcode=#form.dealercode#">
	</CFIF>
	
    <CFIF ParameterExists(Form.btnNext.X)>
        <CFLOCATION URL="#Form.NextStep#?dlrcode=#Form.DealerCode#">
    </CFIF>
        
    <CFIF ParameterExists(Form.btnModify.X)>
		<CFLOCATION URL="webnew_s9.cfm?dlrcode=#Form.DealerCode#">
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

   <CFQUERY NAME="getVehicles" datasource="#gDSN#">
		SELECT	UsedVehicleID as q_UsedVehicleID,
				DealerCode as q_DealerCode,
				VIN as q_VIN,
				Make as q_Make,
				ModelName as q_ModelName,
				CarYear as q_CarYear,
				stock as q_stock,
				image as q_image,
				Features as q_Features
		FROM	UsedVehicles
		WHERE	UsedVehicles.DealerCode = '#g_DealerCode#' 
		ORDER BY	Make, ModelName, CarYear;
      </CFQUERY>        

<div align="center">
       <TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
                <TR ALIGN="center">
                        <TD ALIGN="middle"><h3><font face="Arial,Helvetica">Maintain Your Web Site</font></h3></TD>
                </TR>
                <TR ALIGN="center">
                        <TD ALIGN="middle"><h4><font face="Arial,Helvetica">Used Vehicles</font></h4></TD>
                </TR>
				<CFIF #getVehicles.recordcount# IS NOT 0>
      	          <TR ALIGN="center">
       	                 <TD ALIGN="center"><font face="Arial,Helvetica">The following Used Vehicles are currently associated with this Dealership.  Click the 'Modify' button to make changes.</font></TD>
              	  </TR>
              	  <TR><TD>&nbsp;<p></TD></TR>
				  	<TR><TD align=center>
				  		<TABLE BORDER=0 CELLSPACING=5>
							<TR>
								<TD><FONT SIZE=2 FACE="arial,helvetica"><b>Make</b></FONT></TD>							
								<TD><FONT SIZE=2 FACE="arial,helvetica"><b>Model</b></FONT></TD>
								<TD><FONT SIZE=2 FACE="arial,helvetica"><b>VIN</b></FONT></TD>
								<TD><FONT SIZE=2 FACE="arial,helvetica"><b>Stock</b></FONT></TD>
								<TD><FONT SIZE=2 FACE="arial,helvetica"><b>Year</b></FONT></TD>
								<TD><FONT SIZE=2 FACE="arial,helvetica">&nbsp;&nbsp;<b>Image</b></FONT></TD>
							</TR>
							<CFOUTPUT query="getvehicles">
							<TR>
								<TD><FONT SIZE=2 FACE="arial,helvetica">#q_Make#</FONT></TD>
								<TD><FONT SIZE=2 FACE="arial,helvetica">#q_modelName#</FONT></TD>
								<TD><FONT SIZE=1 FACE="arial,helvetica">#q_VIN#</FONT></TD>
								<TD><FONT SIZE=1 FACE="arial,helvetica">#q_stock#</FONT></TD>
								<TD><FONT SIZE=2 FACE="arial,helvetica">#q_carYear#</FONT></TD>
								<TD><FONT SIZE=2 FACE="arial,helvetica">&nbsp;&nbsp;#q_image#</FONT></TD>
							</TR>
							</CFOUTPUT>
							</TABLE>
					</TD></TR>
					
				<CFELSE>
					<TR align=center><TD><FONT Face="arial,Helvetica">There are currently NO Used Vehicles Associated with this Dealership.  Click the 'Modify' button to make changes.</FONT></TD></TR>
				</CFIF>
					<TR><TD>&nbsp;</TD></TR>
					<FORM name="webvrfy9" action="webvrfy_s9.cfm?dlrcode=<CFOUTPUT>#g_DealerCode#</CFOUTPUT>" method="post">
					<CFOUTPUT>
					<INPUT type="hidden" name="DealerCode" value="#g_dealercode#">
					</CFOUTPUT>
					<INPUT type="hidden" name="NextStep" value="webvrfy_s10.cfm">
					<TR align="center"><TD><INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/back_nav.jpg" BORDER="0" NAME="btnBack" VALUE="< Back">&nbsp;&nbsp;&nbsp;
					<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/addmodifydelete_nav.jpg" BORDER="0" NAME="btnModify" VALUE="Modify">&nbsp;&nbsp;&nbsp;
					<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next_nav.jpg" BORDER="0" NAME="btnNext" VALUE="Next">
					</TD></TR>
					<TR><TD>&nbsp;</TD></TR>
      			  </FORM>
        <TR ALIGN="center"><TD>
                    <FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
                            <INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg" Border="0" NAME="BackToMain" VALUE="Back To Main Menu"></FORM></TD>
        </TR>
</TABLE>
</div>
</CFIF>


</BODY>
</HTML>