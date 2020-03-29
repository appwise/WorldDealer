                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 10, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: service_main_save.cfm,v 1.12 2000/03/03 17:54:28 jkrauss Exp $--->

<cfset PageAccess = application.dealer_access>
<cfinclude template = "../security.cfm">

<cfif g_dlr>
	<cfset save_servicefax = #form.servicefax1# & #form.servicefax2# & #form.servicefax3#>
	<cfset save_partsfax = #form.partsfax1# & #form.partsfax2# & #form.partsfax3#>

	<cfquery name="updateDLR" datasource="#gDSN#">
		UPDATE	Dealers
		SET		ServiceEmail = '#Form.ServiceEmail#',
				ServiceEmail2 = '#Form.ServiceEmail2#',
				ServiceFax = '#save_ServiceFax#',
				PartsEmail = '#Form.PartsEmail#',
				PartsEmail2 = '#Form.PartsEmail2#',
				PartsFax = '#save_PartsFax#'
		WHERE	Dealers.DealerCode = '#g_dealercode#'
	</cfquery>
</cfif>

	
<!--- Replace Carriage Return with <BR> --->
<cfif g_dlr>
	<cfset r_serviceinqsetaparttext = #replace(form.serviceinqsetaparttext, Chr(13),"<BR>","ALL")#>
	<cfset r_servicemaintext = #replace(form.servicemaintext, Chr(13),"<BR>","ALL")#>

	<cfquery name="UpdateDealer" datasource="#gDSN#">
		UPDATE DealerWebs
		SET <!--- If it's a collection, skip Quote and Service Page sections --->
			<cfif #form.serviceinqsetaparttext# is "Please enter your text here.">
				ServiceInqSetApartText2 = '',
			<cfelse>
				ServiceInqSetApartText2 = '#rtrim(r_ServiceInqSetApartText)#',
			</cfif>
			<cfif #form.servicemaintext# is "Please enter your text here.">
				ServiceMainText = ''
			<cfelse>
				ServiceMainText = '#rtrim(r_ServiceMainText)#'
			</cfif>
		WHERE DealerCode='#g_dealercode#'
	</cfquery>
</cfif>
				
<cfif parameterexists(form.saveall.x)>

	<cfquery name="UpdBodyShopYN" datasource="#gDSN#">
		UPDATE DealerWebs
		SET BodyShopYesNo = '#Form.BodyShop#'
		WHERE DealerCode = '#g_dealercode#';
	</cfquery>			
	
	<cfset hoursarray=arraynew(2)>
	
	<cfset hoursarray[1][1]=#form.x1so#>                
	<cfset hoursarray[1][2]=#form.x1sc#>
	<cfset hoursarray[1][3]=#form.x1po#>                
	<cfset hoursarray[1][4]=#form.x1pc#>
	<cfset hoursarray[1][5]=#form.x1bo#>
	<cfset hoursarray[1][6]=#form.x1bc#>
	
	<cfset hoursarray[2][1]=#form.x2so#>                
	<cfset hoursarray[2][2]=#form.x2sc#>
	<cfset hoursarray[2][3]=#form.x2po#>                
	<cfset hoursarray[2][4]=#form.x2pc#>
	<cfset hoursarray[2][5]=#form.x2bo#>
	<cfset hoursarray[2][6]=#form.x2bc#>
	
	<cfset hoursarray[3][1]=#form.x3so#>                
	<cfset hoursarray[3][2]=#form.x3sc#>
	<cfset hoursarray[3][3]=#form.x3po#>                
	<cfset hoursarray[3][4]=#form.x3pc#>
	<cfset hoursarray[3][5]=#form.x3bo#>
	<cfset hoursarray[3][6]=#form.x3bc#>
	
	<cfset hoursarray[4][1]=#form.x4so#>                
	<cfset hoursarray[4][2]=#form.x4sc#>
	<cfset hoursarray[4][3]=#form.x4po#>                
	<cfset hoursarray[4][4]=#form.x4pc#>
	<cfset hoursarray[4][5]=#form.x4bo#>
	<cfset hoursarray[4][6]=#form.x4bc#>
	
	<cfset hoursarray[5][1]=#form.x5so#>                
	<cfset hoursarray[5][2]=#form.x5sc#>
	<cfset hoursarray[5][3]=#form.x5po#>                
	<cfset hoursarray[5][4]=#form.x5pc#>             
	<cfset hoursarray[5][5]=#form.x5bo#>
	<cfset hoursarray[5][6]=#form.x5bc#>
	
	<cfset hoursarray[6][1]=#form.x6so#>                
	<cfset hoursarray[6][2]=#form.x6sc#>
	<cfset hoursarray[6][3]=#form.x6po#>                
	<cfset hoursarray[6][4]=#form.x6pc#>
	<cfset hoursarray[6][5]=#form.x6bo#>
	<cfset hoursarray[6][6]=#form.x6bc#>
	
	<cfset hoursarray[7][1]=#form.x7so#>                
	<cfset hoursarray[7][2]=#form.x7sc#>
	<cfset hoursarray[7][3]=#form.x7po#>                
	<cfset hoursarray[7][4]=#form.x7pc#>
	<cfset hoursarray[7][5]=#form.x7bo#>
	<cfset hoursarray[7][6]=#form.x7bc#>

	<cfloop index="countDays" from="1" to="7">
		<cfquery name="updHour#countDays#" datasource="#gDSN#">
			UPDATE HoursOfOperation
			SET ServiceOpen = '#HoursArray[countDays][1]#',
				ServiceClose = '#HoursArray[countDays][2]#',
				PartsOpen = '#HoursArray[countDays][3]#',
				PartsClose = '#HoursArray[countDays][4]#',
				BodyShopOpen = '#HoursArray[countDays][5]#',
				BodyShopClose = '#HoursArray[countDays][6]#'
			WHERE HoursOfOperation.DealerCode = '#g_dealercode#'
			AND DayOfWeek = CONVERT(int,#countDays#)
		</cfquery>
	</cfloop>
</cfif>

<cflocation url="#application.RELATIVE_PATH#/admin/mysite/service.cfm" addtoken="No">