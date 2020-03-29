<CFINCLUDE template="security.cfm">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
    <!-- ----------------------------------------------------------- -->
    <!--               Created by sigma6, Detroit                    -->
    <!--         Copyright (c) 1997, 1998, 1999 sigma6.              -->
    <!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->

    <!-- ----------------------------------------------------------- -->
    <!--     Linda Swanson for sigma6, interactive media, Detroit    -->
    <!--   lswanson@sigma6.com   www.sigma6.com    www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
	<!--- $Id: webnew_s8aa.cfm,v 1.10 1999/12/29 21:39:09 lswanson Exp $ --->
	<!--- Type of Offer (National, Regional, Custom) --->

<HTML>
<HEAD>
	<TITLE>WorldDealer | Offers</TITLE>
	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

<CFIF #IsDefined("Form.BtnCancel.x")#>
	<CFLOCATION url="webvrfy_s8.cfm?dlrcode=#form.dealercode#">
</CFIF>

<CFSET ChooseType = FALSE>
<CFSET NextMode = FALSE>
<CFSET SaveMode = FALSE>

<CFIF #IsDefined("URL.dlrcode")#>
	<CFSET ChooseType = TRUE>
	<CFSET g_dealercode=#url.dlrcode#>
</CFIF>

<CFIF #IsDefined("Form.BtnNext.X")#>
	<CFSET NextMode = TRUE>
	<CFSET g_DealerCode = #FORM.dealercode#>
</CFIF>

<CFIF #IsDefined("Form.Btnsave.X")#>
	<CFSET SaveMode = TRUE>
	<CFSET g_DealerCode = #FORM.DealerCode#>
</CFIF>

<cfif ChooseType>
	<cfquery name="getOfferTypes" datasource="#gDSN#">
		SELECT 	OfferTypeID,
				Description
		FROM	OfferTypes
		ORDER BY Description
	</cfquery>
</cfif>

<CFIF NextMode OR SaveMode>
	<CFQUERY name="selectDealerWebID" datasource="#gDSN#">
		SELECT	DealerWebID 
		FROM	DealerWebs
		WHERE	DealerCode = '#g_dealercode#';
	</CFQUERY>
</CFIF>

<CFIF NextMode>
	<cfswitch expression="#form.OfferType#">
		<cfcase value="1">
			<!--- National Offer --->
			<cfset National = TRUE>
			<cfset Regional = FALSE>
			<CFOUTPUT>
			<CFQUERY name="getoffers" datasource="#gDSN#">
			SELECT 	Offers.OfferID, 
					Offers.OfferTypeID, 
					Offers.Name, 
					Offers.Description as OfferDescription,
					Offers.ExpirationDate, 
					Offers.ModelID, 
					Models.Description as ModelsDescription,
					Models.Make,
					Makes.MakeName
			FROM 	((Offers 
					INNER JOIN Models ON Offers.ModelID = Models.ModelID) 
					INNER JOIN DealerFranchise ON Models.Make = DealerFranchise.MakeNumber
					INNER JOIN Makes ON Models.Make = Makes.MakeNumber)
			WHERE 	Offers.OfferTypeID = #FORM.OfferType# 
					AND Offers.ExpirationDate > #CreateODBCDate(DateFormat(Now(), "mm/dd/yyyy"))#
					AND DealerFranchise.DF_Number = #Val(Mid(g_dealercode, 11, 3))# 
					AND Offers.OfferID NOT IN (
						SELECT	DealerOffers.OfferID
						FROM	DealerOffers
						WHERE	DealerWebID = #selectDealerWebID.DealerWebID#
						)
			ORDER BY Makes.MakeName, 
					Models.Description,
					Offers.ExpirationDate
			</CFQUERY>
			</cfoutput>
		</cfcase>

		<cfcase value="2">
			<!--- Custom (Dealer) Offer --->
			<CFLOCATION URL="webnew_s8a.cfm?dlrcode=#form.dealercode#">
		</cfcase>
	
		<cfcase value="5">
			<!--- Regional Offer --->
			<cfset National = FALSE>
			<cfset Regional = TRUE>
			<CFOUTPUT>
			<CFQUERY name="getoffers" datasource="#gDSN#">
				SELECT 	Offers.OfferID, 
						Makes.MakeName, 
						MakeRegions.RegionName, 
						Models.Description as ModelsDescription,
						Offers.Name, 
						Offers.Description as OfferDescription, 
						Offers.ExpirationDate
				FROM 	(((DealerFranchise 
						INNER JOIN Offers ON DealerFranchise.RegionID = Offers.RegionID) 
						INNER JOIN Models ON Offers.ModelID = Models.ModelID) 
						INNER JOIN Makes ON Models.Make = Makes.MakeNumber) 
						INNER JOIN MakeRegions ON DealerFranchise.RegionID = MakeRegions.RegionID
				WHERE 	(Offers.OfferTypeID=#FORM.OfferType#)
						AND (Offers.ExpirationDate > #CreateODBCDate(DateFormat(Now(), "mm/dd/yyyy"))#)
						AND (DealerFranchise.DF_Number = #Val(Mid(g_dealercode, 11, 3))#)
						AND Offers.OfferID NOT IN (
							SELECT	DealerOffers.OfferID
							FROM	DealerOffers
							WHERE	DealerWebID = #selectDealerWebID.DealerWebID#
							)
				ORDER BY Makes.MakeName,
						Models.Description,
						MakeRegions.RegionName,
						Offers.ExpirationDate;
			</CFQUERY>
			</cfoutput>
		</cfcase>
	</cfswitch>
</cfif>

<CFIF SaveMode>
	<!--- 
	insert the selected national offer, or all national offers that aren't
	already	associated with this dealership
	--->
	<CFOUTPUT>
	<CFQUERY name="insertDealerOffers" datasource="#gDSN#">
	INSERT INTO DealerOffers (
		DealerWebID,
		OfferID
		)
	SELECT DISTINCT
		#selectDealerWebID.DealerWebID#,
		Offers.OfferID
	FROM
		Offers		 
	WHERE
		<CFIF #form.OfferID# EQ 'All'>
			Offers.OfferID IN (
				SELECT	Offers.OfferID
				<cfif #form.offertype# IS 1> <!--- national --->
				FROM 	(Offers INNER JOIN Models ON Offers.ModelID = Models.ModelID) 
						INNER JOIN DealerFranchise ON Models.Make = DealerFranchise.MakeNumber
				<cfelseif #form.offertype# IS 5>  <!--- regional --->
				FROM 	(((DealerFranchise 
						INNER JOIN Offers ON DealerFranchise.RegionID = Offers.RegionID) 
						INNER JOIN Models ON Offers.ModelID = Models.ModelID) 
						INNER JOIN Makes ON Models.Make = Makes.MakeNumber) 
						INNER JOIN MakeRegions ON DealerFranchise.RegionID = MakeRegions.RegionID
				</cfif>
				WHERE 	Offers.OfferTypeID = #Form.OfferType# AND 
						Offers.ExpirationDate > #CreateODBCDate(DateFormat(Now(), "mm/dd/yyyy"))# AND 
						DealerFranchise.DF_Number = #Val(Mid(g_dealercode, 11, 3))#
				)
			AND Offers.OfferID NOT IN (
				SELECT	DealerOffers.OfferID
				FROM	DealerOffers
				WHERE	DealerWebID = #selectDealerWebID.DealerWebID#
				)
		<CFELSE>
			Offers.OfferID = #Form.OfferID#
		</CFIF>
	</CFQUERY>
	</cfoutput>
	<CFLOCATION url="webvrfy_s8.cfm?dlrcode=#g_dealercode#">
</CFIF>

</HEAD>

<body>
	<br><br><br><br><br>
	<div align="center">
	<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=600 BGCOLOR="FFFFFF">
	<TR ALIGN="center">
		<TD ALIGN="center">
			<h3>
				Dealer Administration - Offers
			</h3>
		</TD>
	</TR>
	<TR><TD>&nbsp;</TD></TR>
<CFIF ChooseType>
	<FORM NAME="StepSix" ACTION="webnew_s8aa.cfm" METHOD="post">
	<TR align="center">
		<TD>
			Select the type of Offer you wish to display.
		</TD>
	</TR>
	<TR><TD>&nbsp;</TD></TR>
	<TR align=center>
		<TD>
			<SELECT name="offertype">
				<cfoutput query="getOfferTypes">
					<OPTION value="#OfferTypeID#">#Description#
				</cfoutput>
			</SELECT>
		</TD>
	</TR>
	<TR><TD>&nbsp;</TD></TR>
	<TR align="center">
		<TD>
			<INPUT type="hidden" name="dealercode" value="<CFOUTPUT>#g_dealercode#</CFOUTPUT>">
			<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg" BORDER="0" NAME="btnCancel" VALUE="Cancel">
			&nbsp;&nbsp;&nbsp;
			<INPUT type="Image" name="BtnNext" value="Next" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next_nav.jpg" BORDER="0">
		</TD>
	</TR>
	</FORM>
	<TR><TD>&nbsp;</TD></TR>
	<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
	<TR align="center">
		<TD>
			<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg" Border="0" NAME="BackToMain" VALUE="Back To Main Menu">
		</TD>
	</TR>
	</FORM>
</CFIF>


<CFIF NextMode>
	<cfoutput>
	<FORM action="webnew_s8aa.cfm" method="post">
	<CFIF #getOffers.RecordCount# EQ 0>
		<TR align="Center">
			<TD>
				There are currently NO <cfif National>National<cfelse>Regional</cfif> Offers to add.
			</TD>
		</TR>
	<CFELSE>
		<TR ALIGN="center">
	 		<TD>
				Choose from the following list of <cfif National>National<cfelse>Regional</cfif> Offers
			</TD>
		</TR>
		<TR><TD>&nbsp;</TD></TR>
		<TR align="Center">
			<TD>
				<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2>
					<!--- Do the header stuff --->
					<TR align="center">
						<TD>&nbsp;</TD>
						<TD><b>Make<b></TD>
						<TD><b>Model<b></TD>
						<cfif Regional>
							<TD><b>Region</b></TD>
						</cfif>
						<TD><b>Offer Name</b></TD>
						<TD><b>Description</b></TD>
						<TD><b>ExpirationDate<b></TD>
					</TR>
					<!--- Add ALL National Offers. --->
					<TR align="center">
						<TD><INPUT type="radio" name="OfferID" value="All"></TD>
						<TD COLSPAN=<cfif Regional>6<cfelse>5</cfif>><FONT COLOR="cc0000">Add <b>All</b> <cfif National>National<cfelse>Regional</cfif> Offers.</font></TD>
					</TR>
					<CFLOOP query="getOffers">
						<!--- Display offers --->
						<TR Align="center">
							<TD>
								<INPUT type="radio" name="OfferID" value="#OfferID#" <CFIF #getOffers.CurrentRow# EQ 1>CHECKED</CFIF>>
							</TD>
							<TD>#MakeName#</TD>
							<TD>#ModelsDescription#</TD>
							<cfif Regional>
								<TD>#RegionName#</TD>
							</cfif>
							<TD>#Name#</TD>
							<TD>#OfferDescription#</TD>
							<TD>#DateFormat(ExpirationDate, "mm/dd/yyyy")#</TD>
						</TR>
					</cfloop>
				</TABLE>
			</TD>
		</TR>
	</CFIF>
	<TR><TD>&nbsp;</TD></TR>
	<TR align="center">
		<TD>
			<INPUT TYPE="hidden" NAME="DealerCode" VALUE=#g_DealerCode#>
			<INPUT TYPE="hidden" NAME="NextStep" VALUE="webnew_s8a.cfm">
			<INPUT type="hidden" name="OfferType" value=#FORM.OfferType#>
            &nbsp;&nbsp;
			<INPUT TYPE="Image" SRC="#application.RELATIVE_PATH#/images/admin/cancel_nav.jpg" BORDER="0" NAME="btnCancel" VALUE="Cancel">
			<CFIF #getOffers.RecordCount# GT 0>				
   	           	&nbsp;&nbsp;
   	       		<INPUT TYPE="Image" NAME="BtnSave" VALUE="Save" SRC="#application.RELATIVE_PATH#/images/admin/save_nav.jpg" BORDER="0">
			</CFIF>
		</TD>
	</TR>
   	</FORM>
	<TR><TD>&nbsp;</TD></TR>
		
	<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
    <TR align=Center>
		<TD>
			<INPUT TYPE="Image"
				SRC="#application.RELATIVE_PATH#/images/admin/backtomain_nav.jpg"
				Border="0"
				NAME="BackToMain"
				VALUE="Back To Main Menu">
		</TD>
	</TR>
   	</FORM>
	</cfoutput>
</CFIF>
 
<TR><TD>&nbsp;</TD></TR>
</TABLE>
	
</div>
</BODY>
</HTML>		
