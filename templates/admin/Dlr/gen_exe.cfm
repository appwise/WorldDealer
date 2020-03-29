<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!--- Linda, 4/29/99: I don't see that this is called from anywhere. --->

    <!-- ----------------------------------------------------------- -->
    <!--     John Turner for sigma6, interactive media, Detroit      -->
    <!--    jturner@sigma6.com   www.sigma6.com    www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
	<!--- $Id: gen_exe.cfm,v 1.6 1999/11/29 15:36:34 lswanson Exp $ --->
                 
<HTML>

<HEAD>

        <TITLE>WorldDealer</TITLE>
        
        <CFIF ParameterExists(Form.dealercode)>
           <CFQUERY NAME="getTemplateInfo" datasource="#gDSN#">
                   SELECT ArtTemplates.FontName as q_FontName,
                          ArtTemplates.FontSize as q_FontSize,
                          ArtTemplates.FontStyle as q_FontStyle,
                          ArtTemplates.FontColor as q_FontColor,
                     FROM ArtTemplates
                    WHERE ArtTemplates.TemplateLocation = #Form.template#
           </CFQUERY>
        </CFIF>

    <CFOUTPUT QUERY="getTemplateInfo">
        <CFSET tmpURL="/scripts/generator.pl?" & 'blank=' & 'sp_' & '#Form.dealercode#' & '_' & '#Form.template#' & '_hea.gif' & '&dealercode=' & '#Form.dealercode#' & '&text=' & '#Form.dealership#' & '&font=' & '#q_FontName#' & '&size=' & '#q_FontSize#' & '&style=' &'#q_FontStyle#' & '&color=' & '#q_FontColor#'>   
        #tmpURL#
        </CFOUTPUT>     
        
        
	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>

<body>
<br><br><br><br><br>



</BODY>

</HTML>