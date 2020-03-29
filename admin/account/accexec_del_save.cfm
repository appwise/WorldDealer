<cfset PageAccess = application.account_coordinator_access>
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
	<!--- $Id: accexec_del_save.cfm,v 1.4 2000/03/21 16:10:58 jkrauss Exp $ --->

<CFQUERY NAME="DeleteAE1" datasource="#gDSN#">
	DELETE FROM AccountExecs
	WHERE       AEID = #Form.AccountExec#
</CFQUERY>

<CFQUERY NAME="DeleteAE2" datasource="#gDSN#">
	DELETE FROM Accounts
	WHERE       AccountKey = '#Form.AccountExec#' AND AccountType = 'AE'
</CFQUERY>

<CFLOCATION URL="accexec.cfm" addtoken="no">