<CFSET webnewstep = 6>
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
	<!--- $Id: webnew_s6.cfm,v 1.6 1999/11/29 15:30:58 lswanson Exp $ --->
	<!--- Dealer Profile (i.e. Who We Are) --->


	<!-------------------------------------------------------------------
		THIS PAGE BREAKS THE CONVENTION OF CALLING ITSELF TO DETERMINE
		WHAT THE NEXT ACTION SHOULD BE.  I DID THIS BECAUSE THE FORM
		TEXTAREAS ARE TOO LONG TO PASS ON THE URL.
		THE FORM ACTION IS HARD CODED TO "WEBNEW_S6A.CFM"    -HML
	---------------------------------------------------------------------->
	
<!--- 
	Overview of symbols used here:
	~~*~ at end of 1st portion.  No 2nd or 3rd portions
	~~$~ prefaces 2nd portion.  2nd portion is in paragraph format
	~~#~ prefaces 2nd portion, where # = # of bullets in 2nd portion
	~~~~ prefaces 3rd portion
 --->
	
	
<HEAD>

    <TITLE>WorldDealer | Create a New Web</TITLE>

    <CFIF ParameterExists(Form.btnCancel.X)>
		<CFLOCATION URL="webvrfy_s6.cfm?dlrcode=#Form.DealerCode#">
    </CFIF>

	<CFSET NewMode = FALSE>
	<CFSET EditMode = FALSE>
	<CFSET SaveMode = FALSE>

    <CFIF ParameterExists(URL.dlrcode)>
           <CFSET EditMode = TRUE>
           <CFSET g_DealerCode = #URL.dlrcode#>
    <CFELSE>
           <CFSET NewMode = TRUE>
           <CFSET g_DealerCode = "">
   </CFIF>
        
	<CFIF ParameterExists(Form.btnSave.X)>
    	<CFSET SaveMode = TRUE>
        <CFSET g_DealerCode = #Form.DealerCode#>
    </CFIF>

<CFIF EditMode>
	<CFQUERY NAME="getText" datasource="#gDSN#">
			SELECT DealerProfileMainText as q_DealerProfileMainText
			FROM DealerWebs
			WHERE DealerWebs.DealerCode = '#g_DealerCode#'
	</CFQUERY>

	<CFIF #getText.q_DealerProfileMainText# EQ ''>
		<CFSET EditMode = FALSE>
		<CFSET NewMode = TRUE>
	</CFIF>     
</CFIF>

<CFIF EditMode>

	<!--- Remove <BR> tags and re-format --->
	<CFSET q_mod_dlrProfileTxt = #Replace(getText.q_DealerProfileMainText,"<BR>",Chr(13),"ALL")#>
	<!---
	Check if 2nd paragraph is blank, "paragraph", or "bullet items"
	Encoded as follows:  
	~~*~ (2) tildes followed by * (asterisk), then another tilde denotes NO second paragraph
	~~$~ (2) tildes followed by $ (dollar sign), then another tilde denotes the second "paragraph" is regular text 	(i.e. paragraph), not bullet items.
	~~#~ (2) tildes followed by the number of bullet items, then another tilde denotes a bullet list
	--->
	<CFSET section_break_1  = #Find ("~~",q_mod_dlrProfileTxt,1)#>
	<!---
		Break up q_mod_dlrProfileTxt into 1st paragraph
	--->
	<CFSET section_1_text = #Mid(q_mod_dlrProfileTxt,1, (section_break_1 - 1))#>
	<CFSET which_type = #Mid(q_mod_dlrProfileTxt,(section_break_1 + 2), 1)#>

	<CFIF #which_type# EQ '$'>
		<CFSET section_2_type = 'Paragraph'>
	<CFELSEIF #which_type# EQ '*'>
		<CFSET section_2_type = 'None'>
	<CFELSE> 
		<CFSET section_2_type='bullet'>
	</CFIF>
		
	<CFIF #section_2_type# IS NOT 'None'>
		<!---
			Find end of second paragraph (or bullets) and start of third paragraph
			Start of 3rd paragraph is marked by (4) tilde's, NO tildes if 3rd paragraph is NULL
		--->
		<CFSET section_break_2 = #Find ("~~~~",q_mod_dlrProfileTxt,1)#>
		<CFIF #section_break_2#>  <!--- Is not '0' --->
			<CFSET section_3_type = TRUE>
		<CFELSE>
			<CFSET section_3_type = FALSE>
		</CFIF>

		<CFIF section_3_type>
			<!---
			3rd paragraph exists
			Find end of 2nd paragraph
			--->
			<CFSET section_break_2 = #Find("~~~~",q_mod_dlrProfileTxt,1)#>
			<!---
				Second paragraph starts at position (section_break_1 + 4)
				Grab 2nd paragraph
			--->
			<CFIF #section_2_type# IS 'Paragraph'>
				<CFSET section_2_text = #Mid(q_mod_dlrProfileTxt,(section_break_1 + 4),(section_break_2 - section_break_1) - 4)#>
			<CFELSE>
				<!---
				bullet list
				--->
				<CFSET section_2_bullet = #Mid(q_mod_dlrProfileTxt,(section_break_1 + 4),(section_break_2 - section_break_1) - 4)#>
			</CFIF>
			<!--- Get length of q_mod_dlrProfileTxt --->
			<CFSET how_long = #Len(q_mod_dlrProfileTxt)#>
			<!--- Grab 3rd paragraph --->
			<CFSET section_3_text = #Mid(q_mod_dlrProfileTxt,(section_break_2 + 4), how_long)#>			
		<CFELSE> <!--- No 3rd paragraph --->
			<!---
			Get length of q_mod_dlrProfileTxt variable
			--->
			<CFSET how_long = #Len(q_mod_dlrProfileTxt)#>
			<CFSET section_2_bullet = #Mid(q_mod_dlrProfileTxt,(section_break_1 + 4), how_long)#>
		</CFIF>	<!--- CFIF section_3_type --->		
				
		<CFIF section_2_type EQ 'bullet'>  <!--- 2nd paragraph is bullet list --->
			<!---
				Now parse "bullet list", remove html, and create an array with each bullet item
				First, remove <UL> and </UL>
			--->
			<CFSET tmp = #Replace(section_2_bullet,"<UL>", "", "ONE")#>
			<CFSET tmp2 = #Replace(tmp,"</UL>", "", "ONE")#>
			<!---
				Now, find all <LI> tags and place that line into an Array
			--->				
			<CFSET bullet_array="#ArrayNew(1)#">
			<CFSET start_pos = 1>
			
			<CFLOOP from=1 to=6 index="count">
				<CFSET start_of_line = #Find("<LI>",tmp2,start_pos)#>
				<CFSET #next_line# = #Find("<LI>",tmp2,(start_of_line + 4))#>
				<CFIF next_line EQ 0>
					<!---
						Last bullet item
					--->
					<CFSET #bullet_array[count]# = #Mid(tmp2,(start_of_line+4),how_long)#>
					<CFSET g_count = #count#>
					<CFBREAK>
				<CFELSE>
					<CFSET #bullet_array[count]# = #Mid(tmp2,(start_of_line + 4), ((next_line - 1) - (start_of_line + 3)))#>
				</CFIF>
				<CFSET #start_pos# = #next_line#>				
			</CFLOOP>
		
		<CFELSEIF (#section_2_type# EQ 'Paragraph') AND (NOT #section_3_type#)>
					<CFSET #section_2_text# = #section_2_bullet#> 
					
		</CFIF> <!--- CFIF Section_2_type IS 'Bullet' --->

	</CFIF>  <!--- 	CFIF Section_2_type IS NOT 'None' --->

	<!---
		Initialize variable so it won't puke later
	--->
		<CFIF NOT IsDefined("g_count")>
			<CFSET g_count = '-1'>
		</CFIF>

</CFIF> <!--- CFIF EditMode --->
     
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
                  <FORM NAME="StepSix" ACTION="webnew_s6a.cfm" METHOD="post">
                  <TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0 WIDTH="100%">
			 <TR>
			 	<TD ALIGN=CENTER>
					<FONT FACE="Arial,Helvetica">
						Your dealer profile consists of up to three portions.  They will be displayed as text, in order,
						on the dealer profile page of your web site.
					</FONT>
				</TD>
			</TR>
			<TR><TD>&nbsp;<p></TD></TR>
             <TR ALIGN=center><TD><FONT FACE="arial,helvetica">
			 	<b>In the space below, enter the first portion of your dealer profile.</b><p>
				</FONT></TD></TR>
                 <CFIF EditMode>
                                   <CFOUTPUT QUERY="getText">
                 <TR ALIGN=center>
                             <TD>
							 	<FONT FACE="arial,helvetica" SIZE=2>
                                 <textarea
								 name="section_1_text"
								 cols="40"
								 rows="10"
								 wrap="PHYSICAL">#section_1_text#</textarea>
								 </FONT>
                                 </TD>
                             </TR>
		                        </CFOUTPUT>

	
							<TR><TD>&nbsp;<p></TD></TR>
				<TR ALIGN=CENTER>
					<TD><FONT FACE="Arial,Helvetica">
						In the second portion of your dealer profile, you may enter up to six "bullet items,"
						a paragraph of copy, or choose to leave it empty.
					</FONT>
					<BR>
					<FONT SIZE=2 FACE="arial,helvetica">
					<I>Please note: If you select "No Second Portion", you will not be given the option to enter a third portion.</I>
					</FONT>
					<FONT FACE="arial,helvetica">
					<p>
					<b>Please select the format for the second portion of your dealer profile:</b></FONT></TD></TR>
				<TR ALIGN=CENTER>
					<TD>
						<FONT FACE="arial,helvetica" SIZE=2>
						<SELECT name="bullet_items">
						<OPTION value="none" <CFIF #section_2_type# IS 'None'>SELECTED</CFIF>>No Second Portion</OPTION>
						<OPTION value="text" <CFIF #section_2_type# IS 'Paragraph'>SELECTED</CFIF>>Regular Text Paragraph for Second Portion</OPTION>
						<OPTION value="1" <CFIF #g_count# IS '1'>SELECTED</CFIF>>One Bullet Item </OPTION>
						<OPTION value="2" <CFIF #g_count# IS '2'>SELECTED </CFIF>>Two Bullet Items</OPTION>
						<OPTION value="3" <CFIF #g_count# IS '3'>SELECTED </CFIF>>Three Bullet Items</OPTION>
						<OPTION value="4" <CFIF #g_count# IS '4'>SELECTED </CFIF>>Four Bullet Items</OPTION>
						<OPTION value="5" <CFIF #g_count# IS '5'>SELECTED </CFIF>>Five Bullet Items</OPTION>
						<OPTION value="6" <CFIF #g_count# IS '6'>SELECTED </CFIF>>Six Bullet Items</OPTION>
						</SELECT>
						</FONT>
					</TD></TR>
                      <CFELSE> <!--- New or Save mode --->
                 <TR ALIGN=center>
                             <TD>
							 	<FONT FACE="arial,helvetica" SIZE=2>
                                 <textarea name="section_1_text" cols="40" rows="10" wrap="PHYSICAL">Enter your Dealer Profile</textarea>
								 </FONT>
                                 </TD>
                             </TR>

				<TR><TD>&nbsp;<p></TD></TR>
				<TR ALIGN=CENTER>
					<TD><FONT FACE="Arial,Helvetica">
						In the second portion of your dealer profile, you may enter up to six "bullet items,"
						a paragraph of copy, or choose to leave it empty.
					</FONT>
					<BR>
					<FONT SIZE=2 FACE="arial,helvetica">
					<I>Please note: If you select "No Second Portion", you will not be given the option to enter a third portion.</I>
					<p>
					<b>Please select how many "bullet items" you wish to enter: </b></FONT></TD></TR>
				<TR ALIGN=CENTER>
					<TD><FONT FACE="arial,helvetica" SIZE=2>
						<SELECT name="bullet_items">
						<OPTION value="none" SELECTED>No Second Portion</OPTION>
						<OPTION value="text">Regular Text Paragraph for Second Portion</OPTION>
						<OPTION value="1" >One Bullet Item </OPTION>
						<OPTION value="2">Two Bullet Items</OPTION>
						<OPTION value="3" >Three Bullet Items</OPTION>
						<OPTION value="4" >Four Bullet Items</OPTION>
						<OPTION value="5">Five Bullet Items</OPTION>
						<OPTION value="6" >Six Bullet Items</OPTION>
						</SELECT>
						</FONT>
					</TD></TR>
	
	      </CFIF>
            
             <TR><TD>&nbsp;<p></TD></TR>
			 
		<CFIF EditMode>
			<TR><TD ALIGN=center><FONT FACE="arial,helvetica">
				<b>Do you wish to enter a third portion of text for this dealer profile?</b><br>&nbsp;
				</FONT></TD></TR>
			 <TR><TD ALIGN=center><FONT FACE="arial,helvetica">
			 	<b>Yes</b>&nbsp;<INPUT
			 		type="radio"
					name="yes_no"
					value="1" <CFIF IsDefined("section_3_text")> CHECKED </CFIF>>&nbsp;&nbsp;&nbsp;&nbsp;
			 <b>No</b>&nbsp;<INPUT
			 		type="radio"
					name="yes_no"
					value="0" <CFIF NOT IsDefined("section_3_text")> CHECKED </CFIF>>
				</FONT>
			 </TD></TR>
		<CFELSE> <!--- NewMode or SaveMode --->
			 <TR><TD ALIGN=center><FONT FACE="arial,helvetica">
			 	<b>Do you wish to enter a third portion of text for this dealer profile?</b><br>&nbsp;
				</FONT></TD></TR>
			 <TR><TD ALIGN=center><FONT FACE="arial,helvetica">
			 	<b>Yes</b>&nbsp;<INPUT type="radio" name="yes_no" value="1" CHECKED>&nbsp;&nbsp;&nbsp;&nbsp;
			 <b>No</b>&nbsp;<INPUT type="radio" name="yes_no" value="0">
			 </FONT>
			 </TD></TR>
		</CFIF>
			 <TR><TD>&nbsp;<p></TD></TR>
                  </TABLE>
                </TD>
        </TR>
        <TR ALIGN="center">
            <TD>
        <CFOUTPUT>
            <INPUT TYPE="hidden" NAME="DealerCode" VALUE=#g_DealerCode#>
			<CFIF IsDefined("section_2_text")>
				<INPUT type="hidden" name="section_2_text" value="#section_2_text#">
			</CFIF>
			
			<CFIF IsDefined("section_3_text")>
				<INPUT type="hidden" name="section_3_text" value="#section_3_text#">
			</CFIF>
		</CFOUTPUT>
			<CFIF IsDefined ("bullet_array")>
				<CFLOOP from=1 to=#count# index="count2">
					<CFOUTPUT>
					<INPUT type="hidden" name="bullet_#count2#" value="#bullet_array[count2]#">
					</CFOUTPUT>
				</CFLOOP>
			</CFIF>			
            <INPUT TYPE="hidden" NAME="NextStep" VALUE="webnew_s6a.cfm">
                &nbsp;&nbsp;
            <INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg" BORDER="0" NAME="btnCancel" VALUE="Cancel">
                &nbsp;&nbsp;
            <INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next_nav.jpg" BORDER="0" NAME="btnNext" VALUE="Next">
                </FORM>
            <p>
                    <FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
                            <INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg" Border="0" NAME="BackToMain" VALUE="Back To Main Menu"></FORM></TD>
        </TR>
</TABLE>

</div>

</BODY>

</HTML>