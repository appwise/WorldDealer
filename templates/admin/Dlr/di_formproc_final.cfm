<CFINCLUDE template="security.cfm">
<!--- $Id: di_formproc_final.cfm,v 1.4 1999/11/29 16:34:03 lswanson Exp $ --->

<CFSET g_dealercode = #FORM.dealercode#>
<CFSET g_offerID = #FORM.OfferID#>

<CFIF IsDefined ("FORM.BtnSave.X")>
	<CFSET SaveMode = TRUE>
	<CFSET CancelMode = FALSE>
</CFIF>

<CFIF IsDefined ("FORM.BtnCancel.X")>
	<CFSET CancelMode = TRUE>
	<CFSET SaveMode = FALSE>
</CFIF>

<CFIF SaveMode>

<CFIF IsDefined("FORM.Var1")>
	<CFSET #variables.var1# = #FORM.var1#>
<CFELSE>
	<CFSET #variables.var1# = ''>
</CFIF>

<CFIF IsDefined ("FORM.Var2")>
	<CFSET #variables.var2# = #FORM.var2#>
<CFELSE>
	<CFSET #variables.var2# = ''>
</CFIF>

<CFIF IsDefined ("FORM.Var3")>
	<CFSET #variables.var3# = #FORM.var3#>
<CFELSE>
	<CFSET #variables.var3# = ''>
</CFIF>

<CFIF IsDefined ("FORM.Var4")>
	<CFSET #variables.var4# = #form.var4#>
<CFELSE>
	<CFSET #variables.var4# = ''>
</CFIF>

<CFIF IsDefined ("FORM.Var5")>
	<CFSET #variables.var5# = #form.var5#>
<CFELSE>
	<CFSET #variables.var5# = ''>
</CFIF>

<CFIF IsDefined ("FORM.Var6")>
	<CFSET #variables.var6# = #form.var6#>
<CFELSE>
	<CFSET #variables.var6# = ''>
</CFIF>

<CFIF IsDefined ("FORM.Var7")>
	<CFSET #variables.var7# = #form.var7#>
<CFELSE>
	<CFSET #variables.var7# = ''>
</CFIF>

<CFIF IsDefined ("FORM.Var8")>
	<CFSET #variables.var8# = #form.var8#>
<CFELSE>
	<CFSET #variables.var8# = ''>
</CFIF>

<CFIF IsDefined ("FORM.Var9")>
	<CFSET #variables.var9# = #form.var9#>
<CFELSE>
	<CFSET #variables.var9# = ''>
</CFIF>

<CFIF IsDefined ("FORM.Var10")>
	<CFSET #variables.var10# = #form.var10#>
<CFELSE>
	<CFSET #variables.var10# = ''>
</CFIF>

<CFIF NOT IsDefined("FORM.new")>

	<CFQUERY name="GetDisclaimerID" datasource="#gDSN#">
	SELECT Offers.DisclaimerID as q_DisclaimerID
	FROM Offers
	WHERE OfferID = #g_offerID#;
	</CFQUERY>

	<CFQUERY name="UpdateDisclaimer" datasource="#gDSN#">
	UPDATE OfferDisclaimers
	SET TemplateID = #form.TemplateID#,
		Var1 = '#Variables.var1#',
		Var2 = '#Variables.var2#',
		Var3 = '#Variables.var3#',
		Var4 = '#Variables.var4#',
		Var5 = '#Variables.var5#',
		Var6 = '#Variables.var6#',
		Var7 = '#Variables.var7#',
		Var8 = '#Variables.var8#',
		Var9 = '#Variables.var9#',
		Var10 = '#Variables.var10#'
	WHERE DisclaimerID = #getDisclaimerID.q_disclaimerID#;
	</CFQUERY>
	<CFSET q_newDisclaimer=#getdisclaimerID.q_disclaimerID#>

	<CFIF #Form.TemplateID# EQ 0>
		<!--- Custom Disclaimer --->
		<CFSET #variables.Disclaimer_Text# = #Replace(form.disclaimer_body,Chr(13),"<BR>","ALL")#>

		<!--- First Check if this Custom Disclaimer Exists --->
		<CFQUERY name="CheckDisclaimer" datasource="#gDSN#">
			SELECT COUNT(DisclaimerID) as q_count
			FROM CustomDisclaimers
			WHERE DisclaimerID = #GetDisclaimerID.q_disclaimerID#;
		</CFQUERY>

		<CFIF CheckDisclaimer.q_count GT 0>
			<CFQUERY name="UpdCustomDisclaimer" datasource="#gDSN#">
			UPDATE CustomDisclaimers
			SET DisclaimerText = '#disclaimer_Text#'
			WHERE DisclaimerID = #q_NewDisclaimer#;
			</CFQUERY>
		<CFELSE>
			<CFQUERY name="InsCustomDisclaimer" datasource="#gDSN#">
			INSERT INTO CustomDisclaimers (DisclaimerText, DisclaimerID)
								VALUES ('#disclaimer_text#', #q_NewDisclaimer#);
			</CFQUERY>
		</CFIF>
	</CFIF>
	
<CFELSE>
	<!--- Insert new Disclaimer --->
	<CFQUERY name="newdisclaimer" datasource="#gDSN#">    
 		INSERT INTO OfferDisclaimers	                          
			(TemplateID,
			Var1,
			Var2,
			Var3,
			Var4,
			Var5,
			Var6,
			Var7,
			Var8,
			Var9,
			Var10)
		VALUES (#form.templateID#,
			'#variables.var1#',
			'#variables.var2#',
			'#variables.var3#',
			'#variables.var4#',
			'#variables.var5#',
			'#variables.var6#',
			'#variables.var7#',
			'#variables.var8#',
			'#variables.var9#',
			'#variables.var10#');
	</CFQUERY>

	<CFQUERY name="getdisclaimerid" datasource="#gDSN#">
		SELECT Max(DisclaimerID) AS new_disclaimer
			FROM OfferDisclaimers;
	</CFQUERY>
	
	<CFIF #Form.TemplateID# EQ 0>
		<!--- Custom Disclaimer --->
		
		<CFSET #disclaimer_text# = #Replace(form.disclaimer_body,Chr(13),"<BR>","ALL")#>
		
		<CFQUERY name="InsCustomDisclaimer" datasource="#gDSN#">
		INSERT INTO CustomDisclaimers (DisclaimerID, DisclaimerText)
						VALUES (#getDisclaimerID.new_disclaimer#,
								'#disclaimer_text#');
		</CFQUERY>	
	</CFIF>  <!--- CFIF TemplateID EQ 0 --->
		<CFSET q_newDisclaimer = #getdisclaimerid.new_disclaimer#>
	</CFIF>
	
<!--- Update Offers table with new DisclaimerID --->
	<CFQUERY name="updateOffer" datasource="#gDSN#">
	UPDATE Offers
	SET DisclaimerID = #q_newDisclaimer#
	WHERE OfferID = #g_offerID#;
	</CFQUERY>

</CFIF> <!---- CFIF SaveMode --->


<CFIF CancelMode>
	<CFIF IsDefined("FORM.new")>
			<!--- Delete NEW offer from Database --->
			<CFQUERY name="getDealerWebID" datasource="#gDSN#">
			SELECT DealerWebID
			FROM DealerWebs
			WHERE DealerCode='#g_dealercode#';
			</CFQUERY>

			<CFQUERY name="deleteDealerOffer" datasource="#gDSN#">
			DELETE FROM DealerOffers
			WHERE OfferID=#g_offerID# AND
			DealerWebID=#GetDealerWebID.DealerWebID#;
			</CFQUERY>

			<CFQUERY name="deleteOffer" datasource="#gDSN#">
			DELETE FROM Offers
       		WHERE OfferID=#g_offerID#;
			</CFQUERY>
		</CFIF>
		<CFLOCATION url="webvrfy_s8.cfm?dlrcode=#g_dealercode#">
</CFIF>

<CFLOCATION url="webnew_s8d.cfm?dlrcode=#g_dealercode#">