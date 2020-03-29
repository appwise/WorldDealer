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
	<!--- $Id: vpselect2.cfm,v 1.6 1999/11/29 15:44:34 lswanson Exp $ --->

<HEAD>

        <TITLE>WorldDealer | List Dealers</TITLE>

    <CFIF ParameterExists(Form.rowlist)>
       <CFSET startrow = ListGetAt(Form.rowlist,1,',')>
       <CFSET endrow = ListGetAt(Form.rowlist,2,',')>
        </CFIF>
        
        <CFIF ParameterExists(URL.rowlist)>
       <CFSET startrow = ListGetAt(URL.rowlist,1,',')>
       <CFSET endrow = ListGetAt(URL.rowlist,2,',')>
        </CFIF>


<!---

    <CFIF ParameterExists(Form.templateMode)>
            <CFIF Form.templateMode EQ 'List'>
                   <CFSET ListMode = TRUE>
                   <CFSET GroupMode = FALSE>
                <CFELSEIF Form.templateMode EQ 'Group'>
                   <CFSET ListMode = FALSE>
                   <CFSET GroupMode = TRUE>
                </CFIF>
        <CFELSE>
            <CFSET ListMode = FALSE>
            <CFSET GroupMode = TRUE>
    </CFIF>

--->

    <CFQUERY NAME="getDealerInfo" datasource="#gDSN#">
              SELECT 	DealerCode as q_DealerCode,
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
                				 Dealers.AEID as q_AEID,
				                 Dealers.ACID as q_ACID,
                                 DealerFirstName as q_DealerFirstName,
                                 DealerLastName as q_DealerLastName,
                                 Dealers.Email as q_EMail,
                                 AccountExecs.LastName as q_AELastName,
                                 AccountExecs.FirstName as q_AEFirstName,
                                 AccountCoordinators.LastName as q_ACLastName,
                                 AccountCoordinators.FirstName as q_ACFirstName
                    FROM DealerMarketingGroups,	 
						(Dealers LEFT JOIN AccountExecs ON Dealers.AEID = AccountExecs.AEID) LEFT JOIN AccountCoordinators ON Dealers.ACID = AccountCoordinators.ACID
               <CFIF Form.criteriaMode EQ "State">
                   WHERE Dealers.StateAbbr = '#Form.criteriaVal#'
               <CFSET criteriaMode = "State">
               <CFSET criteriaVal = #Form.criteriaVal#>
                   </CFIF>
				<CFIF Form.CriteriaMode EQ "Name">
					<CFSET criteriaVal = #form.criteriaVal#>
					<CFIF left(form.criteriaVal,1) IS NOT ','>
						<CFSET the_name = GetToken(Form.CriteriaVal,1,',')>
						<CFSET the_zip = GetToken(Form.CriteriaVal,2,',')>
						WHERE Dealers.DealershipName LIKE '%#Trim(the_name)#%'
						AND Dealers.Zip LIKE '%#Trim(the_zip)#%'
					<CFELSE>
						<CFSET the_zip = GetToken(form.CriteriaVal,1,',')>
						WHERE Dealers.Zip LIKE '%#Trim(the_zip)#%'
					</CFIF>
				</CFIF>
    </CFQUERY>


	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>

<body>
<br><br><br><br><br>

<div align="center">
<TABLE CELLPADDING=5 CELLSPACING=0 BORDER=0  BGCOLOR=ffffff WIDTH=400>
        <TR><TD>&nbsp;<p></TD></TR>
        <TR ALIGN="center">
                <TD ALIGN="middle"><h3><FONT FACE="Arial,Helvetica">Query Results</FONT></h3><br><h4><FONT FACE="Arial,Helvetica">Use your 'Back' button to return to the Groups page.</FONT></h4></TD>
        </TR>
        <TR><TD>&nbsp;<p></TD></TR>
        <TR ALIGN="center">
                <TD ALIGN="CENTER">
                           <FORM NAME="form1" ACTION="vpselect.cfm" METHOD="post">
                           <INPUT TYPE="hidden" NAME="templateMode" VALUE="Group">
                           <CFOUTPUT>
               <INPUT TYPE="hidden" NAME="criteriaMode" VALUE="#criteriaMode#">
               <INPUT TYPE="hidden" NAME="criteriaVal" VALUE="#criteriaVal#">
               </CFOUTPUT>
               <CFLOOP QUERY="getDealerInfo" STARTROW=#startrow#  ENDROW=#endrow#>
				<TABLE BORDER=0>
				<CFOUTPUT>
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

               </CFLOOP>
                           </FORM>
                </TD>
        </TR>
        <TR><TD>&nbsp;<p></TD></TR>
        
</TABLE>

</div>

</BODY>

</HTML>

 

</BODY>
</HTML>

