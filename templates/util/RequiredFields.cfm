<!---
CFMODULE to check for required form fields or URL vars

Copyright (c) 1998 Sigma6 Inc.  All rights reserved.
$Id: RequiredFields.cfm,v 1.1 1999/08/03 21:03:45 wdvanloo Exp $
---><CFSETTING ENABLECFOUTPUTONLY="YES">

<!---
example usage:

<CFMODULE TEMPLATE="RequiredFields.cfm"
		requiredFields="firstName,lastName,streetAddress1|streetAddres2,zipCode"
		return="missingFields"
		isDebug="TRUE">
--->

<!--- is debugging on.  Optional, default is FALSE --->
<CFPARAM NAME="attributes.isDebug" DEFAULT="FALSE">
<CFSET isDebug = attributes.isDebug>

<!---
a list required fields.

The grammar:

requiredFields := fieldSet [, fieldSet]
fieldSet := formField [|formField]
formField := string

A field set is a pipe (|) seperated list of one or more form fields, of which
at least one must be defined as a FORM variable and be non-empty.  Non-empty
is defined as containing at least one non-space character.  Required
fields is a comma seperated list of field sets.

Examples.

1) The degenerative case:
requiredFields="firstName,lastName,email"

2) Using the field sets:
requiredFields="dayPhone|eveningPhone,address1|address2|address3"
--->
<CFPARAM NAME="attributes.requiredFields">
<CFIF isDebug>
	<CFOUTPUT>requiredFields: #attributes.requiredFields#<BR></CFOUTPUT>
</CFIF>

<!---
the name of the variable in caller's scope to return a list of form fields
that weren't defined or were empty.  Note: if at least one formField in a
fieldSet is defined and non-empty, then none of the fields in that fieldSet
are returned, otherwise all the fields in that fieldSet are returned.
--->
<CFPARAM NAME="attributes.return">
<CFIF isDebug>
	<CFOUTPUT>return: #attributes.return#<BR></CFOUTPUT>
</CFIF>

<!--- loop over comma seperated field sets --->
<CFSET missingFields = "">
<CFLOOP INDEX="fieldSet" LIST="#attributes.requiredFields#">
	<CFSET isValid = FALSE>
	<CFSET index = 1>
	<CFSET fieldSetLength = ListLen(fieldSet, "|")>
	
	<!--- loop over pipe seperated form fields --->
	<CFIF isDebug>
		<CFOUTPUT>validating fieldSet (#fieldSet#)<BR></CFOUTPUT>
	</CFIF>
	<CFLOOP CONDITION="(NOT isValid) AND (index LTE fieldSetLength)">
		<CFSET formField = ListGetAt(fieldSet, index, "|")>
		<CFSET fullyQualifiedFormField = "FORM.#formField#">
		
		<CFIF IsDefined("#formField#")>
			<CFIF Len(Trim(Evaluate("#formField#"))) GT 0>
				<CFSET isValid = TRUE>

				<CFIF isDebug>
					<CFOUTPUT>#formField# is valid<BR></CFOUTPUT>
				</CFIF>
			<CFELSEIF isDebug>
				<CFOUTPUT>#formField# is empty or contains only spaces<BR></CFOUTPUT>
			</CFIF>
		<CFELSEIF isDebug>
			<CFOUTPUT>#formField# undefined<BR></CFOUTPUT>
		</CFIF>
		<CFSET index = index + 1>
	</CFLOOP>

	<!--- append fields in fieldset to list of missing fields --->
	<CFIF NOT isValid>
		<CFIF fieldSetLength GT 1>
		
			<!--- change delims leaves an extra delimiter at the end --->
			<CFSET missingFields = ListChangeDelims(fieldSet,",","|")
					& missingFields>
			<!--- <CFSET missingFields = ListAppend(missingFields,
					ListChangeDelims(fieldSet,",","|"))> --->
		<CFELSE>
			<CFSET missingFields = ListAppend(missingFields, fieldSet)>
		</CFIF>
	</CFIF>
</CFLOOP>

<!--- return list of missing fields to caller --->
<CFIF isDebug>
	<CFOUTPUT>returning missing fields (#missingFields#) to CALLER.#attributes.return#<BR></CFOUTPUT>
</CFIF>
<CFSET "CALLER.#attributes.return#" = missingFields>

<CFSETTING ENABLECFOUTPUTONLY="NO">