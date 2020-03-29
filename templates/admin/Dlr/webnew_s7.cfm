<CFSET webnewstep = 7>
<CFINCLUDE template="security.cfm">

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>

    <!-- ----------------------------------------------------------- -->
    <!--       Created by sigma6, Detroit       -->
    <!--         Copyright (c) 1997, 1998, 1999 sigma6.              -->
    <!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->

    <!-- ----------------------------------------------------------- -->
    <!--     John Turner for sigma6, interactive media, Detroit      -->
    <!--    jturner@sigma6.com   www.sigma6.com    www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
	<!--- $Id: webnew_s7.cfm,v 1.8 1999/11/29 15:30:59 lswanson Exp $ --->
	<!--- Why We Are Different - Showroom, Pre-Owned, Quote, Service --->

<HEAD>

        <TITLE>WorldDealer | Create a New Web</TITLE>

    	<CFIF ParameterExists(URL.dlrcode)>
           <CFSET g_DealerCode = #URL.dlrcode#>
           <CFSET EditMode = TRUE>
           <CFSET NewMode = FALSE>
        <CFELSE>
           <CFSET NewMode = TRUE>
           <CFSET EditMode = FALSE>
        </CFIF>
        
        <CFIF ParameterExists(Form.btnSave.X)>
           <CFSET SaveMode = TRUE>
           <CFSET g_DealerCode = #Form.DealerCode#>
		<CFELSE>
           <CFSET SaveMode = FALSE>		
        </CFIF>

    	<CFIF ParameterExists(Form.btnCancel.X)>
			<CFSET CancelMode = TRUE>
			<CFLOCATION URL="webvrfy_s7.cfm?dlrcode=#Form.DealerCode#">
        </CFIF>

<CFIF EditMode>
    <CFQUERY NAME="getText" datasource="#gDSN#">
            SELECT OffersSetApartText,
                   VehicleInqSetApartText1,
                   ServiceInqSetApartText2,
				   PreOwnedSetApartText
            FROM DealerWebs
            WHERE DealerWebs.DealerCode = '#g_DealerCode#'
    </CFQUERY>

	<!--- Remove <BR> tags and re-format --->
	<CFSET q_OffersSetApartText = #Replace(getText.OffersSetApartText,"<BR>",Chr(13),"ALL")#>
	<CFSET q_PreOwnedSetApartText = #Replace(getText.PreOwnedSetApartText,"<BR>",Chr(13),"ALL")#>
	<!--- If it's a collection, skip Quote and Service Page sections --->
	<CFIF Mid(#g_DealerCode#, 6,4) GT '0000'>	
		<CFSET q_VehicleInqSetApartText = #Replace(getText.VehicleInqSetApartText1,"<BR>",Chr(13),"ALL")#>
		<CFSET q_ServiceInqSetApartText = #Replace(getText.ServiceInqSetApartText2,"<BR>",Chr(13),"ALL")#>
	</CFIF>
</CFIF>

<CFIF SaveMode>
	<!--- Replace Carriage Return with <BR> --->
	<CFSET r_OffersSetApartText = #Replace(FORM.OffersSetApartText,Chr(13),"<BR>","ALL")#>
	<CFSET r_PreOwnedSetApartText = #Replace(FORM.PreOwnedSetApartText,Chr(13),"<BR>","ALL")#>
	<!--- If it's a collection, skip Quote and Service Page sections --->
	<CFIF Mid(#g_DealerCode#, 6,4) GT '0000'>
		<CFSET r_VehicleInqSetApartText = #Replace(FORM.VehicleInqSetApartText,Chr(13),"<BR>","ALL")#>
		<CFSET r_ServiceInqSetApartText = #Replace(FORM.ServiceInqSetApartText,Chr(13),"<BR>","ALL")#>
	</CFIF>
	
	<CFQUERY name="UpdateDealer" datasource="#gDSN#">
		UPDATE DealerWebs
		SET 
			<CFIF #r_OffersSetApartText# IS "Please enter your text here.">
				OffersSetApartText = ''
			<CFELSE>
				OffersSetApartText = '#r_OffersSetApartText#'
			</CFIF>
			,
			<CFIF #r_PreOwnedSetApartText# IS "Please enter your text here.">
				PreOwnedSetApartText = ''
			<CFELSE>
				PreOwnedSetApartText = '#r_PreOwnedSetApartText#'
			</CFIF>
			<!--- If it's a collection, skip Quote and Service Page sections --->
			<CFIF Mid(#g_DealerCode#, 6,4) GT '0000'>
				,
				<CFIF #r_VehicleInqSetApartText# IS "Please enter your text here.">
					VehicleInqSetApartText1 = ''
				<CFELSE>
					VehicleInqSetApartText1 = '#r_VehicleInqSetApartText#'
				</CFIF>
				,
				<CFIF #r_ServiceInqSetApartText# IS "Please enter your text here.">
					ServiceInqSetApartText2 = ''
				<CFELSE>
					ServiceInqSetApartText2 = '#r_ServiceInqSetApartText#'
				</CFIF>
			</CFIF>
		WHERE DealerCode='#g_dealercode#'
	</CFQUERY>
	<CFLOCATION URL="webvrfy_s7.cfm?dlrcode=#g_DealerCode#">
</CFIF>

	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>

<body>
<br><br><br><br><br>

<div align="center">
<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
<TR ALIGN="center">
	<TD ALIGN="middle"><h3><font face="Arial,Helvetica">Dealer Administration - Create a New Web</font></h3></TD>
</TR>
<TR ALIGN="center">
	<TD ALIGN="middle"><font face="Arial,Helvetica">Enter the following information.  Required fields are bolded.</font></TD>
</TR>
<TR><TD>&nbsp;<p></TD></TR>
<TR>
	<TD>
    	<FORM NAME="StepSix" ACTION="webnew_s7.cfm" METHOD="post">
        <TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0 WIDTH="100%">
		<TR><TD>&nbsp;<p></TD></TR>
		
		<!--- Why We Are Different - Showroom --->
        <TR ALIGN=center>
			<TD>
				<FONT FACE="arial,helvetica"><b>
				In the space below, enter a brief profile for this dealer's<BR>Showroom Page "Why We Are Different" text.
				</FONT></b><p>
			</TD>
		</TR>
       	<TR ALIGN=center>
           	<TD>
				<FONT FACE="arial,helvetica" SIZE=2>
				<!--- insanely enough, this has to be in one long string, otherwise it puts spaces in front of the text. --->
				<textarea name="OffersSetApartText" cols="40" rows="10" wrap="PHYSICAL"><CFIF EditMode><CFOUTPUT QUERY="getText"><CFIF #RTrim(q_OffersSetApartText)# IS NOT "">#q_OffersSetApartText#<CFELSE>Please enter your text here.</cfif></CFOUTPUT><CFELSE>Please enter your text here.</CFIF></textarea>
				</FONT>
			</TD>
        </TR>
		<TR><TD>&nbsp;<p></TD></TR>
		
		<!--- Why We Are Different - Pre-Owned --->
        <TR ALIGN=center>
			<TD>
				<FONT FACE="arial,helvetica"><b>
				In the space below, enter a brief profile for this dealer's<BR>Pre-Owned Page "Why We Are Different" text.
				</FONT></b><p>
			</TD>
		</TR>
       	<TR ALIGN=center>
           	<TD>
				<FONT FACE="arial,helvetica" SIZE=2>
				<!--- insanely enough, this has to be in one long string, otherwise it puts spaces in front of the text. --->
				<textarea name="PreOwnedSetApartText" cols="40" rows="10" wrap="PHYSICAL"><CFIF EditMode><CFOUTPUT QUERY="getText"><CFIF #RTrim(q_PreOwnedSetApartText)# IS NOT "">#q_PreOwnedSetApartText#<CFELSE>Please enter your text here.</cfif></CFOUTPUT><CFELSE>Please enter your text here.</CFIF></textarea>
				</FONT>
			</TD>
        </TR>
		<TR><TD>&nbsp;<p></TD></TR>
		
		<!--- If it's a collection, skip Quote and Service Page sections --->
		<CFIF Mid(#g_DealerCode#, 6,4) GT '0000'>
			<!--- Why We Are Different - Quote Request --->
    	    <TR ALIGN=center>
				<TD>
					<FONT FACE="arial,helvetica"><b>
					In the space below, enter a brief profile for this dealer's<BR>Quote Request Page "Why We Are Different" text.</b><p>
					</FONT>
				</TD>
			</TR>
	       	<TR ALIGN=center>
    	       	<TD>
					<FONT FACE="arial,helvetica" SIZE=2>
					<!--- insanely enough, this has to be in one long string, otherwise it puts spaces in front of the text. --->
                	<textarea name="VehicleInqSetApartText" cols="40" rows="10" wrap="PHYSICAL"><CFIF EditMode><CFOUTPUT QUERY="getText"><CFIF #RTrim(#q_VehicleInqSetApartText#)# IS NOT "">#q_VehicleInqSetApartText#<CFELSE>Please enter your text here.</cfif></CFOUTPUT><CFELSE>Please enter your text here.</cfif></textarea>
				
					<!--- For visual-sake: here's the nice layout of the above long string.                
					<textarea name="VehicleInqSetApartText" cols="40" rows="10" wrap="PHYSICAL">
					<CFIF EditMode>
						<CFOUTPUT QUERY="getText">
						<CFIF #RTrim(#q_VehicleInqSetApartText#)# IS NOT "">
							#q_VehicleInqSetApartText#
						<CFELSE>
						Please enter your text here.
						</cfif>
						</CFOUTPUT>
		    	    <CFELSE>
						Please enter your text here.
					</cfif>
					</textarea>
					--->				
				 
 					</FONT>
				</TD>
    	    </TR>
        	<TR><TD>&nbsp;<p></TD></TR>
				
			<TR ALIGN=center>
				<TD>
					<FONT FACE="arial,helvetica"><b>
				 	In the space below, enter a brief profile for this dealer's<BR>Service Page "Why We Are Different" text.</b><p>
					</FONT>
				</TD>
			</TR>
       		<TR ALIGN=center>
           		<TD>
					<FONT FACE="arial,helvetica" SIZE=2>
					<!--- insanely enough, this has to be in one long string, otherwise it puts spaces in front of the text. --->					
					<textarea name="ServiceInqSetApartText" cols="40" rows="10" wrap="PHYSICAL"><CFIF EditMode><CFOUTPUT QUERY="getText"><CFIF #RTrim(#q_ServiceInqSetApartText#)# IS NOT "">#q_ServiceInqSetApartText#<CFELSE>Please enter your text here.</cfif></CFOUTPUT><CFELSE>Please enter your text here.</cfif></textarea>
					
					<!--- For visual-sake: here's the nice layout of the above long string.                				
					<textarea name="ServiceInqSetApartText" cols="40" rows="10" wrap="PHYSICAL">
		        	<CFIF EditMode>
						<CFOUTPUT QUERY="getText">
						<CFIF #RTrim(#q_ServiceInqSetApartText#)# IS NOT "">
							#q_ServiceInqSetApartText#
						<CFELSE>
							Please enter your text here.
						</cfif>
						</CFOUTPUT>
			        <CFELSE>
						Please enter your text here.
					</cfif>
					</textarea>
					--->					
 					</FONT>
				</TD>
           	</TR>                           
	        <TR><TD>&nbsp;<p></TD></TR>
		</CFIF>
		
        </TABLE>
    </TD>
</TR>
<TR ALIGN="center">
	<TD>
    	<CFOUTPUT>
		<INPUT TYPE="hidden" NAME="DealerCode" VALUE=#g_DealerCode#>
		</CFOUTPUT>
        <INPUT TYPE="hidden" NAME="NextStep" VALUE="webnew_s7.cfm">
        &nbsp;&nbsp;
        <INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg" BORDER="0" NAME="btnCancel" VALUE="Cancel">
        &nbsp;&nbsp;
        <INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/saveandcontinue_nav.jpg" BORDER="0" NAME="btnSave" VALUE="Save">
        </FORM>
        <p>
        <FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
        <INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg" Border="0" NAME="BackToMain" VALUE="Back To Main Menu">
		</FORM>
	</TD>
</TR>
</TABLE>

</div>

</BODY>
</HTML>