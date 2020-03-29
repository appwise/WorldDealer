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
	<!--- $Id: dealadmin_add_save.cfm,v 1.3 2000/03/03 17:54:23 jkrauss Exp $ --->

<CFQUERY NAME="AddDA" datasource="#gDSN#">
	INSERT INTO Accounts (LoginID, Password, AccountKey, AccountType, PermissionLevel, Name)
	VALUES ('#Form.LoginID#', '#Form.Password#', '#Form.DealerCode#', 'DE', 0, '#Form.Name#')
</CFQUERY>

<CFLOCATION URL="dealadmin.cfm" addtoken="no">