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
<!--- $Id: index.cfm,v 1.21 2000/06/14 21:08:42 bbickel Exp $ --->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>

<HEAD>
	<TITLE><CFOUTPUT>#dealerinfo.dealershipname#</CFOUTPUT></TITLE>
	
	<!--- Check for minimum browser version required/recommended. --->
	<CFSET Browserver="Unknown">
	
	<CFIF CGI.HTTP_USER_AGENT IS NOT "">
		<CFSET Browserver=CGI.HTTP_USER_AGENT>
	</CFIF>
	
	<CFSET AOLVER=0>
	<CFSET MSIEVER=0>
	
	<CFSET AOLStart=Find("AOL",Browserver,1)>
	
	<CFIF AOLStart GT 0>
		<CFSET AOLDEF1=RemoveChars(Browserver,1,AOLStart -1)>
		<CFSET AOLEnd=Find(" ",AOLDEF1, 1)>	
		<CFSET AOLDEF2=RemoveChars(AOLDEF1,1,AOLEnd)>
		<CFSET AOLVER=Val(AOLDEF2)>
	</CFIF>	
	
	<CFSET MSIEStart=Find("MSIE",Browserver,1)>
	
	<CFIF MSIEStart GT 0>
		<CFSET MSIEDEF1=RemoveChars(Browserver,1,MSIEStart -1)>
		<CFSET MSIEEnd=Find(" ",MSIEDEF1, 1)>	
		<CFSET MSIEDEF2=RemoveChars(MSIEDEF1,1,MSIEEnd)>
		<CFSET MSIEVER=Val(MSIEDEF2)>
	</CFIF>	
	
	<!--- linda, 5/4/00: at some later date, keep this query in the header, but modify it to apply to both g_col and g_dlr.
	then, where it's called, you just have to call 1 query.  don't have time to test & debug now... not a bug, just a cleanup. --->
	<CFQUERY name = "getDlrMakes" DATASOURCE="#gDSN#">
		SELECT 	Makes.MakeName, 
				Makes.MakeNumber, 
				Makes.WebAddr
		FROM 	Makes INNER JOIN DealerFranchise ON Makes.MakeNumber = DealerFranchise.MakeNumber
		WHERE 	DealerFranchise.dealercode = '#dealerinfo.dealercode#'
	</cfquery>
	<!--- query to decide if make logos should be displayed for the collection and allow for them to link to the manuf. --->
	<CFQUERY NAME="getmakelogo" DATASOURCE="#gDSN#">
	    SELECT	MakeLogoYN,
				MakeLogoLinkYN
		FROM	DealerWebs
	   WHERE	dealercode ='#dealerinfo.dealercode#'
    </CFQUERY>
	
	<!--- Meta tags --->
	<cfquery name="getMetaStuff" datasource="#gDSN#">
		SELECT	DealerWebsMeta.*
		FROM	DealerWebs INNER JOIN DealerWebsMeta ON DealerWebs.DealerWebID = DealerWebsMeta.DealerWebID
		WHERE	DealerWebs.DealerCode = '#dealerinfo.dealercode#'
	</cfquery>
	
	<cfoutput query="getMetaStuff">
	<META NAME="KEYWORDS" CONTENT="#keyMeta#">
	<META NAME="DESCRIPTION" CONTENT="#shortMeta#">
	<META NAME="DESCRIPTION" CONTENT="#longMeta#">
	</cfoutput>
	
</HEAD>

<!--- <body ...> beginning is in global_x.htm > --->
<CFINCLUDE TEMPLATE="global_#arttempid.arttempid#.htm">
<TABLE  BORDER=0 WIDTH=100% HEIGHT=100% CELLSPACING=0 CELLPADDING=0>
<TR>
	<TD ALIGN=CENTER VALIGN=MIDDLE>
<!---------------------------------------------------------CONTENT-------------------------------------->
<CFIF ((AOLVer GT 0) AND (MSIEVer GT 0))>
	<CFIF (AOLVer LT 4) AND (MSIEVer LT 4)>
		<CFOUTPUT>
			<div align="center"><HR width=80%>
			<Font Face="Arial,helvetica" Size=2>
			<B>
			Alert!<br>
			</B>
			</Font>
			<Font Face="Arial,helvetica" Size=1>
			America Online Version: #AOLVer# Detected<br>
			<a HREF="##AOLupgrade">Please see below for further details.</a><br>
			<HR width=80%></div>
			</Font>
		</CFOUTPUT>	
    </CFIF>
</cfif>

<CFIF ((AOLVer IS 0) AND (MSIEVer LT 4) AND (MSIEVer GT 0))>
		<CFOUTPUT>
			<div align="center"><HR width=80%>
			<Font Face="Arial,helvetica" Size=2>
			<B>
			Alert!<br>
			</B>
			</Font>
			<Font Face="Arial,helvetica" Size=1>
			Microsoft Internet Explorer Version: #MSIEVER# Detected<br>
			<a HREF="##upgrade">Please see below for further details.</a><br>
			</Font>
			<HR width=80%></div>
		</CFOUTPUT>			
</CFIF>

	<TABLE border="0">
	<CFOUTPUT>
	<tr>
		<td>
			<CFINCLUDE TEMPLATE="sp_#arttempid.arttempid#.htm">
		</td>
	</tr>
	<tr>
		<td align="center">
			<CFINCLUDE TEMPLATE="sp_footer.html"><br>
			<br>
		</td>
	</tr>
<cfif getmakelogo.makelogoYN eq "Y">	
	<!--- show manuf logos along the bottom --->
	<tr>
		<TD ALIGN=CENTER>
			<CFIF #g_Col# IS "true">
				<cfquery name="getDlrMakes"	 datasource="#gDSN#">
					SELECT DISTINCT 
							Makes.MakeNumber,
							Makes.MakeName,
							Makes.Webaddr
					FROM	(CollectionDealers 
							INNER JOIN DealerFranchise ON CollectionDealers.DealerCode = DealerFranchise.Dealercode) 
							INNER JOIN Makes ON DealerFranchise.MakeNumber = Makes.MakeNumber
					WHERE 	CollectionDealers.Coll_DealerCode = '#dealerinfo.dealercode#'
				</cfquery>
				<!------ This decides whether to make the logos link to their manufacturer added 6/14 bbickel --->
				<CFIF getDlrMakes.RecordCount>		
					<cfif getmakelogo.MakeLogoLinkYN EQ "Y">
						<CFLOOP query="getDlrMakes">
							<A HREF="http://#WebAddr#"
							TITLE="Go to #MakeName#'s Home Page"
							OnMouseOver="self.status='Go to #MakeName#\'s Home Page';return true"
							OnMouseOut="self.status='';return true"
							target="_blank"><IMG
							SRC="#application.RELATIVE_PATH#/images/make_logo/#MakeNumber#<cfif #make_logo_blk# IS "y">_blk</cfif>.gif" BORDER=0 ALT="#MakeName#">
						</cfloop>
					<cfelse>				
						<CFLOOP query="getDlrMakes">
							<IMG SRC="#application.RELATIVE_PATH#/images/make_logo/#MakeNumber#<cfif #make_logo_blk# IS "y">_blk</cfif>.gif" BORDER=0 ALT="#MakeName#">				
						</cfloop>
					</cfif>
				<CFELSE>
					&nbsp;
				</cfif>
		<!--- Linda, 5/7/99: kludge to satisfy Suburban Collection: show non-WD dealerships' manuf logos --->
				<CFIF #Left(dealerinfo.dealercode, 4)# EQ "0004">
					<br>
					<CFLOOP index="manuf" list="Saturn,Infiniti,Volvo">
						<CFQUERY name="getNonWDMakes" datasource="#gDSN#">
							SELECT 	DISTINCT MakeName, 
									MakeNumber, 
									WebAddr
							FROM	Makes
							WHERE 	MakeName = '#manuf#'
						</cfquery>
					<!------ This decides whether to make the logos link to their manufacturer added 6/14 bbickel --->
					<cfif getmakelogo.MakeLogoLinkYN EQ "Y">	
						<CFLOOP query="getNonWDMakes">
							<A HREF="http://#WebAddr#"
							TITLE="Go to #MakeName#'s Home Page"
							OnMouseOver="self.status='Go to #MakeName#\'s Home Page';return true"
							OnMouseOut="self.status='';return true"
							target="_blank"><IMG
							SRC="#application.RELATIVE_PATH#/images/make_logo/#MakeNumber#<cfif #make_logo_blk# IS "y">_blk</cfif>.gif" BORDER=0 align="middle" ALT="#MakeName#"></a>
						</cfloop>
					<cfelse>
						<CFLOOP query="getNonWDMakes">
							<IMG SRC="#application.RELATIVE_PATH#/images/make_logo/#MakeNumber#<cfif #make_logo_blk# IS "y">_blk</cfif>.gif" BORDER=0 align="middle" ALT="#MakeName#">
						</cfloop>
					</cfif>
					
					</cfloop>
				</cfif>
			
			<CFELSE>
				<!--- Dealerships: get their Manuf logos --->
				<CFQUERY name=getDlrMakes DATASOURCE="#gDSN#">
					SELECT 	DISTINCT Makes.MakeName, 
							Makes.MakeNumber, 
							Makes.WebAddr
					FROM 	Makes INNER JOIN DealerFranchise ON Makes.MakeNumber = DealerFranchise.MakeNumber
					WHERE 	DealerFranchise.dealercode = '#dealerinfo.dealercode#'
				<!--- 		ORDER BY Makes.MakeName	 Linda, 3/11/99: The order is the same as it's added in DealerFranchise table, 
				which should match the order in the dealerhsip name, ie. buick pontiac gmc, not buick gmc pontiac. --->
				</cfquery>
			<!------ This decides whether to make the logos link to their manufacturer added 6/14 bbickel --->
			<cfif getmakelogo.MakeLogoLinkYN EQ "Y">
				<CFLOOP query="getDlrMakes">
					<A HREF="http://#WebAddr#"
					TITLE="Go to #MakeName#'s Home Page"
					OnMouseOver="self.status='Go to #MakeName#\'s Home Page';return true"
					OnMouseOut="self.status='';return true"
					target="_blank"><IMG
					SRC="#application.RELATIVE_PATH#/images/make_logo/#MakeNumber#<cfif #make_logo_blk# IS "y">_blk</cfif>.gif" BORDER=0 align="middle" ALT="#MakeName#"></a>
				</cfloop>
			<cfelse>
				<CFLOOP query="getDlrMakes">
						<IMG SRC="#application.RELATIVE_PATH#/images/make_logo/#MakeNumber#<cfif #make_logo_blk# IS "y">_blk</cfif>.gif" BORDER=0 align="middle" ALT="#MakeName#"></a>
				</cfloop>
			</cfif>
		</CFIF> 
		</td>
	</tr>
</cfif>
	</cfoutput>
	</table>

<!--------------------------------------------------------/CONTENT-------------------------------------->
<a name="AOLupgrade"></a>
<CFIF ((AOLVer GT 0) AND (MSIEVer GT 0))>
	<CFIF (AOLVer LT 4) AND (MSIEVer LT 4)>
		<CFOUTPUT>
			<div align="center"><HR width=80%>
			<Font Face="Arial,helvetica" Size=1>
			To properly view this site you must update your version of America Online.<br>
			To upgrade go to <B>Keyword</B> and type <B>upgrade</B>. When you get to the upgrade area, click on the button that says <B>Upgrade Now</B>.<p>

			<HR width=80%></div>
			</Font>
		</CFOUTPUT>	
    </CFIF>
</cfif>

<a name="upgrade"></a>
<CFIF ((AOLVer IS 0) AND (MSIEVer LT 4) AND (MSIEVer GT 0))>
		<CFOUTPUT>
			<div align="center"><HR width=80%>
			<Font Face="Arial,helvetica" Size=1>
			To properly view this site you must have version 3.1 of the <U><a href="http://www.microsoft.com/msdownload/vbscript/scripting.asp">Internet Explorer Scripting Engine</a></U><br>
			This update is included with newer versions of Microsoft Internet Explorer.<p>
			<TABLE Border=0 cellspacing=0 cellpadding=0><TR><TD>
			<Font Face="Arial,helvetica" Size=1>
			Option 1: Download the latest version of the Scripting Engine <a href="http://www.microsoft.com/msdownload/vbscript/scripting.asp">Here</a><br>
			Option 2: Download the latest version of Internet Explorer <A HREF="http://www.microsoft.com/ie">Here</a><br>
			Option 3: Continue Browsing the site and return to this page if you encounter any errors<br>
			</Font>
			</TD></TR></TABLE>
			</Font>
			<HR width=80%></div>
		</CFOUTPUT>			
</CFIF>

	</TD>
</TR>
</TABLE>
</BODY>
</HTML>