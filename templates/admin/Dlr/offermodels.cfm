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
	<!--- $Id: offermodels.cfm,v 1.8 1999/12/14 22:19:10 lswanson Exp $ --->

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

<CFIF #IsDefined("form.modelID")#>
	<CFSET g_modelID = #form.modelID#>
<CFELSEIF #IsDefined("url.modelid")#>
	<CFSET g_modelID = #url.modelID#>
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



<CFIF #IsDefined("Form.BtnBack.X")#>
	<CFLOCATION url="offermaint.cfm">
</CFIF>

<CFIF SecondMode>
	<!--- Sort by Model --->
	<!--- Get all offers associated with the chosen model(s) --->
	<CFQUERY name="GetOfferModels" datasource="#gDSN#">
		SELECT Offers.OfferID,
				Offers.ModelID,
				Models.Description as q_ModelDescription
		FROM Offers,
			Models
		WHERE Offers.ExpirationDate > #CreateODBCDate(Now())#
			AND Offers.ModelID = Models.ModelID
		<CFIF #g_modelID# IS NOT 'all'>
			AND Offers.ModelID = #g_modelID#
		</CFIF>
		ORDER BY Models.Description;
	</CFQUERY> 

	<CFIF #g_modelID# IS NOT 'all'>
		<CFQUERY name="GetModelName" datasource="#gDSN#">
			SELECT Description
			FROM Models
			WHERE ModelID = #g_ModelID#;
		</CFQUERY>
	</CFIF>

	<CFIF #end_row# GT #getofferModels.RecordCount#>
		<CFSET #end_row# = #getofferModels.RecordCount#>
	</CFIF>

 	<div align="center">
	<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
	<TR>
		<TD ALIGN="center">
			<FONT FACE="Arial,Helvetica"><h3>
				Dealer Administration
				<br>
				Offers Reporting
			</h3></FONT>
		</TD>
	</TR>
	<TR><TD>&nbsp;<p></TD></TR>
	<CFIF #getOfferModels.RecordCount# EQ 0>
		<CFIF #g_ModelID# IS NOT 'all'>
			<CFOUTPUT query="getModelName">
			<TR align="center"><TD><FONT FACE="Arial,Helvetica">
			There were no Offers found for <b>#Description#</b></FONT></TD></TR>
			<TR><TD>&nbsp;</TD></TR>
			</CFOUTPUT>
		<CFELSE>
			<TR align="center"><TD><FONT FACE="Arial,Helvetica">
			There were no Offers found for <b>any</b> Product (Model).</FONT></TD></TR>
			<TR><TD>&nbsp;</TD></TR>
		</CFIF>

	<CFELSE>
		<!--- Query GetOfferModels returned at least one record --->
		<TR align="center"><TD><FONT FACE="Arial,Helvetica">
			The following is a list of all Offers for
			<CFIF #g_ModelID# IS NOT 'all'>
				<CFOUTPUT query="GetModelName">
				<b>#Description#</b>
				</CFOUTPUT>
			<CFELSE>
				<b>All Models</b>
			</CFIF>
			</FONT></TD></TR>
			<TR><TD>&nbsp;</TD></TR>
		
			
			<CFSET #variables.current_row# = #start_row#>
			<CFLOOP Query="GetOfferModels" startrow="#start_row#" endrow="#end_row#">
				<!--- Get DealerOffers for this OfferID --->
				<CFQUERY name="GetdlrOffers" datasource="#gDSN#">
				SELECT Offers.OfferID,
					Offers.Name as q_OfferName,
					Offers.Description as q_OfferDescription,
					OfferTypes.Description as q_OfferType,
					Dealers.DealershipName,
					Offers.ExpirationDate,
					Offers.DisclaimerID,
					OfferDisclaimers.TemplateID,
					DealerWebs.DealerCode,
					Offers.ModelID,
					Models.Description as q_ModelDescription
				FROM Offers,
					OfferTypes,
					Dealers,
					DealerOffers,
					DealerWebs,
					OfferDisclaimers,
					Models
				WHERE Offers.OfferID = #GetOfferModels.OfferID#
				AND Offers.OfferTypeID = OfferTypes.OfferTypeID
				AND DealerOffers.OfferID = Offers.OfferID
				AND DealerOffers.DealerWebID = DealerWebs.DealerWebID
				AND Dealers.DealerCode = DealerWebs.DealerCode
				AND Offers.DisclaimerID = OfferDisclaimers.DisclaimerID
				AND Offers.ExpirationDate > #CreateODBCDate(Now())#
				AND Offers.ModelID = Models.ModelID
				ORDER BY Dealers.DealershipName;
				</CFQUERY>
				
				<CFIF #getDLROffers.RecordCount# IS NOT 0>
					<TR align="center"><TD>
						<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0 WIDTH="90%">
						<CFSET #counter# = 0>
						<CFLOOP query="GetDlrOffers">
							<CFSET #counter# = #counter# + 1>
							<CFOUTPUT>
							<TR>
								<TD><FONT FACE="Arial,Helvetica"><b>Record:</b></FONT></TD>
								<TD>&nbsp;&nbsp;&nbsp;</TD>
								<TD><FONT FACE="Arial,Helvetica">#variables.Current_Row#</FONT></TD>
							</TR>
							<CFIF #g_ModelID# EQ 'all'>
								<TR>
									<TD><FONT FACE="Arial,Helvetica"><b>Model: </b></FONT></TD>
									<TD>&nbsp;&nbsp;&nbsp;</TD>
									<TD><FONT FACE="Arial,Helvetica">#q_ModelDescription#</FONT></TD>
								</TR>
							</CFIF>
							<TR>
								<TD><FONT FACE="Arial,Helvetica"><b>Dealer: </b></FONT></TD>
								<TD>&nbsp;&nbsp;&nbsp;</TD>
								<TD><FONT FACE="Arial,Helvetica">#Dealershipname#</FONT></TD>
							</TR>
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
								<TD><FONT FACE="Arial,Helvetica"><b>Offer Name: </b></FONT></TD>
								<TD>&nbsp;&nbsp;&nbsp;</TD>
								<TD><FONT FACE="Arial,Helvetica">#Q_OfferName#</FONT></TD>
							</TR>
							<TR><TD COLSPAN=3><FONT FACE="Arial,Helvetica"><b>Offer Description</b></FONT></TD></TR>
							<TR>
								<TD COLSPAN=3><FONT FACE="Arial,Helvetica">#q_OfferDescription#</FONT></TD>
							</TR>
							<TR><TD COLSPAN=3><FONT FACE="Arial,Helvetica"><b>Disclaimer:</b></FONT></TD></TR>
							<TR><TD COLSPAN=3><FONT FACE="Arial,Helvetica">
							<CFSET #variables.ID# = #getDlrOffers.DisclaimerID#>
							<CFINCLUDE template="../../../includes/disclaimers/#getDlrOffers.templateID#.cfm">
							</CFOUTPUT>
							</FONT></TD></TR>
							<TR><TD COLSPAN=3>&nbsp;</TD></TR>
						</CFLOOP>
						</TABLE>
					</TD></TR>
				</CFIF>
				
				<CFSET #variables.current_row# = #variables.current_row# + 1>
			</CFLOOP>
		</CFIF>
		<CFIF #GetOfferModels.RecordCount# GT 10>
			<FORM action="offerModels.cfm" method="post">
			<CFOUTPUT>
			<INPUT type="hidden" name="ModelID" value="#g_ModelID#">
			<INPUT type="hidden" name="Current_Record" value="#variables.current_record#">
			</CFOUTPUT>
			<TR ALIGN="center"><TD><FONT FACE="Arial,Helvetica">
				<CFIF #start_row# GT 10>
					<CFSET #back1# = #variables.current_record# - 10>
					<CFSET #back2# = #variables.current_record# - 1>
					<CFOUTPUT>
					<INPUT type="hidden" name="Back1" value="#back1#">
					<INPUT type="hidden" name="Back2" value="#Back2#">
					<INPUT TYPE="Image" SRC="#application.RELATIVE_PATH#/images/admin/previouspage_nav.jpg" Border="0" name="BtnPrevious" value="Previous Page">&nbsp;&nbsp;&nbsp;
					</CFOUTPUT>
				</CFIF>
				<CFIF #variables.current_record# + 10 LE #getofferModels.recordcount#>
					<CFSET #forward1# = #variables.current_record# + 10>
					<CFIF #variables.current_Record# + 19 LE #getofferModels.recordCount#>
						<CFSET #forward2# = #variables.current_record# + 19>
					<CFELSE>
						<CFSET #forward2# = #getofferModels.recordcount#>
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
		<CFIF #GetOfferModels.RecordCount# GT 10>
			<TR><TD ALIGN="center"><FONT FACE="Arial,Helvetica" SIZE="1">
			<CFLOOP FROM=1 TO=#getOfferModels.RecordCount# STEP=10 INDEX="loopcount">
				<CFOUTPUT>
				<CFIF #variables.current_record# EQ #loopcount#>
					<CFIF #getoffermodels.recordcount# GE #loopcount# + 9>
						<b>#loopcount#-#Evaluate(loopcount + 9)#</b>
					<CFELSE>
						<b>#loopcount#-#getoffermodels.recordcount#</b>
					</CFIF>
				<CFELSEIF #loopcount# + 9 LE #getoffermodels.recordcount#>
					<A HREF="offermodels.cfm?jump=#loopcount#&modelid=#g_modelID#">#loopcount#-#Evaluate(loopcount + 9)#</a>
				<CFELSE>
					<A HREF="offermodels.cfm?jump=#loopcount#&modelid=#g_modelID#">#loopcount#-#getoffermodels.recordcount#</a>
				</CFIF>
				</CFOUTPUT>
				&nbsp;|&nbsp;
			</CFLOOP>
			</FONT>
		</TD></TR>
		<TR><TD>&nbsp;</TD></TR>
	</CFIF>
	<FORM Action="offermodels.cfm" method="post">
	<TR align="center"><TD>
		<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/back_nav.jpg" Border="0" value="Back">
	</TD></TR>
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
	<CFQUERY name="GetModels" datasource="#gDSN#">
	SELECT Models.ModelID,
			Models.Description
	FROM Models
	ORDER BY Description;
	</CFQUERY>

	<div align="center">
	<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
	<TR>
		<TD ALIGN="center">
			<FONT FACE="Arial,Helvetica">
				<h3>Dealer Administration<br>Offers Reporting</h3>
			</FONT>
		</TD>
	</TR>
	<TR><TD>&nbsp;<p></TD></TR>
	<TR align="center"><TD><FONT FACE="Arial,Helvetica">Sort Offers By Product (Model)</FONT></TD></TR>
	<TR><TD>&nbsp;</TD></TR>
	<TR align="center"><TD><FONT FACE="Arial,Helvetica">
	Select the model you wish to include in the list of offers.</FONT></TD></TR>
	<FORM action="offermodels.cfm" method="post">
	<TR ALIGN="center"><TD><FONT FACE="Arial,Helvetica">
		<SELECT name="modelID">
		<OPTION value="all">All Models</OPTION>
		<CFOUTPUT query="getModels">
		<OPTION value="#ModelID#">#Description#</OPTION>
		</CFOUTPUT>
		</SELECT></FONT>
	</TD></TR>
	<TR><TD>&nbsp;</TD></TR>
	<TR ALIGN="center"><TD><FONT FACE="Arial,Helvetica">
		<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/back_nav.jpg" BORDER="0" NAME="btnBack" VALUE="< Back">
		&nbsp;&nbsp;&nbsp;<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/showoffers.jpg" Border="0" name="BtnShowOffers" Value="Show Offers">
	</FONT></TD></TR>
	</FORM>
	<TR><TD>&nbsp;</TD></TR>
	<TR ALIGN="center">
		<TD><FONT FACE="Arial,Helvetica">
		<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
		<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg" Border="0" NAME="BackToMain" VALUE="Back To Main Menu"></FORM></TD></FONT>
	</TR>
	</TABLE>
	
</CFIF>

</div>
</BODY>
</HTML>