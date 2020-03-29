<!--- $Id: jscripttest.cfm,v 1.3 1999/11/29 16:34:04 lswanson Exp $ --->

<BODY onLoad="showImageSize()">
<br><br><br><br><br>

<CFSET WhereYouAt=(#Find("/", "#HTTP_USER_AGENT#")# +1)>
<CFSET BVer=#Mid(#HTTP_USER_AGENT#, #WhereYouAt#, 3)#>
<CFIF #HTTP_USER_AGENT# CONTAINS "Mozilla" AND #BVer# GTE 3>
	<CFSET #goodbrowser#="yes">
<CFELSE>
	<CFSET #goodbrowser#="no">
</CFIF>

<CFIF #goodbrowser# IS 'yes'>
<A Name="top">top</a>
<SCRIPT Language="Javascript">
function showImageSize() {
	if(document.checkit.width > 300) {
   		document.write('<br><br><br clear=all>height=' + document.checkit.height + ' width=' + document.checkit.width + '<br><br clear=all>');
	}
}

</script>
</cfif>

<IMG SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/logo.gif" Name="checkit">
