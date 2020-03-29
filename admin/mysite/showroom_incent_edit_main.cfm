<cfset PageAccess = application.dealer_access>

                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 13, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!--- $Id: showroom_incent_edit_main.cfm,v 1.12 2000/03/21 16:11:03 jkrauss Exp $ --->
<!--- Showroom: Add/Edit Custom Dealership Vehicle Incentives --->

<!--- if Delete, redirect to delete form --->
<cfif #isdefined("form.Delete.X")# or #isdefined("form.DeleteAll.X")#>
	<cfif #isdefined("Form.DeleteAll.X")#>
		<cfset all = true>
	<cfelse>
		<cfset all = false>
	</cfif>
	<cflocation url="showroom_incent_del_rusure.cfm?OfferID=#form.OfferID#&all=#all#">
</cfif>


<cfoutput>
<cfif #isdefined("form.offerID")#>
	<cfset editmode = true>
	<cfquery name="getDLROffer" datasource="#gDSN#">
		SELECT 	Offers.ModelID,
				Offers.Name,
				Offers.Description as offerDescription,
				Offers.ExpirationDate,
				Offers.OfferTypeID,
				Offertypes.Description as offerType,
				OfferDisclaimers.TemplateID
		FROM 	DealerWebs 
				INNER JOIN DealerOffers ON DealerWebs.DealerWebID = DealerOffers.DealerWebID
				INNER JOIN Offers ON DealerOffers.OfferID = Offers.OfferID
				INNER JOIN OfferTypes ON Offers.OfferTypeID = OfferTypes.OfferTypeID
				INNER JOIN OfferDisclaimers ON Offers.DisclaimerID = OfferDisclaimers.DisclaimerID
		WHERE 	DealerWebs.DealerCode = '#g_dealercode#' AND
				Offers.OfferID = #form.OfferID#;
	</cfquery>
	
	<cfset theoffertype = #getdlroffer.offertypeid#>
<cfelse>
	<cfset editmode = false>
	<cfset theoffertype = 2>  <!--- New Dealer Incentive --->
</cfif>

<table border="0" cellpadding="5" cellspacing="0" width="100%">
<!--- If they're trying to edit a National/Regional Incentive, give them error message that they're not allowed to. --->
<cfif #theoffertype# neq 2>  <!--- Not a Dealer (Custom) Incentive --->
	<tr align="center">
		<td colspan="2">
			Sorry, the Incentive you selected is a #GetDLROffer.offerType# Offer.<br>
			This Incentive may only be edited by an Account Coordinator.<br>
			Click the <b>Cancel</b> button below to try again.
		</td>
	</tr>
<cfelse>  <!--- It IS a Dealer (Custom) Incentive --->
	<!--- <form name="DealerIncentives" action="showroom_incent_photo.cfm" method="post"> --->
	<form name="DealerIncentives" action="showroom_incent_discl.cfm" method="post">
	<!--- Select a Model --->
	<tr>
		<td align="right">
			<b>Select a Model</b>
		</td>
		<td>
	 		<!--- get Makes for dealership --->	
			<cfquery name="getDlrMakes" datasource="#gDSN#">
				SELECT 	Makes.MakeNumber,
						MakeName
				FROM 	Makes INNER JOIN DealerFranchise ON Makes.MakeNumber = DealerFranchise.MakeNumber
				WHERE	DealerFranchise.dealercode = '#g_dealercode#'
			</cfquery>

			<!--- Drop-down box of MakeName & all models under that make --->
	   	    <select name="modelid">
			<cfloop query="getDlrMakes">
				<option value=""><b>#UCase(MakeName)#</b> 
				<option value=""><b>------------------</b> 
				<!--- get all vehicles for the make we're on --->
				<cfquery name="getvehiclelist" datasource="#gDSN#">
					SELECT	description,
  		    				VehicleType,
							modelid
					FROM	models
					Where   Make = #getDlrMakes.MakeNumber#
					ORDER BY VehicleType, description ASC
				</cfquery>
		
				<cfset prevcartype=" ">
	
				<!--- get all vehicles for the make we're on --->
				<cfloop query="getvehiclelist">
					<!--- If new vehicle type, do white space, vehicle type, underline --->
					<cfif #prevcartype# is not #vehicletype#>
		    			<cfset prevcartype=#vehicletype#>
						<option value="">
						<cfswitch expression="#VehicleType#">
							<cfcase value="c"><option value="">Cars</cfcase>
							<cfcase value="s"><option value="">Sport Utility Vehicles</cfcase>									
							<cfcase value="t"><option value="">Trucks</cfcase>									
							<cfcase value="v"><option value="">Vans</cfcase>									
						</cfswitch>
 								<option value="">--------------------
		    				</cfif>
    				<option value="#modelid#" <cfif editmode><cfif #getdlroffer.modelid# eq #getvehiclelist.modelid#>SELECTED</cfif></cfif>>#description#					
				</cfloop>
				<option value="">
			</cfloop>
			</select>
			<input type="hidden" name="modelid_required" value="<A HREF='Javascript:history.back();'>Please select your vehicle model.</a>">
		</td>
	</tr>

	<!--- Incentive Name --->
	<tr>
		<td align="right">
			<b>Incentive Name</b>
		</td>
		<td>
			<input type="text"
				name="offer_name"
				size="35"
				maxlength="35" 
				value="<cfif EditMode>#getdlroffer.Name#</cfif>">
			<input type="hidden" name="offer_name_required" value="Incentive Name Required">
		</td>
	</tr>
	
	<!--- Incentive Description --->
	<tr>
		<td align="right" valign="top">
			<b>Incentive Description</b>
		</td>
		<td>
			<textarea name="offer_body"
				cols="35"
				rows="10"
				wrap="PHYSICAL"><cfif editmode>#Replace(getDLROffer.OfferDescription,"<BR>",Chr(13),"ALL")#</cfif></textarea>
			<input type="hidden" name="offer_body_required" value="Incentive Description Required">
		</td>
	</tr>
	
	<!--- Expiration Date --->
	<tr>
		<td align="right">
			<b>Expiration Date</b> (mm/dd/yyyy)
		</td>
		<td>
			<input type="text"
				name="expiration"
				maxlength="10"
				<cfif editmode>
					value="#DateFormat(getDLROffer.ExpirationDate,'mm/dd/yyyy')#"
<!--- If no value is given, the default is today's date plus one month.   Chris Wacker 11/09/2000 1:50 PM --->
				<cfelse>
					value="#DateFormat(DateAdd("m",1,Now()),'mm/dd/yyyy')#"
				</cfif>>
			<input type="hidden" name="expiration_date" value="You must enter an expiration date in the form mm/dd/yyyy">
		</td>
	</tr>
	
	<!--- Disclaimer --->
	<tr>
		<td align="right" valign="top">
			<b>Select a Disclaimer Template</b>
		</td>
		<td>
			<table border=0 cellpadding="0" cellspacing="0">
			<tr>
				<td align=center valign=middle>
					<input type="radio" name="templateID" value="1" <cfif not editmode>CHECKED<cfelseif editmode and #getdlroffer.templateid# is '1'>CHECKED</cfif>><br>&nbsp;
				</td>
				<td align=left>
					<b>MSRP:</b>
					<br>
					MSRP. Title and taxes extra.
				</td>
			</tr>
			<tr>
				<td align="center" valign="middle">
					<input type="Radio" name="templateID" value="0" <cfif editmode><cfif #getdlroffer.templateid# is '0'>CHECKED</cfif></cfif>><br>&nbsp;
				</td>
				<td align="left">
					<b>Custom:</b>
					<br>
					Enter a custom disclaimer.
				</td>
			</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<cfif isdefined("form.offerid")>
				<input type="hidden" name="offerID" value="#form.OfferID#">
			</cfif>
			<input type="Image" src="#application.RELATIVE_PATH#/images/admin/next.gif" border="0" name="Next" value="Next">
			</form>
		</td>
	</tr>
</cfif>
<tr>
	<td colspan="2" align="center">
		<form name="Cancel" action="showroom_incent.cfm" method="post">
		<input type="Image" src="#application.RELATIVE_PATH#/images/admin/cancel.gif" border="0" name="Cancel" value="Cancel">
		</form>
	</td>
</tr>
</table>
</cfoutput>
