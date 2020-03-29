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
<!--- $Id: notactive.cfm,v 1.6 2000/06/21 21:55:58 lswanson Exp $ --->

<CFQUERY NAME="getWebState" DATASOURCE="#gDSN#">
		SELECT	Description
		FROM 	webstates
		WHERE	webstateid = #arttempid.webstateid#;
	</CFQUERY>
	
<!--- 
<CFQUERY NAME="GetDealer" DATASOURCE="#gDSN#">
	SELECT	DealershipName,
			EMail
	FROM	Dealers
	WHERE	DealerCode='#client.DealerCode#';
</CFQUERY>
 --->
<HTML>

<HEAD>
	<TITLE><cfoutput>#dealerinfo.dealershipname#</cfoutput></TITLE>
	<cfswitch expression="#arttempid.webstateid#">
		<cfcase value="2, 3, 4, 6">
			<META http-equiv="REFRESH"
				CONTENT="15; URL=http://www.worlddealer.net">
		</cfcase>
	</cfswitch>
</HEAD>

<BODY BGCOLOR=ffffff>
<cfoutput>
<TABLE BORDER=0 CELLSPACING=0 ALIGN=CENTER WIDTH=300>
<TR>
	<TD ALIGN=CENTER>
		<br><br>
		<IMG SRC="#application.RELATIVE_PATH#/images/common/wd_logo.gif" WIDTH="291" HEIGHT="48">
	</TD>
</TR>
<TR>
	<TD align="center">
		<br>
		<FONT FACE="Arial,Helvetica">
		<cfswitch expression="#arttempid.webstateid#">
			<!--- Inactive, Archived, Deleted --->
			<!--- linda, 6/15/00: phasing out Archived & Deleted. --->
			<cfcase value="2, 3, 4">
				<B>Sorry!</B>
				<br><br>
				<b>#dealerinfo.dealershipname#'s</b> dealership website, formerly brought to you by <a href='http://www.worlddealer.net'>WorldDealer</a>, 
				is no longer available.
				<cfif #trim(dealerinfo.email)# neq "">
					<br><br>
					You may contact #dealerinfo.dealershipname# directly via e-mail 
					at <a href='mailto:#dealerinfo.email#'>#dealerinfo.email#</a><cfif #dealerinfo.phone# neq ""> or 
					call #Trim(Left(DealerInfo.Phone,3))#-#Mid(DealerInfo.Phone,4,3)#-#Mid(DealerInfo.Phone,7,4)#</cfif>.
				</cfif>
				<br><br>
				For further assistance, please e-mail <a href='mailto:support@worlddealer.net'>support@worlddealer.net</a>.
				<br><br>
				Your browser will be redirected to <a href='http://www.worlddealer.net'>www.worlddealer.net</a>.  
			</cfcase>
			
			<!--- In Progress --->
			<cfcase value="5">
				Thank you for visiting 
				<br>
				<b>#dealerinfo.dealershipname#</b>.
				<br><br>
				Our site is currently in progress, but we plan to launch our exciting new site shortly, so check back soon!
			</cfcase>

			<!--- On Hold --->
			<cfcase value=" 6">
				<B>Sorry!</B>
				<br><br>
				<b>#dealerinfo.dealershipname#'s</b> dealership website, brought to you by <a href='http://www.worlddealer.net'>WorldDealer</a>, 
				is temporarily unavailable.  We apologize for any inconvenience this may cause.  
				<cfif #trim(dealerinfo.email)# neq "">
					<br><br>
					You may contact #dealerinfo.dealershipname# directly via e-mail 
					at <a href='mailto:#dealerinfo.email#'>#dealerinfo.email#</a><cfif #dealerinfo.phone# neq ""> or 
					call #Trim(Left(DealerInfo.Phone,3))#-#Mid(DealerInfo.Phone,4,3)#-#Mid(DealerInfo.Phone,7,4)#</cfif>.
				</cfif>
				<br><br>
				For further assistance, please e-mail <a href='mailto:support@worlddealer.net'>support@worlddealer.net</a>.
				<br><br>
				Your browser will be redirected to <a href='http://www.worlddealer.net'>www.worlddealer.net</a>.  
				<br><br>
				Please try back again.
			</cfcase>
		</cfswitch>
		</FONT>
	</TD>
</TR>
</TABLE>
</cfoutput>
</BODY>
</HTML>
