<CFSETTING ENABLECFOUTPUTONLY=TRUE>
<!---
Dump a CFML exception into a mail message.

Copyright (c) 1998, 1999, 2000 AppNet Inc.  All rights reserved.

$Id: DumpException.cfm,v 1.5 2000/02/16 21:06:58 jsturm Exp $
--->

<!--- time of exception --->
<CFIF IsDefined("ATTRIBUTES.time")>
	<CFSET now = ATTRIBUTES.time>
<CFELSE>
	<CFSET now = Now()>
</CFIF>

<!--- who to notify --->
<CFIF IsDefined("ATTRIBUTES.mailTo")>
	<CFSET errorMailTo = ATTRIBUTES.mailTo>
<CFELSE>
	<CFSET errorMailTo = CALLER.errorMailTo>
</CFIF>

<!--- return address --->
<CFIF IsDefined("ATTRIBUTES.mailFrom")>
	<CFSET adminMailTo = ATTRIBUTES.mailFrom>
<CFELSE>
	<CFSET adminMailTo = CALLER.adminMailTo>
</CFIF>

<!--- the exception itself --->
<CFIF IsDefined("ATTRIBUTES.exception")>
	<CFSET exception = ATTRIBUTES.exception>
<CFELSE>
	<CFSET exception = CALLER.cfcatch>
</CFIF>

<CFSET NL = Chr(10)>

<CFSET message = "">
<CFSET message = message & RepeatString("=", 78) & NL>
<CFSET message = message & "UNHANDLED EXCEPTION" & NL>
<CFSET message = message & RepeatString("=", 78) & NL>
<CFSET message = message & "time: " & DateFormat(now) & TimeFormat(now, "HH:mm:ss") & NL> 
<CFSET message = message & "type: " & exception.type & NL>

<CFLOOP INDEX="catchVar" LIST="NativeErrorCode,SQLState,ErrNumber,MissingFileName,lockName,lockOperation">
	<CFIF IsDefined("exception.#catchVar#")>
		<CFSET message = message & catchVar & ": " 
				& Evaluate("exception.#catchVar#") & NL>
	</CFIF>
</CFLOOP>

<CFSET message = message & "message: " & exception.message & NL>
<CFSET message = message & NL & "======" & NL>
<CFSET message = message & "DETAIL" & NL>
<CFSET message = message & "======" & NL>

<!--- must use </PRE> ...<PRE> kludge since exception.detail contains HTML content --->
<CFSET message = message & "</pre>" & exception.detail & "<pre>" & NL>
<CFMODULE TEMPLATE="DumpRequest.cfm" message="message">
<CFSET message = message & RepeatString("=", 78) & NL>

<CFIF NOT IsDefined("cookie.debug")>
	<CFMAIL TO=#errorMailTo#
			FROM=#adminMailTo#
			SUBJECT="Server Error: #CGI.REMOTE_ADDR# @ #DateFormat(now, 'MM/DD/YY')# #TimeFormat(now, 'HH:mm:ss')#">#message#</CFMAIL>
<CFELSE>
	<CFOUTPUT><pre>#message#</pre></CFOUTPUT>
</CFIF>

<CFSETTING ENABLECFOUTPUTONLY=FALSE>
