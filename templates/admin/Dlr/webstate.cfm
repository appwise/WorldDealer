   <!-- ----------------------------------------------------------- -->
   <!--           Created for WorldDealer by Sigma6, Inc.           -->
   <!--     Copyright (c) 1998, 1999 WorldDealer and Sigma6, Inc.   -->
   <!--         All Rights Reserved.  Used By Permission.           -->
   <!-- ----------------------------------------------------------- -->
   <!-- ----------------------------------------------------------- -->
   <!--           Sigma6, interactive media, Detroit/NYC            -->
   <!--               conceive : construct : connect                -->
   <!--   www.sigma6.com   webmaster@sigma6.com   info@sigma6.com   -->
   <!--                                                             -->
   <!--   Last updated: January 6, 1999                             -->
   <!-- ----------------------------------------------------------- -->
   <!--     Linda Swanson for sigma6, interactive media, Detroit    -->
   <!--    lswanson@sigma6.com   www.sigma6.com    www.s6313.com    -->
   <!--               conceive : construct : connect                -->
   <!-- ----------------------------------------------------------- -->

   <!-- ----------------------------------------------------------- -->
   <!-- Sigma6, s6, and the Sigma6 logos are registered trademarks. -->
   <!-- All other trademarks and servicemarks are the property of   -->
   <!-- their respective owners.                                    -->
   <!-- ----------------------------------------------------------- -->
	<!--- $Id: webstate.cfm,v 1.6 1999/11/29 15:31:00 lswanson Exp $ --->

<CFSET PageAccess = 2>
<CFINCLUDE template="security.cfm">

<!--- If not Sys Admin, forward to webstate2 --->
<CFIF #Left(AccessLevel,1)# LT application.SYSADMIN_ACCESS>
	<CFLOCATION url="webstate2.cfm">
</CFIF>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>

<HEAD>
	<TITLE>WorldDealer | Update Collection / Dealer Web Activity States</TITLE>
	
	<!--- this query gets all dealerships.  unable to filter out based on Mid(dealercode) = '0000' within SQL, so have to get all & filter out later when used --->
	<CFQUERY NAME="getCollections" datasource="#gDSN#">
		SELECT	Dealercode, DealershipName
 		FROM Dealers
		ORDER BY DealershipName
	</CFQUERY>
	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>

<body>
<br><br><br><br><br>

<div align="center">
<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=420 BGCOLOR="FFFFFF">
<TR><TD>&nbsp;<p></TD></TR>

<TR ALIGN="center">
	<TD><h3><FONT FACE="Arial,Helvetica">
		Update Activity State</FONT></h3></TD>
</TR>

<TR ALIGN="center">
	<TD ALIGN="middle"><FONT FACE="Arial,Helvetica">Select a collection from the list below.  If your WorldDealer Web Site is not part of a collection, select Dealership Not in a Collection."</FONT></TD>
</TR>

<!--- Drop-down list of collections --->
<TR><TD>&nbsp;<p></TD></TR>
<TR>
	<TD>
	<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0 WIDTH="100%">
		<FORM NAME="Find1" ACTION="webstate2.cfm" METHOD="post">
		<TR>
			<TD ALIGN="right"><b><font face="Arial,Helvetica">Choose a Collection:</font></b></TD>
			<TD>&nbsp;&nbsp;&nbsp;</TD>
			<TD>
				<SELECT NAME="Collection">
				<OPTION VALUE="0000">Dealership Not In A Collection
				<CFOUTPUT QUERY="getCollections">
				<!--- just get collections (where dealer # is 0000) --->
				<CFIF Mid(#Dealercode#, 6, 4) IS '0000'>
					<OPTION VALUE="#Left(Dealercode, 4)#">#DealershipName#
				</CFIF>
				</CFOUTPUT>
				</SELECT>
	 		</TD>
 		</TR>
		<TR><TD COLSPAN=3>&nbsp;<p></TD></TR>
		<TR ALIGN=center>
  			<TD COLSPAN=3><INPUT TYPE="image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/go_nav.jpg" Border="0" NAME="btnFind1" VALUE="GO!"></TD>
		</TR>
		<TR><TD COLSPAN=3>&nbsp;<p></TD></TR>
		</FORM>
	</TABLE>
	</TD>
</TR>

<!--- "Back to Main Menu" button--->
<TR ALIGN="center">
	<TD>
	<p>
	<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
		<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg" Border="0" NAME="BackToMain" VALUE="Back To Main Menu">
	</FORM>
	</TD>
</TR>

</TABLE>

</div>

</BODY>
</HTML>