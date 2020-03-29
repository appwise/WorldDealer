<cfif isDefined("cookie.pr_compare")>

	<cfcookie name="pr_compare" value="bye-bye" expires="NOW">

	<script language="JavaScript">
	<!--
		opener.location.href=opener.location;
		opener.focus();
		window.close();
	//-->
	</script>
	
<cfelse>
	hi...there is no cookie to remove<p>
	<a href="javascript:window.close()">click here to go back</a>
</cfif>
