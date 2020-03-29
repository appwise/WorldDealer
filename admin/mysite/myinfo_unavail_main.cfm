                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <February 23, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: myinfo_unavail_main.cfm,v 1.4 2000/03/08 22:56:20 lswanson Exp $--->

<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: myinfo_unavail_main.cfm,v $">

<cfquery name="GetConflictName" datasource="#gDSN#">
	SELECT DealershipName
	FROM Dealers
	WHERE DealerCode = '#URL.new#';
</cfquery>

<cfquery name="GetDLRName" datasource="#gDSN#">
	SELECT DealershipName
	FROM Dealers
	WHERE DealerCode = '#URL.orig#';
</cfquery>

<table border=0 cellpadding=0 cellspacing=0 width="100%">
<tr align="center">
	<td><br><h4>Duplicate Dealer Code</h4></td>
</tr>
<tr align="center">
	<td>
		<cfoutput>
		Sorry.  The Dealercode you have chosen, <b>#URL.new#</b>, 
		<br>
		is already being used by <b>#GetConflictName.DealershipName#</b>.
		<br><br>
		The following Dealercode: <b>#URL.orig#</b>,
		<br>
		for Dealership <b>#GetDLRName.Dealershipname#</b>,
		<br>
		was NOT changed.
		<br><br>
		After clicking the Back button below, click "Reload" in your browser.
		</cfoutput>
	</td>
</tr>
<tr align="center">
	<td>
		<br>
		<a href="JavaScript:history.back()"><img
			src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/back.gif" BORDER=0 ALT="Back"></a>
	</td>
</tr>
</table>
<cfmodule template="/util/DumpDebug.cfm" text="end   $RCSfile: myinfo_unavail_main.cfm,v $">

