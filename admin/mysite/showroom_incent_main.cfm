<cfset PageAccess = application.dealer_access>

                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 11, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!--- $Id: showroom_incent_main.cfm,v 1.9 2000/03/21 16:11:03 jkrauss Exp $ --->
<!--- Main Showroom: Vehicle Incentives page --->

<!--- get all existing offers --->
<cfquery name="getDLROffers" datasource="#gDSN#">
	SELECT 	Offers.OfferID,
			Offers.Name,
			Offertypes.Description as incentType,
			Offers.ExpirationDate,
			Models.Description as modelDescription,
			Makes.MakeName
	FROM 	DealerWebs 
			INNER JOIN DealerOffers ON DealerWebs.DealerWebID = DealerOffers.DealerWebID
			INNER JOIN Offers ON DealerOffers.OfferID = Offers.OfferID
			INNER JOIN OfferTypes ON Offers.OfferTypeID = OfferTypes.OfferTypeID
			INNER JOIN Models ON Offers.ModelID = Models.ModelID
			INNER JOIN Makes ON Models.Make = Makes.MakeNumber
	WHERE 	DealerWebs.DealerCode = '#g_dealercode#' AND
			Offers.ExpirationDate >= #CreateODBCDate(DateFormat(Now(), "mm/dd/yyyy"))#
	ORDER BY Makes.MakeName,
			Models.Description, 
			Offers.ExpirationDate;
</cfquery>


<table border=0 cellpadding=10 cellspacing=0 width="100%">
<cfif #getdlroffers.recordcount# eq 0>
	<tr align="center">
		<td>
			There are currently NO incentives associated with this dealership.
		</td>
	</tr>
<cfelse>
	<form name="Incentives" action="showroom_incent_edit.cfm" method="post">
	<tr align="center">
		<td>
			Please select the incentive you wish to modify.
		</td>
	</tr>
	<tr align="center">
		<td>
			<table border=1 cellpadding=5 cellspacing=0>
			<tr>
				<td>&nbsp;</td>
				<td><b>Make</b></td>
				<td><b>Model</b></td>
				<td><b>Incentive Name</b></td>
				<td><b>Incentive Type</b></td>
				<td><b>Expiration Date</b></td>
			</tr>
			<cfoutput query="getDLRoffers">
			<tr>
				<td><input type="radio" name="offerID" value="#offerID#" <cfif #getdlroffers.currentrow# eq 1>CHECKED</cfif>></td>
				<td>#MakeName#</td>
				<td>#modelDescription#</td>
				<td>#Name#</td>
				<td>#incentType#</td>
				<td>#DateFormat(expirationdate,"mm/dd/yyyy")# </td>
			</tr>
			</cfoutput>
			</table>
		</td>
	</tr>
	<tr align=center>
		<td>
			<br>
			<CFOUTPUT>
			<input type="Image" src="#application.RELATIVE_PATH#/images/admin/modify.gif" BORDER="0" NAME="Modify" VALUE="Modify Incentive">&nbsp;&nbsp;&nbsp;
			<input type="Image" src="#application.RELATIVE_PATH#/images/admin/deletebutton.gif" BORDER="0" name="Delete" VALUE="Delete Incentive">&nbsp;&nbsp;&nbsp;
			<input type="Image" src="#application.RELATIVE_PATH#/images/admin/deleteall.gif" BORDER="0" name="DeleteAll" VALUE="Delete All Incentives">
			</cfoutput>
			</form>
		</td>
	</tr>
</cfif>

<tr align="center">
	<td>
		<form name="AddIncentive" action="showroom_incent_type.cfm" method="post">
		<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/add.gif" BORDER="0" NAME="Add" VALUE="Add New Incentive">
		</form>
		<form name="Cancel" action="showroom.cfm" method="post">
		<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/cancel.gif" BORDER="0" NAME="Cancel" VALUE="Cancel">
		</form>
	</td>
</tr>
</table>
