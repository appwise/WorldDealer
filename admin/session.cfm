<!---
interface cold fusion to Java for session management

Copyright (c) 2000 Sigma6 Inc.  All rights reserved.
$Id: session.cfm,v 1.7 2000/06/20 15:55:58 lswanson Exp $
--->

<!---
Check to see if session is valid and hasn't expired.  'URL.sid' is
the only valid way to pass session ID.

post: sessionID is defined
post: user is a query object and is defined
--->
<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: session.cfm,v $">
<CFSETTING SHOWDEBUGOUTPUT="TRUE">

<cfset isValidSession = false>

<cfif isdefined("cookie.sid")>
	<CFMODULE TEMPLATE="/util/DumpDebug.cfm" TEXT="session.cfm 1. YES, cookie.sid is defined :)">
	<cfx_java class="COM.worlddealer.cfx.SessionManager" action="verify" 
		sessionid="#cookie.sid#" return="isValidSession">
<cfelse>
	<CFMODULE TEMPLATE="/util/DumpDebug.cfm" TEXT="session.cfm 1. no, cookie.sid is not defined :(">
</cfif>

<!---
if the session is associated with a known user, set the URL.sessionID, so that login.cfm can 
still see the variable, and do the getUserInfo query, so that any page knows who the current user is.
--->
<cfif isValidSession>
	<CFMODULE TEMPLATE="/util/DumpDebug.cfm" TEXT="session.cfm 2. yes, isValidSession :)">
	<cfset URL.sessionid = cookie.sid>
	<cfx_java class="COM.worlddealer.cfx.SessionManager" action="hasProperty" 
		sessionid="#URL.sessionid#" name="userID" return="userIDexist">
	<cfif userIDexist>
		<CFMODULE TEMPLATE="/util/DumpDebug.cfm" TEXT="session.cfm 3. yes, userIDexist :)">
		<cfx_java class="COM.worlddealer.cfx.SessionManager" action="getProperty" 
			sessionid="#URL.sessionid#" name="userID" return="userID">
		<!--- retrieve user record for the current session --->
		<cfquery name="getUserInfo" datasource="#gDSN#">
			SELECT	* 
			FROM	Accounts
			WHERE	RowID = #userID#
		</cfquery>
	<cfelse>
		<CFMODULE TEMPLATE="/util/DumpDebug.cfm" TEXT="session.cfm 3. no, NOT userIDexist :(">
	</cfif>
<cfelse>
	<!--- leave the user ID unspecified --->
	<!--- linda, 2/29/2000: 1st time in, create a sessionid.  & store it in cookie.sid --->
	<CFMODULE TEMPLATE="/util/DumpDebug.cfm" TEXT="session.cfm 2. no, NOT isValidSession :(">
	<cfx_java class="COM.worlddealer.cfx.SessionManager" action="create" 
		return="URL.sessionid">
	<cfcookie name="sid" value = "#URL.sessionid#">
</cfif>

<cfmodule template="/util/DumpDebug.cfm" text="end   $RCSfile: session.cfm,v $">
