<!---
toggle debug output on/off

Copyright (c) 1998 Sigma6 Inc.  All rights reserved.
$Id: debug.cfm,v 1.1 2000/02/07 17:12:15 lswanson Exp $
--->
<CFSETTING ENABLECFOUTPUTONLY=FALSE>
<CFHEADER NAME="expires" VALUE="NOW">

<CFSET debug = 0>
<CFIF IsDefined("cookie.debug")>
        <CFSET debug = cookie.debug>
</CFIF>
<CFSET newDebug = (debug + 1) MOD 3>
<CFIF newDebug GT 0>
        <CFCOOKIE NAME="debug" VALUE="#newDebug#">
<CFELSE>
        <CFCOOKIE NAME="debug" VALUE="#newDebug#" EXPIRES="NOW">
</CFIF>

<!--- if debug on, turn it off, and vis versa --->
<P>debug
        <CFSWITCH EXPRESSION="#newDebug#">
                <CFCASE VALUE="0">
                        <CFCOOKIE NAME="debug" VALUE="0" EXPIRES="NOW">
                        off
                </CFCASE>
                <CFCASE VALUE="1">
                        on
                </CFCASE>
                <CFCASE VALUE="2">
                        on, verbose on
                </CFCASE>
        </CFSWITCH>
</P>

<A HREF="javascript:document.location.reload(1)">next setting</A><BR>
<A HREF="javascript:void(window.history.back());">go back</A><BR>