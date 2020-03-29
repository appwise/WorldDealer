<CFSET PageAccess = 0>
<CFINCLUDE template="security.cfm">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>

    <!-- ----------------------------------------------------------- -->
    <!--                  Created by sigma6, Detroit                 -->
    <!--            Copyright (c) 1997, 1998, 1999 sigma6.           -->
    <!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->

    <!-- ----------------------------------------------------------- -->
    <!--    Howard Levine for sigma6, interactive media, Detroit     -->
    <!--    hlevine@sigma6.com   www.sigma6.com    www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
	<!--- $Id: index2.cfm,v 1.10 1999/12/03 21:28:58 lswanson Exp $ --->

<HEAD>

    <TITLE>WorldDealer | Dealer Administration</TITLE>
	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">
	
</HEAD>

<body>
<br><br><br><br><br>
<div align="center">


<!---    EVERYONE (ALL ACCESS LEVELS) SEE THIS    --->
<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
	<TR><TD>&nbsp;<p></TD></TR>
		
    <TR ALIGN="center">
        <TD ALIGN="middle"><h3>WorldDealer Administration Main Menu</h3></TD>
    </TR>
		
	<FORM NAME="f_Main" ACTION="redirect.cfm" METHOD="post">
	
	<TR ALIGN="center">
		<TD>
			<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0>
		
			<!--- START SECTION 1 --->
			
			<TR ALIGN="center"><td colspan="3" align="CENTER">
				
				<b>Update Your Web Site</b></TD></TR>
			
			<TR><TD>&nbsp;</TD></TR>
			
 			<!--- All access levels --->
            <TR>
            	<TD ALIGN="right">Update Web Site or Collection</TD>
				<TD>&nbsp;&nbsp;&nbsp;</TD>                             
                <TD>
				<INPUT TYPE="image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/go_nav.jpg" Border="0" NAME="NewSearch" VALUE="GO!">
				</TD>
            </TR>
							
            <TR><TD COLSPAN=3>&nbsp;<p></TD></TR>

			<!--- Only Admin Access sees this --->
			<CFIF #Left(AccessLevel,1)# EQ #application.SYSADMIN_ACCESS#>				
            <TR>
            	<TD ALIGN="right">Update Web Activity State</TD>
            	<TD>&nbsp;&nbsp;&nbsp;</TD>                             
            	<TD>
				<INPUT TYPE="image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/go_nav.jpg" Border="0" NAME="WebState" VALUE="GO!">
				</TD>
            </TR>
							
            <TR><TD COLSPAN=3>&nbsp;<p></TD></TR>

			</CFIF>
			<CFIF #Left(AccessLevel,1)# EQ #application.SYSADMIN_ACCESS#>
			<TR>
				<TD ALIGN="Right">Maintain National and Regional Offers</TD>
				<TD>&nbsp;&nbsp;&nbsp;</TD>
				<TD>
				<INPUT TYPE="image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/go_nav.jpg" Border="0" name="NationalOffers" value="GO!">
				</TD>
			</TR>
			</cfif>
			<CFIF #Left(AccessLevel,1)# GTE #application.ACCOUNT_COORDINATOR_ACCESS#>	
			<TR><TD COLSPAN=3>&nbsp;<p></TD></TR>
            <TR><TD COLSPAN=3><HR WIDTH="100%"></TD></TR>
            <TR><TD COLSPAN=3>&nbsp;<p></TD></TR>
		
			<!---   END SECTION 1 / START SECTION 2   --->
			
			<TR ALIGN="center"><TD COLSPAN=3><b>WorldDealer Database Maintenance</b></TD></TR>
			
			<TR><TD COLSPAN=3>&nbsp;&nbsp;&nbsp;</TD></TR>
<!--- Linda 3/16/99: This is redundant of "Maintain Web Site" in "Web Site Maintenance" section	
			<TR>
            	<TD ALIGN="right">Edit Collection/Dealer Information</TD>
                <TD>&nbsp;&nbsp;&nbsp;</TD>                             
                <TD><INPUT TYPE="image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/go_nav.jpg" Border="0" NAME="FindDealer" VALUE="GO!"></TD>
            </TR>

			<TR><TD COLSPAN=3>&nbsp;<p></TD></TR>
 --->
			<TR>
            	<TD ALIGN="right">Add a New Collection</TD>
                <TD>&nbsp;&nbsp;&nbsp;</TD>                             
                <TD><INPUT TYPE="image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/go_nav.jpg" Border="0" NAME="NewCollection" VALUE="GO!"></TD>
            </TR>

			<TR><TD COLSPAN=3>&nbsp;<p></TD></TR>
			
			<TR>
            	<TD ALIGN="right">Add a New Dealer</TD>
                <TD>&nbsp;&nbsp;&nbsp;</TD>                             
                <TD><INPUT TYPE="image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/go_nav.jpg" Border="0" NAME="NewDealer" VALUE="GO!"></TD>
            </TR>

			<TR><TD COLSPAN=3>&nbsp;<p></TD></TR>
			
			<TR>
				<TD ALIGN="right">Delete a Collection</TD>
				<TD>&nbsp;&nbsp;&nbsp;</TD>
				<TD><INPUT TYPE="image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/go_nav.jpg" Border="0" NAME="DeleteCollection" Value="GO!"></TD>
			</TR>
			
			<TR><TD COLSPAN=3>&nbsp;<p></TD></TR>
			
			<TR>
				<TD ALIGN="right">Delete a Dealer</TD>
				<TD>&nbsp;&nbsp;&nbsp;</TD>
				<TD><INPUT TYPE="image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/go_nav.jpg" Border="0" NAME="DeleteDealer" Value="GO!"></TD>
			</TR>
			
			<TR><TD COLSPAN=3>&nbsp;<p></TD></TR>

			<TR>
				<TD ALIGN="right">Maintain Makes and Models</TD>
				<TD>&nbsp;&nbsp;&nbsp;</TD>
				<TD><INPUT TYPE="image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/go_nav.jpg" Border="0" NAME="Manuf" Value="GO!"></TD>
			</TR>
<!--- linda, 9/15/99: merged make & model maintenance
			<TR><TD COLSPAN=3>&nbsp;<p></TD></TR>

			<TR>
				<TD ALIGN="right">Maintain New Models</TD>
				<TD>&nbsp;&nbsp;&nbsp;</TD>
				<TD><INPUT TYPE="image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/go_nav.jpg" Border="0" NAME="NewModel" Value="GO!"></TD>
			</TR>
 --->			
			<TR><TD COLSPAN=3>&nbsp;<p></TD></TR>

			<TR>
				<TD ALIGN="right">Add a Pre-Owned Model</TD>
				<TD>&nbsp;&nbsp;&nbsp;</TD>
				<TD><INPUT TYPE="image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/go_nav.jpg" Border="0" NAME="AddModel" Value="GO!"></TD>
			</TR>
			
			<TR><TD COLSPAN=3>&nbsp;<p></TD></TR>

			<TR>
				<TD ALIGN="right">Delete a Pre-Owned Model</TD>
				<TD>&nbsp;&nbsp;&nbsp;</TD>
				<TD><INPUT TYPE="image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/go_nav.jpg" Border="0" NAME="DeleteModel" Value="GO!"></TD>
			</TR>
			
			<TR><TD COLSPAN=3>&nbsp;<p></TD></TR></CFIF>
			
			<CFIF #Left(AccessLevel,1)# EQ #application.SYSADMIN_ACCESS#>				
			<TR>
            	<TD ALIGN="right">Maintain the List of Account Executives</TD>
                <TD>&nbsp;&nbsp;&nbsp;</TD>                             
                <TD><INPUT TYPE="image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/go_nav.jpg" Border="0" NAME="AE" VALUE="GO!"></TD>
            </TR>

			<TR><TD COLSPAN=3>&nbsp;<p></TD></TR>
			
            <TR>
            	<TD ALIGN="right">Maintain the List of Account Coordinators</TD>
                <TD>&nbsp;&nbsp;&nbsp;</TD>                             
                <TD><INPUT TYPE="image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/go_nav.jpg" Border="0" NAME="AC" VALUE="GO!"></TD>
            </TR>
			
			<TR><TD COLSPAN=3>&nbsp;<p></TD></TR>

            <TR>
            	<TD ALIGN="right">Maintain the List of Dealer Administrators</TD>
                <TD>&nbsp;&nbsp;&nbsp;</TD>                             
                <TD><INPUT TYPE="image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/go_nav.jpg" Border="0" NAME="DA" VALUE="GO!"></TD>
            </TR>
			
			<TR><TD COLSPAN=3>&nbsp;&nbsp;&nbsp;</TD></TR>
			</CFIF>
			
            <TR><TD COLSPAN=3><HR WIDTH="100%"></TD></TR>
            <TR><TD COLSPAN=3>&nbsp;<p></TD></TR>
	
			<!--- END SECTION 2 / START SECTION 3  --->
			
			<TR ALIGN="center"><TD COLSPAN=3><b>Generate Reports</b></TD></TR>
			
			<!--- <TR><TD COSPAN=3>&nbsp;</TD></TR>
			<TR>
            	<TD ALIGN="right">Dealer Web Reporting</TD>
                <TD>&nbsp;&nbsp;&nbsp;</TD>                             
                <TD>
				<INPUT TYPE="submit" NAME="Reporting" VALUE="GO!">
				</TD>
            </TR> --->
				<TR>
					<TD COLSPAN=3>&nbsp;<p></TD>
				</TR>
			<CFIF #Left(AccessLevel,1)# GTE #application.ACCOUNT_COORDINATOR_ACCESS#>
				<TR>
					<TD ALIGN="right">Offers  Reporting</TD>
					<TD>&nbsp;&nbsp;&nbsp;</TD>                             
					<TD>
					<INPUT TYPE="image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/go_nav.jpg" Border="0" NAME="OfferMaint" VALUE="GO!">
					</TD>
				</TR>
				<TR>
					<TD COLSPAN=3>&nbsp;<p></TD>
				</TR>
<!--- linda, 12/3/99: messner keeps selecting this & it's not coded for WD *at all*.  still using WDDE code.  Comment out until it's done.		
				
				<TR>
					<TD ALIGN="right">View/Print Collection/Dealer Info</TD>
					<TD>&nbsp;&nbsp;&nbsp;</TD>                             
					<TD><INPUT TYPE="image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/go_nav.jpg" Border="0" NAME="ViewPrint" VALUE="GO!"></TD>
				</TR>
				<TR>
					<TD COLSPAN=3>&nbsp;</TD>
				</TR>
--->
            </CFIF>
<!--- linda, 12/3/99: messner keeps selecting this & it's not coded for WD *at all*.  still using WDDE code.  Comment out until it's done.		
			<CFIF #Left(AccessLevel,1)# GTE #application.ACCOUNT_EXECUTIVE_ACCESS#>
				<TR>
					<TD ALIGN="right">Administrative Logon Reporting</TD>
					<TD>&nbsp;&nbsp;&nbsp;</TD>                             
					<TD>
					<INPUT TYPE="image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/go_nav.jpg" Border="0" NAME="LogonReports" VALUE="GO!">
					</TD>
				</TR>
            	<TR>
					<TD COLSPAN=3>&nbsp;<p></TD>
				</TR>
			</CFIF>	
            <CFIF #Left(AccessLevel,1)# GTE #application.ACCOUNT_COORDINATOR_ACCESS#>
				<TR>
					<TD ALIGN="right">Art Template Reporting</TD>
					<TD>&nbsp;&nbsp;&nbsp;</TD>
					<TD><INPUT TYPE="image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/go_nav.jpg" Border="0" name="TemplateReport" Value="GO!"></TD>
				</TR>
			</CFIF>
			<TR>
				<TD COLSPAN=3>&nbsp;<p></TD>
			</TR>
 --->
			<TR>
		 		<TD ALIGN="right">Lead Reporting</TD>
				<TD>&nbsp;&nbsp;&nbsp;</TD>
				<TD><INPUT TYPE="image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/go_nav.jpg" Border="0" name="LeadReport" Value="GO!"></TD>
			</TR>
			<TR><TD COLSPAN=3>&nbsp;<p></TD></TR>
	        <TR><TD COLSPAN=3><HR WIDTH="100%"></TD></TR>
	        <TR><TD COLSPAN=3>&nbsp;<p></TD></TR>
		</TABLE>
		</TD>
	</TR>
	</FORM>
</TABLE>
	

</div>

</BODY>
</HTML>
