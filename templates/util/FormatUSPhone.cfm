<!---
format input of U.S. phone number into raw and pretty formats

Copyright (c) 1998 Sigma6 Inc.  All rights reserved.
$Id: FormatUSPhone.cfm,v 1.1 1999/08/16 20:10:46 ttaylor Exp $
--->
<CFSET isError = FALSE>

<!--- some constants --->
<CFSET PHONE_NUMBER_LENGTH = 10>

<!--- U.S. phone number to format (required) --->
<CFPARAM NAME="attributes.phoneNumber">

<!--- name of variable in caller's scope to return raw phone number (required) --->
<CFPARAM NAME="attributes.returnRaw">

<!--- name of variable in caller's scope to return the raw extension (required) --->
<CFPARAM NAME="attributes.returnExtension">

<!--- name of variable in caller's scope to return the pretty format number (required) --->
<CFPARAM NAME="attributes.returnPretty">

<!--- name variable in caller's scope to return TRUE or FALSE if there was an error (required) --->
<CFPARAM NAME="attributes.returnIsError">

<CFSET raw = "">
<CFSET extension = "">
<CFSET pretty = "">
<CFSET stripped = REReplace(attributes.phoneNumber, "[^0-9]", "", "ALL")>
<CFIF REFind("1[2-9][0-9][0-9][2-9][0-9][0-9][0-9][0-9][0-9][0-9]", stripped) EQ 1>
	<CFSET phoneNumberLength = PHONE_NUMBER_LENGTH + 1>
	<CFSET start = 2>
<CFELSEIF REFind("[2-9][0-9][0-9][2-9][0-9][0-9][0-9][0-9][0-9][0-9]", stripped) EQ 1>
	<CFSET phoneNumberLength = PHONE_NUMBER_LENGTH>
	<CFSET start = 1>
<CFELSE>
	<CFSET isError = TRUE>
</CFIF>

<CFIF NOT isError>
	<CFSET raw = Left(stripped, phoneNumberLength)>
	<CFIF Len(stripped) GT phoneNumberLength>
		<CFSET extension = Right(stripped, Len(stripped) - phoneNumberLength)>
	</CFIF>
	<CFSET pretty = "(#Mid(stripped, start, 3)#) #Mid(stripped, start + 3, 3)#-#Mid(stripped, start + 6, 4)#">
	<CFIF Len(extension) GT 0>
		<CFSET pretty = pretty & " x" & extension>
	</CFIF>
	<CFSET "caller.#attributes.returnRaw#" = raw>
	<CFSET "caller.#attributes.returnExtension#" = extension>
	<CFSET "caller.#attributes.returnPretty#" = pretty>
	<CFSET "caller.#attributes.returnIsError#" = FALSE>
<CFELSE>
	<CFSET "caller.#attributes.returnIsError#" = TRUE>
</CFIF>