<cfset PageAccess = application.dealer_access>

                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 10, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
						  
<!---$Id: coupons_main.cfm,v 1.17 2000/03/21 16:11:01 jkrauss Exp $--->

<cfquery name="getCoupons" datasource="#gDSN#">
	SELECT	VirtualCouponID, Description
	FROM	VirtualCoupons INNER JOIN DealerWebs ON VirtualCoupons.DealerWebID = DealerWebs.DealerWebID
 	WHERE	Status='A'
	AND		dealercode = '#g_dealercode#'
</cfquery>

<cfquery name="getDlrArtTemp" datasource="#gDSN#">
	SELECT 	ArtTempID 
	FROM 	DealerWebs
	WHERE 	DealerCode = '#g_dealercode#'
</cfquery>

<cfset justmodified = "false">
<cfif ParameterExists(url.mod)>
	<cfset justmodified = "true">
</cfif>

<form name="coupons" action="coupons_action.cfm" method="POST">
<table border="0" cellspacing="0" cellpadding="3">
<cfif #getcoupons.recordcount#>
	<tr>
		<td>
			This application gives you the ability to create the coupons that appear on the Coupons page of your dealership's Website.  Site visitors can then print out these coupons and redeem them at your dealership.<p>
			Please select a coupon and click on 'Modify' or 'Delete' below.  Or, click the 'Add' button below to add a coupon.
			<br><br>
		</td>
	</tr>
	<tr>
		<td align="center">
			<table border=0 cellspacing=3 cellpadding=0>
			<cfloop query="getCoupons">
				<tr>
					<td align="center" valign="middle">
						<input type="radio" name="CouponID" value="<CFOUTPUT>#VirtualCouponID#</cfoutput>" <cfif #getcoupons.currentrow# eq 1>CHECKED</cfif>>
					</td>
					<td>
						<cfoutput>
						<img src="#application.RELATIVE_PATH#/images/coupons/#Trim(g_dealerCode)#_#getDlrArtTemp.ArtTempID#_#VirtualCouponID#_coupon.gif">
						</cfoutput>
					</td>
				</tr>
			</cfloop>
			</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<cfif justmodified>
	<tr>
		<td align="CENTER">
			<table border="0" cellspacing="0" cellpadding="0"><tr><td>
			<font color="Red"><b>NOTE:</b></font><br>
			You may have to refresh your browser window<br>
			to see the changes you've just made.
			</td></tr></table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	</cfif>
	<tr>
		<td align="center">
			<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/modify.gif" BORDER="0" name="Modify" value="Modify">
			&nbsp;&nbsp;&nbsp;
			<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/deletebutton.gif" BORDER="0" name="Delete" value="Delete">
		</td>
	</tr>
	<tr>
		<td align="center">
			<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/add.gif" BORDER="0" name="Add" value="Add">
		</td>
	</tr>
<cfelse>
	<tr>
		<td>
			This application gives you the ability to create the coupons that appear on the Coupons page of your dealership's Website.  Site visitors can then print out these coupons and redeem them at your dealership.<p>
			There are currently NO Coupons Associated with this Dealership.  Click the 'Add' button below to add a coupon.
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr align="center">
		<td>
			<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/add.gif" BORDER="0" name="Add" value="Add">
		</td>
	</tr>
</cfif>
</table>
</form>