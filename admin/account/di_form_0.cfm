<!--- Custom Disclaimer --->   
<!--- $Id: di_form_0.cfm,v 1.2 2000/05/18 23:53:07 lswanson Exp $ --->

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
	
<div align="center">
<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0>
<TR>
	<TD ALIGN=CENTER>
		<b>Custom Disclaimer</b>
	</TD>
</TR>

<FORM action="incentives_photo.cfm?MakeNumber=<cfoutput>#URL.MakeNumber#&RegionID=#URL.RegionID#</cfoutput>" method="post">
<TR>
	<TD ALIGN="center">
		<TEXTAREA name="disclaimer_body" 
			cols=35 
			rows=10 
			wrap="virutal"><cfif EditMode><cfoutput>#variables.DisclaimerText#</cfoutput></cfif></TEXTAREA>
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
		<a href="incentives.cfm?MakeNumber=#URL.MakeNumber#&RegionID=#URL.RegionID#"
			onmouseover="self.status='Cancel';return true"
			onmouseout="self.status='';return true"><img 
			src="#application.RELATIVE_PATH#/images/admin/cancel.gif"
			width="47" height="15" border="0"
			alt="Cancel"></a>
		&nbsp;&nbsp;
		<INPUT TYPE="Image" 
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next.gif" 
			BORDER="0" 
			NAME="Save" 
			VALUE="next">
		</form>
		<p>
	</TD>
</TR>
</TABLE>
