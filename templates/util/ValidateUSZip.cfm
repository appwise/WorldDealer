<!---
CFMODULE to validate a U.S. zipcode

Copyright (c) 1998 Sigma6 Inc.  All rights reserved.
$Id: ValidateUSZip.cfm,v 1.2 1999/08/24 02:56:26 wdvanloo Exp $
---><CFSETTING ENABLECFOUTPUTONLY="YES">

<!---
example usage:

<CFMODULE TEMPLATE="ValidateUSZip.cfm"
		zipCode="#ZipCode#">
--->

<!---this template checks if a zip code is in the valid US format...
     5 digits, or 5 digits, followed by '-', followed by four more digits.
	 the variable validZip is true if the zip is valid, false otherwise --->

		<CFIF Len(attributes.zipCode) EQ 5>
			<cfloop index="zipCheckLoop" from="1" to="5">
			<CFOUTPUT>
			<!--- #step# : #Mid(attributes.zipCode, zipCheckLoop, 1)#  #Asc(Mid(attributes.zipCode, zipCheckLoop, 1))#--->
			</CFOUTPUT>
				<CFIF ((Asc(Mid(attributes.zipCode, zipCheckLoop, 1)) LT 48) OR (Asc(Mid(attributes.zipCode, zipCheckLoop, 1)) GT 57))>
					<CFSET Caller.validZip = 0>
					<CFBREAK>
				<CFELSE>
					<CFSET Caller.validZip = 1>
				</CFIF>
			</CFLOOP>
		<CFELSEIF Len(attributes.zipCode) EQ 10>
			<cfloop index="zipCheckLoop" from="1" to="10">
				<CFIF zipCheckLoop NEQ 6>
					<CFIF ((Asc(Mid(attributes.zipCode, zipCheckLoop, 1)) LT 48) OR (Asc(Mid(attributes.zipCode, zipCheckLoop, 1)) GT 57))>
						<CFSET Caller.validZip = 0>
						<CFBREAK>
					<CFELSE>
						<CFSET Caller.validZip = 1>
					</CFIF>
				<CFELSEIF zipCheckLoop EQ 6>
					<CFIF (Asc(Mid(attributes.zipCode, zipCheckLoop, 1)) NEQ 45)>
						<CFSET Caller.validZip = 0>
						<CFBREAK>
					<CFELSE>
						<CFSET Caller.validZip = 1>						
					</CFIF>
				</CFIF>
			</CFLOOP>
		<CFELSE>
			<CFSET Caller.validZip = 0>
		</CFIF>

<CFSETTING ENABLECFOUTPUTONLY="NO">