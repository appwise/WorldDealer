<cfset webnewstep = 3>

<!doctype html public "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>

    <!-- ----------------------------------------------------------- -->
    <!--                 Created by sigma6, Detroit                  -->
    <!--         Copyright (c) 1997, 1998, 1999 sigma6.              -->
    <!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->

    <!-- ----------------------------------------------------------- -->
    <!--     John Turner for sigma6, interactive media, Detroit      -->
    <!--    jturner@sigma6.com   www.sigma6.com    www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
	<!--- $Id: webnew_s3.cfm,v 1.10 2000/06/05 22:57:01 lswanson Exp $ --->
	<!--- Hours of Operation --->


<HEAD>

	<title>WorldDealer | Create a New Web</title>
	
    <cfif parameterexists(form.btncancel.x)>
           <cflocation url="webvrfy_s3.cfm?dlrcode=#Form.DealerCode#">
    </cfif>
	
	<!--- linda, 10/15/99: i don't think newmode exists anymore, because of Joel's new default hours 
	of operation entry screen that diverts it & fills it in before getting to the edit screen. --->
	<!--- <cfset newmode = false> --->
    <cfset editmode = false>
    <cfset savemode = false>

    <cfif parameterexists(url.dlrcode)>
        <cfset g_dealercode = #url.dlrcode#>
        <cfset editmode = true>
    <!--- <cfelse>
           <cfset g_dealercode = "">
           <cfset newmode = true> --->
    </cfif>
        
    <cfif parameterexists(form.btnsave.x)>
        <cfset savemode = true>
        <cfset g_dealercode = #form.dealercode#>
    </cfif>

	<cfquery name="checkbodyshop" datasource="#gDSN#">
		SELECT	BodyShopYesNo
		FROM	dealerwebs
		WHERE	DealerCode = '#g_DealerCode#';
	</cfquery>

    <cfset dayoftheweek = arraynew(1)>
    <cfset openhoursarray = arraynew(1)>
    <cfset closehoursarray = arraynew(1)>
    <cfset dlrhours = arraynew(2)>
        
    <cfset dayoftheweek[1] = 'Mon'>
    <cfset dayoftheweek[2] = 'Tue'>
    <cfset dayoftheweek[3] = 'Wed'>
    <cfset dayoftheweek[4] = 'Thu'>
    <cfset dayoftheweek[5] = 'Fri'>
    <cfset dayoftheweek[6] = 'Sat'>
    <cfset dayoftheweek[7] = 'Sun'>
        
    <cfset openhoursarray[1] = 'Closed'>
    <cfset openhoursarray[2] = '06:00 AM'>
    <cfset openhoursarray[3] = '06:30 AM'>
    <cfset openhoursarray[4] = '07:00 AM'>
    <cfset openhoursarray[5] = '07:30 AM'>
    <cfset openhoursarray[6] = '08:00 AM'>
    <cfset openhoursarray[7] = '08:30 AM'>
    <cfset openhoursarray[8] = '09:00 AM'>
    <cfset openhoursarray[9] = '09:30 AM'>
    <cfset openhoursarray[10] = '10:00 AM'>
    <cfset openhoursarray[11] = '10:30 AM'>
    <cfset openhoursarray[12] = '11:00 AM'>
    <cfset openhoursarray[13] = '11:30 AM'>
    <cfset openhoursarray[14] = '12:00 PM'>
    <cfset openhoursarray[15] = '12:30 PM'>
    <cfset openhoursarray[16] = '01:00 PM'>

    <cfset closehoursarray[1] = 'Closed'>
    <cfset closehoursarray[2] = '11:00 AM'>
    <cfset closehoursarray[3] = '11:30 AM'>
    <cfset closehoursarray[4] = '12:00 PM'>
    <cfset closehoursarray[5] = '12:30 PM'>
    <cfset closehoursarray[6] = '01:00 PM'>
    <cfset closehoursarray[7] = '01:30 PM'>
    <cfset closehoursarray[8] = '02:00 PM'>
    <cfset closehoursarray[9] = '02:30 PM'>
    <cfset closehoursarray[10] = '03:00 PM'>
    <cfset closehoursarray[11] = '03:30 PM'>
    <cfset closehoursarray[12] = '04:00 PM'>
    <cfset closehoursarray[13] = '04:30 PM'>
    <cfset closehoursarray[14] = '05:00 PM'>
    <cfset closehoursarray[15] = '05:30 PM'>
    <cfset closehoursarray[16] = '06:00 PM'>
    <cfset closehoursarray[17] = '06:30 PM'>
    <cfset closehoursarray[18] = '07:00 PM'>
    <cfset closehoursarray[19] = '07:30 PM'>
    <cfset closehoursarray[20] = '08:00 PM'>
    <cfset closehoursarray[21] = '08:30 PM'>
    <cfset closehoursarray[22] = '09:00 PM'>
    <cfset closehoursarray[23] = '09:30 PM'>
    <cfset closehoursarray[24] = '10:00 PM'>
    <cfset closehoursarray[25] = '10:30 PM'>
    <cfset closehoursarray[26] = '11:00 PM'>
	<cfset closehoursarray[27] = '11:30 PM'>
	<cfset closehoursarray[28] = '12:00 AM'>

	<cfif editmode>
		<cfquery name="getDLRHours" datasource="#gDSN#">
			SELECT HourID as q_HourID,
					DayOfWeek as q_DayOfWeek,
					SalesOpen as q_Salesopen,
					SalesClose as q_SalesClose,
					ServiceOpen as q_ServiceOpen,
					ServiceClose as q_ServiceClose,
					PartsOpen as q_PartsOpen,
					PartsClose as q_PartsClose
			<!--- <CFIF checkbodyshop.bodyshopyesno IS "Y"> --->,
					BodyShopOpen as q_BodyShopOpen,
					BodyShopClose as q_BodyShopClose
			<!--- </CFIF> --->
			FROM HoursOfOperation
			WHERE HoursOfOperation.DealerCode = '#g_DealerCode#'
			ORDER BY DayOfWeek ASC
		</cfquery>
				
		<cfif #getdlrhours.recordcount# is not 0>
			<cfloop query="getDLRHours">
				<cfset dlrhours[currentrow][1] = #getdlrhours.q_salesopen#>     
				<cfset dlrhours[currentrow][2] = #getdlrhours.q_salesclose#>    
				<cfset dlrhours[currentrow][3] = #getdlrhours.q_serviceopen#>   
				<cfset dlrhours[currentrow][4] = #getdlrhours.q_serviceclose#>  
				<cfset dlrhours[currentrow][5] = #getdlrhours.q_partsopen#>     
				<cfset dlrhours[currentrow][6] = #getdlrhours.q_partsclose#>
				<cfset dlrhours[currentrow][7] = #getdlrhours.q_bodyshopopen#>
				<cfset dlrhours[currentrow][8] = #getdlrhours.q_bodyshopclose#>
			</cfloop>
		</cfif>
	</cfif>
		
	<cfif savemode>
		<cfquery name="UpdBodyShopYN" datasource="#gDSN#">
			UPDATE DealerWebs
			SET BodyShopYesNo = '#Form.BodyShop#'
			WHERE DealerCode = '#g_DealerCode#';
		</cfquery>			
	
		<cfset HoursArray=arraynew(2)>
		
		<cfset HoursArray[1][1]=#form.x1so#>                
		<cfset HoursArray[1][2]=#form.x1sc#>                
		<cfset HoursArray[1][3]=#form.x1vo#>                
		<cfset HoursArray[1][4]=#form.x1vc#>                
		<cfset HoursArray[1][5]=#form.x1po#>                
		<cfset HoursArray[1][6]=#form.x1pc#>
		<cfset HoursArray[1][7]=#form.x1bo#>
		<cfset HoursArray[1][8]=#form.x1bc#>
		
		<cfset HoursArray[2][1]=#form.x2so#>                
		<cfset HoursArray[2][2]=#form.x2sc#>                
		<cfset HoursArray[2][3]=#form.x2vo#>                
		<cfset HoursArray[2][4]=#form.x2vc#>                
		<cfset HoursArray[2][5]=#form.x2po#>                
		<cfset HoursArray[2][6]=#form.x2pc#>
		<cfset HoursArray[2][7]=#form.x2bo#>
		<cfset HoursArray[2][8]=#form.x2bc#>
		
		<cfset HoursArray[3][1]=#form.x3so#>                
		<cfset HoursArray[3][2]=#form.x3sc#>                
		<cfset HoursArray[3][3]=#form.x3vo#>                
		<cfset HoursArray[3][4]=#form.x3vc#>                
		<cfset HoursArray[3][5]=#form.x3po#>                
		<cfset HoursArray[3][6]=#form.x3pc#>
		<cfset HoursArray[3][7]=#form.x3bo#>
		<cfset HoursArray[3][8]=#form.x3bc#>
		
		<cfset HoursArray[4][1]=#form.x4so#>                
		<cfset HoursArray[4][2]=#form.x4sc#>                
		<cfset HoursArray[4][3]=#form.x4vo#>                
		<cfset HoursArray[4][4]=#form.x4vc#>                
		<cfset HoursArray[4][5]=#form.x4po#>                
		<cfset HoursArray[4][6]=#form.x4pc#>
		<cfset HoursArray[4][7]=#form.x4bo#>
		<cfset HoursArray[4][8]=#form.x4bc#>
		
		<cfset HoursArray[5][1]=#form.x5so#>                
		<cfset HoursArray[5][2]=#form.x5sc#>                
		<cfset HoursArray[5][3]=#form.x5vo#>                
		<cfset HoursArray[5][4]=#form.x5vc#>                
		<cfset HoursArray[5][5]=#form.x5po#>                
		<cfset HoursArray[5][6]=#form.x5pc#>             
		<cfset HoursArray[5][7]=#form.x5bo#>
		<cfset HoursArray[5][8]=#form.x5bc#>
		
		<cfset HoursArray[6][1]=#form.x6so#>                
		<cfset HoursArray[6][2]=#form.x6sc#>                
		<cfset HoursArray[6][3]=#form.x6vo#>                
		<cfset HoursArray[6][4]=#form.x6vc#>                
		<cfset HoursArray[6][5]=#form.x6po#>                
		<cfset HoursArray[6][6]=#form.x6pc#>
		<cfset HoursArray[6][7]=#form.x6bo#>
		<cfset HoursArray[6][8]=#form.x6bc#>
		
		<cfset HoursArray[7][1]=#form.x7so#>                
		<cfset HoursArray[7][2]=#form.x7sc#>                
		<cfset HoursArray[7][3]=#form.x7vo#>                
		<cfset HoursArray[7][4]=#form.x7vc#>                
		<cfset HoursArray[7][5]=#form.x7po#>                
		<cfset HoursArray[7][6]=#form.x7pc#>
		<cfset HoursArray[7][7]=#form.x7bo#>
		<cfset HoursArray[7][8]=#form.x7bc#>
		
	
		<!--- 
		<cfif #form.mode# eq 'new'>
			<cfloop index="Counter" from="1" to="7">
				<cfquery name="insertHour#Counter#" datasource="#gDSN#">
					INSERT INTO HoursOfOperation (DealerCode, DayOfWeek, SalesOpen, SalesClose, ServiceOpen, ServiceClose, PartsOpen, PartsClose, UsedOpen, UsedClose, BodyShopOpen, BodyShopClose
					VALUES ('#Form.DealerCode#', CONVERT(int,#Counter#), '#HoursArray[Counter][1]#', '#HoursArray[Counter][2]#', '#HoursArray[Counter][3]#', '#HoursArray[Counter][4]#', '#HoursArray[Counter][5]#', '#HoursArray[Counter][6]#', '', '', '#HoursArray[Counter][7]#', '#HoursArray[Counter][8]#'
				</cfquery>
			</cfloop>
		</cfif> --->
						
		<cfif #form.mode# eq 'edit'>
			<cfloop index="countDays" from="1" to="7">
				<cfquery name="updHour#countDays#" datasource="#gDSN#">
					UPDATE HoursOfOperation
					SET SalesOpen = '#HoursArray[countDays][1]#',
						SalesClose = '#HoursArray[countDays][2]#',
						ServiceOpen = '#HoursArray[countDays][3]#',
						ServiceClose = '#HoursArray[countDays][4]#',
						PartsOpen = '#HoursArray[countDays][5]#',
						PartsClose = '#HoursArray[countDays][6]#',
						UsedOpen = '', 
						UsedClose = '',
						BodyShopOpen = '#HoursArray[countDays][7]#',
						BodyShopClose = '#HoursArray[countDays][8]#'
					WHERE HoursOfOperation.DealerCode = '#Form.DealerCode#'
					AND DayOfWeek = CONVERT(int,#countDays#)
				</cfquery>
			</cfloop>
		</cfif>
	            
	    <cflocation url="webvrfy_s3.cfm?dlrcode=#Form.DealerCode#">
		
	</cfif>

	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</head>

<body>
<br><br><br><br><br>

<cfif editmode>
	
	<!--- <cfif #getdlrhours.recordcount# eq 0>
		<cfset editmode = false>
		<cfset newmode = true>
	</cfif> --->

<div align="center">
<table cellpadding=3 cellspacing=0 border=0 width=410 bgcolor="FFFFFF">
<tr align="center">
	<td align="middle">
		<h3>Dealer Administration - Create a New Web</h3>
	</td>
</tr>
<tr align="center">
	<td align="middle">
		<h4>Hours of Operation</h4>
	</td>
</tr>
<tr align="center">
	<td align="middle">
		Select the correct open and close times from the choices below.<br>
		Click 'Next' when finished, or any of the other buttons.
	</td>
</tr>
<tr>
	<td>&nbsp;<p></td>
</tr>
<tr align=middle>
	<td>
	<form name="StepThree" action="webnew_s3.cfm" method="post">
		<table cellpadding=5 cellspacing=0 border=1>
		<tr align=middle>
			<td>&nbsp;</td>
			<td colspan=2><b>Sales</b></td>
			<td colspan=2><b>Service</b></td>
			<td colspan=2><b>Parts</b></td>
			<td colspan=2><b>Body Shop</b></td>
		</tr>
		<tr valign=center align=middle>
			<td>&nbsp;</td>
			<td><b>Open</b></td>
			<td><b>Close</b></td>
			<td><b>Open</b></td>
			<td><b>Close</b></td>
			<td><b>Open</b></td>
			<td><b>Close</b></td>
			<td><b>Open</b></td>
			<td><b>Close</b></td>
		</tr>
	<cfloop index="weekday" from="1" to="7" step="1">
		<cfoutput>
		<tr valign=center>
			<td><b>#dayoftheweek[weekday]#</b></td>
			<td>
			<!--- Sales Open --->
			<select name="X#weekday#SO">
				<cfloop index="HourCount" from=1 to=16>
					<option value="#openhoursarray[HourCount]#"<cfif #dlrhours[weekday][1]# is '#openhoursarray[hourcount]#'> SELECTED</cfif>>#openhoursarray[HourCount]#
				</cfloop>
			</select>
			</td>
			<td>
			<!--- Sales Close --->
			<select name="X#weekday#SC">
				<cfloop index="HourCount" from=1 to=28>
					<option value="#closehoursarray[HourCount]#" <cfif #dlrhours[weekday][2]# is '#closehoursarray[hourcount]#'>SELECTED</cfif>> #closehoursarray[HourCount]#
				</cfloop>
			</select>
			</td>
			<td>
			<!--- Service Open --->
			<select name="X#weekday#VO">
				<cfloop index="HourCount" from=1 to=16>
					<option value="#openhoursarray[HourCount]#" <cfif #dlrhours[weekday][3]# is '#openhoursarray[hourcount]#'>SELECTED</cfif>> #openhoursarray[HourCount]#
				</cfloop>
			</select>
			</td>
			<td>
			<!--- Service Close --->
			<select name="X#weekday#VC">
				<cfloop index="HourCount" from=1 to=28>
					<option value="#closehoursarray[HourCount]#" <cfif #dlrhours[weekday][4]# is '#closehoursarray[hourcount]#'>SELECTED</cfif>> #closehoursarray[HourCount]#
				</cfloop>
			</select>
			</td>
			<td>
			<!--- Parts Open --->
			<select name="X#weekday#PO">
				<cfloop index="HourCount" from=1 to=16>
					<option value="#openhoursarray[HourCount]#" <cfif #dlrhours[weekday][5]# is '#openhoursarray[hourcount]#'>SELECTED</cfif>> #openhoursarray[HourCount]#
				</cfloop>
			</select>
			</td>
			<td>
			<!--- Parts Close --->
			<select name="X#weekday#PC">
				<cfloop index="HourCount" from=1 to=28>
					<option value="#closehoursarray[HourCount]#" <cfif #dlrhours[weekday][6]# is '#closehoursarray[hourcount]#'>SELECTED</cfif>> #closehoursarray[HourCount]#
				</cfloop>
			</select>
			</td>
			<td>
			<!--- BodyShop Open --->
			<select name="X#weekday#BO">
				<cfloop index="HourCount" from=1 to=16>
					<option value="#openhoursarray[HourCount]#" <cfif #dlrhours[weekday][7]# is '#openhoursarray[hourcount]#'>SELECTED</cfif>> #openhoursarray[HourCount]#
				</cfloop>
			</select>
			</td>
			<td>
			<!--- BodyShop Close --->
			<select name="X#weekday#BC">
				<cfloop index="HourCount" from=1 to=28>
					<option value="#closehoursarray[HourCount]#" <cfif #dlrhours[weekday][8]# is '#closehoursarray[hourcount]#'>SELECTED</cfif>> #closehoursarray[HourCount]#
				</cfloop>
			</select>
			</td>
		</tr>
		</cfoutput>
	</cfloop>
		</table>
	</td>
</tr>       
<tr>
	<td>
		<table cellspacing=0 cellpadding=0 border=0 width="100%">
		<tr>
			<td>&nbsp;<p></td>
		</tr>
		</table>
	</td>
</tr>
<tr align="center">
	<td>
		Would this dealer like to include Body Shop Hours of Operation on their website?<p>
		<!--- <cfif not editmode>
			<input type="radio" value="Y" name="BodyShop" checked>Yes&nbsp;&nbsp;
			<input type="radio" value="N" name="BodyShop">No
		<cfelse> --->
			<input type="radio" value="Y" name="BodyShop" <cfif #checkbodyshop.bodyshopyesno# eq 'y'>CHECKED</cfif>>Yes&nbsp;&nbsp;
			<input type="radio" value="N" name="BodyShop" <cfif #checkbodyshop.bodyshopyesno# eq 'n'>CHECKED</cfif>>No
		<!--- </cfif> --->
	</td>
</tr>
<tr>
	<td>&nbsp;</td>
</tr>
<tr align="center">
	<td align=center>
		<cfoutput>
		<input type="hidden" name="DealerCode" value=#g_dealercode#>
		<cfif editmode>
			<input type="hidden" name="Mode" value="Edit">
		<cfelse>
			<input type="hidden" name="Mode" value="New">
		</cfif>
		</cfoutput>
		<input type="hidden" name="NextStep" value="webnew_s4.cfm">
		<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/cancel_nav.jpg" BORDER="0" NAME="btnCancel" VALUE="Cancel">
		&nbsp;&nbsp;
		<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/saveandcontinue_nav.jpg" BORDER="0" NAME="btnSave" VALUE="Save">
		</form>
		<form name="f_Back" action="redirect.cfm" method="post">
			<input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/backtomain_nav.jpg" Border="0" NAME="BackToMain" VALUE="Back To Main Menu">
		</form>
	</td>
</tr>
</table>


</div>
</cfif>

</body>
</html>