<cfset PageAccess = application.dealer_access>

                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 13, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!--- $Id: showroom_incent_photo_main.cfm,v 1.9 2000/03/21 16:11:03 jkrauss Exp $ --->
<!--- Showroom: Custom Dealership Vehicle Incentives Photo --->

<!--- Existing Incentive --->
<cfif #isdefined("form.OfferID")#>
	<cfset editmode = true>
	<cfquery name="GetOffer" datasource="#gDSN#">
		SELECT	CarcutID
		FROM	Offers
		WHERE	Offers.OfferID = #form.OfferID#;
	</cfquery>
<cfelse>
	<cfset editmode = false>
</cfif>
	
<!--- LINDA: enhanced this query, so it looks in the right dir (Make) for carcuts --->
<cfquery name="getCarCuts" datasource="#gDSN#">
	SELECT	CarCutKey.CarCutID,
		   	Models.Make
	FROM 	CarCutKey INNER JOIN Models ON CarCutKey.ModelID = Models.ModelID
	WHERE 	CarCutKey.ModelID = #form.ModelID#;
</cfquery>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<!--- Choose CarCut --->
<form  action="showroom_incent_save.cfm" METHOD="post">
<tr align=center>
	<td>
		<br>
		<b>Select a Carcut</b>
	</td>
</tr>
<tr align=center>
	<td>
		<br>
		<!--- Display all the Carcuts for the selected model --->
		<cfset #counter# = 1>
		<cfloop query="getCarCuts">
			<cfoutput>
			Carcut #counter#: 
			<input type="radio"
				name="carcut"
				value="#carcutID#"
				<cfif editmode>
					<cfif #carcutid# eq #getoffer.carcutid#>CHECKED</cfif>
				<cfelse>
					<cfif #carcutid# eq '1'>CHECKED</cfif>
				</cfif>>
			&nbsp;&nbsp;
			<img
				src="#application.RELATIVE_PATH#/images/vehicles/#Make#/#form.modelID#_#carcutID#.jpg"
				align="middle">
			<p>
			</cfoutput>
			<cfset #counter# = #counter# + 1>
		</cfloop>
	</td>
</tr>
<tr align="center">
	<td>
		<br>
 	     		<cfoutput>
		<cfif editmode>
			<input type="hidden" name="offerID" value="#form.offerID#">
		</cfif>
		<input type="hidden" name="ModelID" value="#Form.ModelID#">
		<input type="hidden" name="offer_name" value="#form.Offer_name#">
		<input type="hidden" name="offer_body" value="#form.offer_body#">
		<input type="hidden" name="expiration" value="#form.expiration#">
		<input type="hidden" name="templateid" value="#form.templateid#">
		<cfif parameterexists(form.disclaimer_body)>
			<input type="hidden" name="disclaimer_body" value="#form.disclaimer_body#">
		</cfif>
		</cfoutput>
		<a href="JavaScript:history.back();"
			onmouseover="self.status='Back';return true"
			onmouseout="self.status='';return true"><img
			src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/back.gif" BORDER=0></a>			
		<input type="Image"
			src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/save.gif"
			Border="0"
			NAME="Save"
			VALUE="Save">
		</form>
		<form  action="showroom_incent.cfm" METHOD="post">
     	     	<input type="Image" 
			src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/cancel.gif" 
			BORDER="0" 
			NAME="Cancel" 
			VALUE="Cancel">
		</form>
	</td>
</tr>
</table>
