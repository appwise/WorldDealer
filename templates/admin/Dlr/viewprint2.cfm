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
	<!--- $Id: viewprint2.cfm,v 1.5 1999/11/29 15:44:34 lswanson Exp $ --->

<HEAD>

        <TITLE>WorldDealer | List Dealers</TITLE>

    <CFQUERY NAME="countDLR" datasource="#gDSN#">
         SELECT Count(*) as q_DLRCount
                   FROM Dealers
          <CFIF ParameterExists(Form.btnVP1)>
          WHERE Dealers.StateAbbr = '#Form.StateAbbr#'
          </CFIF>
    </CFQUERY>

    <CFQUERY NAME="getDealerInfo" datasource="#gDSN#">
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
                                 Email as q_EMail                    FROM Dealers
               <CFIF ParameterExists(Form.btnVP1)>
                   WHERE Dealers.StateAbbr = '#Form.StateAbbr#'
                   </CFIF>
    </CFQUERY>

	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>

<body>
<br><br><br><br><br>


<CFOUTPUT QUERY="countDLR">
    <CFSET tmpNumber = #q_DLRCount# / 10>
        <CFSET NumOfGroups = Int(#tmpNumber#)>
    <CFSET Chunk = #NumOfGroups# * 10>
        <CFSET DLRRemainder = #q_DLRCount# - #Chunk#>
        
        
        tmpNumber:&nbsp;#tmpNum#<br>
        NumOfGroups:&nbsp;#NumOfGroups#<br>
        Chunk:&nbsp;#chunk#<br>
        DLRRemainder:&nbsp;#DLRRemainder#<br>
        
</CFOUTPUT>

<div align="center">
<TABLE CELLPADDING=5 CELLSPACING=0 BORDER=0 WIDTH="100%">
        <TR><TD>&nbsp;<p></TD></TR>
        <TR ALIGN="center">
                <TD ALIGN="middle"><h3><FONT FACE="Arial,Helvetica">Query Results</FONT></h3></TD>
        </TR>
        <TR><TD>&nbsp;<p></TD></TR>
        <TR ALIGN="center">
                <TD ALIGN="middle"><FONT FACE="Arial,Helvetica"></FONT></TD>
        </TR>
        <TR><TD>&nbsp;<p></TD></TR>
        
</TABLE>
</div>

</BODY>

</HTML>

 

</BODY>
</HTML>

