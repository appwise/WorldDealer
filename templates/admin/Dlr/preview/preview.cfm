<!-- ----------------------------------------------------------- -->
<!--                 Created by Sigma6, Inc.                     -->
<!--             Copyright (c) 1998 Sigma6, Inc.                 -->
<!--         All Rights Reserved.  Used By Permission.           -->
<!-- ----------------------------------------------------------- -->
<!-- ----------------------------------------------------------- -->
<!--           Sigma6, interactive media, Detroit/NYC            -->
<!--               conceive : construct : connect                -->
<!--   www.sigma6.com   webmaster@sigma6.com   info@sigma6.com   -->
<!--                                                             -->
<!--   Last updated: <January 14, 1999>                          -->
<!-- ----------------------------------------------------------- -->
<!--   Linda Swanson for sigma6, interactive media, Detroit      -->
<!--   lswanson@sigma6.com   www.sigma6.com    www.s6313.com     -->
<!--               conceive : construct : connect                -->
<!-- ----------------------------------------------------------- -->
<!-- ----------------------------------------------------------- -->
<!-- Sigma6, s6, and the Sigma6 logos are registered trademarks. -->
<!-- All other trademarks and servicemarks are the property of   -->
<!-- their respective owners.                                    -->
<!-- ----------------------------------------------------------- -->
<!--- $Id: preview.cfm,v 1.6 1999/11/24 22:14:13 lswanson Exp $ --->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>

<HEAD>
        <TITLE><CFOUTPUT QUERY="dealerinfo">#dealershipname#</CFOUTPUT></TITLE>
</HEAD>

<CFOUTPUT>
<CFINCLUDE TEMPLATE="global_#url.TemplateLocation#.htm">
</CFOUTPUT>


<A NAME="top">  

<TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0>
<TR>
    <TD VALIGN=TOP rowspan="2" WIDTH=115>

		<TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0>
		<TR>
			<TD valign="bottom" ALIGN="CENTER">
				<IMG
				SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/logo/<CFOUTPUT>#URL.dealercode#</CFOUTPUT>_<CFOUTPUT>#url.TemplateLocation#</CFOUTPUT>_logo_hea.gif"
        		BORDER=0
		        ALT="<CFOUTPUT>#dealerinfo.dealershipname#</CFOUTPUT>"></TD></TR>
		<TR><TD VALIGN="TOP" align="center">
				<IMG
		        SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/<CFOUTPUT>#url.TemplateLocation#</CFOUTPUT>/nav_sh_nav.gif"
		        BORDER=0
		        ALT="Browse Our Showroom"><BR><IMG
		        SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/<CFOUTPUT>#url.TemplateLocation#</CFOUTPUT>/nav_pr_nav.gif"
		        BORDER=0
		        ALT="Our Pre-Owned Inventory"><BR><IMG
		        SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/<CFOUTPUT>#url.TemplateLocation#</CFOUTPUT>/nav_qu_nav.gif"
        		BORDER=0
		        ALT="Request a Quote"><BR><IMG
		        SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/<CFOUTPUT>#url.TemplateLocation#</CFOUTPUT>/nav_fi_nav.gif"
        		BORDER=0
		        ALT="Financing Inquiries"><BR><IMG
		        SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/<CFOUTPUT>#url.TemplateLocation#</CFOUTPUT>/nav_le_nav.gif"
        		BORDER=0
		        ALT="Lease vs. Buy"><BR><IMG
		        SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/<CFOUTPUT>#url.TemplateLocation#</CFOUTPUT>/nav_adv_nav.gif"
		        BORDER=0
		        ALT="Manufacturer's Advantage"><BR><IMG
		        SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/<CFOUTPUT>#url.TemplateLocation#</CFOUTPUT>/nav_se_nav.gif"
        		BORDER=0
		        ALT="Send a Service or Parts Request"><BR><IMG
        		SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/<CFOUTPUT>#url.TemplateLocation#</CFOUTPUT>/nav_de_nav.gif"
		        BORDER=0
		        ALT="About <CFOUTPUT>#dealerinfo.dealershipname#</CFOUTPUT>"><BR><IMG
		        SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/<CFOUTPUT>#url.TemplateLocation#</CFOUTPUT>/nav_ma_nav.gif"
        		BORDER=0
		        ALT="Maps to <CFOUTPUT>#dealerinfo.dealershipname#</CFOUTPUT>"><BR><IMG
        		SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/<CFOUTPUT>#url.TemplateLocation#</CFOUTPUT>/nav_co_nav.gif"
		        BORDER=0
        		ALT="Printable Coupons"><BR>
			<CFIF #url.Calculator# IS "Y"><IMG
		        SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/<CFOUTPUT>#url.TemplateLocation#</CFOUTPUT>/nav_ca_nav.gif"
		        BORDER=0
		        ALT="Payment Calculator"><CFELSE><IMG
				SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/<CFOUTPUT>#url.TemplateLocation#</CFOUTPUT>/nav_noca_nav.gif"
				BORDER=0
				ALT=""><br></CFIF></TD></TR>
			<CFIF #leftnavbase# IS "true">		
			<TR><TD ALIGN=CENTER>
        		<IMG SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/<CFOUTPUT>#url.TemplateLocation#</CFOUTPUT>/nav_base_nav.gif"
		        BORDER=0
		        ALT=""></td></tr>
		</cfif>
		</TABLE>

	</TD>
	<TD ALIGN=CENTER VALIGN=TOP WIDTH=485> 
		<TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0 WIDTH=400>
		<TR>
	        <TD ALIGN="center">
                <IMG
                SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/banner/<CFOUTPUT>#URL.dealercode#</CFOUTPUT>_default_adbanner_hea.gif"
                BORDER=0
                ALT="<CFOUTPUT>#dealerinfo.dealershipname#</CFOUTPUT>">
			</TD>
		</TR>
		<TR>
			<TD>
				<BR>
			</td>
		</tr>
		<TR>
        	<TD VALIGN=TOP Align="center">
				<IMG
                SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/<CFOUTPUT>#url.TemplateLocation#</CFOUTPUT>/tle_sh_hea.gif"
                BORDER=0
                ALT="">
	        </TD>
		</TR>
		<TR>
			<TD>
				<BR>
			</td>
		</tr>
 		<TR>
        	<TD ALIGN=CENTER>
				<SCRIPT LANGUAGE="JavaScript">
				function go(){
				page= document.showroom.page.options[document.showroom.page.selectedIndex].value;
				if (document.showroom.page.options[document.showroom.page.selectedIndex].value != "")
				       location= page;
				}
				</SCRIPT>
				<FONT SIZE=2 FACE="arial,helvetica">
				<BR>
                Select a vehicle from the drop down list then click the submit button to view a picture and description.
				<BR><BR>
				<FORM NAME="showroom">
					<SELECT NAME="page" size="1">
						<OPTION VALUE=""><B>Select Vehicle</b> 
					</SELECT>
	        	    <A HREF="JavaScript: go();"
    	        	OnMouseOver="self.status='Select a vehicle';return true"
	        	    OnMouseOut="self.status='';return true"><img src="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/<CFOUTPUT>#url.TemplateLocation#</CFOUTPUT>/frm_submit_nav.gif" Align="absmiddle" border=0 alt="View Selection"></A></FORM>
	            </FORM>
				<BR>
				</FONT>
	        </TD>
		</TR>
		</TABLE>

    </TD>
</TR>

<TR>
	<TD ALIGN=CENTER valign="bottom">
    	<BR><BR>
		<A HREF="#"><IMG
		SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/<CFOUTPUT>#url.TemplateLocation#</CFOUTPUT>/nav_getquote_nav.gif"
		BORDER=0
		ALT="Request a Quote"></A>
		<BR>
		<FONT SIZE=2 FACE="arial,helvetica" COLOR=<CFOUTPUT>#thecolor#</cfoutput>>

		<CFOUTPUT QUERY="dealerinfo">
		<B>#dealershipname#</B>
		</FONT>
		<BR>
		<FONT SIZE=1 FACE="arial,helvetica">
		<I>#TagLine#</I><BR>
		#addressline1# #addressline2# #city#, #stateabbr# #zip#<BR>
		Ph:#phone# Fx:#faxphone#<BR>
		Email:<A HREF="##">#email#</A>
		</FONT>
		</CFOUTPUT>
		<BR><BR>
		<FONT SIZE=1 FACE="arial,helvetica">
		<A HREF="#">Home</A> |
		<A HREF="#">Showroom</A> |
		<A HREF="#">Pre-Owned</A> |
		<A HREF="#">Quote</A> |
		<A HREF="#">Financing</A> |
		<A HREF="#">Lease vs. Buy</A><BR>
		<A HREF="#">Manufacturer's Advantage</A>
		<A HREF="#">Service & Parts</A> |
		<A HREF="#">Dealer Profile</A> |
		<A HREF="#">Map</A> |
		<A HREF="#">Coupons</A>
		<CFIF #url.Calculator# IS "Y"> | <A HREF="#">Calculator</A></CFIF>
		<p>
		&copy;1997-1999 All Rights Reserved
		</FONT>
		
		<CFIF #thefooter# IS "true">
			<br><br>
			<A HREF="#top#"
				TITLE="Back to Top"
				OnMouseOver="self.status='Back to Top';return true"
				OnMouseOut="self.status='';return true"><IMG
				SRC="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/<CFOUTPUT>#url.TemplateLocation#</CFOUTPUT>/nav_foot_nav.gif"
				BORDER=0
				ALT="Back to Top"></A>
		</cfif>
	</TD>
</TR>
</TABLE>
<p>
<FORM ACTION="../webnew_s4.cfm" method="post">
	<CFOUTPUT>
	<INPUT type="hidden" name="dealercode" value="#URL.DealerCode#">
	<INPUT type="hidden" name="ArtTemplate" value="#url.TemplateLocation#">
	<INPUT type="hidden" name="Calculator" value="#URL.Calculator#">
	<INPUT type="hidden" name="BtnReturn" value="">
	</CFOUTPUT>
	<FONT FACE="Arial,Helvetica">
	<INPUT type="image" name="Back to Dealer Administration" SRC="back.gif">
	</FONT>
</FORM>

</BODY>
</HTML>