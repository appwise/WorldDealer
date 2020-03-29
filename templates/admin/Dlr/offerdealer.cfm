<CFSET PageAccess = 1>
<CFINCLUDE template="security.cfm">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>

    <!-- ----------------------------------------------------------- -->
    <!--                Created by sigma6, Detroit                   -->
    <!--         Copyright (c) 1997, 1998, 1999 sigma6.              -->
    <!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
	
    <!-- ----------------------------------------------------------- -->
    <!--    Howard Levine for sigma6, interactive media, Detroit     -->
    <!--    hlevine@sigma6.com   www.sigma6.com    www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
	<!--- $Id: offerdealer.cfm,v 1.8 1999/12/14 22:17:28 lswanson Exp $ --->

<HEAD>
	<TITLE>WorldDealer | Offers  Reporting</TITLE>
	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>

<body>
<br><br><br><br><br>

<CFIF #IsDefined("URL.jump")#>
	<!---jump = First record to display --->
	<CFSET #Variables.current_Record# = #URL.Jump#>
<CFELSEIF NOT #IsDefined("Form.Current_Record")#>
	<CFSET #Variables.current_record# = 1>
<CFELSE>
	<CFSET #variables.current_record# = #form.current_record#>
</CFIF>

<CFIF #IsDefined("form.dealercode")#>
	<CFSET g_dealercode = #form.dealercode#>
<CFELSEIF #IsDefined("url.dlrcode")#>
	<CFSET g_dealercode = #url.dlrcode#>
</CFIF>


<CFIF #IsDefined("URL.jump")#>
	<CFSET SecondMode = TRUE>
	<CFSET FirstMode = FALSE>
	<CFSET  #start_row# = #url.jump#>
	<CFSET #end_row# = #url.jump# + 9>
	<CFSET variables.current_record = #url.jump#>
<CFELSEIF #IsDefined("Form.BtnPrevious.X")#>
	<CFSET SecondMode = TRUE>
	<CFSET FirstMode = FALSE>
	<CFSET #start_row# = #form.back1#>
	<CFSET #end_Row# = #form.back2#>
	<CFSET #variables.current_record# = #form.current_record# - 10>
<CFELSEIF #IsDefined("Form.BtnNext.X")#>
	<CFSET FirstMode = FALSE>
	<CFSET SecondMode = TRUE>
	<CFSET #start_row# = #form.forward1#>
	<CFSET #end_row# = #form.forward2#>
	<CFSET #variables.current_record# = #form.current_record# + 10>
<CFELSEIF #IsDefined("Form.BtnShowOffers.X")#>
	<CFSET SecondMode = TRUE>
	<CFSET FirstMode = FALSE>
	<CFSET #start_row# = 1>
	<CFSET #end_row# = 10>
<CFELSE>
	<CFSET FirstMode = TRUE>
	<CFSET SecondMode = FALSE>
</CFIF>


<!--- <CFOUTPUT>CurrentRecord: #variables.current_record#</CFOUTPUT> --->


<CFIF #IsDefined("Form.BtnBack.X")#>
	<CFLOCATION URL="offermaint.cfm">
</CFIF>

<CFIF SecondMode>
	<CFQUERY name="GetOffers" datasource="#gDSN#">
	SELECT 			Offers.OfferID,
					Offers.Name as q_OfferName,
					Offers.Description as q_OfferDescription,
					Offers.ExpirationDate,
					Offers.DisclaimerID,
					Offers.ModelID,
					OfferTypes.Description as q_OfferType,
					Dealers.DealershipName,
					OfferDisclaimers.TemplateID,
					DealerWebs.DealerCode,
					Models.Description as q_ModelDescription
	FROM (Models INNER JOIN (((Offers 
	INNER JOIN OfferTypes ON Offers.OfferTypeID = OfferTypes.OfferTypeID) 
	INNER JOIN OfferDisclaimers ON Offers.DisclaimerID = OfferDisclaimers.DisclaimerID) 
	INNER JOIN DealerOffers ON Offers.OfferID = DealerOffers.OfferID) ON Models.ModelID = Offers.ModelID) 
	INNER JOIN (DealerWebs 
	INNER JOIN Dealers ON DealerWebs.DealerCode = Dealers.DealerCode) ON DealerOffers.DealerWebID = DealerWebs.DealerWebID
	WHERE Offers.ExpirationDate > #CreateODBCDate(Now())#
	<CFIF #g_dealercode# IS NOT 'all'>
		AND Dealers.DealerCode = '#g_dealercode#'
	</CFIF>
	<CFIF #g_dealercode# EQ 'all' AND #Left(AccessLevel,1)# EQ #application.ACCOUNT_EXECUTIVE_ACCESS#>
		AND Dealers.AEID = #RemoveChars(AccessLevel,1,2)#
	</CFIF>
	ORDER BY Dealers.DealershipName;
	</CFQUERY>

<!--- 	<CFOUTPUT><br>RecordCount: #getoffers.recordcount#</CFOUTPUT> --->

	<CFIF #g_dealercode# IS NOT 'all'>
		<CFQUERY name="GetDealershipName" datasource="#gDSN#">
		SELECT DealerShipName
		FROM Dealers
		WHERE DealerCode = '#g_dealercode#';
		</CFQUERY>
	</CFIF>

	<CFIF #end_row# GT #getoffers.RecordCount#>
		<CFSET #end_row# = #getoffers.RecordCount#>
	</CFIF>
	
	<div align="center">
	<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
	<TR ALIGN="center">
		<TD ALIGN="middle"><FONT FACE="Arial,Helvetica">
		<h3>Dealer Administration<br>Offers  Reporting</h3></FONT></TD>
	</TR>
	<TR><TD>&nbsp;<p></TD></TR>

	<CFIF #GetOffers.RecordCount# EQ 0>
		<CFIF #g_dealercode# IS NOT 'all'>
			<CFOUTPUT query="getDealerShipName">
			<TR align="center"><TD><FONT FACE="Arial,Helvetica">
			There were no Offers found for <b>#DealershipName#</b></FONT></TD></TR>
			<TR><TD>&nbsp;</TD></TR>
			</CFOUTPUT>
		<CFELSE>
			<TR align="center"><TD><FONT FACE="Arial,Helvetica">
			There were no Offers found for <b>any</b> Dealer.</FONT></TD></TR>
			<TR><TD>&nbsp;</TD></TR>
		</CFIF>
	<CFELSE>
		<!--- one or more offers found --->
		<TR align="center"><TD><FONT FACE="Arial,Helvetica">
		The following is a list of all Offers for
		<CFIF #g_dealercode# IS NOT 'all'>
			<CFOUTPUT query="GetDealershipName">
			<b>#DealershipName#</b>
			</CFOUTPUT>
		<CFELSE>
			<b>All Dealers</b>
		</CFIF>
		</FONT></TD></TR>
		<TR><TD>&nbsp;</TD></TR>

		<TR align="center"><TD>
			<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0 WIDTH="90%">
			<CFLOOP query="GetOffers" startrow="#start_row#" endrow="#end_row#">
				<CFOUTPUT>
				<TR><TD><FONT FACE="Arial,Helvetica"><b>Record:</b></FONT></TD>
					<TD>&nbsp;</TD>
					<TD><FONT FACE="Arial,Helvetica">#currentRow#</FONT></TD>
				</TR>
				<CFIF #g_dealercode# EQ 'all'>
					<TR>
						<TD><FONT FACE="Arial,Helvetica"><b>Dealer:</b></FONT></TD>
						<TD>&nbsp;&nbsp;&nbsp;</TD>
						<TD><FONT FACE="Arial,Helvetica">#DealershipName#</FONT></TD>
					</TR>
				</CFIF>
				<TR>
					<TD><FONT FACE="Arial,Helvetica"><b>Offer Type:</b></FONT></TD>
					<TD>&nbsp;&nbsp;&nbsp;</TD>
					<TD><FONT FACE="Arial,Helvetica">#q_OfferType#</FONT></TD>
				</TR>
				<TR>
					<TD><FONT FACE="Arial,Helvetica"><b>ExpirationDate: </b></FONT></TD>
					<TD>&nbsp;&nbsp;&nbsp;</TD>
					<TD><FONT FACE="Arial,Helvetica">#Dateformat(ExpirationDate,"mm/dd/yyyy")#</FONT></TD>
				</TR>
				<TR>
					<TD><FONT FACE="Arial,Helvetica"><b>Model:</b></FONT></TD>
					<TD>&nbsp;&nbsp;&nbsp;</TD>
					<TD><FONT FACE="Arial,Helvetica">#q_ModelDescription#</FONT></TD>
				</TR>
				<TR>
					<TD><FONT FACE="Arial,Helvetica"><b>Offer Name: </b></FONT></td>
					<td>&nbsp;&nbsp;&nbsp;</TD>
					<TD><FONT FACE="Arial,Helvetica">#Q_OfferName#</FONT></TD>
				</TR>
				<TR>
					<TD COLSPAN=3><FONT FACE="Arial,Helvetica"><b>Offer Description:</b></FONT></TR>
				</TR>			
				<TR>
					<TD COLSPAN=3><FONT FACE="Arial,Helvetica">#q_OfferDescription#</FONT></TD>
				</TR>
				<TR><TD COLSPAN=3><FONT FACE="Arial,Helvetica"><b>Disclaimer:</b></FONT></TD></TR>
				<TR><TD COLSPAN=3><FONT FACE="Arial,Helvetica">
				<CFSET #variables.ID# = #getOffers.DisclaimerID#>
				<CFINCLUDE template="../../../includes/disclaimers/#getOffers.templateID#.cfm">
				</CFOUTPUT>
				<!--- Show disclaimer --->
				</FONT></TD></TR>
				<TR><TD COLSPAN=3>&nbsp;</TD></TR>
			</CFLOOP>
			</TABLE></TD>
		</TR>
	</CFIF>	<!---   CFIF #GetOffers.RecordCount# EQ 0   --->
		
	<CFIF #GetOffers.RecordCount# GT 10>
		<!--- More than 10 offers found --->
		<FORM action="offerdealer.cfm" method="post">
		<CFOUTPUT>
		<INPUT type="hidden" name="DealerCode" value="#g_dealercode#">
		<INPUT type="hidden" name="Current_Record" value="#variables.current_record#">
		</CFOUTPUT>
		<TR ALIGN="center"><TD><FONT FACE="Arial,Helvetica">
		<CFIF #start_row# GT 10>
			<CFSET #back1# = #variables.current_record# - 10>
			<CFSET #back2# = #variables.current_record# - 1>
			<CFOUTPUT>
			<INPUT type="hidden" name="Back1" value="#back1#">
			<INPUT type="hidden" name="Back2" value="#Back2#">
			<INPUT type="image" name="BtnPrevious" value="Previous Page" SRC="#application.RELATIVE_PATH#/images/admin/previouspage_nav.jpg" Border="0">&nbsp;&nbsp;&nbsp;
			</CFOUTPUT>
		</CFIF>

		<CFIF #variables.current_record# + 10 LE #getoffers.recordcount#>
			<!--- Set variables for "next 10 records" --->
			<CFSET #forward1# = #variables.current_record# + 10>
			<CFIF #variables.current_Record# + 19 LE #getoffers.recordCount#>
				<CFSET #forward2# = #variables.current_record# + 19>
			<CFELSE>
				<CFSET #forward2# = #getoffers.recordcount#>
			</CFIF>
			<CFOUTPUT>
			<INPUT type="Hidden" name="Forward1" value="#forward1#">
			<INPUT type="hidden" name="Forward2" value="#forward2#">
			<INPUT type="Image" name="BtnNext" value="Next Page" SRC="#application.RELATIVE_PATH#/images/admin/nextpage_nav.jpg" Border="0">
			</CFOUTPUT>
		</CFIF>
		&nbsp; <!--- In Case table cell is empty --->
		</FONT></TD></TR>
		</FORM>
		<TR><TD>&nbsp;</TD></TR>
	</CFIF>  <!---  CFIF #GetOffers.RecordCount# GT 10   --->

	<CFIF #getoffers.RecordCount# GT 10>
		<!--- Show 1-10 | 11-20 | 21-30, etc.   --->
		<TR><TD ALIGN="center"><FONT FACE="Arial,Helvetica" SIZE="1">
		<CFLOOP FROM=1 TO=#getoffers.RecordCount# STEP=10 INDEX="loopcount">
			<CFOUTPUT>
			<CFIF #variables.current_record# EQ #loopcount#>
				<CFIF #getoffers.recordcount# GE #loopcount# + 9>
					<b>#loopcount#-#Evaluate(loopcount + 9)#</b>
				<CFELSE>
					<b>#loopcount#-#getoffers.recordcount#</b>
				</CFIF>
			<CFELSEIF #loopcount# + 9 LE #getoffers.recordcount#>
				<A HREF="offerdealer.cfm?jump=#loopcount#&dlrcode=#g_dealercode#">#loopcount#-#Evaluate(loopcount + 9)#</a>
			<CFELSE>
				<A HREF="offerdealer.cfm?jump=#loopcount#&dlrcode=#g_dealercode#">#loopcount#-#getoffers.recordcount#</a>
			</CFIF>
			</CFOUTPUT>
			&nbsp;|&nbsp;
		</CFLOOP>
		</FONT>
		</TD></TR>
		<TR><TD>&nbsp;</TD></TR>
	</CFIF>

	<FORM Action="offerdealer.cfm" method="post">
	<TR align="center"><TD><FONT FACE="Arial,Helvetica"><INPUT type="image" value="Back" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/back_nav.jpg" Border="0"></FONT></TD></TR>
	</FORM>
	<TR><TD>&nbsp;</TD></TR>
	<TR ALIGN="center">
		<TD><FONT FACE="Arial,Helvetica">
		<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
		<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg" Border="0" NAME="BackToMain" VALUE="Back To Main Menu"></FORM></FONT></TD>
	</TR>
	</TABLE>
</CFIF>



<CFIF FirstMode>

	<CFQUERY name="GetDealers" datasource="#gDSN#">
	SELECT Dealers.DealerCode,
			Dealers.DealershipName
	FROM Dealers
	WHERE Dealers.DealerCode IN (SELECT DealerCode FROM DealerWebs)
	<CFIF #Left(AccessLevel,1)# LE 2>
		AND Dealers.AEID = #RemoveChars(AccessLevel,1,2)#
	</CFIF>
	ORDER BY DealershipName
	</CFQUERY>

	<div align="center">
	<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
	<TR ALIGN="center">
		<TD ALIGN="middle"><FONT FACE="Arial,Helvetica">
		<h3>Dealer Administration<br>Offers  Reporting</h3></TD></FONT>
	</TR>
	<TR><TD>&nbsp;<p></TD></TR>
	<TR align="center"><TD><FONT FACE="Arial,Helvetica">Sort Offers By Dealer</FONT></TD></TR>
	<TR><TD>&nbsp;</TD></TR>

	<TR align="center">
		<TD><FONT FACE="Arial,Helvetica">Select the dealer you wish to include in the list of offers.</FONT></TD>
	</TR>
	<FORM action="offerdealer.cfm" method="post">
	<TR ALIGN="center"><TD><FONT FACE="Arial,Helvetica">
		<SELECT name="DealerCode">
		<OPTION value="all">All dealers</OPTION>
		<CFOUTPUT query="getDealers">
		<OPTION value="#DealerCode#">#DealershipName#</OPTION>
		</CFOUTPUT>
		</SELECT></FONT>
	</TD></TR>
	<TR><TD>&nbsp;</TD></TR>
	<TR ALign="center"><TD><FONT FACE="Arial,Helvetica">
	<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/back_nav.jpg" BORDER="0" NAME="btnBack" VALUE="< Back">&nbsp;&nbsp;&nbsp;<INPUT type="image" name="BtnShowOffers" Value="Show Offers" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/showoffers.jpg" Border="0">
	</FONT></TD></TR>
	</FORM>
	<TR><TD>&nbsp;</TD></TR>
	<TR ALIGN="center">
		<TD><FONT FACE="Arial,Helvetica">
		<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
		<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg" Border="0" NAME="BackToMain" VALUE="Back To Main Menu"></FORM></FONT></TD>
	</TR>
	</TABLE>
</CFIF>


</div>
</BODY>
</HTML>
