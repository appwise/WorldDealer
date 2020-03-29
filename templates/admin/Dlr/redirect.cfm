	<!--- <CFINCLUDE template="security.cfm"> --->
    <!-- ----------------------------------------------------------- -->
    <!-- ----------------------------------------------------------- -->
    <!--           Created by sigma6, Detroit                        -->
    <!--         Copyright (c) 1997, 1998, 1999 sigma6.              -->
    <!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
    <!--               conceive : construct : connect                -->
	<!-- ----------------------------------------------------------- -->

    <!-- ----------------------------------------------------------- -->
    <!--     John Turner for sigma6, interactive media, Detroit      -->
    <!--    jturner@sigma6.com   www.sigma6.com    www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
	<!--- $Id: redirect.cfm,v 1.8 1999/11/29 18:18:39 lswanson Exp $ --->
                 
    <!---
                                   redirect.cfm

         this template takes input from any form and redirects Cold
                 Fusion accordingly using CFLOCATION.
                 
    --->

<!--- Frequently called: keep at top --->
<CFIF IsDefined("Form.BackToMain.X")>
    <CFLOCATION URL="index2.cfm">
</CFIF>


<!--- Called from Dealer Admin Main Menu --->
<!--- Web Site Maintenance --->		
<CFIF IsDefined("Form.NewSearch.X")>
	<!--- Admin Access --->
	<CFIF #Left(AccessLevel,1)# EQ application.SYSADMIN_ACCESS>				
    	<CFLOCATION URL="webfind.cfm">
	<CFELSE>
    	<CFLOCATION URL="webfind2.cfm">
	</CFIF>
</CFIF>

<CFIF IsDefined("Form.WebState.X")>
	<!--- Admin Access --->
	<CFIF #Left(AccessLevel,1)# EQ application.SYSADMIN_ACCESS>				
    	<CFLOCATION URL="webstate.cfm">
	<CFELSE>
    	<CFLOCATION URL="webstate2.cfm">
	</CFIF>
</CFIF>

<CFIF IsDefined("Form.NationalOffers.X")>
	<CFLOCATION URL="offerMakes.cfm">
</CFIF>
<!--- Dealer Info Maintenance --->
<!--- called from webfind.cfm too --->
<CFIF IsDefined("Form.NewCollection.X")>
    <CFLOCATION URL="loadnew.cfm?addtype=collection">
</CFIF>

<CFIF IsDefined("Form.NewDealer.X")>
    <CFLOCATION URL="loadnew.cfm?addtype=dealer">
</CFIF>

<CFIF IsDefined("Form.DeleteCollection.X")>
	<CFLOCATION URL="deletecollection.cfm">
</CFIF>

<CFIF IsDefined("Form.DeleteDealer.X")>
	<CFLOCATION URL="deletedealer.cfm">
</CFIF>

<CFIF IsDefined("Form.Manuf.X")>
	<CFLOCATION URL="manufadmin.cfm">
</CFIF>

<!--- linda, 9/15/99: merged make & model maintenance
<CFIF IsDefined("Form.NewModel.X")>
	<CFLOCATION URL="newModelAdmin.cfm">
</CFIF>
--->

<CFIF IsDefined("Form.AddModel.X")>
	<CFLOCATION URL="pr_modeladmin.cfm">
</CFIF>

<CFIF IsDefined("Form.DeleteModel.X")>
	<CFLOCATION URL="pr_deletemodel.cfm">
</CFIF>

<CFIF IsDefined("Form.AE.X")>
    <CFLOCATION URL="loadAE.cfm">
</CFIF>

<CFIF IsDefined("Form.AC.X")>
    <CFLOCATION URL="loadAC.cfm">
</CFIF>

<CFIF IsDefined("Form.DA.X")>
    <CFLOCATION URL="loadDA.cfm">
</CFIF>

<!--- Reports --->
<CFIF IsDefined("Form.OfferMaint.X")>
    <CFLOCATION URL="offermaint.cfm">
</CFIF>

<CFIF IsDefined("Form.ViewPrint.X")>
    <CFLOCATION URL="viewprint.cfm">
</CFIF>

<CFIF IsDefined("Form.LogonReports.X")>
	<CFLOCATION URL="logons.cfm">
</CFIF>

<CFIF IsDefined("Form.TemplateReport.X")>
	<CFLOCATION URL="templatereport.cfm">
</CFIF>

<CFIF IsDefined("Form.LeadReport.X")>
	<CFLOCATION URL="leads/index.cfm?FromTemplate=redirect">
</CFIF>



<!--- Linda, 3/16/99: i don't think this gets called anymore.  if it does, change loadfind.cfm to webfind.cfm
<CFIF IsDefined("Form.FindDealer.X")>
    <CFLOCATION URL="loadfind.cfm">
</CFIF>

Linda, 3/17/99: webmodify.htm doesn't even exist anymore!
<CFIF IsDefined("Form.WebModify.X")>
    <CFLOCATION URL="webmodify.htm">
</CFIF>

Neither does entlevelreporting.htm
<CFIF IsDefined("Form.Reporting.X")>
    <CFLOCATION URL="demo/entlevelreporting.htm">
</CFIF>

<CFIF IsDefined("Form.FileUpload.X")>
    <CFLOCATION URL="../ford_upload/upload.cfm">
</CFIF>

Not called from anywhere
<CFIF IsDefined("Form.DisclaimerMaint.X")>
    ---    <CFLOCATION URL="disclaimermaint.htm">   ---
    <CFLOCATION URL="../OfferDisclaimers/di_template.cfm">
</CFIF>

although usedmaint.htm exists, it's not called from anywhere
<CFIF IsDefined("Form.UsedMaint.X")>
    <CFLOCATION URL="usedmaint.htm">
</CFIF>

although tmpmaint.cfm exists, it's not called from anywhere
<CFIF IsDefined("Form.TemplateMaint.X")>
    <CFLOCATION URL="tmpmaint.cfm">
</CFIF>

Is this intended to be in loadDA_dchoose.cfm?  It's not called via redirect.cfm.
<CFIF IsDefined("Form.loadDA_dchoose.X")>
	--- Admin Access ---
	<CFIF #Left(AccessLevel,1)# EQ application.SYSADMIN_ACCESS>				
    	<CFLOCATION URL="loadDA_dchoose.cfm">
	<CFELSE>
    	<CFLOCATION URL="loadDA_dchoose2.cfm">
	</CFIF>
</CFIF>

used to be called from webfind.cfm, calling NewCollection now instead
<CFIF IsDefined("Form.btnNew.X")>
    <CFLOCATION URL="loadnew.cfm?addtype=collection">
</CFIF>
--->
</BODY>
</HTML>