<!--- $Id: killcookie.cfm,v 1.2 1999/11/29 16:34:04 lswanson Exp $ --->

<CFCOOKIE expires="NOW" name="FORDAccess">
<CFSET blah=#DeleteClientVariable("FORDAccess")#>
Done