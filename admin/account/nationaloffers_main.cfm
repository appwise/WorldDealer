<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>

    <!-- ----------------------------------------------------------- -->
    <!--                 Created by sigma6, Detroit                  -->
    <!--         Copyright (c) 1997, 1998, 1999 sigma6.              -->
    <!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->

    <!-- ----------------------------------------------------------- -->
    <!--     Howard Levine for sigma6, interactive media, Detroit    -->
    <!--    hlevine@sigma6.com   www.sigma6.com    www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
	<!--- $Id: nationaloffers_main.cfm,v 1.7 2000/05/18 23:53:08 lswanson Exp $ --->

<HEAD>

<TITLE>WorldDealer | Maintain Offers</TITLE>
<!--- <CFQUERY NAME="getAEDealerCode" DATASOURCE="#gDSN#">
	SELECT DISTINCT DealerCode as q_DealerCode
	FROM Dealers
	WHERE AEID = #RemoveChars(AccessLevel,1,2)#
</cfquery>
 --->
<!--- These lines check if the user is returning from the di_form_x.cfm pages --->
<!--- <CFIF #IsDefined("Variables.Dealercode")#>
	--- do nothing ---
<CFELSEIF NOT #IsDefined("Form.Dealercode")#>
	<CFSET variables.DealerCode = getAEDealerCode.q_DealerCode>
<CFELSE>
	<CFSET variables.dealercode = #form.dealercode#>
</CFIF>
 --->
 
 <!--- linda, 11/16/99: first, do any processing that doesn't require a page being loaded.
 Redirects get processed 1st, get em outta the way with a minimum of checks.
 Then purely query-based processing (adds, updates, deletes), so that when they're done, 
 they fall thru to the default ChooseOfferMode & will display the listing of offers, 
 without having to call nationaloffer.cfm again. --->
 
 <!--- if Cancel on ChooseOfferMode page, return to Make/Region selection page --->
<CFIF #IsDefined("form.btnCancelMake.X")#>
	<CFLOCATION url="nationaloffers.cfm">
</CFIF>
<!--- if Cancel on other pages, return to ChooseOfferMode page --->
<CFIF #IsDefined("form.btnCancelOffer.X")#>
	<CFLOCATION url="nationaloffers.cfm?MakeNumber=#URL.MakeNumber#&RegionID=#URL.RegionID#">
</CFIF>

<!--- User is at the end of adding or modifying an offer.  Clicked "Save National Offer" button. --->



<!--- Determine the Mode it's in --->
<!--- linda, 11/16/99: Modes are trimmed down to events that display a page.  
Events that just cause processing are listed above, so that when they're done, 
they'll fall into the default ChooseOfferMode & will display the listing of offers. --->
<CFSET ChooseOfferMode = FALSE>
<CFSET NewMode = FALSE>
<CFSET ModifyMode = FALSE>
<CFSET CustDisclMode = FALSE>
<CFSET CarCutMode = FALSE>
<CFSET DeleteMode = FALSE>

<CFIF #IsDefined("Form.btnNew.X")#>	<!--- Add New Offer button on ChooseOfferMode page  --->
	<CFSET NewMode = TRUE>
<CFELSEIF #IsDefined("Form.btnModify.X")#>  <!--- Modify Offer button on ChooseOfferMode page --->
	<CFSET ModifyMode = TRUE>
<CFELSEIF #IsDefined("Form.btnNext.X")#>
	<cfif #form.TemplateID# EQ 1>
		<!--- Standard MSRP, no additional disclaimer info req'd.  continue on to CarCuts --->
		<CFSET CarCutMode = TRUE>
	<cfelse>
		<!--- Custom disclaimer or disclaimer templates, where you can enter %, $ amts, dates, etc. --->
		<CFSET CustDisclMode = TRUE>
	</cfif>
<CFELSEIF #IsDefined("Form.btnSaveDiscl.X")#>  <!--- done with custom disclaimer, ready to continue with carcut. --->
	<CFSET CarCutMode = TRUE>
<CFELSEIF #IsDefined("Form.btnDelete.X")#>  <!--- Delete Offer button on Add/Modify/Delete page --->
	<CFSET DeleteMode = TRUE>
<CFELSE>
	<CFSET ChooseOfferMode = TRUE>
</CFIF>

<!--- proceed with mode-specific queries --->





<!--- these happen for every mode, to display in the page heading --->

<!--- so the background doesn't repeat --->
<link rel=stylesheet href="../admin.css" type="text/css">

</HEAD>

<BODY>
<!--- this page heading is common to all modes --->


