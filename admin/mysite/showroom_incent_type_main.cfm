<cfset PageAccess = application.dealer_access>

                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 11, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!--- $Id: showroom_incent_type_main.cfm,v 1.7 2000/03/21 16:11:03 jkrauss Exp $ --->
<!--- Showroom: Vehicle Incentives, Type of Incentive (National, Regional, Custom) --->

<cfquery name="getOfferTypes" datasource="#gDSN#">
	SELECT 	OfferTypeID,
			Description
	FROM	OfferTypes
	ORDER BY Description
</cfquery>

<form name="incent_type" action="showroom_incent_type_chosen.cfm" method="post">
<table width="100%" border="0" cellpadding="10" cellspacing="0">
	<tr align="center">
		<td>
			Select the type of Incentive you wish to add.
		</td>
	</tr>
	<tr align=center>
		<td>
			<select name="offertype">
				<cfoutput query="getOfferTypes">
					<option value="#OfferTypeID#">#Description#
				</cfoutput>
			</select>
		</td>
	</tr>
	<tr align="center">
		<td>
			<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/next.gif" BORDER="0" name="Next" value="Next">
			</form>
			<form name="cancel" action="showroom_incent.cfm" method="post">
			<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/cancel.gif" BORDER="0" NAME="Cancel" VALUE="Cancel">
			</form>
		</td>
	</tr>
	</form>
</table>
