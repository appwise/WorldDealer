<CFSETTING ENABLECFOUTPUTONLY=TRUE>
<CFMODULE TEMPLATE="/util/DumpDebug.cfm" TEXT="begin $RCSfile: StaticPage.cfm,v $">
<!---
NAME:           CF_StaticPage
FILE:			StaticPage.cfm
CREATED:		04/21/1998
LAST MODIFIED:	04/22/1998
VERSION:	    1.0
AUTHOR:         Rob Bilson (rbils@amkor.com)
DESCRIPTION:    CF_StaticPage is a custom CFML tag that allows you to
				create static HTML pages from Cold Fusion templates.
				The tag requires CFHTTP and CFFILE and is DESCigned to work with
				Cold Fusion 3.1 or better.
				
				In addition to Cold Fusion templates, this tag will also work
				with ASP and other dynamically generated pages as well as 
				static HTML pages.
COPYRIGHT:		Copyright (C) 1998 by Rob Bilson, All Rights Reserved
				This program is free software; you can redistribute it
				and/or modify it under the terms of the GNU General Public
				License as published by the Free Software Foundation;
				either version 2 of the License, or any later version.

				This program is distributed in the hope that it will be
				useful, but WITHOUT ANY WARRANTY; without even the implied
				warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
				PURPOSE.  See the GNU General Public License for more
				details.
				
				You should have received a copy of the GNU General Public
				License along with this program; if not, write to the Free
				Software Foundation, Inc., 59 Temple Place - Suite 330,
				Boston, MA  02111-1307, USA.
KNOWN ISSUES:   None
--->

<!--- data validation and local variable assignments --->
<CFIF ISDEFINED("attributes.url")>
	<CFSET YourURL = attributes.url>
<CFELSE>
	<H2>You can't leave the parameter <B>URL</B> blank</H2>
	<CFABORT>
</CFIF>

<CFIF ISDEFINED("attributes.port")>
	<CFSET YourPort = attributes.port>
<CFELSE>
	<CFIF LEFT(YourUrl, 5) IS "https">
		<CFSET YourPort = 443>
	<CFELSE>
		<CFSET YourPort = 80>
	</CFIF>
</CFIF>

<CFIF ISDEFINED("attributes.UserName")>
	<CFSET YourUserName = attributes.UserName>
<CFELSE>
	<CFSET YourUserName = "">
</CFIF>

<CFIF ISDEFINED("attributes.Password")>
	<CFSET YourPassword = attributes.Password>
<CFELSE>
	<CFSET YourPassword = "">
</CFIF>

<CFIF ISDEFINED("attributes.ProxyServer")>
	<CFSET YourProxyServer = attributes.ProxyServer>
<CFELSE>
	<CFSET YourProxyServer = "">
</CFIF>

<CFIF ISDEFINED("attributes.FileOnServer")>
	<CFSET YourFileOnServer = attributes.FileOnServer>
<CFELSE>
	<H2>You can't leave the parameter <B>FileOnServer</B> blank</H2>
	<CFABORT>
</CFIF>

<!--- make sure the filename for the file being created ends in .htm or .html --->
<!--- more extensions could be added here if necessary or DESCired --->
<!--- <CFIF Right(YourFileOnServer, 5) IS NOT ".html" >
<CFIF Right(YourFileOnServer, 4) IS NOT ".htm">
	<H2>The attribute <B>FileOnServer</B> must contain a filename with a .htm or .html extension</H2>
	<CFABORT>
</CFIF>
<H2>The attribute <B>FileOnServer</B> must contain a filename with a .htm or .html extension</H2>
</CFIF>

<CFOUTPUT>Right(YourFileOnServer, 5): #Right(YourFileOnServer, 5)#</cfoutput> --->

<CFIF ISDEFINED("attributes.ResolveURL")>
	<CFSET YourResolveURL = attributes.ResolveURL>
<CFELSE>
	<CFSET YourResolveURL = "No">
</CFIF>



<!--- plug variable values into cfhttp and execute the remote cfm file --->
<CFHTTP METHOD="GET"
		URL="#YourURL#"
		PORT="#YourPort#"
        USERNAME="#YourUserName#"
        PASSWORD="#YourPassword#"
        RESOLVEURL="#YourResolveURL#"
		PROXYSERVER="#YourProxyServer#">
</CFHTTP>
<CFSET tempArray = ListToArray(attributes.PageList)>

<CFSET tempFileContent= CFHTTP.FileContent>




<!--- <cfloop index="loop" from="1" to="#ArrayLen(tempArray)#">


<CFSET tempSearch = 'index.cfm?location=' & tempArray[loop] & chr(34)>
<CFSET tempFound = 'page' & tempArray[loop] & '.htm' & chr(34)>

<CFSET tempFileContent=ReplaceNoCase(tempFileContent, tempSearch, tempFound , "ALL")>


<CFSET waitUntil = DateAdd('S', 10, Now())>

<cfloop condition="TRUE">
<CFIF DateCompare(Now(), waitUntil) GTE 0><CFBREAK></cfif>

</cfloop>

</cfloop>
 --->



<!--- write the file grabbed by cfhttp to a new html file on the server --->
<CFFILE ACTION="write"
		FILE="#YourFileOnServer#"
		OUTPUT="#tempFileContent#">		

<!--- send a variable back to the calling template with the contents of the new file --->		
<CFSET caller.FileContent=#CFHTTP.FileContent#>
<CFMODULE TEMPLATE="/util/DumpDebug.cfm" TEXT="end   $RCSfile: StaticPage.cfm,v $">
<CFSETTING ENABLECFOUTPUTONLY=FALSE>
