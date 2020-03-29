<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

    <!-- ----------------------------------------------------------- -->
    <!--       Created by sigma6, Detroit       -->
    <!--         Copyright (c) 1997, 1998, 1999 sigma6.              -->
    <!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->

    <!-- ----------------------------------------------------------- -->
    <!--     John Turner for sigma6, interactive media, Detroit      -->
    <!--    jkrauss@sigma6.com   www.sigma6.com    www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->

	<!--- $Id: arttemp_save.cfm,v 1.1 2000/06/15 17:09:05 jkrauss Exp $ --->

<cfif parameterexists(form.save.x)>
	<CFQUERY NAME="updateArtTemplate" datasource="#gDSN#">
		UPDATE	arttemplates
		SET		description = '#form.description#',
				fontname = '#form.fontname#',
				sp_textboundsx = #form.sp_textboundsx#,
				sp_textboundsy = #form.sp_textboundsy#,
				sp_textboundswidth = #form.sp_textboundswidth#,
				sp_textboundsheight = #form.sp_textboundsheight#,
				sp_fontsize = #form.sp_fontsize#,
				sp_fontstyle = '#form.sp_fontstyle#',
				sp_textalign = '#form.sp_textalign#',
				sp_textcolor = '#form.sp_textcolor#',
				logo_textboundsx = #form.logo_textboundsx#,
				logo_textboundsy = #form.logo_textboundsy#,
				logo_textboundswidth = #form.logo_textboundswidth#,
				logo_textboundsheight = #form.logo_textboundsheight#,
				logo_fontsize = #form.logo_fontsize#,
				logo_fontstyle = '#form.logo_fontstyle#',
				logo_textalign = '#form.logo_textalign#',
				logo_textcolor = '#form.logo_textcolor#',
				coup_textboundsx = #form.coup_textboundsx#,
				coup_textboundsy = #form.coup_textboundsy#,
				coup_textboundswidth = #form.coup_textboundswidth#,
				coup_textboundsheight = #form.coup_textboundsheight#
		WHERE	arttempid = #Form.arttempid#
	</CFQUERY>
<cfelse>	
	<CFQUERY NAME="insertArtTemplate" datasource="#gDSN#">
		INSERT INTO ArtTemplates (
				arttempid,
				templatestateid,
				description,
				fontname,
				sp_textboundsx,
				sp_textboundsy,
				sp_textboundswidth,
				sp_textboundsheight,
				sp_fontsize,
				sp_fontstyle,
				sp_textalign,
				sp_textcolor,
				logo_textboundsx,
				logo_textboundsy,
				logo_textboundswidth,
				logo_textboundsheight,
				logo_fontsize,
				logo_fontstyle,
				logo_textalign,
				logo_textcolor,
				coup_textboundsx,
				coup_textboundsy,
				coup_textboundswidth,
				coup_textboundsheight
			)
		VALUES (
				#form.arttempid#,
				1,
				'#form.description#',
				'#form.fontname#',
				#form.sp_textboundsx#,
				#form.sp_textboundsy#,
				#form.sp_textboundswidth#,
				#form.sp_textboundsheight#,
				#form.sp_fontsize#,
				'#form.sp_fontstyle#',
				'#form.sp_textalign#',
				'#form.sp_textcolor#',
				#form.logo_textboundsx#,
				#form.logo_textboundsy#,
				#form.logo_textboundswidth#,
				#form.logo_textboundsheight#,
				#form.logo_fontsize#,
				'#form.logo_fontstyle#',
				'#form.logo_textalign#',
				'#form.logo_textcolor#',
				#form.coup_textboundsx#,
				#form.coup_textboundsy#,
				#form.coup_textboundswidth#,
				#form.coup_textboundsheight#
			)
	</CFQUERY>
</cfif>

<cflocation url="arttemp.cfm" addtoken="No">