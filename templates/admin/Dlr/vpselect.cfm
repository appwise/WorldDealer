<CFSET PageAccess = 1>
<CFINCLUDE template="security.cfm">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

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
	<!--- $Id: vpselect.cfm,v 1.6 1999/11/29 15:44:34 lswanson Exp $ --->


<HEAD>

        <TITLE>WorldDealer | List Dealers</TITLE>

    <CFQUERY NAME="countDLR" datasource="#gDSN#">
         SELECT Count(*) as q_DLRCount
                   FROM Dealers
          <CFIF ParameterExists(Form.btnVP2.X)>
          WHERE Dealers.StateAbbr = '#Form.StateAbbr#'
          </CFIF>
          <CFIF ParameterExists(Form.btnVP3.X)>
          WHERE Dealers.DealershipName LIKE '%#Form.DealershipName#%'
                    AND Dealers.Zip LIKE '%#Form.ZipCode#%'
          </CFIF>
    </CFQUERY>
            <CFQUERY NAME="getDealerInfo1" datasource="#gDSN#">
                      SELECT     DealerCode as q_DealerCode,
                                 DealershipName as q_DealershipName,
                                         AddressLine1 as q_AddressLine1,
                                         AddressLine2 as q_AddressLine2,
                                         City as q_City,
                                         StateAbbr as q_StateAbbr,
                                         Zip as q_Zip,
                                         ContactName as q_ContactName,
                                         ContactPhone as q_ContactPhone,
                                         Phone as q_Phone,
                                         FaxPhone as q_FaxPhone,
										 AEID as q_AEID,
				                         ACID as q_ACID,
                                         DealerFirstName as q_DealerFirstName,
                                         DealerLastName as q_DealerLastName,
                                         Email as q_EMail
							FROM Dealers
                       <CFIF ParameterExists(Form.btnVP2.X)>
                           WHERE Dealers.StateAbbr = '#Form.StateAbbr#'
               <CFSET criteriaMode = "State">
               <CFSET criteriaVal = #Form.StateAbbr#>
                           </CFIF>
                       <CFIF ParameterExists(Form.btnVP3.X)>
                           WHERE Dealers.DealershipName LIKE '%#Form.DealershipName#%'
                             AND Dealers.Zip LIKE '%#Form.ZipCode#%'
               <CFSET criteriaMode = "Name">
               <CFSET criteriaVal = #Form.DealershipName# & ',' & #Form.ZipCode# & ','>
                           </CFIF>
                           ORDER BY Dealers.DealershipName
            </CFQUERY>

    <CFQUERY NAME="getDealerInfo2" datasource="#gDSN#">
              SELECT     DealerCode as q_DealerCode,
                         DealershipName as q_DealershipName,
                                 AddressLine1 as q_AddressLine1,
                                 AddressLine2 as q_AddressLine2,
                                 City as q_City,
                                 StateAbbr as q_StateAbbr,
                                 Zip as q_Zip,
                                 ContactName as q_ContactName,
                                 ContactPhone as q_ContactPhone,
                                 Phone as q_Phone,
                                 FaxPhone as q_FaxPhone,
                                 DealerFirstName as q_DealerFirstName,
                                 DealerLastName as q_DealerLastName,
                                 Dealers.Email as q_EMail,
								 AccountExecs.LastName as q_AELastName,
                                 AccountExecs.FirstName as q_AEFirstName,
                                 AccountCoordinators.LastName as q_ACLastName,
                                 AccountCoordinators.FirstName as q_ACFirstName
                    FROM DealerMarketingGroups,
					(Dealers LEFT JOIN AccountExecs ON Dealers.AEID = AccountExecs.AEID) LEFT JOIN AccountCoordinators ON Dealers.ACID = AccountCoordinators.ACID
               <CFIF ParameterExists(Form.btnVP2.X)>
                   WHERE Dealers.StateAbbr = '#Form.StateAbbr#'
                   </CFIF>
               <CFIF ParameterExists(Form.btnVP3.X)>
                   WHERE Dealers.DealershipName LIKE '%#Form.DealershipName#%'
                     AND Dealers.Zip LIKE '%#Form.ZipCode#%'
                   </CFIF>
                ORDER BY Dealers.DealershipName
    </CFQUERY>

	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>



<CFOUTPUT QUERY="countDLR">
    <CFIF #Form.GroupBy# EQ 'ALL'>
        <CFSET tmpRows="1," & #q_DLRCount#>
                <CFSET AllMode = TRUE>
        <CFELSE>
            <CFSET tmpNumber = #q_DLRCount# / #Form.GroupBy#>
                <CFSET NumOfGroups = Int(#tmpNumber#)>
            <CFSET Chunk = #NumOfGroups# * #Form.GroupBy#>
                <CFSET DLRRemainder = #q_DLRCount# - #Chunk#>
                <CFSET AllMode = FALSE>
        </CFIF>
</CFOUTPUT>

<CFIF AllMode>

<body>
<br><br><br><br><br>
<div align="center">
<TABLE CELLPADDING=5 CELLSPACING=0 BORDER=0 WIDTH="400" BGCOLOR="FFFFFF">
        <TR><TD>&nbsp;<p></TD></TR>
        <TR ALIGN="center">
                <TD ALIGN="middle"><h3><FONT FACE="Arial,Helvetica">Query Results</FONT></h3>
				<br><h4><FONT FACE="Arial,Helvetica">Click on 'Back' to return to the Groups page.</FONT></h4></TD>
        </TR>
        <TR><TD>&nbsp;<p></TD></TR>
        <TR ALIGN="center">
                <TD>
				<TABLE BORDER=0>
				<CFOUTPUT QUERY="getDealerInfo2">
				<TR><TD><FONT SIZE=2 FACE="arial,helvetica">Dealer Code:</FONT></TD>
				<TD><FONT SIZE=2 FACE="arial,helvetica">#q_DealerCode#</FONT></TD></TR>
				<TR><TD><FONT SIZE=2 FACE="arial,helvetica">Dealership Name:</FONT></TD>
				<TD><FONT SIZE=2 FACE="arial,helvetica">#q_DealershipName#</FONT></TD></TR>
				<TR><TD><FONT SIZE=2 FACE="arial,helvetica">Address 1:</FONT></TD>
				<TD><FONT SIZE=2 FACE="arial,helvetica">#q_AddressLine1#</FONT></TD></TR>
				<TR><TD><FONT SIZE=2 FACE="arial,helvetica">Address 2:</FONT></TD>
				<TD><FONT SIZE=2 FACE="arial,helvetica">#q_AddressLine2#</FONT></TD></TR>
				<TR><TD><FONT SIZE=2 FACE="arial,helvetica">City:</FONT></TD>
				<TD><FONT SIZE=2 FACE="arial,helvetica">#q_City#</FONT></TD></TR>
				<TR><TD><FONT SIZE=2 FACE="arial,helvetica">State:</FONT></TD>
				<TD><FONT SIZE=2 FACE="arial,helvetica">#q_StateAbbr#</FONT></TD></TR>
				<TR><TD><FONT SIZE=2 FACE="arial,helvetica">Zip:</FONT></TD>
				<TD><FONT SIZE=2 FACE="arial,helvetica">#q_Zip#</FONT></TD></TR>
				<TR><TD><FONT SIZE=2 FACE="arial,helvetica">Contact Name:</FONT></TD>
				<TD><FONT SIZE=2 FACE="arial,helvetica">#q_ContactName#</FONT></TD></TR>
				<TR><TD><FONT SIZE=2 FACE="arial,helvetica">Contact Phone:</FONT></TD>
				<TD><FONT SIZE=2 FACE="arial,helvetica">#q_ContactPhone#</FONT></TD></TR>
				<TR><TD><FONT SIZE=2 FACE="arial,helvetica">Phone:</FONT></TD>
				<TD><FONT SIZE=2 FACE="arial,helvetica">#q_Phone#</FONT></TD></TR>
				<TR><TD><FONT SIZE=2 FACE="arial,helvetica">Fax:</FONT></TD>
				<TD><FONT SIZE=2 FACE="arial,helvetica">#q_FaxPhone#</FONT></TD></TR>
				<TR><TD><FONT SIZE=2 FACE="arial,helvetica">Account Exec:</FONT></TD>
				<TD><FONT SIZE=2 FACE="arial,helvetica">#Trim(q_AEFirstName)# #Trim(q_AELastName)#</FONT></TD></TR>
				<TR><TD><FONT SIZE=2 FACE="arial,helvetica">Account CoOrdinator:</FONT></TD>
				<TD><FONT SIZE=2 FACE="arial,helvetica">#Trim(q_ACFirstName)# #Trim(q_ACLastName)#</FONT></TD></TR>
				<TR><TD><FONT SIZE=2 FACE="arial,helvetica">Dealer's First Name:</FONT></TD>
				<TD><FONT SIZE=2 FACE="arial,helvetica">#q_DealerFirstName#</FONT></TD></TR>
				<TR><TD><FONT SIZE=2 FACE="arial,helvetica">Dealer's Last Name:</FONT></TD>
				<TD><FONT SIZE=2 FACE="arial,helvetica">#q_DealerLastName#</FONT></TD></TR>
				<TR><TD><FONT SIZE=2 FACE="arial,helvetica">Email:</FONT></TD>
				<TD><FONT SIZE=2 FACE="arial,helvetica">#q_EMail#</FONT></TD></TR>
				<TR><TD COLSPAN=2>&nbsp;</TD></TR>
				</CFOUTPUT>
				</TABLE>
                </TD>
        </TR>
        <TR><TD>&nbsp;</TD></TR>
		<form action="viewprint.cfm" method="POST">
		<TR ALIGN="center"><TD><input type="Image" name="" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/back_nav.jpg" border="0"></TD></TR>
		</FORM>

				<tr align="CENTER">
            <td><FONT FACE="Arial,Helvetica">
                    <FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
                            <input type="Image"
       name="BackToMain"
       SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg"
       border="0">

                        </FORM></FONT></TD>
        </TR>        
</TABLE>

</div>

<CFELSE>

<body>
<br><br><br><br><br>
<div align="center">
<TABLE CELLPADDING=5 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
        <TR><TD>&nbsp;<p></TD></TR>
		        <TR ALIGN="center">
                <TD ALIGN="middle"><h3><FONT FACE="Arial,Helvetica">Dealer Administration - View/Print</FONT></h3></TD>
        </TR>
		
		<CFIF #countDlr.recordCount# IS NOT 0>
        <TR ALIGN="center">
                <TD ALIGN="middle"><h3><FONT FACE="Arial,Helvetica">Query Results in groups of <CFOUTPUT>#Form.GroupBy#</CFOUTPUT></FONT></h3></TD>
        </TR>
        <TR><TD>&nbsp;<p></TD></TR>
        <TR ALIGN="center">
                <TD ALIGN="middle"><FONT FACE="Arial,Helvetica">
                   <CFLOOP INDEX="LoopCounter" FROM=0 TO=#NumOfGroups#>
                      <CFOUTPUT>
                           <CFSET startrow = ((#LoopCounter# * #Form.GroupBy#) + 1)>
                           <CFSET endrow = ((#LoopCounter# * #Form.GroupBy#) + #Form.GroupBy#)>
                           <CFIF #LoopCounter# EQ #NumOfGroups#>
                                 <CFSET endrow = #tmpNumber# * #Form.GroupBy#>
                           </CFIF>
                           <CFSET tmpDisplay = #LoopCounter# + 1>
                                   <FORM NAME="form#LoopCounter#" ACTION="vpselect2.cfm" METHOD="post">
                                   <INPUT TYPE="hidden" NAME="templateMode" VALUE="List">
                       <INPUT TYPE="hidden" NAME="criteriaMode" VALUE="#criteriaMode#">
                       <INPUT TYPE="hidden" NAME="criteriaVal" VALUE="#criteriaVal#">
                       <INPUT TYPE="hidden" NAME="rowlist" VALUE="#startrow#,#endrow#">
                                   Group #tmpDisplay#&nbsp;&nbsp;<INPUT TYPE="image" NAME="go" BORDER=0 SRC="#application.RELATIVE_PATH#/images/admin/go_nav.jpg">
                   </FORM>
<!---                   <a href="vpselect.cfm?list=#startrow#,#endrow#">Group #tmpDisplay#</a><br> --->
                          <CFSET startrow = ''>
                          <CFSET endrow = ''>
                       </CFOUTPUT>
                           </CFLOOP>
                </FONT></TD>
        </TR>
		<CFELSE>
			<TR ALIGN="center"><TD><FONT FACE="Arial,Helvetica">
			Sorry, there were no records found for the criterion you selected.
			</FONT></TD></TR>
		</CFIF>
        <TR><TD>&nbsp;<p></TD></TR>
		<FORM ACTION="viewprint.cfm" method="post">
		<TR ALIGN="center"><TD><INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/back_nav.jpg" Border="0" value="Back"></TD></TR>
		</FORM>

				<TR ALIGN="center">
            <TD><FONT FACE="Arial,Helvetica">
                    <FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
                            <INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg" Border="0" NAME="BackToMain" VALUE="Back To Main Menu"></FORM></FONT></TD>
        </TR>


</TABLE>

</div>
</CFIF>

</BODY>

</HTML>

 
