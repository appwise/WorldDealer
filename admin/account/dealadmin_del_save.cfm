
<!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 14, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: dealadmin_del_save.cfm,v 1.4 2000/03/21 16:10:59 jkrauss Exp $ --->

<cfset PageAccess = application.account_coordinator_access>
<cfinclude template = "../security.cfm">

<CFQUERY NAME="DeleteDA" datasource="#gDSN#">
	DELETE FROM Accounts
	WHERE RowID = #Form.DealerAdministrator#
</CFQUERY>

<CFLOCATION URL="dealadmin.cfm" addtoken="no">