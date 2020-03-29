<!---
description here

Copyright (c) 1998 Sigma6 Inc.  All rights reserved.
$Id: DumpRequest.cfm,v 1.3 1999/12/09 18:21:10 ttaylor Exp $
---><CFSETTING ENABLECFOUTPUTONLY="YES">

<!--- message to glom on to (required) --->
<CFPARAM NAME="attributes.message">

<CFSET NL = Chr(10)>
<CFSET message = "">
<CFSET message = message & NL & "=============" & NL>
<CFSET message = message & "URL INFO" & NL>
<CFSET message = message & "=============" & NL>

<CFLOOP INDEX="var" LIST="sid,fa,user.userID,user.username">
	<CFIF IsDefined(var)>
		<CFSET message = message & var & ": " & Evaluate(var) & NL>
	</CFIF>
</CFLOOP>

<CFIF IsDefined("CGI.QUERY_STRING")>
	<CFSET message = message & NL & "==========" & NL>
	<CFSET message = message & "URL FIELDS" & NL>
	<CFSET message = message & "==========" & NL>
	
	<CFSET urlFields = Replace(CGI.QUERY_STRING, "&", NL, "ALL")>
	<CFSET urlFields = Replace(urlFields, "=", ": ", "ALL")>
	<CFSET message = message & urlFields & NL>
</CFIF>

<CFIF IsDefined("FORM.FIELDNAMES")>
	<CFSET message = message & NL & "==========" & NL>
	<CFSET message = message & "FORM FIELDS" & NL>
	<CFSET message = message & "==========" & NL>

	<CFLOOP INDEX="field" LIST="#FORM.fieldnames#,FIELDNAMES">
		<CFSET message = message & field & ": " & Evaluate("FORM.#field#") & NL>
	</CFLOOP>
</CFIF>

<CFSET message = message & NL & "==========" & NL>
<CFSET message = message & "CGI VARIABLES" & NL>
<CFSET message = message & "==========" & NL>

<CFLOOP INDEX="var" LIST="SERVER_PORT,CONTENT_LENGTH,HTTP_CONTENT_LENGTH,HTTP_ACCEPT,HTTP_HOST,REMOTE_ADDR,CONTENT_TYPE,HTTP_REFERER,SERVER_PROTOCOL,HTTP_ACCEPT_LANGUAGE,HTTP_ACCEPT_CHARSET,URL_METHOD,CF_TEMPLATE_PATH,PATH_INFO,HTTP_USER_AGENT,REMOTE_HOST,AUTH_USER,AUTH_TYPE,SERVER_SOFTWARE,SERVER_NAME,QUERY_STRING,HTTP_ACCEPT_ENCODING,SCRIPT_NAME,REMOTE_USER,HTTP_CONTENT_TYPE,HTTP_COOKIE,AUTH_GROUP,HTTP_CONNECTION,PATH_TRANSLATED">
	<CFIF IsDefined("CGI.#var#")>
		<CFSET message = message & var & ": " & Evaluate("CGI.#var#") & NL>
	</CFIF>
</CFLOOP>

<CFIF IsDefined("URL.s6.util.trace")>
	<CFSET message = message & NL & "==========" & NL>
	<CFSET message = message & "DEBUG TRACE" & NL>
	<CFSET message = message & "==========" & NL>
	<CFSET message = message & URL.s6.util.trace & NL>
</CFIF>
<CFPARAM NAME="caller.#attributes.message#" DEFAULT="">
<CFSET "caller.#attributes.message#" = Evaluate("caller.#attributes.message#") & message>
<CFSETTING ENABLECFOUTPUTONLY="NO">
