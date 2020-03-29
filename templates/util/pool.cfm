<!---
display ConnectionPool info and statistics.

Copyright (c) 1999, 2000 AppNet Inc.  All rights reserved.
$Id: pool.cfm,v 1.1 2000/04/25 20:23:23 ttaylor Exp $

Usage:
	
	Place a copy of this template (or include it from a template) within your 
	project where application.source is defined, preferably someplace 
	secure.

See: s6/cfml/util/ConnectionPool.cfm
--->

<CFSET pool= application.source.getPool()>

<CFIF IsDefined("FORM.flush")>
	<CFSET junk = pool.shutdown()>
	<CFSET junk = pool.init()>
	<CFLOCATION URL=#CGI.SCRIPT_NAME#>
</CFIF>

<CFMODULE TEMPLATE="/util/ConnectionPool.cfm" POOL=#pool#>
