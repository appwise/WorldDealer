<CFSET PageAccess = 1>
<CFINCLUDE template="security.cfm">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>

    <!-- ----------------------------------------------------------- -->
    <!--               Created by sigma6, Detroit                    -->
    <!--         Copyright (c) 1997, 1998, 1999 sigma6.              -->
    <!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->

    <!-- ----------------------------------------------------------- -->
    <!--    Howard Levine for sigma6, interactive media, Detroit     -->
    <!--    hlevine@sigma6.com   www.sigma6.com    www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
	<!--- $Id: offertype.cfm,v 1.8 1999/12/14 22:19:42 lswanson Exp $ --->

<HEAD>
	<TITLE>WorldDealer | Offers Reporting</TITLE>
	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>

<body>
<br><br><br><br><br>



<CFIF #IsDefined("URL.jump")#>
	<CFSET #Variables.current_Record# = #URL.Jump#>
<CFELSEIF NOT #IsDefined("Form.Current_Record")#>
	<CFSET #Variables.current_record# = 1>
<CFELSE>
	<CFSET #variables.current_record# = #form.current_record#>
</CFIF>

<CFIF #IsDefined("form.offertypeID")#>
	<CFSET g_offerTypeID = #form.offertypeID#>
<CFELSEIF #IsDefined("url.offertypeID")#>
	<CFSET g_offertypeID = #url.offertypeID#>
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

<!--- <CFOUTPUT>Current Record: #current_record#<br></CFOUTPUT> --->

<CFIF #IsDefined("Form.BtnBack.X")#>
	<CFLOCATION url="offermaint.cfm">
</CFIF>

<CFIF FirstMode>
	<CFQUERY name="GetOfferTypes" datasource="#gDSN#">
	SELECT OfferTypes.OfferTypeID,
			OfferTypes.Description
	FROM OfferTypes
	ORDER BY Description;
	</CFQUERY>

	<div align="center">
	<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
	<TR ALIGN="center">
		<TD ALIGN="middle"><FONT FACE="arial,helvetica">
		<h3>Dealer Administration<br>Offers  Reporting</h3></FONT></TD>
	</TR>
	<TR><TD>&nbsp;<p></TD></TR>
	<TR align="center"><TD><FONT FACE="arial,helvetica">Sort Offers By Offer Type</FONT></TD></TR>
	<TR><TD>&nbsp;</TD></TR>
	<TR align="center"><TD><FONT FACE="arial,helvetica">
	Select the Offer Type you wish to include in the list of offers.</FONT></TD></TR>
	<FORM action="offertype.cfm" method="post">
	<TR ALIGN="center"><TD><FONT FACE="arial,helvetica">
		<SELECT name="OfferTypeID">
		<OPTION value="all">All Offer Types</OPTION>
		<CFOUTPUT query="getOfferTypes">
		<OPTION value="#OfferTypeID#">#Description#</OPTION>
		</CFOUTPUT>
		</SELECT></FONT>
	</TD></TR>
	<TR><TD>&nbsp;</TD></TR>
	<TR ALIGN="center"><TD><FONT FACE="arial,helvetica">
		<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/back_nav.jpg" BORDER="0" NAME="btnBack" VALUE="< Back">
		&nbsp;&nbsp;&nbsp;<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/showoffers.jpg" Border="0" name="BtnShowOffers" Value="Show Offers"></FONT>
	</TD></TR>
	</FORM>
	<TR><TD>&nbsp;</TD></TR>
	<TR ALIGN="center">
		<TD><FONT FACE="arial,helvetica">
		<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
		<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg" Border="0" NAME="BackToMain" VALUE="Back To Main Menu"></FORM></FONT></TD>
	</TR>
	</TABLE>
</CFIF>


<CFIF SecondMode>
	<!--- Get all offers associated with the chosen Offer Type --->
	<CFQUERY name="GetOfferTypes" datasource="#gDSN#">
		SELECT Offers.OfferID,
				OfferTypes.OfferTypeID,
				OfferTypes.Description
		FROM Offers,
			 OfferTypes
		WHERE Offers.ExpirationDate > #CreateODBCDate(Now())#
		AND Offers.OfferTypeID = OfferTypes.OfferTypeID
		<CFIF #g_offertypeID# IS NOT 'all'>
			AND OfferTypes.OfferTypeID = #g_offertypeID#
		</CFIF>
		ORDER BY OfferTypes.Description;
	</CFQUERY> 

	<CFIF #g_offertypeID# IS NOT 'all'>
		<CFQUERY name="GetOfferType" datasource="#gDSN#">
			SELECT Description
			FROM OfferTypes
			WHERE OfferTypeID = #g_offertypeID#
		</CFQUERY>
	</CFIF>

	<CFIF #end_row# GT #GetOfferTypes.RecordCount#>
		<CFSET #end_row# = #GetOfferTypes.RecordCount#>
	</CFIF>

	<!--- 	<CFOUTPUT>Total Records: #getoffertypes.recordcount#</CFOUTPUT> --->
 	<div align="center">
	<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
	<TR ALIGN="center">
		<TD ALIGN="middle">
		<FONT FACE="arial,helvetica"><h3>Dealer Administration<br></FONT>Offers  Reporting</h3></TD>
	</TR>
	<TR><TD>&nbsp;<p></TD></TR>
	<CFIF #getOfferTypes.RecordCount# EQ 0>
		<CFIF #g_OffertypeID# IS NOT 'all'>
			<CFOUTPUT query="getOfferType">
			<TR align="center"><TD><FONT FACE="arial,helvetica">
			There were no offers found for Offer Type, <b>#Description#</b>.</FONT></TD></TR>
			<TR><TD>&nbsp;</TD></TR>
			</CFOUTPUT>
		<CFELSE>
			<TR align="center"><TD><FONT FACE="arial,helvetica">
				There were no offers found for <b>any</b> Offer Type.</FONT></TD></TR>
			<TR><TD>&nbsp;</TD></TR>
		</CFIF>

	<CFELSE>
		<TR align="center"><TD><FONT FACE="arial,helvetica">The following is a list of 
		<CFIF #g_OffertypeID# IS NOT 'all'>
			<CFOUTPUT query="GetOfferType">
			<b>#Description#</b> Offers
			</CFOUTPUT>
		<CFELSE>
			<b>All Offers</b>
		</CFIF>
		</FONT></TD></TR>
		<TR><TD>&nbsp;</TD></TR>
		
			
		<CFSET #variables.current_row# = #start_row#>
			<CFLOOP Query="GetOfferTypes" startrow="#start_row#" endrow="#end_row#">
				<!--- 	<TR><TD>Looping over: <CFOUTPUT>#variables.current_row#</CFOUTPUT></TD></TR> --->
				<!--- Get DealerOffers for this OfferID --->
				<CFQUERY name="GetdlrOffers" datasource="#gDSN#">
				SELECT Offers.OfferID,
					Offers.Name as q_OfferName,
					Offers.Description as q_OfferDescription,
					OfferTypes.Description as q_OfferType,
					Offers.ExpirationDate,
					Offers.DisclaimerID,
					OfferDisclaimers.TemplateID
				FROM Offers,
					OfferTypes,
					DealerOffers,
					OfferDisclaimers
				WHERE Offers.OfferID = #GetOfferTypes.OfferID#
				AND Offers.OfferTypeID = OfferTypes.OfferTypeID
				AND DealerOffers.OfferID = Offers.OfferID
				AND Offers.DisclaimerID = OfferDisclaimers.DisclaimerID
				AND Offers.ExpirationDate > #CreateODBCDate(Now())#
				</CFQUERY>

				<CFIF #getDLROffers.RecordCount# IS NOT 0>
					<TR align="center"><TD>
						<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0 WIDTH="90%">
						<!--Table2-->
						<CFSET #counter# = 0>
						<CFLOOP query="GetDlrOffers">
							<CFSET #counter# = #counter# + 1>
				
				 			<CFQUERY name="GetDLR" datasource="#gDSN#">
								SELECT Dealers.DealershipName,
										Models.Description
								FROM  Dealers, 
						 				Offers,
					     				DealerOffers,
						 				DealerWebs,
						 				Models
								WHERE Offers.OfferID = #GetDLROffers.OfferID#
									AND DealerOffers.OfferID = Offers.OfferID
									AND DealerOffers.DealerWebID = DealerWebs.DealerWebID
									AND Dealerwebs.DealerCode = Dealers.DealerCode
									AND Offers.ModelID = Models.ModelID;
							</CFQUERY>
							<!--- <CFOUTPUT><TR><TD>FOUND OFFER: #getdlrOffers.OfferID#</TD></TR></CFOUTPUT> --->
							<CFIF #GetDlr.RecordCount# IS NOT 0>
								<CFOUTPUT>
								<TR>
									<TD><FONT FACE="arial,helvetica"><b>Record:</b></FONT></TD>
									<TD>&nbsp;&nbsp;&nbsp;</TD>
									<TD><FONT FACE="arial,helvetica">#variables.Current_Row#</FONT></TD>
								</TR>
								<CFIF #g_offertypeID# EQ 'all'>
									<TR>
										<TD><FONT FACE="arial,helvetica"><b>Offer Type:</b></FONT></TD>
										<TD>&nbsp;&nbsp;&nbsp;</TD>
										<TD><FONT FACE="arial,helvetica">#q_OfferType#</FONT></TD>
									</TR>
								</CFIF>
					 			<TR>
									<TD><FONT FACE="arial,helvetica"><b>Dealer: </b></FONT></TD>
									<TD>&nbsp;&nbsp;&nbsp;</TD>
									<TD><FONT FACE="arial,helvetica">#GetDlr.Dealershipname#</FONT></TD>
								</TR> 
								<TR> 
									<TD><FONT FACE="arial,helvetica"><b>ExpirationDate: </b></FONT></TD>
									<TD>&nbsp;&nbsp;&nbsp;</TD>
									<TD><FONT FACE="arial,helvetica">#Dateformat(ExpirationDate,"mm/dd/yyyy")#</FONT></TD>
								</TR>
								<TR>
									<TD><FONT FACE="arial,helvetica"><b>Model: </b></FONT></TD>
									<TD>&nbsp;&nbsp;&nbsp;</TD>
									<TD><FONT FACE="arial,helvetica">#getDLR.Description#</FONT></TD>
								</TR> 
								<TR>
									<TD><FONT FACE="arial,helvetica"><b>Offer Name: </b></FONT></TD>
									<TD>&nbsp;&nbsp;&nbsp;</TD>
									<TD><FONT FACE="arial,helvetica">#Q_OfferName#</FONT></TD>
								</TR>
								<TR><TD COLSPAN=3><FONT FACE="arial,helvetica"><b>Offer Description</b></FONT></TD></TR>
								<TR>
									<TD COLSPAN=3><FONT FACE="arial,helvetica">#q_OfferDescription#</FONT></TD>
								</TR>
								<TR><TD COLSPAN=3><FONT FACE="arial,helvetica"><b>Disclaimer:</b></FONT></TD></TR>
								<TR><TD COLSPAN=3><FONT FACE="arial,helvetica">
									<CFSET #variables.ID# = #getDlrOffers.DisclaimerID#>
									<CFINCLUDE template="../../../includes/disclaimers/#getDlrOffers.templateID#.cfm">
								</CFOUTPUT>
								</FONT></TD></TR>
								<TR><TD COLSPAN=3>&nbsp;</TD></TR>
							</CFIF>
						</CFLOOP>
						</TABLE>
					</TD></TR>
				</CFIF>
				
				<CFSET #variables.current_row# = #variables.current_row# + 1>
			</CFLOOP>
		</CFIF>
		<CFIF #GetOfferTypes.RecordCount# GT 10>
			<FORM action="OfferType.cfm" method="post">
			<CFOUTPUT>
			<INPUT type="hidden" name="OfferTypeID" value="#g_OfferTypeID#">
			<INPUT type="hidden" name="Current_Record" value="#variables.current_record#">
			</CFOUTPUT>
			<TR ALIGN="center"><TD><FONT FACE="arial,helvetica">
				<CFIF #start_row# GT 10>
					<CFSET #back1# = #variables.current_record# - 10>
					<CFSET #back2# = #variables.current_record# - 1>
					<CFOUTPUT>
					<INPUT type="hidden" name="Back1" value="#back1#">
					<INPUT type="hidden" name="Back2" value="#Back2#">
					<INPUT TYPE="Image" SRC="#application.RELATIVE_PATH#/images/admin/previouspage_nav.jpg" Border="0" name="BtnPrevious" value="Previous Page">&nbsp;&nbsp;&nbsp;
					</CFOUTPUT>
				</CFIF>
				<CFIF #variables.current_record# + 10 LE #GetOfferTypes.recordcount#>
					<CFSET #forward1# = #variables.current_record# + 10>
					<CFIF #variables.current_Record# + 19 LE #GetOfferTypes.recordCount#>
						<CFSET #forward2# = #variables.current_record# + 19>
					<CFELSE>
						<CFSET #forward2# = #GetOfferTypes.recordcount#>
					</CFIF>
					<CFOUTPUT>
					<INPUT type="Hidden" name="Forward1" value="#forward1#">
					<INPUT type="hidden" name="Forward2" value="#forward2#">
					<INPUT TYPE="Image" SRC="#application.RELATIVE_PATH#/images/admin/nextpage_nav.jpg" Border="0" name="BtnNext" value="Next Page">
					</CFOUTPUT>
				</CFIF>
				&nbsp; <!--- In case table cell is empty --->
			</FONT></TD></TR>
			</FORM>
			<TR><TD>&nbsp;</TD></TR>
		</CFIF>
		<CFIF #GetofferTypes.RecordCount# GT 10>
			<TR><TD ALIGN="center"><FONT FACE="Arial,Helvetica" SIZE="1">
				<CFLOOP FROM=1 TO=#GetOfferTypes.RecordCount# STEP=10 INDEX="loopcount">
				<CFOUTPUT>
				<CFIF #variables.current_record# EQ #loopcount#>
					<CFIF #getoffertypes.recordcount# GE #loopcount# + 9>
						<b>#loopcount#-#Evaluate(loopcount + 9)#</b>
					<CFELSE>
						<b>#loopcount#-#getoffertypes.recordcount#</b>
					</CFIF>
				<CFELSEIF #loopcount# + 9 LE #GetOfferTypes.recordcount#>
					<A HREF="offertype.cfm?jump=#loopcount#&offertypeid=#g_offertypeID#">#loopcount#-#Evaluate(loopcount + 9)#</a>
				<CFELSE>
					<A HREF="offertype.cfm?jump=#loopcount#&offertypeid=#g_OfferTypeID#">#loopcount#-#getoffertypes.recordcount#</a>
				</CFIF>
				</CFOUTPUT>
				&nbsp;|&nbsp;
			</CFLOOP>
			</FONT>
		</TD></TR>
		<TR><TD>&nbsp;</TD></TR>
	</CFIF>
	<FORM Action="offertype.cfm" method="post">
	<TR align="center"><TD><FONT FACE="arial,helvetica"><INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/back_nav.jpg" Border="0" value="<< Back"></FONT>
	</TD></TR>
	</FORM>
	<TR><TD>&nbsp;</TD></TR>
	<TR ALIGN="center">
		<TD><FONT FACE="arial,helvetica">
		<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
		<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg" Border="0" NAME="BackToMain" VALUE="Back To Main Menu"></FORM></FONT></TD>
	</TR>
	</TABLE>
</CFIF>


</div>
</BODY>
</HTML>