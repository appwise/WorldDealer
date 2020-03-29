                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <March 17, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: SQL.cfm,v 1.2 2000/03/22 22:11:11 lswanson Exp $--->

<!---
execute query entered in form...very dangerous but no more so than other
administrative features in production.
--->

<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: SQL.cfm,v $">

<cfset pageaccess = application.sysadmin_access>
<cfinclude template="../security.cfm">

<cfif userid neq '1'>
	<cflocation url="../err_noaccess.cfm">
<cfelse>
	<cfmodule template="/util/query.cfm" valid_datasource_list="WorldDlr" fname="SQL.cfm">
</cfif>

<cfmodule template="/util/DumpDebug.cfm" text="end   $RCSfile: SQL.cfm,v $">
