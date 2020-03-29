<CFSET webnewstep = 4>
<CFINCLUDE template="security.cfm">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>

    <!-- ----------------------------------------------------------- -->
    <!--             Created by sigma6, Detroit                      -->
    <!--         Copyright (c) 1997, 1998, 1999 sigma6.              -->
    <!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->

    <!-- ----------------------------------------------------------- -->
    <!--     Howard Levine for sigma6, interactive media, Detroit    -->
    <!--                cleaned up by Warren Lapham                  -->
    <!--    wlapham@sigma6.com   www.sigma6.com    www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
	<!--- $Id: webnew_s4.cfm,v 1.7 1999/11/29 15:30:58 lswanson Exp $ --->
	<!--- Select a Template --->


<HEAD>

        <TITLE>WorldDealer | Create a New Web</TITLE>

    <CFIF ParameterExists(Form.TemplatePreview.X)>
<!--- 		<CFSET tmpURL="#g_relpath#/templates/admin/dlr/preview/preview_" & #Form.ArtTemplateID# & ".cfm?dealercode=" & #form.dealercode# & "&calculator=" & #form.calculator#> --->
		<CFSET tmpURL="#g_relpath#/templates/admin/dlr/preview/preview.cfm?dealercode=" & #form.dealercode# & "&TemplateLocation=" & #Form.TemplateLocation# & "&calculator=" & #form.calculator#>
	    <CFLOCATION URL="#tmpURL#">
	</CFIF>

	<CFIF ParameterExists(Form.btnCancel.X)>
         <CFLOCATION URL="webvrfy_s4.cfm?dlrcode=#Form.DealerCode#">
    </CFIF>

    <CFSET NewMode = FALSE>
    <CFSET EditMode = FALSE>
 	<CFSET ReturnMode = FALSE>
	<CFSET ConfirmMode = FALSE>
    <CFSET SaveMode = FALSE>

	<CFIF ParameterExists(URL.new)>
		<CFSET g_DealerCode = #URL.dlrcode#>
        <CFSET NewMode = TRUE>
    </CFIF>
        
    <CFIF ParameterExists(URL.dlrcode)>
		<CFSET g_DealerCode = #URL.dlrcode#>
        <CFSET EditMode = TRUE>
    </CFIF>
	
	<!--- the only diff between ReturnMode & EditMode is that ReturnMode captures the values the user selected (Form.variables), but it isn't stored in the db yet. --->
	<CFIF ParameterExists(Form.BtnReturn)>
		<CFSET g_DealerCode = #form.dealercode#>
		<CFSET ReturnMode = TRUE>
	</CFIF>
	
	<CFIF ParameterExists(Form.btnConfirm.X)>
		<CFSET g_DealerCode = #Form.DealerCode#>
		<CFSET ConfirmMode = TRUE>
	</CFIF>
		
    <CFIF ParameterExists(Form.btnSave.X)>
        <CFSET g_DealerCode = #Form.DealerCode#>
		<CFSET SaveMode = TRUE>
    </CFIF>

    <CFIF NewMode OR EditMode OR ReturnMode>
		<CFQUERY NAME="getDealerName" datasource="#gDSN#">
              SELECT DealershipName as q_DealershipName
                FROM Dealers
               WHERE Dealers.DealerCode = '#g_DealerCode#'
		</CFQUERY>

		<!--- to determine whether to show the custom Ford or Chevy templates --->		
		<CFQUERY NAME = "getDealerFranchise" DATASOURCE = "WorldDlr">
			SELECT	MakeNumber
			FROM	DealerFranchise
			WHERE	DealerFranchise.DF_Number = #Val(Mid(g_dealercode, 11, 3))#
		</cfquery>
		<CFSET Ford = "no">
		<CFSET Chevy = "no">
		<CFIF getDealerFranchise.RecordCount EQ 1>
		<CFLOOP query="getDealerFranchise">
			<CFIF #MakeNumber# EQ 1>
				<CFSET Ford = "yes">
			<CFELSEIF #MakeNumber# EQ 12>
				<CFSET Chevy = "yes">
			</cfif>
		</cfloop>
		</cfif>
			
		<CFQUERY NAME="getDLRTemplate" datasource="#gDSN#">
		      SELECT ArtTempID as q_DLRTemplate,
			  		 CalculatorYesNo,
					 BodyShopYesNo
			    FROM DealerWebs
			   WHERE DealerWebs.DealerCode = '#g_DealerCode#'
		</CFQUERY>
		   
        <CFQUERY NAME="getTemplates" datasource="#gDSN#">
              SELECT TemplateLocation,
                     Description as q_Description
              FROM ArtTemplates
			  ORDER BY TemplateLocation
        </CFQUERY>
    </CFIF>
        
    <CFIF SaveMode>
		<CFQUERY NAME="updateDLR" datasource="#gDSN#">
          UPDATE DealerWebs
          SET 	DealerWebs.ArtTempID = #Form.TemplateLocation#,
				DealerWebs.CalculatorYesNo = '#Form.Calculator#'
          WHERE DealerWebs.DealerCode = '#g_DealerCode#'
         </CFQUERY>

         <CFLOCATION URL="webvrfy_s4.cfm?dlrcode=#g_dealercode#">
	</CFIF>

	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>

<body>
<br><br><br><br><br>

<CFIF NewMode OR EditMode OR ReturnMode>
	<div align="center">
	<table width="410" border="0" cellspacing="0" cellpadding="0" bgcolor="#FFFFFF">
        <TR><TD>&nbsp;<p></TD></TR>
        <TR ALIGN="center">
                <TD ALIGN="middle"><h3><font face="Arial,Helvetica">Dealer Administration - Create a New Web</font></h3></TD>
        </TR>
        <TR ALIGN="center">
                <TD ALIGN="middle"><h4><font face="Arial,Helvetica">Select a template for <CFOUTPUT QUERY="getDealerName"><i>#q_DealershipName#</i></CFOUTPUT></font></h4></TD>
        </TR>
        <TR ALIGN="center">
                <TD ALIGN="middle"><font face="Arial,Helvetica">Select a template from the choices below.  To see a preview of your selection,
                click the 'Preview' button.</font></TD>
        </TR>
        <TR><TD>&nbsp;<p></TD></TR>
        <FORM NAME="StepFour" ACTION="webnew_s4.cfm" METHOD="post">
		<TR ALIGN=middle>
        	<TD>
            	<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH="100%">
			    	<CFLOOP QUERY="getTemplates">
						<!--- template 1 = custom for Weikert Ford or any other Ford dealerships --->
						<!--- template 2 = custom for Chevy dealerships --->
						<CFIF #TemplateLocation# GT 2 
							OR (#TemplateLocation# EQ 1 AND #Ford# EQ "yes")
							OR (#TemplateLocation# EQ 2 AND #Chevy# EQ "yes")> 
							<!---Linda, 5/5/99: The Down Home template (template 2) is Messner's property per Anna.
							Don't allow WD to choose it until further notice.  
							5/17/99: We have approval from Messner per RZ to use all their templates! --->
		                   	<TR ALIGN="center">
    	                    	<TD ALIGN="right"><FONT FACE="arial,helvetica">
									<CFOUTPUT>
									<CFIF NewMode>
										<INPUT TYPE="radio" VALUE="#TemplateLocation#" NAME="TemplateLocation"<CFIF #TemplateLocation# EQ 1> CHECKED</CFIF>>
				   	            	<CFELSEIF EditMode>
										<INPUT TYPE="radio" VALUE="#TemplateLocation#" NAME="TemplateLocation"<CFIF #TemplateLocation# EQ #getDLRTemplate.q_DLRTemplate#> CHECKED</CFIF>>
									<CFELSEIF ReturnMode>
										<INPUT TYPE="radio" VALUE="#TemplateLocation#" NAME="TemplateLocation"<CFIF #TemplateLocation# EQ #form.ArtTemplate#> CHECKED</CFIF>>
									</CFIF>
									</CFOUTPUT>
									</FONT>
								</TD>
        	                    <TD>&nbsp;&nbsp;</TD>
            	                <TD ALIGN="left">
								  	<FONT FACE="arial,helvetica"><CFOUTPUT>#q_Description#</CFOUTPUT></FONT>
								</TD>
                    		</TR>
						</cfif>
 					</CFLOOP>
				</TABLE>
            </TD>
        </TR>
        <TR><TD>&nbsp;<p></TD></TR>
	    <TR ALIGN=middle>
            <TD>
				<FONT FACE="arial,helvetica">
                  Would this dealer like to include a Payment Calculator on their website?<p>
				<CFIF NewMode>
					<INPUT TYPE="radio" VALUE="Y" NAME="Calculator" CHECKED>Yes&nbsp;&nbsp;
					<INPUT TYPE="radio" VALUE="N" NAME="Calculator">No
				<CFELSEIF EditMode>
					<!--- NEQ 'N' captures if it's Y or blank, defaults to Y. --->
					<INPUT TYPE="radio" VALUE="Y" Name="Calculator" <CFIF #GetDLRTemplate.CalculatorYesNo# NEQ 'N'>CHECKED</CFIF>>Yes&nbsp;&nbsp;
					<INPUT TYPE="radio" VALUE="N" Name="Calculator" <CFIF #getDLRTemplate.CalculatorYesNo# EQ 'N'>CHECKED</CFIF>>No
				<CFELSEIF ReturnMode>
					<INPUT TYPE="radio" VALUE="Y" Name="Calculator" <CFIF #Form.Calculator# EQ 'Y'>CHECKED</CFIF>>Yes&nbsp;&nbsp;
					<INPUT TYPE="radio" VALUE="N" Name="Calculator" <CFIF #Form.Calculator# EQ 'N'>CHECKED</CFIF>>No
				</CFIF>
				</FONT>
			</TD></TR>
		 <!--- these are all compacted for spacing concerns--->
		<tr align="CENTER" valign="MIDDLE"><td align="CENTER" valign="MIDDLE"><br></TD></TR>

   		<tr align="CENTER" valign="MIDDLE"><td align="CENTER" valign="MIDDLE"><INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/preview.jpg" BORDER="0" NAME="TemplatePreview" VALUE="Preview"></TD></TR>
	
		<tr align="CENTER" valign="MIDDLE"><td align="CENTER" valign="MIDDLE">&nbsp;<br></TD></TR>

		<tr align="CENTER" valign="MIDDLE"><td align="CENTER" valign="MIDDLE"><INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg" BORDER="0" NAME="btnCancel" VALUE="Cancel"></TD></TR><tr align="CENTER" valign="MIDDLE"><td align="CENTER" valign="MIDDLE">&nbsp;<br></TD></TR>

       	<tr align="CENTER" valign="MIDDLE"><td align="CENTER" valign="MIDDLE"><input type="Image" name="btnConfirm" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next_nav.jpg" border="0" vspace="0" hspace="0"></TD></TR>

		<tr align="CENTER" valign="MIDDLE"><td align="CENTER" valign="MIDDLE">&nbsp;<br></TD></TR>
		
		<CFOUTPUT><input type="Hidden" name="DealerCode" value="#g_DealerCode#"></CFOUTPUT>
		<INPUT TYPE="hidden" NAME="NextStep" VALUE="webnew_s5.cfm"></FORM>
		<TR ALIGN="center"><td align="CENTER"><FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post"><INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg" Border="0" NAME="BackToMain" VALUE="Back To Main Menu"></FORM></TD></TR>
	</TABLE>
</CFIF>
<!--- Linda, 5/4/99: merged code with NewMode & EditMode code
<CFIF ReturnMode>

          <CFQUERY NAME="getDealerName" datasource="#gDSN#">
              SELECT DealershipName as q_DealershipName
                    FROM Dealers
                   WHERE Dealers.DealerCode = '#g_dealercode#'
           </CFQUERY>
		   
		   	<CFQUERY NAME="getDLRTemplate" datasource="#gDSN#">
		      SELECT ArtTempID as q_DLRTemplate,
			  		CalculatorYesNo,BodyShopYesNo
			    FROM DealerWebs
			   WHERE DealerWebs.DealerCode = '#g_dealercode#'
		   </CFQUERY>

		   
		  <CFQUERY NAME="getTemplates" datasource="#gDSN#">
              SELECT ArtTempID as q_ArtTempID,
                         Description as q_Description
                    FROM ArtTemplates
           </CFQUERY>

<div align="center">
<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
        <TR><TD>&nbsp;<p></TD></TR>
        <TR ALIGN="center">
                <TD ALIGN="middle"><h3><font face="Arial,Helvetica">Dealer Administration - Create a New Web</font></h3></TD>
        </TR>
        <TR ALIGN="center">
                <TD ALIGN="middle"><h4><font face="Arial,Helvetica">Select a template for <CFOUTPUT QUERY="getDealerName"><i>#q_DealershipName#</i></CFOUTPUT></font></h4></TD>
        </TR>
        <TR ALIGN="center">
                <TD ALIGN="middle"><font face="Arial,Helvetica">Select a template from the choices below.  To see a preview of your selection,
                click the 'Preview' button.</font></TD>
        </TR>
        <TR><TD>&nbsp;<p></TD></TR>
        <FORM NAME="StepFour" ACTION="webnew_s4.cfm" METHOD="post">   
        <TR ALIGN=middle>
            <TD>
               <TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH="100%">
                   
				       <CFLOOP QUERY="getTemplates">
                           <TR ALIGN="center">
                            <TD ALIGN="right"><FONT FACE="arial,helvetica">
							  	<CFIF #q_ArtTempID# EQ #form.ArtTemplate#>
									<INPUT TYPE="radio" VALUE=<CFOUTPUT>#q_ArtTempID#</CFOUTPUT> NAME="ArtTemplateID" CHECKED>
								<CFELSE>
									<INPUT TYPE="radio" VALUE=<CFOUTPUT>#q_ArtTempID#</CFOUTPUT> NAME="ArtTemplateID">
								</CFIF>
								</FONT>
							</TD>
                                  <TD>&nbsp;&nbsp;</TD>
                                  <TD ALIGN="left">
								  	<FONT FACE="arial,helvetica"><CFOUTPUT>#q_Description#</CFOUTPUT></FONT>
									</TD>
                           </TR>
					   </CFLOOP>
               </TABLE>
            </TD>
        </TR>
        <TR><TD>&nbsp;<p></TD></TR>
    <TR ALIGN=middle>
            <TD>
				<FONT FACE="arial,helvetica">
                  Would this dealer like to include a Payment Calculator on their website?<p>
					<INPUT TYPE="radio" VALUE="Y" Name="Calculator" <CFIF #Form.Calculator# EQ 'Y'>CHECKED</CFIF>>Yes&nbsp;&nbsp;
					<INPUT TYPE="radio" VALUE="N" Name="Calculator" <CFIF #Form.Calculator# EQ 'N'>CHECKED</CFIF>>No
				</FONT>
			</TD></TR>
        <TR ALIGN=middle>
            <TD>
                  <TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0 WIDTH="100%">
             <TR><TD>&nbsp;<p></TD></TR>
             <TR ALIGN=center><TD>
			 	<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/preview.jpg" BORDER="0" NAME="TemplatePreview" VALUE="Preview"></TD></TR>
                  </TABLE>
                </TD>
        </TR>
        <TR><TD>&nbsp;<p></TD></TR>
        <TR ALIGN="center">
            <TD>
                <CFOUTPUT>
                    <INPUT TYPE="hidden" NAME="DealerCode" VALUE=#g_DealerCode#>
                        </CFOUTPUT>
                    <INPUT TYPE="hidden" NAME="NextStep" VALUE="webnew_s5.cfm">
                        &nbsp;&nbsp;
                    <INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg" BORDER="0" NAME="btnCancel" VALUE="Cancel">
                        &nbsp;&nbsp;
                    <INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next_nav.jpg" BORDER="0" NAME="btnConfirm" VALUE="Next">
                        </FORM>
                    <p>
                    <FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
                            <INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg" Border="0" NAME="BackToMain" VALUE="Back To Main Menu"></FORM>
					</TD>
        </TR>
</TABLE>


</CFIF>
 --->

<CFIF ConfirmMode>

	<CFQUERY NAME="getDealerName" datasource="#gDSN#">
		SELECT DealershipName as q_DealershipName
        FROM Dealers
        WHERE Dealers.DealerCode = '#g_dealercode#'
    </CFQUERY>

	<CFQUERY name="GetTemplate" datasource="#gDSN#">
		SELECT Description
		FROM ArtTemplates
		WHERE TemplateLocation = #Form.TemplateLocation#
	</CFQUERY>

<div align="center">
<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
        <TR><TD>&nbsp;<p></TD></TR>
        <TR ALIGN="center">
                <TD ALIGN="middle"><h3><font face="Arial,Helvetica">Dealer Administration - Create a New Web</font></h3></TD>
        </TR>
        <TR ALIGN="center">
                <TD ALIGN="middle"><h4><font face="Arial,Helvetica">Select a template for <CFOUTPUT QUERY="getDealerName"><i>#q_DealershipName#</i></CFOUTPUT></font></h4></TD>
        </TR>
		<TR><TD>&nbsp;</TD></TR>
		<CFOUTPUT query="GetTemplate">
		<TR><TD ALIGN="center"><FONT Face="Arial,Helvetica">The <b>#Description#</b> Splash Page Logo below has been created for your web site.</FONT></TD></TR>
</CFOUTPUT>
<TR><TD>&nbsp;</TD></TR>
<CFOUTPUT>
<TR><TD align="center"><IMG SRC="#g_relpath#/images/sp_logo/sp_#g_dealercode#_#form.TemplateLocation#_hea.gif"></TD></TR>
</CFOUTPUT>
<TR><TD>&nbsp;</TD></TR>
<TR><TD align="center"><FONT Face="Arial,Helvetica">Click <b>Save and Continue</b> to accept this Art Template.<br>
Click <b>Cancel</b> to choose another Art Template.</FONT></TD></TR>
<TR><TD>&nbsp;</TD></TR>
<FORM action="webnew_s4.cfm" method="post">
<CFOUTPUT>
<INPUT type="hidden" name="Calculator" value="#FORM.Calculator#">
<INPUT type="hidden" name="TemplateLocation" value="#Form.TemplateLocation#">
<INPUT type="hidden" name="DealerCode" value="#g_DealerCode#">
</CFOUTPUT>
<TR><TD align="center"><INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg" BORDER="0" NAME="btnCancel" VALUE="Cancel">
&nbsp;&nbsp;&nbsp;<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/saveandcontinue_nav.jpg" BORDER="0" name="btnSave" value="Save">
</TD></TR>
</FORM>
<TR><TD>&nbsp;</TD></TR>
<FORM action="redirect.cfm" method="post">
<TR><TD align="center"><INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg"
			Border="0"
			NAME="BackToMain"
			VALUE="Back To Main Menu">
</TD></TR>
</FORM>
<TR><TD>&nbsp;</TD></TR>
</TABLE>

</CFIF>



</div>

</BODY>
</HTML>