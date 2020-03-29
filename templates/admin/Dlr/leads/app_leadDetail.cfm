<!---
Created by Sigma6, Inc.
Copyright (c) 1998 Sigma6, Inc.
All Rights Reserved.  Used By Permission.

Sigma6, interactive media, Detroit/NYC
conceive : construct : connect
www.sigma6.com   webmaster@sigma6.com   info@sigma6.com

Last updated: <Jul 31, 1998>

Tim Taylor for sigma6, interactive media, Detroit
ttaylor@sigma6.com   www.sigma6.com    www.s6313.com
conceive : construct : connect

Sigma6, s6, and the Sigma6 logos are registered trademarks.
All other trademarks and servicemarks are the property of
their respective owners.
--->
<!--- $Id: app_leadDetail.cfm,v 1.7 1999/12/22 23:17:18 lswanson Exp $ --->

<!---
app_leadDetail.cfm - lead Detail queries and such
pre: Form.leadid is defined
pre: Form.leadtype is defined
--->

<CFIF NOT isError>
	<!--- build where clause for select statement to query the general lead table --->
	<CFQUERY NAME="selectLeadDetail" DATASOURCE="#gDSN#">
		SELECT
			RequestInfoGeneral.RequestInfoID as leadID,
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
		FROM
			RequestInfoGeneral,
			RequestInfoTypes
		WHERE
			RequestInfoGeneral.RequestInfoTypeID = RequestInfoTypes.RequestInfoTypeID
			AND RequestInfoGeneral.RequestInfoID = #Form.leadID#
	</CFQUERY>
	
	<!-- query the lead specific table -->
	<CFIF selectLeadDetail.leadTypeID EQ QUOTE_LEAD>
		<CFQUERY NAME="selectQuoteDetail" DATASOURCE="#gDSN#">
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
		</CFQUERY>
		<!--- RequestInfoQuote.TradeInVin, --->
	<CFELSEIF (selectLeadDetail.leadTypeID EQ PERSONAL_FINANCE_LEAD)
			OR (selectLeadDetail.leadTypeID EQ BUSINESS_FINANCE_LEAD)>
	
		<!--- personal and business leads use the same table --->
		<CFQUERY NAME="selectFinanceDetail" DATASOURCE="#gDSN#">
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
				<CFIF selectLeadDetail.leadTypeID EQ PERSONAL_FINANCE_LEAD>
					AND ApplicationType = 'personal'
				<CFELSEIF selectLeadDetail.leadTypeID EQ BUSINESS_FINANCE_LEAD>
					AND ApplicationType = 'business'
				</CFIF>
		</CFQUERY>
	<CFELSEIF selectLeadDetail.leadTypeID EQ APPOINTMENT_SERVICE_LEAD>
	<cfoutput>#Form.leadID#</cfoutput>
		<CFQUERY NAME="selectApptServiceDetail" DATASOURCE="#gDSN#">
			SELECT
				RequestInfoService.ServiceRequestDesc,
				RequestInfoService.PrevCustomer,
				RequestInfoService.Date1,
				RequestInfoService.Date2,
				RequestInfoService.Date3,
				RequestInfoService.Time1,
				RequestInfoService.Time2,
				RequestInfoService.Time3,
				RequestInfoService.Make as vehicleMake,
				RequestInfoService.Model as vehicleModel,
				RequestInfoService.CarYear as vehicleYear,
				RequestInfoService.VIN,
				UsedVehiclesModels.ModelName as officialVehicleModel,
				UsedVehiclesModels.Make as officialVehicleMake,
				UsedVehiclesModels.Year as officialVehicleYear
			FROM
				RequestInfoService,
				UsedVehiclesModels
			WHERE
				RequestInfoService.RequestInfoGeneralID = #Form.leadID#
				AND RequestInfoService.ModelID = UsedVehiclesModels.ID
		</CFQUERY>
		
	<CFELSEIF selectLeadDetail.leadTypeID EQ PARTS_SERVICE_LEAD>
		<CFQUERY NAME="selectPartsServiceDetail" DATASOURCE="#gDSN#">
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
		</CFQUERY>		
	</CFIF>
</CFIF>