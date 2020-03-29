                        <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 11, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->            
<!---$Id: security.cfm,v 1.19 2000/03/10 21:14:57 lswanson Exp $--->

<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: security.cfm,v $">

<cfif not isdefined("userID")>
	<!--- If UserID not defined, we've timed out -> re-login. --->
	<cflocation url="#application.RELATIVE_PATH#/admin/err_timedout.cfm">
</cfif>

<!---basic enforcing of level restrictions...redirects to front if access not allowed--->
<cfif isdefined("Variables.PageAccess")>
	<cfif accesslevel lt pageaccess>
		<!--- Not enough access --->
	 	<cflocation url="#application.RELATIVE_PATH#/admin/err_noaccess.cfm"> 
	</cfif>
</cfif>

<cfmodule template="/util/DumpDebug.cfm" text="end   $RCSfile: security.cfm,v $">
