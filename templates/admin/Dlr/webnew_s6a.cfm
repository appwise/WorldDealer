<CFINCLUDE template="security.cfm">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>

    <!-- ----------------------------------------------------------- -->
    <!--                Created by sigma6, Detroit                   -->
    <!--         Copyright (c) 1997, 1998, 1999 sigma6.              -->
    <!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->

    <!-- ----------------------------------------------------------- -->
    <!--     John Turner for sigma6, interactive media, Detroit      -->
    <!--    jturner@sigma6.com   www.sigma6.com    www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
	<!--- $Id: webnew_s6a.cfm,v 1.6 1999/11/29 15:30:58 lswanson Exp $ --->
	<!--- Dealer Profile (i.e. Who We Are) --->

<!--- Linda, 8/11/99: note: don't use " within the data entry text.  It truncates the string at that point! :p
Work-around: use ' instead. --->

<HEAD>

        <TITLE>WorldDealer | Create a New Web</TITLE>

  <!--- CAREFUL, this breaks the convention of the previous pages --->
    <CFIF ParameterExists(Form.btnCancel.X)>
           <CFLOCATION URL="webvrfy_s6.cfm?dlrcode=#Form.DealerCode#">
    </CFIF>

 	<CFSET EditMode = FALSE>
	<CFSET SaveMode = FALSE>
 
	<CFIF ParameterExists(Form.btnSave.X)>
		<CFSET SaveMode = TRUE>
		<CFSET g_DealerCode=#Form.DealerCode#>
    <CFELSEIF ParameterExists(Form.btnNext.X)>
		<CFSET EditMode = TRUE>
        <CFSET g_DealerCode = #Form.DealerCode#>
    </CFIF>
	
	<CFIF #FORM.Bullet_Items# IS 'none'>
		<!---- No second paragraph --->
		<CFSET EditMode = FALSE>
		<CFSET SaveMode = TRUE>
	</CFIF>

	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>

<CFIF SaveMode>
<!--- Parse the form variables and convert the entire DealerProfile back into one HTML string --->
	<CFIF #form.bullet_items# IS 'text'>
		<!--- Check the last to chars to RETURN or LINEFEED --->
		<CFSET temp = #Right(form.section_1_text,2)#>
		<CFSET char2 = #Mid(temp,2,1)#>
		<CFSET char1 = #Mid(temp,1,1)#>

		<CFIF ((#char1# EQ #Chr(10)#) OR (#char1# EQ #Chr(13)#)) AND ((#char2# EQ #Chr(10)#) OR (#char2# EQ #Chr(13)#))>
			<CFSET final_text = #form.section_1_text# & "~~$~" & #form.section_2_text#>
		<CFELSE>	
			<CFSET final_text = #form.section_1_text# & "<BR><BR>~~$~" & #form.section_2_text#>
		</CFIF>
		<CFIF #form.yes_no# IS '1'>
			<CFSET temp = #Right(form.section_2_text,2)#>
			<CFSET char2 = #Mid(temp,2,1)#>
			<CFSET char1 = #Mid(temp,1,1)#>
			<CFIF ((#char1# EQ #Chr(10)#) OR (#char1# EQ #Chr(13)#)) AND ((#char2# EQ #Chr(10)#) OR (#char2# EQ #Chr(13)#))>
				<CFSET #final_text# = #final_text# & "~~~~" & #form.section_3_text#>
			<CFELSE>
				<CFSET #final_text# = #final_text# & "<BR><BR>~~~~" & #form.section_3_text#>
			</CFIF>
		</CFIF>

	<CFELSEIF #form.bullet_items# IS 'none'>
		<CFSET final_text = #form.section_1_text# & '~~*~'>

	<CFELSE> <!--- bullet list --->
		<CFSET #final_text# = #form.section_1_text# & '~~' & #form.bullet_items# & '~' & "<UL>" >
		<CFLOOP from=1 to=#form.bullet_items# index="count">
			<CFSET temp = #Evaluate("form.bullet_#count#")#>
			<CFSET #final_text# = #final_text# & "<LI>" & #temp#>
		</CFLOOP>
		<CFSET #final_text# = #final_text# & "</UL>" >
		<CFIF #form.yes_no# IS '1'>
			<CFSET #final_text# = #final_text# & '~~~~' & #form.section_3_text#>
		</CFIF>
		
	</CFIF>
	<!--- Replace CR's with <BR>'s --->
	<CFSET #final_text# = #Replace(final_text,Chr(13),"<BR>","ALL")#>

	
	<CFQUERY NAME="updateDLR" datasource="#gDSN#">
                     UPDATE DealerWebs
                     SET DealerProfileMainText = '#final_text#'
					 WHERE DealerWebs.DealerCode='#g_DealerCode#'
	</CFQUERY>
	<CFLOCATION URL="webvrfy_s6.cfm?dlrcode=#g_DealerCode#">
</CFIF> <!--- CFIF SaveMode --->


<CFIF EditMode>
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
        <FORM NAME="StepSix" ACTION="webnew_s6a.cfm" METHOD="post">
        <TR><TD>&nbsp;<p></TD></TR>
		<TR><TD ALIGN=CENTER><FONT FACE="arial,helvetica"><b>Portion One:</B></FONT></TD></TR>
		<TR><TD align=center>
			<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=1 WIDTH="80%">
			<TR><TD>
				<FONT FACE="arial,helvetica">
			 <CFOUTPUT>#form.section_1_text#</CFOUTPUT>
			 	</FONT>
			 </TD></TR></TABLE>
		</TD></TR>
			 <TR><TD>&nbsp;</TD></TR>
			 <CFIF #FORM.Bullet_Items# EQ 'text'>
			 	<TR><TD align=CENTER><FONT FACE="arial,helvetica">
					<b>In the space below, enter the second portion of your dealer profile</b><br>
			 	<CFIF IsDefined("Form.Section_2_text")>  <!--- Edit mode --->
				<!--- Remove white spaces at head of "Form.Section_2_text" --->
					<CFSET temp=#LTrim(Form.Section_2_text)#>
					<CFIF #Mid(temp,1,4)# IS "<UL>" >
						<CFSET #q_text# = 'Enter your text here.'>
					<CFELSE>
						<CFSET #q_text# = #form.section_2_text#>
					</CFIF>
					</FONT>
					<CFOUTPUT>
					<FONT FACE="arial,helvetica" SIZE=2>
					<textarea	 name="section_2_text"
								 cols="40"
								 rows="10"
								 wrap="PHYSICAL">#q_text#</Textarea>
					</CFOUTPUT>
					</FONT>
				<CFELSE>	<!--- New Mode --->
					<FONT FACE="arial,helvetica" SIZE=2>
					<textarea    name="section_2_text"
								cols="40"
								rows="10"
								wrap="physical">Enter your text here.</Textarea>
					</FONT>
				</CFIF>
				</TD></TR>
			<CFELSE> <!--- Bullet List --->
				<TR><TD ALIGN=CENTER><FONT FACE="arial,helvetica">
					<b>Enter the bullet items for your second portion in the spaces below.</b><p>
				<CFLOOP from=1 to=#form.bullet_items# index="count">
					<CFOUTPUT>
					<CFIF IsDefined ("form.bullet_#count#")>  <!---Editmode --->
					<CFSET temp = #Evaluate("form.bullet_#count#")#>
						Bullet Item #count#:<br> <INPUT type="text" name="bullet_#count#" value="#temp#" size="45"><br>
					<CFELSE> <!---NewMode --->
						Bullet Item #count#: <br><INPUT type="text" name="bullet_#count#" value="Item #count#" size="45"><br>
					</CFIF>
					</CFOUTPUT>
				</CFLOOP>
			</CFIF></FONT>
			</TD></TR>
			
			<CFIF #Form.Yes_No# EQ '1'>
				<TR><TD>&nbsp;</TD></TR>
				<TR><TD align=CENTER><FONT FACE="arial,helvetica">
					<b>In the space below, enter the third portion of your dealer profile.</b><br>
				<CFIF IsDefined("Form.section_3_text")>
					</FONT>
					<FONT FACE="arial,helvetica" SIZE=2>
					<CFOUTPUT>
					<TextArea name="section_3_text"
								cols="40"
								rows="10"
								wrap="physical">#Form.section_3_text#</Textarea>
					</CFOUTPUT>
					</FONT>
				<CFELSE>
					<FONT FACE="arial,helvetica" SIZE=2>
					<Textarea name="section_3_text"
							  cols="40"
							  rows="10"
							  wrap="physical">Enter your text here.</Textarea>
					</FONT>
				</CFIF>
				</TD></TR>
			</CFIF>
			
			<TR><TD>&nbsp;</TD></TR>
			<TR ALIGN="center">
            <TD>
        	<CFOUTPUT>
            <INPUT TYPE="hidden" NAME="DealerCode" VALUE=#g_DealerCode#>
			<INPUT type="hidden" name="section_1_text" value="#form.section_1_text#">
			<INPUT type="hidden" name="bullet_items" value="#form.bullet_items#">
			<INPUT type="hidden" name="Yes_No" value="#form.Yes_No#">
			</CFOUTPUT>
			<INPUT TYPE="hidden" NAME="NextStep" VALUE="webnew_s6b.cfm">
                &nbsp;&nbsp;
            <INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg" BORDER="0" NAME="btnCancel" VALUE="Cancel">
                &nbsp;&nbsp;
            <INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/saveandcontinue_nav.jpg" BORDER="0" NAME="btnSave" VALUE="Save">
                </FORM>
            <p>
                    <FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
                            <INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg" Border="0" NAME="BackToMain" VALUE="Back To Main Menu"></FORM></TD>
        </TR>
</TABLE>

</div>
			 
</CFIF>

</BODY>
</HTML>
