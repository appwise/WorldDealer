<cfset PageAccess = application.dealer_access>

                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 11, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!--- $Id: showroom_incent_del_rusure_main.cfm,v 1.9 2000/03/21 16:11:03 jkrauss Exp $ --->
<!--- Showroom: Delete Vehicle Incentives --->


<cfif #url.all# is false>
	<!--- Only one offer selected for deletion --->
	<cfquery name="getoffer" datasource="#gDSN#">
		SELECT 	Offers.Name,
				Offers.Description as offerDescription,
				Offers.ExpirationDate,
				Offertypes.Description as offertype,
				Models.Description as ModelDescription
		FROM 	DealerWebs 
				INNER JOIN DealerOffers ON DealerWebs.DealerWebID = DealerOffers.DealerWebID
				INNER JOIN Offers ON DealerOffers.OfferID = Offers.OfferID
				INNER JOIN OfferTypes ON Offers.OfferTypeID = OfferTypes.OfferTypeID
				INNER JOIN Models ON Offers.ModelID = Models.ModelID
		WHERE 	DealerWebs.DealerCode = '#g_dealercode#' AND
				Offers.OfferID=#URL.OfferID#
   	 </cfquery>
</cfif>

<table border="0" cellpadding="5" cellspacing="0" width="100%">
<cfif #url.all# is true>
	<!--- DELETE ALL OFFERS --->
	<tr>
		<td align="center" colspan="2">
			<br>
			<b>You are about to permanently delete <font color="#ff0000">ALL</font> offers associated with this dealership.<br><br>
			Are you sure?</b><br><br>
		</td>
	</tr>
<cfelse>
	<!--- Only One Offer selected for Deletion --->
	<tr align="center">
		<td colspan="2">
			<br>
			<b>You about about to permanently delete the following offer.<br>
			Are you sure?</b><br><br>
		</td>
	</tr>
	<cfoutput query="getoffer">
	<tr>
		<td align="right">
			<b>Model:</b>
		</td>
		<td>
			#ModelDescription#
		</td>
	</tr>
	<tr>
		<td align="right">
			<b>Offer Name:</b>
		</td>
		<td>
			#Name#
		</td>
	</tr>
	<tr>
		<td align="right" valign="top">
			<b>Offer Text:</b>
		</td>
		<td>
			#Replace(offerDescription, chr(13), "<BR>", "ALL")#
		</td>
	</tr>
	<tr>
		<td align="right">
			<b>Type:</b>
		</td>
		<td>
			#offertype#
		</td>
	</tr>
	<tr>
		<td align="right">
			<b>Expiration Date:</b>
		</td>
		<td>
			#DateFormat(ExpirationDate,"mm/dd/yyyy")#
		</td>
	</tr>
	</cfoutput>

</cfif>

<tr><td>&nbsp;</td></tr>
<tr align="center">
	<td colspan="2">
		<form action="showroom_incent_del.cfm" method="post">
		<input type="hidden" name="offerID" value="<cfoutput>#URL.OfferID#</cfoutput>">
		<input type="hidden" name="all" value="<cfoutput>#URL.all#</cfoutput>">
		<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/deletebutton.gif" BORDER="0" name="Delete" value="Delete">
		</form>
		<form action="showroom_incent.cfm" method="post">
		<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/cancel.gif" BORDER="0" NAME="Cancel" VALUE="Cancel">
		</form>
	</td>
</tr>
</table>
