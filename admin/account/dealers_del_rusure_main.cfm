                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <February 8, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: dealers_del_rusure_main.cfm,v 1.11 2000/06/16 02:05:10 lswanson Exp $ --->
<!--- Are you sure you want to delete this dealer? --->

<cfif g_dlr>
	<!--- Are you sure you want to delete this dealer? --->
	<cfquery name="getDealer" datasource="#gDSN#">
		SELECT	Dealers.DealershipName, 
				Dealers.City, 
				Dealers.StateAbbr, 
				Dealers.URL, 
				WebStates.Description as Webstate
		FROM 	Dealers 
				INNER JOIN WebStates ON Dealers.WebStateID = WebStates.WebStateID
		WHERE 	Dealers.DealerCode = '#g_dealercode#'
	</cfquery>
	
	<div align="center">
	<table border=0 cellpadding=10 cellspacing=0>
	<cfif #getdealer.recordcount#>
		<tr align="center">
			<td>
				<font size="+1" color="ff0000">C A U T I O N ! !</font>
			</td>
		</tr>
		<tr align="center">
			<td>
				You are about to permanently DELETE all Websites and references to the following Dealership.
				<br><br>
				Are you sure you wish to completely erase this dealership?
			</td>
		</tr>
		<tr align="center">
			<td>
				<table border=0 cellpadding=5 cellspacing=0>
				<cfoutput query="GetDealer">
				<tr>
					<td align="right">
						Dealership:
					</td>
					<td align="left">
						<b>#DealershipName#</b>
					</td>
				</tr>
				<tr>
					<td align="right">
						Dealer Code:
					</td>
					<td align="left">
						<b>#g_dealercode#</b>
					</td>
				</tr>
				<tr>
					<td align="right">
						City, State:
					</td>
					<td align="left">
						<b>#City#, #StateAbbr#</b>
					</td>
				</tr>
				<tr>
					<td align="right">
						Primary URL:
					</td>
					<td align="left">
						<b>#URL#</b>
					</td>
					</tr>
					<tr>
						<td align="right">
							Web State:
						</td>
					<td align="left">
						<b>#WebState#</b>
					</td>
				</tr>
				</cfoutput>
				</table>
			</td>
		</tr>
		<tr align="center">
			<td>
				<form action="dealers_del.cfm" method="post">
				<a href="dealers.cfm"><img src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/cancel.gif" BORDER="0" width="47" height="15" alt="Cancel"></a>
				&nbsp;&nbsp;
				<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/deletebutton.gif" Border="0" width="47" height="15" name="Delete" value="Delete">
				</form>
			</td>
		</tr>
	<cfelse>
		<tr align="center">
			<td>
				<b>This Dealership does not have a Website.</b>
			</td>
		</tr>
	</cfif>	
	</table>
<cfelseif g_col>
	<!--- Are you sure you want to delete this collection of dealers? --->
	
	<cfquery name="getDealer" datasource="#gDSN#">
		SELECT	Dealers.DealershipName, 
				Dealers.City, 
				Dealers.StateAbbr, 
				Dealers.URL, 
				WebStates.Description as Webstate
		FROM 	Dealers 
				INNER JOIN WebStates ON Dealers.WebStateID = WebStates.WebStateID
		WHERE 	Dealers.DealerCode = '#g_dealercode#'
	</cfquery>
	
	<cfif #getdealer.recordcount#>
		<cfquery name="getCollDlrs" datasource="#gDSN#">
			SELECT	Dealers.DealershipName
			FROM	CollectionDealers INNER JOIN Dealers ON CollectionDealers.DealerCode = Dealers.DealerCode
			WHERE 	CollectionDealers.Coll_DealerCode = '#g_dealercode#'
		</cfquery>
	</cfif>
	
	<div align="center">
	<table border=0 cellpadding=10 cellspacing=0>
	<cfif #getdealer.recordcount# gt 0>
		<tr align="center">
			<td>
				<font size="+1" color="ff0000">C A U T I O N ! !</font>
			</td>
		</tr>
		<tr align="center">
			<td>
				You are about to permanently DELETE all websites and references to the following Collection,<br>
				including the following Dealerships:<br>
				<cfoutput query="getCollDlrs">
					<br><b>#DealershipName#</b>
				</cfoutput>	
				<br><br>
				Are you sure you wish to completely erase this Collection?
			</td>
		</tr>
		<tr align="center">
			<td>
				<table border=0 cellpadding=5 cellspacing=0>
				<cfoutput query="GetDealer">
				<tr>
					<td align="right">
						Collection:
					</td>
					<td align="left">
						<b>#DealershipName#</b>
					</td>
				</tr>
				<tr>
					<td align="right">
						Dealer Code:
					</td>
					<td align="left">
						<b>#g_dealercode#</b>
					</td>
				</tr>
				<tr>
					<td align="right">
						City, State:
					</td>
					<td align="left">
						<b>#City#, #StateAbbr#</b>
					</td>
				</tr>
				<tr>
					<td align="right">
						Primary URL:
					</td>
					<td align="left">
						<b>#URL#</b>
					</td>
				</tr>
				<tr>
					<td align="right">
						Web State:
					</td>
					<td align="left">
						<b>#WebState#</b>
					</td>
				</tr>
				</cfoutput>
				</table>
			</td>
		</tr>
		<tr align="center">
			<td>
				<form action="dealers_del.cfm" method="post">
				<a href="dealers.cfm"><img src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/cancel.gif" BORDER="0" width="47" height="15" alt="Cancel"></a>
				&nbsp;&nbsp;
				<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/deletebutton.gif" Border="0" width="47" height="15" name="Delete" value="Delete">
				</form>
			</td>
		</tr>
	<cfelse>
		<tr align="center">
			<td>
				<b>This Collection does not have a Website.</b>
			</td>
		</tr>
	</cfif>
	</table>
</cfif>