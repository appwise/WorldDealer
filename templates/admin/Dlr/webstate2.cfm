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
	<!--- $Id: webstate2.cfm,v 1.6 1999/11/29 15:31:00 lswanson Exp $ --->
   
<CFSET PageAccess = 2>
<CFSET webverifystep = 0>
<CFINCLUDE template="security.cfm">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>

<HEAD>
    <TITLE>WorldDealer | Update Collection / Dealer Web Activity States</TITLE>	
	
	<!--- this query gets all dealerships.  unable to filter out based on Mid(dealercode) = '0000' within SQL, so have to get all & filter out later when used --->
	<CFQUERY NAME="getCollections" datasource="#gDSN#">
		SELECT	Dealercode, DealershipName
 		FROM Dealers
			<CFIF Left(AccessLevel, 1) EQ application.ACCOUNT_EXECUTIVE_ACCESS>
				WHERE Dealers.AEID = #RemoveChars(AccessLevel,1,2)#			
			<CFELSEIF Left(AccessLevel, 1) EQ application.ACCOUNT_COORDINATOR_ACCESS>
				WHERE Dealers.ACID = #RemoveChars(AccessLevel,1,2)#
			</cfif>
		ORDER BY DealershipName
	</CFQUERY>
	
	<!--- find all the dealerships that AE or AC are assigned to, or if it's 1 dealer, just show that 1 dealership --->
    <CFQUERY NAME="findDLR" datasource="#gDSN#">
		SELECT DealerCode, DealershipName
		FROM Dealers
			<CFIF Left(AccessLevel, 1) EQ application.SYSADMIN_ACCESS>
<!--- 				WHERE Dealers.DealerCode GT '#FORM.Collection#' --->
<!--- 				AND Dealers.DealerCode LT 'IncrementValue(Val(#FORM.Collection#))' --->
<!--- 				AND Dealers.DealerCode LT '#Evaluate(FORM.Collection +1)#' --->
			<CFELSEIF Left(AccessLevel, 1) EQ application.ACCOUNT_EXECUTIVE_ACCESS>
				WHERE Dealers.AEID = #RemoveChars(AccessLevel,1,2)#			
			<CFELSEIF Left(AccessLevel, 1) EQ application.ACCOUNT_COORDINATOR_ACCESS>
				WHERE Dealers.ACID = #RemoveChars(AccessLevel,1,2)#
			<CFELSEIF Left(AccessLevel, 1) EQ application.DEALER_ACCESS>			
				WHERE Dealers.DealerCode = #RemoveChars(AccessLevel,1,2)#			
			</cfif>
 		ORDER BY DealershipName
    </CFQUERY>
	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>

<body>
<br><br><br><br><br>

<div align="center">
<TABLE CELLPADDING=5 CELLSPACING=0 BORDER=0 WIDTH=420 BGCOLOR="FFFFFF">
	<TR><TD>&nbsp;<p></TD></TR>
	
    <TR ALIGN="center">
		<TD><h3><FONT FACE="Arial,Helvetica">Update Activity State</FONT></h3></TD>
    </TR>
	
	<TR align="center">
		<TD><FONT FACE="Arial,Helvetica">Select a collection or dealership below, then click <B>Next</B>.
		<CFIF Left(AccessLevel, 1) EQ application.SYSADMIN_ACCESS>
			<BR>Click <B>New Search</B> to start over.
		</CFIF>
		</FONT></TD>
	</TR>
	
<CFIF ParameterExists(Form.Collection)>
	<CFIF #Form.Collection# NEQ "0000">			
		
	<TR><TD>&nbsp;<p></TD></TR>		

	
 	<TR ALIGN="center">
		<TD><h4><font face="Arial,Helvetica">Select Collection</font></h4></TD>
	</TR>
	
	<TR ALIGN="center">
		<FORM NAME="FindColl" ACTION="webstate3.cfm" METHOD="post">
		<INPUT TYPE="hidden" NAME="NextStep" VALUE="webstate3.cfm">
		<INPUT type="hidden" name="DealerCode_required" value="You must select a collection.">
		<TD>
			<SELECT NAME="DealerCode">
				<CFIF ParameterExists(Form.Collection)>
					<CFIF #Form.Collection# EQ "0000">			
						<OPTION VALUE="0000">No Collection
					</CFIF>
				</CFIF>
			<CFOUTPUT QUERY="getCollections">
			<!--- just get collections (where dealer # is 0000) --->
			<CFIF Mid(Dealercode, 6, 4) IS '0000'>
				<!--- if sysadmin, just show collection selected on prev. page --->
				<CFIF ParameterExists(Form.Collection)>
					<CFIF Left(DealerCode, 4) EQ '#FORM.Collection#'>	
						<OPTION VALUE="#DealerCode#">#DealershipName#
					</CFIF>
				<!--- for dealers, show the parent collection --->
				<CFELSEIF Left(AccessLevel, 1) EQ application.DEALER_ACCESS>
					<CFIF Left(DealerCode, 4) IS #Mid(AccessLevel,3,4)#>
						<OPTION VALUE="#DealerCode#">#DealershipName#
					</CFIF>
				<cfelse>
				<OPTION VALUE="#DealerCode#">#DealershipName#
				</CFIF>
			</CFIF>
			</CFOUTPUT>
			</SELECT>
 		</TD>
	</TR>
	<TR ALIGN="center">
		<TD>
            <INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next_nav.jpg" BORDER="0" NAME="btnNext" VALUE="Next">		
			</FORM>
		</TD>
	</TR>
	
	</CFIF>
</CFIF>		
	
	<TR ALIGN="center">
		<TD><h4><font face="Arial,Helvetica">Select Dealer</font></h4></TD>
	</TR>
	
<!--- if dealers were found, display them in drop-down list --->	
<CFIF findDLR.RecordCount GT '0'>
	<TR ALIGN=center>
	<FORM NAME="FindForm2" ACTION="webstate3.cfm" METHOD="post">
	<INPUT TYPE="hidden" NAME="NextStep" VALUE="webstate3.cfm">
	<INPUT type="hidden" name="DealerCode_required" value="You must select a dealer.">
		<TD>
			<SELECT NAME="DealerCode">
			<CFOUTPUT QUERY="findDLR">
			<!--- if sysadmin, just show dealerships within collection selected on prev. page --->
			<CFIF ParameterExists(Form.Collection)>
				<CFIF Left(DealerCode, 4) EQ '#FORM.Collection#'
					AND Mid(DealerCode, 6, 4) NEQ '0000'>
					<OPTION VALUE="#DealerCode#">#DealershipName# (#DealerCode#)
				</cfif>
			<cfelse>
				<OPTION VALUE="#DealerCode#">#DealershipName# (#DealerCode#)
			</cfif>
			</CFOUTPUT>
			</SELECT>
		</TD>
	</TR>
<!--- 	<TR><TD>&nbsp;<p></TD></TR> --->
	<TR ALIGN="center">
		<TD>
            <INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next_nav.jpg" BORDER="0" NAME="btnNext" VALUE="Next">		
			</FORM>
			<p>
			<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
			<CFIF Left(AccessLevel, 1) EQ application.SYSADMIN_ACCESS>
                <INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/newsearch.jpg" Border="0" NAME="Webstate" VALUE="New Search">			
				<p>
			</CFIF>
			<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg" Border="0" NAME="BackToMain" VALUE="Back To Main Menu">
			</FORM>
		</TD>
	</TR>
	
<CFELSE>
	<!--- if no dealers were found, error msg --->
	<TR ALIGN="center">
		<TD ALIGN="middle"><h4><font face="Arial,Helvetica">No Dealers were found that are assigned to you.
		Click the 'New Search' button to return to the search form.</font></h4></TD>
	</TR>
	<TR><TD>&nbsp;<p></TD></TR>
	<TR ALIGN="center">
		<TD>
		<FORM NAME="NoDealerFound" ACTION="webnew.cfm" METHOD="post">
		<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/newdealer.jpg" Border="0" NAME="NewDealer" VALUE="New Dealer">
		</FORM>
		<p>
		<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
		<CFIF Left(AccessLevel, 1) EQ application.SYSADMIN_ACCESS>
            <INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/newsearch.jpg" Border="0" NAME="Webstate" VALUE="New Search">		
	 		<p>
		</CFIF>
		<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg" Border="0" NAME="BackToMain" VALUE="Back To Main Menu"></FORM></TD>
	</TR>
</CFIF>
</TABLE>
</div>

</BODY>
</HTML>