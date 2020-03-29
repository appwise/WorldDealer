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
<!--   Last updated: <May 21, 1998>                              -->
<!-- ----------------------------------------------------------- -->
<!--   Daniel Fettinger for sigma6, interactive media, Detroit   -->
<!--   dfettinger@sigma6.com   www.sigma6.com    www.s6313.com   -->
<!--               conceive : construct : connect                -->
<!-- ----------------------------------------------------------- -->
<!-- ----------------------------------------------------------- -->
<!-- Sigma6, s6, and the Sigma6 logos are registered trademarks. -->
<!-- All other trademarks and servicemarks are the property of   -->
<!-- their respective owners.                                    -->
<!-- ----------------------------------------------------------- -->

<HTML>
	<!--- $Id: ma_process.cfm,v 1.3 1999/11/24 21:57:49 lswanson Exp $ --->

<HEAD>

<SCRIPT LANGUAGE="JavaScript">
	<!--
		function submitevent(){
			document.map.submit();
			}
	//-->
</SCRIPT>

<CFQUERY NAME="allImages" DATASOURCE="#gDSN#">
	SELECT	Banners.Description as q_Description,
			Banners.BannerID,
			Banners.SpecPromoID,
			Banners.Status,
			SpecialPromotions.Description,
			SpecialPromotions.ArtTempID,
			Banners.FileLocation
	FROM	Banners,DealerBanners, SpecialPromotions
	WHERE	status = '1'
	AND		DealerWebID=#arttempid.dealerwebid#
	AND		DealerBanners.bannerid=Banners.bannerid
	AND 	Banners.SpecPromoID = SpecialPromotions.SpecPromoID
	AND 	SpecialPromotions.ExpirationDate > #CreateODBCDate(Now())#
</CFQUERY>

<CFIF #allimages.RecordCount#>  <!--- Is not 0 --->
	<CFSET imgArray = ArrayNew(2)>

	<CFLOOP QUERY="allImages">
 	   <CFSET imgArray[CurrentRow][1] = allImages.FileLocation[CurrentRow]>
	    <CFSET imgArray[CurrentRow][2] = allImages.Description[CurrentRow]>
 	   <CFSET imgArray[CurrentRow][3] = allImages.SpecPromoID[CurrentRow]>
	</CFLOOP>

	<CFSET imgArraySize = allImages.RecordCount>

	<CFSET imgNumber = RandRange( 1, #imgArraySize# )>
	<CFSET FileLocation = imgArray[#imgNumber#][1]>
	<CFSET Description = imgArray[#imgNumber#][2]>
	<CFSET SpecPromoID = imgArray[#imgNumber#][3]>

</CFIF>

</HEAD>

<FORM NAME="map" ACTION="/scripts/mapper.pl" METHOD="post">
<INPUT TYPE="hidden" NAME="query" VALUE="address">
<CFOUTPUT QUERY="dealerinfo">
<INPUT TYPE="hidden" NAME="street" VALUE="#addressline1# #addressline2#">
<INPUT TYPE="hidden" NAME="city" VALUE="#city#">
<INPUT TYPE="hidden" NAME="state" VALUE="#stateabbr#">
<INPUT TYPE="hidden" NAME="zipcode" VALUE="#zip#">
<INPUT TYPE="hidden" NAME="ArtTempID" VALUE="#ArtTempID.ArtTempID#">
<INPUT TYPE="hidden" NAME="CalculatorYesNo" VALUE="#ArtTempID.CalculatorYesNo#">
<INPUT TYPE="hidden" NAME="dealershipname" VALUE="#dealershipname#">
<INPUT TYPE="hidden" NAME="email" VALUE="#email#">
<INPUT TYPE="hidden" NAME="TagLine" VALUE="#TagLine#">
<INPUT TYPE="hidden" NAME="ContactPhone" VALUE="#Phone#">
<INPUT TYPE="hidden" NAME="FaxPhone" VALUE="#FaxPhone#">
<INPUT TYPE="hidden" NAME="dealercode" VALUE="#RTrim(dealercode)#">
</CFOUTPUT>
<CFIF #allimages.RecordCount# IS NOT 0>
	<INPUT TYPE="hidden" NAME="bannercode" VALUE=<CFOUTPUT>"<A HREF='#application.RELATIVE_PATH#/templates/dlr/#arttempid.arttempid#/of_#arttempid.arttempid#_index.cfm?specpromoid=#specpromoid#'><IMG SRC='#application.RELATIVE_PATH#/images/banner/#dealerinfo.dealercode#_#specpromoid#_adbanner_hea.gif' BORDER=0 VSPACE=0 HSPACE=0 WIDTH=400 HEIGHT=50 ALT='#allimages.q_description#'></A>"</CFOUTPUT>>
<CFELSE>
	<INPUT type="hidden" name="bannercode" value=<CFOUTPUT>"<IMG SRC='#application.RELATIVE_PATH#/images/banner/#dealerinfo.dealercode#_default_adbanner_hea.gif' BORDER=0 VSPACE=0 HSPACE=0 WIDTH=400 HEIGHT=50 ALT='#dealerinfo.dealershipname#'>"</CFOUTPUT>>
</CFIF>

</FORM>
 <BODY BGCOLOR=ffffff
		OnLoad="submitevent();">
</BODY>
</HTML>