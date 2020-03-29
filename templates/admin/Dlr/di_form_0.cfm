<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>

<CFINCLUDE template="security.cfm">
<!--- Custom Disclaimer --->   
<!--- $Id: di_form_0.cfm,v 1.5 1999/11/24 22:54:03 lswanson Exp $ --->

<HEAD>
	<TITLE>WorldDealer | Maintain Offers</TITLE>
	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

	<CFSET g_templateID = #form.templateID#>

	<CFSET NewMode = FALSE>
	<CFSET EditMode = FALSE>
	
	<CFIF ParameterExists (FORM.new)>
		<CFSET NewMode = TRUE>
	<CFELSE>
		<CFSET g_offerID = #FORM.offerID#>
		
		<CFQUERY name="getTemplateID" datasource="#gDSN#">
		SELECT 	TemplateID
		FROM 	OfferDisclaimers,
				Offers
		WHERE 	Offers.OfferID = #g_offerID# AND
				OfferDisclaimers.DisclaimerID = Offers.DisclaimerID;
		</CFQUERY>

		<CFIF #getTemplateID.TemplateID# EQ #FORM.TemplateID#>
			<CFSET EditMode = TRUE>
		<CFELSE>  <!--- Chose a different Disclaimer Template, use NewMode --->
			<CFSET NewMode = TRUE>
		</CFIF>
	</CFIF>

	<cfif EditMode>	
		<CFQUERY name="getDisclaimer" datasource="#gDSN#">
			SELECT	CustomDisclaimers.DisclaimerText
			FROM 	OfferDisclaimers,
				 	CustomDisclaimers,
			 		Offers
			WHERE 	OfferDisclaimers.DisclaimerID = Offers.DisclaimerID AND
					Offers.OfferID = #g_offerID# AND
					OfferDisclaimers.DisclaimerID = CustomDisclaimers.DisclaimerID;
		</CFQUERY>

		<!--- Replace <BR> tags with Line Feeds --->
		<CFSET #variables.DisclaimerText# = #Replace(getDisclaimer.DisclaimerText,"<BR>",Chr(13),"ALL")#>
	</cfif>
	
</HEAD>

<BODY>
	<br><br><br><br><br>
	<div align="center">
	<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
	<TR ALIGN="center">
		<TD ALIGN="middle">
			<h3>
			<br>Maintain Offers
			<!--- <br><cfoutput>#getMakeName.MakeName# <cfif #URL.RegionID# EQ 0>National<cfelse>#getRegionName.RegionName#</cfif></cfoutput> --->
			</h3>
		</TD>
	</TR>
	<TR><TD>&nbsp;</TD></TR>

	<TR>
		<TD ALIGN=CENTER>
			<b>Custom Disclaimer</b>
		</TD>
	</TR>

	<CFIF #IsDefined("Variables.National_Offer")#>
		<FORM action="nationaloffers.cfm?MakeNumber=<cfoutput>#URL.MakeNumber#&RegionID=#URL.RegionID#</cfoutput>" method="post" name="myform">
	<CFELSE>
		<FORM action="di_template3.cfm" method="post" name="myform">
	</CFIF>
	<TR>
		<TD ALIGN="center">
			<TEXTAREA name="disclaimer_body" 
				cols=35 
				rows=10 
				wrap="virutal"><cfif EditMode><cfoutput>#variables.DisclaimerText#</cfoutput><cfelse>Enter your disclaimer here.</cfif></TEXTAREA>
		</TD>
	</TR>
	<TR>
		<TD ALIGN=CENTER>
			<CFOUTPUT>
			<CFIF #IsDefined("Variables.National_Offer")#>
				<INPUT type="hidden" name="ModelID" value="#Form.ModelID#">
				<INPUT type="hidden" name="offer_name" value="#form.Offer_name#">
				<INPUT type="hidden" name="offer_body" value="#form.offer_body#">
				<INPUT type="hidden" name="Expiration" value="#form.Expiration#">
			<cfelse>
				<!--- if called from webnew_s8c.cfm, it's the dealership's Custom Offers --->
				<INPUT TYPE="hidden" NAME="DealerCode" VALUE=#form.DealerCode#>
				<INPUT TYPE="hidden" NAME="NextStep" VALUE="webnew_s9.cfm">
			</cfif>
			<INPUT type="hidden" name="templateID" value="0">
			<CFIF ParameterExists(form.new)>
				<INPUT type="hidden" name="new" value="#form.new#">
				<INPUT type="hidden" name="Regions" value="#Form.Regions#">
			<cfelse>
				<INPUT type="hidden" NAME="offerID" value="#form.offerID#">
			</CFIF>
			</CFOUTPUT>
			<br>
			<!--- Cancel, Reset, Next, BackToMain buttons --->
			<INPUT TYPE="Image" 
				SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg" 
				BORDER="0" 
				NAME="btnCancelOffer" 
				VALUE="Cancel">
			&nbsp;&nbsp;
			<A HREF="JavaScript:document.myform.reset();"
				OnMouseOver="self.status='Reset';return true"
				OnMouseOut="self.status='';return true"><IMG
				SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/reset_nav.jpg"
				BORDER=0></A>
			&nbsp;&nbsp;
			<INPUT TYPE="Image" 
				SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next_nav.jpg" 
				BORDER="0" 
				NAME="btnSaveDiscl" 
				VALUE="Next">
			</form>
			<p>
			<form NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
			<INPUT TYPE="Image"
				SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg"
				Border="0"
				NAME="BackToMain"
				VALUE="Back To Main Menu">
			</form>
		</TD>
	</TR>
	</TABLE>
</BODY>
</HTML>