<CFINCLUDE template="security.cfm">

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

   <!-- ----------------------------------------------------------- -->
   <!--             Created by Sigma6, Inc.                         -->
   <!--     Copyright (c) 1998, 1999 Sigma6, Inc.                   -->
   <!--         All Rights Reserved.  Used By Permission.           -->
   <!-- ----------------------------------------------------------- -->
   <!-- ----------------------------------------------------------- -->
   <!--           Sigma6, interactive media, Detroit/NYC            -->
   <!--               conceive : construct : connect                -->
   <!--   www.sigma6.com   webmaster@sigma6.com   info@sigma6.com   -->
   <!--                                                             -->
   <!--   Last updated: Monday, May 18, 1998                        -->
   <!-- ----------------------------------------------------------- -->
   <!--     Howard Levine for sigma6, interactive media, Detroit    -->
   <!--    hlevine@sigma6.com   www.sigma6.com    www.s6313.com     -->
   <!--               conceive : construct : connect                -->
   <!-- ----------------------------------------------------------- -->
   <!-- ----------------------------------------------------------- -->
   <!-- Sigma6, s6, and the Sigma6 logos are registered trademarks. -->
   <!-- All other trademarks and servicemarks are the property of   -->
   <!-- their respective owners.                                    -->
   <!-- ----------------------------------------------------------- -->
	<!--- $Id: webvrfy_s12d.cfm,v 1.6 1999/11/29 15:31:00 lswanson Exp $ --->
	<!--- Congrats!  Done creating web site. --->

<CFSET g_Dealercode = #url.dlrcode#>

<CFQUERY name="getdealer" datasource="#gDSN#">
SELECT DealershipName
FROM Dealers
WHERE Dealercode = '#g_dealercode#';
</CFQUERY>

<HTML>
<HEAD>
   <TITLE>WorldDealer | Create a New Web</TITLE>

	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

	<!--- to get the webstateid --->
	<CFQUERY NAME="getwebstate" datasource="#gDSN#">
		SELECT  webstateid
		FROM    dealerwebs
		WHERE   dealercode = '#g_dealercode#'
	</CFQUERY>
</HEAD>

<body>
<br><br><br><br><br>


<div align="center">
       <TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
                <TR ALIGN="center">
                        <TD ALIGN="middle"><h3><font face="Arial,Helvetica">Dealer Administration - Verify Dealer Info</font></h3></TD>
                </TR>
				<TR align="center"><TD><FONT FACE="Arial,Helvetica">
				Congratulations!<br>You have finished building the web site for <br>
				<CFOUTPUT><b>#getdealer.dealershipname#</b></CFOUTPUT>.<br><br>
				<CFOUTPUT>
				<CFIF #getwebstate.webstateid# EQ 1>
					Click <B><A HREF="#application.RELATIVE_PATH#/templates/dlr/index.cfm?dealercode=#URL.dlrcode#">here</A></B>
					to view the completed site.
				<!--- 8/24/99: don't know if this is the route Messner wants to go.  Might get bombarded with calls.
				<CFELSE>
					To view the completed site, ask your WorldDealer Account Coordinator to activate this site. --->
				</cfif>
				</CFOUTPUT>
				</FONT></TD></TR>
				<TR><TD>&nbsp;</TD></TR>
				<CFOUTPUT><FORM ACTION="webvrfy_s11.cfm?dlrcode=#g_dealercode#" method="post"></CFOUTPUT>
				<CFOUTPUT>
				<INPUT type="hidden" name="DealerCode" value="#g_dealercode#">
				</CFOUTPUT>
				<TR align="center"><TD><FONT FACE="Arial,Helvetica" size="-1">
				<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/back_nav.jpg" Border="0" NAME="Back" VALUE="Back">
				
				</FONT></TD></TR>
				</FORM>
				<TR><TD>&nbsp;</TD></TR>
				<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
				<TR align="center"><TD><FONT FACE="Arial,Helvetica" SIZE="-1">
				<INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg"
			Border="0"
			NAME="BackToMain"
			VALUE="Back To Main Menu">

                </FONT></TD></TR>
				</FORM>
				<TR><TD>&nbsp;</TD></TR>
				</TABLE>
				
				
				
				</BODY>
				</HTML>

			

</BODY>
</HTML>
