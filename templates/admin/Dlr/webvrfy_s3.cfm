<cfset webverifystep = 3>
<cfinclude template="security.cfm">
<!doctype html public "-//W3C//DTD HTML 4.0 Transitional//EN">

    <!-- ----------------------------------------------------------- -->
    <!--              Created by sigma6, Detroit                     -->
    <!--         Copyright (c) 1997, 1998, 1999 sigma6.              -->
    <!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->

    <!-- ----------------------------------------------------------- -->
    <!--     John Turner for sigma6, interactive media, Detroit      -->
    <!--    jturner@sigma6.com   www.sigma6.com    www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
	<!--- $Id: webvrfy_s3.cfm,v 1.7 1999/11/29 15:31:01 lswanson Exp $ --->
	<!--- Hours of Operation --->



<HEAD>

    <title>WorldDealer | Create a New Web</title>
	
	<cfif parameterexists(form.btninit.x)>
		<cflocation url="webvrfy_s3_action.cfm?dlrcode=#form.DealerCode#">
	</cfif>
	
	<cfif parameterexists(form.btnback.x)>
		<cflocation url="webvrfy_s2.cfm?dlrcode=#form.DealerCode#">
	</cfif>
	
    <cfif parameterexists(form.btnnext.x)>
   		<cflocation url="webvrfy_s4.cfm?dlrcode=#Form.DealerCode#">
	</cfif>
        
    <cfif parameterexists(form.btnmodify.x)>
		<cflocation url="webnew_s3.cfm?dlrcode=#Form.DealerCode#">
    <cfelseif parameterexists(url.dlrcode)>
        <cfset verifymode = true>
        <cfset g_dealercode = #url.dlrcode#>
	<cfelse>
       	<cfset verifymode = false>
    </cfif>

	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</head>

<body>
<br><br><br><br><br>

<cfif verifymode>

	<cfquery name="checkbodyshop" datasource="#gDSN#">
		SELECT	BodyShopYesNo
		FROM	dealerwebs
		WHERE	DealerCode = '#g_DealerCode#';
	</cfquery>

    <cfquery name="getDLRHours" datasource="#gDSN#">
            SELECT			HourID as q_HourID,
							DayOfWeek as q_DayOfWeek,
               				SalesOpen as q_Salesopen,
							SalesClose as q_SalesClose,
							ServiceOpen as q_ServiceOpen,
							ServiceClose as q_ServiceClose,
							PartsOpen as q_PartsOpen,
							PartsClose as q_PartsClose
			<cfif checkbodyshop.bodyshopyesno is "Y">,
							BodyShopOpen as q_BodyShopOpen,
							BodyShopClose as q_BodyShopClose
			</cfif>
                  FROM HoursOfOperation
                 WHERE HoursOfOperation.DealerCode = '#g_DealerCode#'
          ORDER BY DayOfWeek ASC
    </cfquery>

	<div align="center">
	<table cellpadding=0 cellspacing=0 border=0 width=630 bgcolor="FFFFFF">
        <tr align="center">
			<td align="middle">
				<h3>Maintain Your Web Site</h3>
			</td>
        </tr>
        <tr align="center">
            <td align="middle">
				<h4>Hours of Operation</h4>
			</td>
        </tr>

	<cfif #getDLRHours.RecordCount# EQ 0>
	<!--- if new dealership that hasn't entered any hours yet, allow entry of default hours of operation --->
		<tr>
			<td align="CENTER">
				<cfoutput>
				<!--- <form name="InitiateForm" action="webvrfy_s3.cfm?dlrcode=#g_DealerCode#" method="post"> --->
				<form name="DefaultHours" action="webvrfy_s3_action.cfm?dlrcode=#g_DealerCode#" method="post">
        	    <input type="hidden" name="DealerCode" value="#g_DealerCode#">		
				</cfoutput>
				<table cellpadding="3">
					<tr>
						<td colspan="2">
							
							<div align="center"><b>You currently have no business hours selected.</b></div>
							<p>
							Please enter regular opening and closing times<br>
							(Monday through Friday) for your dealership.<br>
							You will then be able to customize your business hours.
						</td>
					</tr>
					<tr>
						<td width="50%" align="RIGHT">Opening Time:</td>
						<td width="50%">
							<select name="OpeningTime">
							<option value="Closed">Closed
							<option value="06:00 AM">06:00 AM
							<option value="06:30 AM">06:30 AM
							<option value="07:00 AM">07:00 AM
							<option value="07:30 AM">07:30 AM
							<option value="08:00 AM" selected>08:00 AM
							<option value="08:30 AM">08:30 AM
							<option value="09:00 AM">09:00 AM
							<option value="09:30 AM">09:30 AM
							<option value="10:00 AM">10:00 AM
							<option value="10:30 AM">10:30 AM
							<option value="11:00 AM">11:00 AM
							<option value="11:30 AM">11:30 AM
							<option value="12:00 PM">12:00 PM
							<option value="12:30 PM">12:30 PM
							<option value="01:00 PM">01:00 PM
							</select>
						</td>
					</tr>
					<tr>
						<td width="50%" align="RIGHT">Closing Time:</td>
						<td width="50%">
							<select name="ClosingTime">
							<option value="Closed">Closed
							<option value="01:00 PM">01:00 PM
							<option value="01:30 PM">01:30 PM
							<option value="02:00 PM">02:00 PM
							<option value="02:30 PM">02:30 PM
							<option value="03:00 PM">03:00 PM
							<option value="03:30 PM">03:30 PM
							<option value="04:00 PM">04:00 PM
							<option value="04:30 PM">04:30 PM
							<option value="05:00 PM" selected>05:00 PM
							<option value="05:30 PM">05:30 PM
							<option value="06:00 PM">06:00 PM
							<option value="06:30 PM">06:30 PM
							<option value="07:00 PM">07:00 PM
							<option value="07:30 PM">07:30 PM
							<option value="08:00 PM">08:00 PM
							<option value="08:30 PM">08:30 PM
							<option value="09:00 PM">09:00 PM
							<option value="09:30 PM">09:30 PM
							<option value="10:00 PM">10:00 PM
							<option value="10:30 PM">10:30 PM
							<option value="11:00 PM">11:00 PM
							<option value="11:30 PM">11:30 PM
							<option value="12:00 AM">12:00 AM
							</select>
						</td>
					</tr>
					<tr>
						<td colspan="2" align="CENTER">
							<cfoutput>
							<!--- set default hours of operation --->
							<input type="Image" src="#application.RELATIVE_PATH#/images/admin/submit.jpg" border="0" name="btnInit" value="Submit the Form">
							</form>
							<!--- Back & Next buttons --->
			                <form name="VrfyThree" action="webvrfy_s3.cfm?dlrcode=#g_DealerCode#" method="post">
			        	    <input type="hidden" name="DealerCode" value="#g_DealerCode#">		
							<input type="Image" src="#application.RELATIVE_PATH#/images/admin/back_nav.jpg" border="0" name="btnBack" value="< Back">
							&nbsp;&nbsp;
							<input type="Image" src="#application.RELATIVE_PATH#/images/admin/next_nav.jpg" border="0" name="btnNext" value="Next">
							</form>
							<!--- Back to Main Menu --->
							<form name="f_Back" action="redirect.cfm" method="post">
							<br>
			                <input type="Image" src="#application.RELATIVE_PATH#/images/admin/backtomain_nav.jpg" Border="0" NAME="BackToMain" VALUE="Back To Main Menu">
							</form>
							</cfoutput>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	<cfelse>	
		<!--- if they've already entered their hours --->
        <tr align="center">
			<td align="middle">
				Verify the hours of operation for this dealership.<br>
				To change an entry, click the <b>'Modify'</b> button.
			</td>
        </tr>
        <tr><td>&nbsp;<p></td></tr>
        <tr align=middle>
            <td>
            	<table cellpadding=5 cellspacing=0 border=1>
                <tr align=middle>
                	<td>&nbsp;</td>
                    <td><b>Sales</b></td>
                    <td><b>Service</b></td>
                    <td><b>Parts</b></td>
					<cfif checkbodyshop.bodyshopyesno is "Y">
						<td><b>Body Shop</b></td>
					</cfif>
                </tr>
                
				<cfoutput query="getDLRHours" group="q_DayOfWeek">
                <tr valign=center>
                	<td>
						
				 		<cfif q_dayofweek eq '1'><b>Mon</b>
                        <cfelseif q_dayofweek eq '2'><b>Tue</b>
                        <cfelseif q_dayofweek eq '3'><b>Wed</b>
                        <cfelseif q_dayofweek eq '4'><b>Thu</b>
                        <cfelseif q_dayofweek eq '5'><b>Fri</b>
                        <cfelseif q_dayofweek eq '6'><b>Sat</b>
                        <cfelseif q_dayofweek eq '7'><b>Sun</b>
                        </cfif>
						
					</td>
                    <cfif q_salesopen contains "Closed">
                    	<td align=center>
							Closed</td>
                     <cfelse>
                        <td>
							#q_SalesOpen# - #q_SalesClose#</td>
                     </cfif>
                     <cfif q_serviceopen contains "Closed">
                     	<td align=center>Closed</td>
                     <cfelse>
                     	<td>#q_ServiceOpen# - #q_ServiceClose#</td>
                     </cfif>
                     <cfif q_partsopen contains "Closed">
                     <td align=center>Closed</td>
                     <cfelse>
						<td>#q_PartsOpen# - #q_PartsClose#</td>
                     </cfif>
					<cfif checkbodyshop.bodyshopyesno is "Y">
						<cfif q_bodyshopopen contains "Closed">
                        	<td align=center>Closed</td>
                        <cfelse>
                        	<td>#q_BodyShopOpen# - #q_BodyShopClose#</td>
                        </cfif>
					</cfif>
                </tr>
                </cfoutput>
                </table>
            </td>
        </tr>
	    <tr><td>&nbsp;<p></td></tr>
        <tr align="center">
            <td>
                <cfoutput>
                <form name="VrfyThree" action="webvrfy_s3.cfm?dlrcode=#g_DealerCode#" method="post">
              	<input type="hidden" name="DealerCode" value="#g_DealerCode#">
                <input type="hidden" name="NextStep" value="webvrfy_s4.cfm">
				<input type="Image" src="#application.RELATIVE_PATH#/images/admin/back_nav.jpg" border="0" name="btnBack" value="< Back">
				&nbsp;&nbsp;
                <input type="Image" src="#application.RELATIVE_PATH#/images/admin/modify_nav.jpg" border="0" name="btnModify" value="Modify">
                &nbsp;&nbsp;
                <input type="Image" src="#application.RELATIVE_PATH#/images/admin/next_nav.jpg" border="0" name="btnNext" value="Next">
                </form>
	            </cfoutput>
                <p>
                <form name="f_Back" action="redirect.cfm" method="post">
                <input type="Image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/backtomain_nav.jpg" Border="0" NAME="BackToMain" VALUE="Back To Main Menu"></form>
			</td>
        </tr>
	</cfif>
</table>

</div>

<cfelse>

</cfif>

</body>
</html>

