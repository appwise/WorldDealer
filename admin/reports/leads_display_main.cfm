<!--- Created by AppNet, Inc., Detroit
www.appnet.com
Copyright (c) 1999, 2000 AppNet, Inc. 
All other trademarks and servicemarks are the property of   
their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
Appnet, Inc. logos are registered trademarks.  
Created: <January 11, 2000>
webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: leads_display_main.cfm,v 1.11 2000/06/07 14:40:22 bbickel Exp $--->

<cfset records_per_page = 10>
<cfset max_jumps = 10>

<cfset location = "leads_display.cfm"
		& "?FromTemplate=dsp_leadList"
		& "&reportCoverage="  & reportcoverage
		& "&leadType=" & leadtype
		& "&orderBy=" & orderby
		& "&orderDirection=" & orderdirection>

<cfquery name="selectLeadList" datasource="#gDSN#">
	SELECT
		RequestInfoGeneral.RequestInfoID,
		RequestInfoGeneral.RequestInfoTypeID,
		RequestInfoTypes.Description,
		RequestInfoGeneral.FName,
		RequestInfoGeneral.LName,
		RequestInfoGeneral.WhenSubmitted
	FROM
		RequestInfoGeneral, RequestInfoTypes
	WHERE
		RequestInfoGeneral.RequestInfoTypeID = RequestInfoTypes.RequestInfoTypeID
		AND RequestInfoGeneral.RequestInfoTypeID IN (#leadType#)
		<cfif (g_dlr)>
			AND RequestInfoGeneral.DealerCode = '#g_dealercode#'
		<cfelseif parameterExists(url.reportCoverage)>
			AND RequestInfoGeneral.DealerCode = '#URL.reportCoverage#'
		<cfelse>
			AND RequestInfoGeneral.DealerCode = '#form.reportCoverage#'
		</cfif>
		<cfif orderby eq "date">
			ORDER BY RequestInfoGeneral.WhenSubmitted #orderDirection#
		<cfelseif orderby eq "leadType">
			ORDER BY RequestInfoGeneral.RequestInfoTypeID #orderDirection#
		<cfelseif orderby eq "lastName">
			ORDER BY RequestInfoGeneral.LName #orderDirection#
	</cfif>
</cfquery>

<cfparam name="page" default="1">
<cfset recordcount = selectleadlist.recordcount>
<cfset pagecount = ceiling(recordcount / records_per_page)>
<cfset startrow = ((page - 1) * records_per_page) + 1>
<cfset endrow = startrow + records_per_page - 1>
<cfif endrow gt recordcount>
	<cfset endrow = recordcount>
</cfif>

<cfif isDefined("form.reportCoverage")>
	<cfquery name="getDlrName" datasource="#gDSN#">
		SELECT DealershipName
		FROM Dealers
		WHERE DealerCode = '#form.reportCoverage#'
	</cfquery>
<cfelseif isDefined("URL.reportCoverage")>
	<cfquery name="getDlrName" datasource="#gDSN#">
		SELECT DealershipName
		FROM Dealers
		WHERE DealerCode = '#URL.reportCoverage#'
	</cfquery>
</cfif>


<form action="leads_detail.cfm" METHOD="POST">
<cfoutput>
<input type="hidden" name="reportCoverage" value="#reportCoverage#">
<input type="hidden" name="leadType" value="#leadType#">
<input type="hidden" name="orderBy" value="#orderBy#">
<input type="hidden" name="orderDirection" value="#orderDirection#">
<input type="hidden" name="page" value="#page#">
<!--- <input type="hidden" name="DealerCode" value="#DealerCode#"> --->
</cfoutput>
<div align="center">
<table border="0" cellpadding="0" cellspacing="5" width="100%">
<cfif getDlrName.recordcount>
<tr>
	<td colspan="4"><b>Leads for <cfoutput>#getDlrName.DealershipName#</cfoutput></b><br>&nbsp;</td>
</tr>
</cfif>
<cfif selectleadlist.recordcount gt 0>
	<tr align="left">
		<td>&nbsp;</td>
		<td><b>Name</b></td>
		<td><b>Lead Type</b></td>
		<td><b>Date</b></td>
	</tr>
	<cfset reccount = 0>
	<cfoutput query="selectLeadList" startrow="#startRow#" maxrows="10">
		<cfset reccount = reccount +1>
		<tr align="left">
			<td><input type="radio" name="leadID" value="#RequestInfoID#"<cfif #reccount# eq 1>CHECKED</cfif>></td>
			<td>#LName#, #FName#</td>
			<td>#Description#</td>
			<td>#DateFormat(WhenSubmitted, "mm/dd/yyyy")#</td>
		</tr>
	</cfoutput>
	<tr>
		<td colspan="4">&nbsp;</td>
	</tr>
	<tr align="center">
		<td colspan="4">
			<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td colspan="3" align="center">page&nbsp;<cfoutput>#page#</cfoutput>&nbsp;of&nbsp;<cfoutput>#pageCount#</cfoutput></td>
			</tr>
			<tr valign="top">
				<td align="right" width="50%">
				<tt>
				<cfsetting enablecfoutputonly="YES">
				<cfif #page# gt 1>
					<cfoutput><a href="#location#&FuseAction=jump&page=#Evaluate(page - 1)#">previous</a>&nbsp;|&nbsp;</cfoutput>
				<cfelse>
					<cfoutput>&nbsp;</cfoutput>
				</cfif>
				<cfsetting enablecfoutputonly="NO">
				</tt>
				</td>
				<td align="center">
				<tt>
				<cfsetting enablecfoutputonly="YES">
				<cfif #pagecount# gt 1>
					<!--- <CFMODULE TEMPLATE="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/templates/util/jumpmenu.cfm" --->
					<cfmodule template="jumpmenu.cfm" beginpage="1" endpage="#pageCount#" currentpage="#page#" maxjumps="#MAX_JUMPS#" location="#location#">
				<cfelse>
					&nbsp;
				</cfif>
				<cfsetting enablecfoutputonly="NO">
				</tt>
				</td>
				<td align="left" width="50%">
				<tt>
				<cfsetting enablecfoutputonly="YES">
				<cfif page lt pagecount>
					<cfoutput>|&nbsp;<a href="#location#&FuseAction=jump&page=#Evaluate(page + 1)#">next</a></cfoutput>
				<cfelse>
					<cfoutput>&nbsp;</cfoutput>
				</cfif>
				<cfsetting enablecfoutputonly="NO">
				</tt>
				</td>
			</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr align="center">
		<td colspan="4">
		<a href="#" OnMouseOver="self.status='Back';return true" OnMouseOut="self.status='';return true" OnClick="history.go(-1);return false"><img src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/back.gif" Border="0" ALT="Back"></a>
		<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/seedetails.gif" BORDER="0" NAME="ShowLeadDetail">
		</td>
	</tr>
	<tr>
		<td colspan="4">&nbsp;</td>
	</tr>
<cfelse>
	<tr align="center">
		<td colspan="4">No leads</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr align="center">
		<td colspan="4">
		<a href="#" OnMouseOver="self.status='Back';return true" OnMouseOut="self.status='';return true" OnClick="history.go(-1);return false"><img src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/back.gif" Border="0" ALT="Back"></a>
		</td>
	</tr>
</cfif>
</table>
</div>
</form>