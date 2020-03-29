    <!-- ----------------------------------------------------------- -->
    <!--       Created by sigma6, Detroit       -->
    <!--         Copyright (c) 1997, 1998, 1999 sigma6.              -->
    <!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->

    <!-- ----------------------------------------------------------- -->
    <!--     John Turner for sigma6, interactive media, Detroit      -->
    <!--    jturner@sigma6.com   www.sigma6.com    www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
	<!--- $Id: arttemp_del_main.cfm,v 1.1 2000/06/15 17:09:04 jkrauss Exp $ --->
		
<CFQUERY NAME="DeleteTemplate" datasource="#gDSN#">
	SELECT description
	FROM   ArtTemplates
	WHERE  ArtTempID = #URL.arttempid#
</CFQUERY>

<div align="center">
<br>&nbsp;<br>
<table>
<tr>
	<td>Are you sure you want to delete the <b><cfoutput query="deletetemplate">#description#</cfoutput></b> template?</td>
</tr>
</table><p>

<form action="arttemp_del_action.cfm" method="POST">
<cfoutput>
	<input type="hidden" name="arttempid" value="#url.arttempid#">
	<a href="javascript:history.back()"><IMG SRC="#application.RELATIVE_PATH#/images/admin/cancel.gif" NAME="Cancel" border="0"></a>&nbsp;&nbsp;<input type="image" src="#application.RELATIVE_PATH#/images/admin/deletebutton.gif" name="Delete" value="Delete" border="0">
</cfoutput>
</form>

</div>