<cfset PageAccess = application.dealer_access>
<cfinclude template = "../security.cfm">

<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: design_thumb.cfm,v $">
<!doctype html public "-//W3C//DTD HTML 4.0 Transitional//EN">
                
				            <!--Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <November 15, 1999>
                               Creator: Bryan Bickel for AppNet, Inc.
                Bryan.Bickel@appnet.com webmaster@sigma6.com and info@sigma6.com -->            
                                         <!--$ID$-->

<!--- Linda: this takes the underline off of the text links & makes the colors match the template --->

<html>
<head>
	<title>WorldDealer</title>

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

<cfif ford eq "yes" OR chevy eq "yes">
	<cfset dispImage = URL.image - 1>
	<cfset maximage = 13>
	<cfset counter = 1>
<cfelse>
	<cfset dispImage = URL.image - 2>
	<cfset maximage = 12>
	<cfset counter = 2>
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
	WHERE arttempid = #URL.image#
</cfquery>

<cfif goodbrowser>
	<script language="JavaScript">
	<!--
		function selectPlease() {
			window.opener.location.href="design_save.cfm?pleaseChange=<cfoutput>#getTemplates.arttempid#</cfoutput>";
			window.close();
		}
	//-->
	</script>
</cfif>
	
</head>

<body bgcolor="Black" marginwidth=0 marginheight=0 leftmargin=0 topmargin=0 link="Silver" vlink="Silver" onload="window.focus();" alink="Yellow">

<table width="100%" border="0" cellspacing="0" cellpadding="5" bgcolor="Black" height="100%">
<tr bgcolor="Black">
	<cfif ford eq "yes" AND url.image eq 2>
		<td bgcolor="Black"><font face="Arial, Verdana, Helvetica" size="3" color="White"><b>Side Product -- Ford Custom</b></font></td>
	<cfelse>
		<td bgcolor="Black"><font face="Arial, Verdana, Helvetica" size="3" color="White"><b><cfoutput>#getTemplates.q_Description#</cfoutput></b></font></td>
	</cfif>
	<cfif #gettemplates.arttempid# eq #getdlrtemplate.q_dlrtemplate#>
		<td align="RIGHT" bgcolor="Black"><font face="Arial, Verdana, Helvetica" size="2" color="#EEAA00"><b>Current Template</b></font></td>
	<cfelseif (goodbrowser) AND (#left(accesslevel,1)# GT application.dealer_access)>
		<td align="RIGHT" bgcolor="Black"><font face="Arial, Verdana, Helvetica" size="1" color="White"><a href="javascript:selectPlease()" style="text-decoration: none; color: #EEAA00;">click here to select<br>this template</a></font></td>
	<cfelse>
		<td align="RIGHT" bgcolor="Black"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/tmp_wd_logo.gif" border=0></td>
	</cfif>
</tr>
<tr bgcolor="Black">
	<!--- Navigation to get Prev/Next Image --->
	<td colspan="2" align="CENTER" bgcolor="Black">
	<font face="Arial, Helvetica, Verdana" size="2" color="White">
	<cfoutput>
		<cfif #dispImage# gt 1>
			<a href="design_thumb.cfm?image=#Evaluate(URL.Image -1)#"
			onmouseover="self.status='View Previous Image';return true"
			onmouseout="self.status='';return true" style="text-decoration: none;">&lt;&lt; Previous</a>&nbsp;&nbsp;|&nbsp;
		<cfelse>
			&lt;&lt; Previous&nbsp;&nbsp;|&nbsp;
		</cfif>
		<cfloop index="imageCount" from="1" to="#MaxImage#">
		<cfset actualDestination = imageCount + counter><!--- counter used to be 2 --->
		<cfif ford eq "yes" and url.image eq 1>
			<cfset actualDestination = actualDestination - 1>
		</cfif>
			<cfif #actualDestination# eq #URL.image#>
				<b>#imageCount#</b>
			<cfelse>
				<a href="design_thumb.cfm?image=#actualDestination#" style="text-decoration: none;">#imageCount#</a>
			</cfif>
		</cfloop>
		<cfif #dispImage# lt #maximage#>
			<cfif ford eq "yes" and url.image eq 1>
				&nbsp;|&nbsp;&nbsp;<a href="design_thumb.cfm?image=#Evaluate(URL.Image +2)#"
				onmouseover="self.status='View Next Image';return true"
				onmouseout="self.status='';return true" style="text-decoration: none;">Next &gt;&gt;</a>
			<cfelse>
				&nbsp;|&nbsp;&nbsp;<a href="design_thumb.cfm?image=#Evaluate(URL.Image +1)#"
				onmouseover="self.status='View Next Image';return true"
				onmouseout="self.status='';return true" style="text-decoration: none;">Next &gt;&gt;</a>
			</cfif>
		<cfelse>
			&nbsp;|&nbsp;&nbsp;Next &gt;&gt;
		</cfif>
	</cfoutput>
	</font>
	</td>
</tr>
<tr bgcolor="White">
	<td colspan="2" align="CENTER" bgcolor="White">
	<font face="Arial, Helvetica, Verdana" size="2">
	<cfif ford eq "yes" AND url.image eq 2>
		<cfset image = image - 1>
	</cfif>
	<cfoutput> 
		<img src="#application.RELATIVE_PATH#/images/admin/tmp_#image#_sp_lg.jpg" border=1 width=320 height=210><p>
		<img src="#application.RELATIVE_PATH#/images/admin/tmp_#image#_in_lg.jpg" border=1 width=320 height=210><br>
	</cfoutput>
	</font>
	</td>
</tr>
<tr bgcolor="Black">
	<td colspan="2" align="CENTER" bgcolor="Black">
	<font face="Arial, Helvetica, Verdana" size="1" color="Silver">
	<!--- Close --->
	<a href="javascript:self.close();" onmouseover="self.status='Close This Browser Window';return true" onmouseout="self.status='';return true" style="text-decoration: none;">CLOSE WINDOW</a>
	</font>
	</td>
</tr>
</table>

</body>
</html>
<cfmodule template="/util/DumpDebug.cfm" text="end   $RCSfile: design_thumb.cfm,v $">