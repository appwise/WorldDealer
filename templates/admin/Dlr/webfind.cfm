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
   <!--   Last updated: December 17, 1998                           -->
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
	<!--- $Id: webfind.cfm,v 1.6 1999/11/29 15:30:57 lswanson Exp $ --->

<CFSET PageAccess = 0>
<CFINCLUDE template="security.cfm">

<!--- If not Sys Admin, forward to webfind2 --->
<CFIF #Left(AccessLevel,1)# LT application.SYSADMIN_ACCESS>
	<CFLOCATION url="webfind2.cfm">
</CFIF>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>

<HEAD>
	<TITLE>WorldDealer | Select A Collection</TITLE>
	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>

<body>
<br><br><br><br><br>

<div align="center">
<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=420 BGCOLOR="FFFFFF">
<TR><TD>&nbsp;<p></TD></TR>

<TR ALIGN="center">
	<TD ALIGN="middle"><h3><FONT FACE="Arial,Helvetica">Maintain Your Web Site</FONT></h3></TD>
</TR>

<TR ALIGN="center">
	<TD ALIGN="middle"><FONT FACE="Arial,Helvetica">Select a collection from the list below, or choose the "New" button
	to add a collection from scratch.  If your WorldDealer website is not part of a collection, please select "Dealership Not in a Collection."</FONT></TD>
</TR>

	
<!--- this query gets all dealerships.  unable to filter out based on Mid(dealercode) = '0000' within SQL, so have to get all & filter out later when used --->
<CFQUERY NAME="getCollections" datasource="#gDSN#">
	SELECT	Dealercode, 
			DealershipName,
			AEID,
			ACID
	FROM 	Dealers
	<CFIF VAL(Left(#Accesslevel#,1)) LT 3>
	Where AEID = #RemoveChars(AccessLevel,1,2)# or
		  ACID = #RemoveChars(AccessLevel,1,2)#
	</CFIF>
	ORDER BY DealershipName
</CFQUERY>


<!--- Drop-down list of collections --->
<TR><TD>&nbsp;<p></TD></TR>
<TR>
	<TD>
	<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0 WIDTH="100%">
		<FORM NAME="Find1" ACTION="webfind2.cfm" METHOD="post">
		<TR>
			<TD ALIGN="right"><b><font face="Arial,Helvetica">Choose a Collection:</font></b></TD>
			<TD>&nbsp;&nbsp;&nbsp;</TD>
			<TD>
				<SELECT NAME="Collection">
				<OPTION VALUE="0000">Dealership Not In A Collection		
				<CFOUTPUT QUERY="getCollections">
					<!--- just get collections (where dealer # is 0000) --->
					<CFIF Mid(#Dealercode#, 6, 4) IS '0000'>
						<OPTION VALUE="#Dealercode#">#DealershipName#
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

<!--- "New" & "Back to Main Menu" buttons--->
<TR ALIGN="center">
	<TD>
	<p>
	<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
	    <INPUT TYPE="image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/New.jpg" BORDER="0" NAME="NewCollection" VALUE="New">
		<P>
		<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg" Border="0" NAME="BackToMain" VALUE="Back To Main Menu">
	</FORM>
	</TD>
</TR>

</TABLE>

</div>

</BODY>
</HTML>