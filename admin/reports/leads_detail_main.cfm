<!--- Created by AppNet, Inc., Detroit
www.appnet.com
Copyright (c) 1999, 2000 AppNet, Inc. 
All other trademarks and servicemarks are the property of   
their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
Appnet, Inc. logos are registered trademarks.  
Created: <January 11, 2000>
webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: leads_detail_main.cfm,v 1.12 2000/06/15 16:36:16 lswanson Exp $--->

<cfset phone_number_length = 9>

<cfquery name="selectLeadDetail" datasource="#gDSN#">
	SELECT	RequestInfoGeneral.RequestInfoID as leadID,
			RequestInfoGeneral.RequestInfoTypeID as leadTypeID,
			RequestInfoTypes.Description,
			RequestInfoGeneral.FName,
			RequestInfoGeneral.LName,
			RequestInfoGeneral.AddressLine1,
			RequestInfoGeneral.AddressLine2,
			RequestInfoGeneral.City,
			RequestInfoGeneral.StateAbbr,
			RequestInfoGeneral.Zip,
			RequestInfoGeneral.EmailAddress,
			RequestInfoGeneral.DayPhone,
			RequestInfoGeneral.EvePhone,
			RequestInfoGeneral.WhenSubmitted
	FROM	RequestInfoGeneral INNER JOIN RequestInfoTypes ON RequestInfoGeneral.RequestInfoTypeID = RequestInfoTypes.RequestInfoTypeID
	WHERE	RequestInfoGeneral.RequestInfoID = #Form.leadID#
</cfquery>
	
<cfswitch expression="#selectleaddetail.leadtypeid#">
	<!--- Quote Lead --->
	<cfcase value="1">
		<cfquery name="selectQuoteDetail" datasource="#gDSN#">
			SELECT
				TimeToBuy,
				HeardAbout,
				Make,
				Model,
				Year,
				VIN,
				BodyStyle,
				Color1,
				Color2,
				Interior1,
				Interior2,
				Transmission,
				Engine,
				HowPay,
				DownPayment,
				TradeInYear,
				TradeInModel,
				TradeInMileage,
				TradeInEngine,
				TradeInBalance,
				TradeInValue,
				Comments
			FROM
				RequestInfoQuote
			WHERE
				RequestInfoGeneralID = #Form.leadID#
		</cfquery>
		<!--- TradeInVin, --->
	</cfcase>
	
	<!--- Personal and Business Financing leads use the same table --->
	<cfcase value="2, 3">
		<cfquery name="selectFinanceDetail" datasource="#gDSN#">
			SELECT
				CreditType,
				JointCreditRelationship,
				SSN,
				DateOfBirth,
				ResidenceLength,
				PropertyOwner,
				MonthlyPayment,
				PropertySituation,
				BusinessName,
				WorkAddress,
				WorkCity,
				EmploymentLength,
				GrossIncome,
				Occupation,
				Employer
			FROM
				RequestInfoFinancing
			WHERE
				RequestInfoGeneralID = #Form.leadID#
				<cfif selectleaddetail.leadtypeid eq 2>
					AND ApplicationType = 'personal'
				<cfelseif selectleaddetail.leadtypeid eq 3>
					AND ApplicationType = 'business'
				</cfif>
		</cfquery>
	</cfcase>
	
	<!--- Service Appointment Lead --->
	<cfcase value="4">
		<cfquery name="selectApptServiceDetail" datasource="#gDSN#">
			SELECT	ServiceRequestDesc,
					PrevCustomer,
					Date1,
					Date2,
					Date3,
					Time1,
					Time2,
					Time3,
					Make as vehicleMake,
					Model as vehicleModel,
					CarYear as vehicleYear,
					VIN
			FROM	RequestInfoService
			WHERE	RequestInfoGeneralID = #Form.leadID#
		</cfquery>
	</cfcase>
	
	<!--- Service Part Request Lead --->
	<cfcase value="5">
		<cfquery name="selectPartsServiceDetail" datasource="#gDSN#">
			SELECT
				CarMake as vehicleMake,
				CarModel as vehicleModel,
				CarYear as vehicleYear,
				PartRequestDesc,
				PrevCustomer,
				DepositInfo,
				CardType,
				CardNumber,
				CardExp
				VIN			
			FROM
				RequestInfoParts
			WHERE
				RequestInfoGeneralID = #Form.leadID#
		</cfquery>		
	</cfcase>
</cfswitch>


<cfquery name="getDealerInfo" datasource="#gDSN#">
	SELECT DealershipName
	FROM Dealers
	<!--- linda, 2/17/2000: this was pulling in the wrong Dealership Name
	<cfif isDefined("form.dealercode")>
		WHERE DealerCode = '#form.dealercode#'
	<cfelse> --->
		WHERE DealerCode = '#g_dealercode#'
	<!--- </cfif> --->
</cfquery>

<br>
<table border="0" cellspacing="0" cellpadding="3" align="center">
<cfoutput query="selectLeadDetail">
<tr>
	<td><b>Lead Type</b></td><td>#Description#</td></tr>
<tr>
	<td colspan="2"><b><u><br>Submitted By:</u></b></td></tr>
<tr>
	<td><b>First Name</b></td><td>#FName#</td></tr>
<tr>
	<td><b>Last Name</b></td><td>#LName#</td></tr>
<tr>
	<td><b>Address</b></td><td>#AddressLine1#</td></tr>
<tr>
	<td>&nbsp;</td><td>#AddressLine2#</td></tr>
<tr>
	<td><b>City</b></td><td>#City#</td></tr>
<tr>
	<td><b>State</b></td><td>#StateAbbr#</td></tr>
<tr>
	<td><b>Zip</b></td><td>#Zip#</td></tr>
<tr>
	<td><b>E-mail</b></td>
	<td><a href="mailto:#EmailAddress#?subject=#getDealerInfo.DealershipName# At Your Service">#EmailAddress#</a></td></tr>
<tr>
	<td><b>Daytime Phone</b></td>
	<td><cfif (len(dayphone) ge phone_number_length) and isnumeric(left(dayphone, phone_number_length))>(#Left(DayPhone, 3)#) #Mid(DayPhone, 4, 3)#-#Mid(DayPhone, 7, 4)#</cfif></td></tr>
<tr>
	<td><b>Evening Phone</b></td>
	<td><cfif (len(evephone) ge phone_number_length) and isnumeric(left(evephone, phone_number_length))>(#Left(EvePhone, 3)#) #Mid(EvePhone, 4, 3)#-#Mid(DayPhone, 7, 4)#</cfif></td></tr>
<tr>
	<td><b>Submitted on:</b></td>
	<td>#DateFormat(WhenSubmitted, "mm/dd/yyyy")#</td>
</tr>
</cfoutput>

<cfswitch expression="#selectleaddetail.leadtypeid#">
	<!--- Quote Lead --->
	<cfcase value="1">
      	<cfoutput query="selectQuoteDetail">
		<tr>
			<td><b>Readiness To Buy:</b></td><td>#TimeToBuy#</td></tr>
		<tr>
			<td><b>Heard About Your Site:</b></td><td>#HeardAbout#</td></tr>
		</cfoutput>
	    <tr> 
	        <td colspan="2">
				<br>
				<u><b><cfoutput query="selectLeadDetail">#FName#</cfoutput> is interested in the following vehicle:</b></u></td>
	    </tr>
		<cfoutput query="selectQuoteDetail">
	    <tr> 
	        <td> 
	          <b>Make</b>
	        </td>
	        <td>#Make#</td>
	    </tr>
	    <tr> 
	        <td> 
	          <b>Model</b>
	        </td>
	        <td>#Model#</td>
	    </tr>
	    <tr> 
	        <td> 
	          <b>Year</b>
	        </td>
	        <td>#Year#</td>
	    </tr>
	    <tr> 
	        <td> 
	          <b>BodyStyle</b>
	        </td>
	        <td>#BodyStyle#</td>
	    </tr>
	    <tr> 
	        <td> 
	          <b>Color 1</b>
	        </td>
	        <td>#Color1#</td>
	    </tr>
	    <tr> 
	        <td> 
	          <b>Color 2</b>
	        </td>
	        <td>#Color2#</td>
	    </tr>
	    <tr> 
	        <td> 
	          <b>Interior 1</b>
	        </td>
	        <td>#Interior1#</td>
	    </tr>
	    <tr> 
	        <td> 
	          <b>Interior 2</b>
	        </td>
	        <td>#Interior2#</td>
	    </tr>
	    <tr> 
	        <td> 
	          <b>Transmission</b>
	        </td>
	        <td>#Transmission#</td>
	    </tr>
	    <tr> 
	        <td> 
	          <b>Engine</b>
	        </td>
	        <td>#Engine#</td>
	    </tr>
	    <tr> 
	        <td> 
	          <b>Would Like to Pay By</b>
	        </td>
	        <td>#HowPay#</td>
	    </tr>
	    <tr> 
	        <td> 
	          <b>Down Payment</b>
	        </td>
	        <td>#DownPayment#</td>
	    </tr>
	    <tr> 
	        <td colspan="2">
			  <br>
	          <b><u>Trade-in Info:</u></b>
	        </td>
	    </tr>
	    <tr> 
	        <td> 
	          <b>Year</b>
	        </td>
	        <td>#TradeInYear#</td>
	    </tr>
	    <tr> 
	        <td> 
	          <b>Model</b>
	        </td>
	        <td>#TradeInModel#</td>
	    </tr>
	    <tr> 
	        <td> 
	          <b>Mileage</b>
	        </td>
	        <td>#TradeInMileage#</td>
	    </tr>
	    <tr> 
	        <td> 
	          <b>Engine</b>
	        </td>
	        <td>#TradeInEngine#</td>
	    </tr>
	    <tr> 
	        <td> 
	          <b>Balance</b>
	        </td>
	        <td>#TradeInBalance#</td>
	    </tr>
	    <tr> 
	        <td> 
	          <b>Value</b>
	        </td>
	        <td>#TradeInValue#</td>
	    </tr>
	    <!--- <TR>
			<td><B>TradeInVin</B></TD>
		
			<td>#TradeInVin#</TD>
		</TR> ---> 
	    <tr> 
	        <td> 
	          <b>Comments</b>
	        </td>
	        <td>#Comments#</td>
	    </tr>
		</cfoutput>
	</cfcase>
	
	<!--- Personal and Business Financing Leads --->
	<cfcase value="2, 3">
		<cfoutput query="selectFinanceDetail">
		<tr>
			<td colspan="2"><br><b><u>Credit Information:</u></b></td></tr>
		<tr>
			<td><b>Credit Type</b></td><td>#CreditType#</td></tr>
		<tr>
			<td><b>JointCreditRelationship</b></td><td>#JointCreditRelationship#</td></tr>
		<tr>
			<td><b>SSN</b></td><td>#SSN#</td></tr>
		<tr>
			<td><b>Date Of Birth</b></td><td>#DateFormat(DateOfBirth, "mm/dd/yyyy")#</td></tr>
		<tr>
			<td><b>Time at Residence</b></td><td>#ResidenceLength#</td></tr>
		<tr>
			<td><b>Property Owner</b></td><td>#PropertyOwner#</td></tr>
		<tr>
			<td><b>Monthly Payment</b></td><td>#MonthlyPayment#</td></tr>
		<tr>
			<td><b>Property Situation</b></td><td>#PropertySituation#</td></tr>
		<tr>
			<td><b>Business Name</b></td><td>#BusinessName#</td></tr>
		<tr>
			<td><b>Work Address</b></td><td>#WorkAddress#</td></tr>
		<tr>
			<td><b>Work City</b></td><td>#WorkCity#</td></tr>
		<tr>
			<td><b>Employment Length</b></td><td>#EmploymentLength#</td></tr>
		<tr>
			<td><b>Gross Income</b></td><td>#GrossIncome#</td></tr>
		<tr>
			<td><b>Occupation</b></td><td>#Occupation#</td></tr>
		<tr>
			<td><b>Employer</b></td><td>#Employer#</td></tr>
		</cfoutput>
	</cfcase>
	
	<!--- Service Appointment Lead --->
	<cfcase value="4">
		<cfoutput query="selectApptServiceDetail">
		<tr>
			<td><b>Year Make Model</b></td><td>#vehicleYear# #vehicleMake# #vehicleModel#</td></tr>
		<tr>
			<td><b>Description</b></td><td>#ServiceRequestDesc#</td></tr>
		<tr>
			<td><b>Previous Customer?</b></td><td>#PrevCustomer#</td></tr>
		<tr>
			<td><b>First Preference</b></td><td>#Date1# #Time1#</td></tr>
		<tr>
			<td><b>Second Preference</b></td><td>#Date2# #Time2#</td></tr>
		<tr>
			<td><b>Third Preference</b></td><td>#Date3# #Time3#</td></tr>
		</cfoutput> 
	</cfcase>
	
	<!--- Service Part Request Lead --->
	<cfcase value="5">
		<cfoutput query="selectPartsServiceDetail">
		<tr>
			<td><b>Vehicle Information</b></td><td>#vehicleYear# #vehicleMake# #vehicleModel#</td></tr>
		<tr>
			<td><b>Description</b></td><td>#PartRequestDesc#</td></tr>
		<tr>
			<td><b>Previous Customer?</b></td><td>#PrevCustomer#</td></tr>
		<tr>
			<td><b>Deposit Info</b></td><td>#DepositInfo#</td></tr>
		<tr>
			<td><b>Card Type</b></td><td>#CardType#</td></tr>
		<tr>
			<td><b>Card Number</b></td><td>#CardNumber#</td></tr>
		<tr>
			<td><b>Card Exp Date</b></td><td><cfif isdefined("CardExp")>#CardExp#</cfif></td></tr>
		</cfoutput>
	</cfcase>
</cfswitch>
<tr>
	<td colspan="2" align="center">
		<br>
		<a href="#" OnMouseOver="self.status='Back';return true" OnMouseOut="self.status='';return true" OnClick="history.go(-1);return false"><img src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/back.gif" Border="0" ALT="Back"></a>
	</td>
</tr>
</table>
