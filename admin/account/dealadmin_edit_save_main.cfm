<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

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

	<!--- $Id: dealadmin_edit_save_main.cfm,v 1.5 2000/05/18 23:53:07 lswanson Exp $ --->

<cfif form.dealedit EQ "modify">
	<CFQUERY NAME="updDA" datasource="#gDSN#">
		UPDATE Accounts
		SET    LoginID = '#Form.LoginID#',
			   Password = '#Form.Password#',
			   AccountKey = '#Form.Dealer#',
			   Name = '#Form.Name#',
			   PermissionLevel = 0
		WHERE  RowID = #Form.RowID#
	</CFQUERY>
<cfelse>
	<CFQUERY NAME="AddDA" datasource="#gDSN#">
		INSERT INTO Accounts (LoginID, Password, AccountKey, AccountType, PermissionLevel, Name)
		VALUES ('#Form.LoginID#', '#Form.Password#', '#Form.Dealer#', 'DE', 0, '#Form.Name#')
	</CFQUERY>
</cfif>

<CFLOCATION URL="dealadmin.cfm" addtoken="no">