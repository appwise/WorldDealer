<cfset PageAccess = application.dealer_access>

<cfquery name="getDealerName" datasource="#gDSN#">
	SELECT DealershipName as q_DealershipName
	FROM Dealers
	WHERE Dealers.DealerCode = '#g_dealercode#'
</cfquery>

<!--- to determine whether to show the custom Ford or Chevy templates --->		
<cfquery name = "getDealerFranchise" datasource = "WorldDlr">
	SELECT	MakeNumber
	FROM	DealerFranchise
	WHERE	DealerFranchise.dealercode = '#g_dealercode#'
</cfquery>

<cfset ford = "no">
<cfset chevy = "no">

<cfif getdealerfranchise.recordcount eq 1>
	<cfloop query="getDealerFranchise">
		<cfif #makenumber# eq 1>
			<cfset ford = "yes">
		<cfelseif #makenumber# eq 12>
			<cfset chevy = "yes">
		</cfif>
	</cfloop>
</cfif>

<cfquery name="getDLRTemplate" datasource="#gDSN#">
	SELECT 	ArtTempID as q_DLRTemplate,
			CalculatorYesNo,
			BodyShopYesNo
	FROM DealerWebs
	WHERE DealerWebs.DealerCode = '#g_dealercode#'
</cfquery>

<cfquery name="getTemplates" datasource="#gDSN#">
	SELECT 	arttempid,
			Description as q_Description
	FROM ArtTemplates
	ORDER BY arttempid
</cfquery>

<cfif goodbrowser>
	<SCRIPT LANGUAGE="javascript">
	<!--
	function openWindow(docName)
		{
		newWindow = window.open(docName, "BiggerView", "width=400,height=575,toolbar=no,status=no,menubar=no,scrollbars=no");
		}
	//-->
	</script>
</cfif>

<table border="0" cellspacing="0" cellpadding="5" width="100%">
<tr>
	<cfif #left(accesslevel,1)# GT application.dealer_access>
		<td>Select a template from the choices below.  Click on the thumbnails to see the images in more detail.  When you've selected a template, click Save at the bottom of the page.</td>
	<cfelse>
		<td>Below are thumbnails of the available templates.  Click on the thumbnails to see the images in more detail.</td>
	</cfif>
</tr>
<form name="PickADesign" action="design_save.cfm" method="post">
<tr>
	<td align="CENTER">
	<table cellpadding=2 cellspacing=0 border=0>
	<cfloop query="getTemplates">
	<!--- template 1 = custom for Weikert Ford or any other Ford dealerships --->
	<!--- template 2 = custom for Chevy dealerships --->
	<!---Linda, 5/5/99: The Down Home template (template 2) is Messner's property per Anna.
		Don't allow WD to choose it until further notice.  
		5/17/99: We have approval from Messner per RZ to use all their templates! --->
		<cfif #arttempid# gt 2  or (#arttempid# eq 1 and #ford# eq "yes") or (#arttempid# eq 2 and #chevy# eq "yes")> 
		<cfoutput>
		<tr>
			<td align="right">#q_Description#
			<cfif #left(accesslevel,1)# EQ application.dealer_access>
				<cfif #arttempid# eq #getdlrtemplate.q_dlrtemplate#>
					<br><font size="-1" color="##EEAA00"><b>&gt;&gt; current template &gt;&gt;</b></font>
				</cfif>
			</cfif></td>
			<td>&nbsp;</td>
			<cfif #left(accesslevel,1)# GT application.dealer_access>
				<td align="right"><input type="radio" value="#arttempid#" name="arttempid"<cfif #arttempid# eq #getdlrtemplate.q_dlrtemplate#> CHECKED</cfif>></td>
				<td>&nbsp;</td>
			</cfif>
			<td align="left"><cfif goodbrowser><A HREF="JavaScript:openWindow('design_thumb.cfm?image=#arttempid#')"
					OnMouseOver="self.status='#q_Description#';return true"
					OnMouseOut="self.status='';return true"></cfif><img src="#application.RELATIVE_PATH#/images/admin/tmp_#arttempid#_sp_sm.gif" border=1 width=100 height=65><cfif goodbrowser></a></cfif></td>
			<td>&nbsp;</td>
			<td align="left"><cfif goodbrowser><A HREF="JavaScript:openWindow('design_thumb.cfm?image=#arttempid#')"
					OnMouseOver="self.status='#q_Description#';return true"
					OnMouseOut="self.status='';return true"></cfif><img src="#application.RELATIVE_PATH#/images/admin/tmp_#arttempid#_in_sm.gif" border=1 width=100 height=65><cfif goodbrowser></a></cfif></td>
		</tr>
		</cfoutput>
		</cfif>
	</cfloop>
	</table>
	</td>
</tr>
<cfif #left(accesslevel,1)# GT application.dealer_access>
<tr>
	<td align="CENTER"><input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/save.gif" BORDER="0" name="Save" value="Save"></td>
</tr>
</cfif>
</form>
</table>