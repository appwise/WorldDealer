<cfset PageAccess = application.dealer_access>
<cfinclude template = "../security.cfm">

<!--- <cfsetting enablecfoutputonly="YES"> --->
<!---
Created by Sigma6, Inc.
Copyright (c) 1998 Sigma6, Inc.
All Rights Reserved.  Used By Permission.

Sigma6, interactive media, Detroit/NYC
conceive : construct : connect
www.sigma6.com   webmaster@sigma6.com   info@sigma6.com

Last updated: <Aug 18, 1998>

Tim Taylor for sigma6, interactive media, Detroit
ttaylor@sigma6.com   www.sigma6.com    www.s6313.com
conceive : construct : connect

Sigma6, s6, and the Sigma6 logos are registered trademarks.
All other trademarks and servicemarks are the property of
their respective owners.
--->
<!--- $Id: goodmap.cfm,v 1.6 2000/03/10 21:20:51 lswanson Exp $ --->

<!---
goodmap.cfm - this is the location genmap_redirect.cfm tells the mapping script to redirect
on to success
--->
<!--- <cfsetting enablecfoutputonly="NO"> --->
<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: goodmap.cfm,v $">
<!doctype html public "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<!--- this HTML comment is so genmap_redirect.cfm can tell the mapping script succeeded --->
<!-- com.sigma6.ford.admin.mapper: SUCCESS -->
</html>
<cfmodule template="/util/DumpDebug.cfm" text="end   $RCSfile: goodmap.cfm,v $">