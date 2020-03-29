<cfset PageAccess = application.sysadmin_access>
<cfinclude template = "../security.cfm">

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
	<!--- $Id: arttemp_del_action.cfm,v 1.1 2000/06/15 17:09:04 jkrauss Exp $ --->
	
	<!--- Eventually, the best thing to do would be to just set the templatestateID to 0...but that'll be easy. --->
	<!--- Can't really do that until the templatestateID is actually utilized in the site. --->

<CFQUERY NAME="DeleteArtTemp" datasource="#gDSN#">
	DELETE FROM ArtTemplates
	WHERE 	arttempid = #form.arttempid#
</CFQUERY>

<CFLOCATION URL="arttemp.cfm" addtoken="no">