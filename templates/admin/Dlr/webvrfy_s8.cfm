<CFSET webverifystep = 8>
<CFINCLUDE template="security.cfm">

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

    <!-- ----------------------------------------------------------- -->
    <!--               Created by sigma6, Detroit                    -->
    <!--         Copyright (c) 1997, 1998, 1999 sigma6.              -->
    <!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->

    <!-- ----------------------------------------------------------- -->
    <!--     John Turner for sigma6, interactive media, Detroit      -->
    <!--    jturner@sigma6.com   www.sigma6.com    www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
	<!--- $Id: webvrfy_s8.cfm,v 1.6 1999/11/29 15:31:01 lswanson Exp $ --->
	<!--- Offers --->
	
<HTML>

<HEAD>

    <TITLE>WorldDealer | Offers</TITLE>
	
	<CFIF ParameterExists(Form.btnBack.X)>
		<CFLOCATION url="webvrfy_s7.cfm?dlrcode=#form.dealercode#">
	</CFIF>
	
    <CFIF ParameterExists(Form.btnNext.X)>
		<CFLOCATION URL="#Form.NextStep#?dlrcode=#Form.DealerCode#">
    </CFIF>
        
    <CFIF ParameterExists(Form.btnModify.X)>
    	<CFLOCATION URL="webnew_s8.cfm?dlrcode=#Form.DealerCode#">
	</cfif>

	<CFIF ParameterExists(URL.dlrcode)>
		<CFSET VerifyMode = TRUE>
		<CFSET g_DealerCode = #URL.dlrcode#>
	<CFELSE>
		<CFSET VerifyMode = FALSE>
	</CFIF>

	<CFIF VerifyMode>
    	<CFQUERY NAME="getDLROffers" datasource="#gDSN#">
	   		SELECT 	Offers.Name as q_offerName,
					Offers.ExpirationDate as q_ExpirationDate,
					Offertypes.Description as q_offertype,
					Models.Description as q_ModelDescription,
					Makes.MakeName
			FROM 	DealerWebs 
					INNER JOIN DealerOffers ON DealerWebs.DealerWebID = DealerOffers.DealerWebID
					INNER JOIN Offers ON DealerOffers.OfferID = Offers.OfferID
					INNER JOIN OfferTypes ON Offers.OfferTypeID = OfferTypes.OfferTypeID
					INNER JOIN Models ON Offers.ModelID = Models.ModelID
					INNER JOIN Makes ON Models.Make = Makes.MakeNumber
			WHERE 	DealerWebs.DealerCode = '#g_DealerCode#' AND
					Offers.ExpirationDate > #CreateODBCDate('1/1/95')#
			ORDER BY Makes.MakeName,
					Models.Description, 
					Offers.ExpirationDate;
		</CFQUERY>
	</CFIF>
		
	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>
		
<body>

<CFIF VerifyMode>
<br><br><br><br><br>
<div align="center">
<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=500 BGCOLOR="FFFFFF">
<TR>
	<TD ALIGN="center">
		<h3>
			Maintain Your Web Site
		</h3>
	</TD>
</TR>
<TR ALIGN="center">                    
	<TD ALIGN="middle"><h4>Vehicle Offers</h4></TD>
</TR>
<TR ALIGN=CENTER>
	<TD>
		<CFIF #getDLROffers.RecordCount# IS '0'>
			There are currently NO Offers associated with this dealership.
		<CFELSE>
			The following offers are currently associated with this dealership:
			<p>
			<TABLE BORDER=0 CELLPADDING=3>
			<TR>
				<TD>
					<b>Make</b>
				</TD>
				<TD>
					<b>Model</b>
				</TD>
				<TD>
					<b>Offer Name</b>
				</TD>
				<TD>
					<b>Type</b>
				</TD>
				<TD>
					<b>Expiration Date</b>
				</TD>
			</TR>
			<CFOUTPUT query="getDLRoffers">
			<TR>
				<TD>
					#MakeName#
				</TD>
				<TD>
					#q_modelDescription#
				</TD>
				<TD>
					#q_offername#
				</TD>
				<TD>
					#q_offertype#
				</td>
				<TD>
					#DateFormat(q_expirationdate,"mm/dd/yyyy")#
				</TD>
			</TR>
			</CFOUTPUT>
			</TABLE>
		</CFIF>
	</TD>
</TR>
<TR><TD>&nbsp;<p></TD></TR>
<TR>
	<TD ALIGN=CENTER>
		<CFOUTPUT>
		<FORM NAME="VrfyEight" ACTION="webvrfy_s8.cfm?dlrcode=#g_DealerCode#" METHOD="post">
			<INPUT TYPE="hidden" NAME="DealerCode" VALUE="#g_DealerCode#">
			<INPUT TYPE="hidden" NAME="NextStep" VALUE="webvrfy_s9.cfm">
			<INPUT TYPE="Image"
				SRC="#application.RELATIVE_PATH#/images/admin/back_nav.jpg"
				BORDER="0"
				NAME="btnBack"
				VALUE="Back">
			&nbsp;&nbsp;
			<INPUT TYPE="Image" SRC="#application.RELATIVE_PATH#/images/admin/addmodifydelete_nav.jpg"
				BORDER="0"
				NAME="btnModify"
				VALUE="Modify">
			&nbsp;&nbsp;
			<INPUT TYPE="Image" SRC="#application.RELATIVE_PATH#/images/admin/next_nav.jpg"
				BORDER="0"
				NAME="btnNext"
				VALUE="Next">
		</FORM>
		</CFOUTPUT>
		<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
			<INPUT TYPE="Image"
				SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg"
				Border="0"
				NAME="BackToMain"
				VALUE="Back To Main Menu">
		</FORM>
	</TD>
</TR>
</TABLE>

</div>
</CFIF>

</BODY>
</HTML>