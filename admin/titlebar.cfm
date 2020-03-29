<script language="JavaScript">
<!-- Hide Script
   function resetTimer() {
      clearTimeout(timerID);
      startTimer();
   }
// 600000 milliseconds equals 10 minutes
   function startTimer() {
      timerID = setTimeout
("alert('Your session will time-out in less than 5 minutes.  We suggest that you click the refresh button --F5-- on your browser to reset this timer.')",600000);
   }
// End Hide Script-->
</script>

<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: titlebar.cfm,v $">
                         <!--- Created by AppNet, Inc., Detroit
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 11, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->            
<!---$Id: titlebar.cfm,v 1.21 2000/02/29 17:36:58 lswanson Exp $--->

<cfif IsDefined("getUserInfo.RowID")>
	<cfquery name="getUserName" datasource="#gDSN#">
		SELECT	Name
		FROM	Accounts
		WHERE 	RowID = #getUserInfo.RowID#
	</cfquery>
</cfif>

<cfif IsDefined("g_dealercode")>
	<cfquery name="getDlrName" datasource="#gDSN#">
		SELECT	DealershipName as Name
		FROM	Dealers
		WHERE	DealerCode = '#g_dealercode#'
	</cfquery>
	
	<cfquery name="totalLeads" datasource="#gDSN#">
		SELECT	RequestInfoID
		FROM	RequestInfoGeneral
		WHERE	Dealercode = '#g_dealercode#'
	</cfquery>
</cfif>

<cfoutput>
<body onLoad="startTimer()">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr bgcolor="666666">
	<td width="5">&nbsp;</td>
	<!--- Dealership Name --->
	<td align="LEFT">
		<font color="ffcc00">
		<cfif IsDefined("getUserInfo.RowID")>
			<b>#getUserName.Name# <cfif IsDefined("g_dealercode")> -- </cfif></b>
		</cfif>
		<cfif IsDefined("g_dealercode")>
			<b>#getDlrName.Name#</b>
		<cfelse>
			&nbsp;
		</cfif>
		</font>
	</td>
	<!--- today's date --->
	<td align="RIGHT">
 		<font size=-1 color="ffcc00">
 		#DateFormat(Now(), "mmmm d, yyyy")#
		</font>
	</td>
	<td width="5">&nbsp;</td>
</tr>
<tr bgcolor="888888">
	<td width="5">&nbsp;</td>
	<!--- Title of Page --->
	<td align="left">
		<cfif IsDefined("title")>
			<font color="ffffff">
			<b>#title#</b>
			</font>
		<cfelse>
			&nbsp;
		</cfif>
	</td>
	<!--- Total Leads --->
	<td align="RIGHT">
		<cfif IsDefined("g_dealercode")>
			<a href="#application.RELATIVE_PATH#/admin/reports/leads.cfm?dealer=#g_dealercode#" class="titlebar"><font color="ffcc00"><b>Total Leads:</b></font></a> <font color="ffcc00">#totalLeads.RecordCount#</font>
		<cfelse>
			&nbsp;
		</cfif>
	</td>
	<td width="5">&nbsp;</td>
</tr>
</table>
</cfoutput>
<cfmodule template="/util/DumpDebug.cfm" text="end   $RCSfile: titlebar.cfm,v $">
</body>