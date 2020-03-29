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
<!--- $Id: dsp_leadDetail.cfm,v 1.6 1999/12/22 23:17:18 lswanson Exp $ --->

<!---
dsp_leadDetail.cfm - lead Detail display screen
pre: URL.leadid is defined
pre: URL.leadtype is defined
--->

<CFSETTING ENABLECFOUTPUTONLY="NO">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>

<!--- header.cfm sets up a table already --->
<CFMODULE template="..\header.cfm"
		windowTitle="Dealer Administration, Lead Reporting"
		screenTitle="Lead Reporting Detail">

		<TR ALIGN="center">
			<TD>
			<CFIF NOT isError>
				<TABLE BORDER="0" CELLPADDING="1" CELLSPACING="0">
					<CFOUTPUT QUERY="selectLeadDetail">
					<TR>
						<TD ALIGN="right">
							<B>Lead Type</B>
						</TD>
						<TD ALIGN="left">
							#Description#
						</TD>
					</TR>
					<TR>
						<TD ALIGN="right">
							<B>First Name</B>
						</TD>
						<TD ALIGN="left">
							#FName#
						</TD>
					</TR>
					<TR>
						<TD ALIGN="right">
							<B>Last Name</B>
						</TD>
						<TD ALIGN="left">
							#LName#
						</TD>
					</TR>
					<TR>
						<TD ALIGN="right">
							<B>Address</B>
						</TD>
						<TD ALIGN="left">
							#AddressLine1#
						</TD>
					</TR>
					<TR>
						<TD ALIGN="right">&nbsp;</TD>
						<TD ALIGN="left">
							#AddressLine2#
						</TD>
					</TR>
					<TR>
						<TD ALIGN="right">
							<B>City</B>
						</TD>
						<TD ALIGN="left">
							#City#
						</TD>
					</TR>
					<TR>
						<TD ALIGN="right">
							<B>State</B>
						</TD>
						<TD ALIGN="left">
							#StateAbbr#
						</TD>
					</TR>
					<TR>
						<TD ALIGN="right">
							<B>Zip</B>
						</TD>
						<TD ALIGN="left">
							#Zip#
						</TD>
					</TR>
					<TR>
						<TD ALIGN="right">
							<B>E-mail</B>
						</TD>
						<TD ALIGN="left">
							#EmailAddress#
						</TD>
					</TR>
					<TR>
						<TD ALIGN="right">
							<B>Day Phone</B>
						</TD>
						<TD ALIGN="left">
							<CFIF (Len(DayPhone) GE PHONE_NUMBER_LENGTH) AND isNumeric(Left(DayPhone, PHONE_NUMBER_LENGTH))>(#Left(DayPhone, 3)#) #Mid(DayPhone, 4, 3)#-#Mid(DayPhone, 7, 4)#</CFIF>
						</TD>
					</TR>
					<TR>
						<TD ALIGN="right">
							<B>Evening Phone</B>
						</TD>
						<TD ALIGN="left">
							<CFIF (Len(EvePhone) GE PHONE_NUMBER_LENGTH) AND isNumeric(Left(EvePhone, PHONE_NUMBER_LENGTH))>(#Left(EvePhone, 3)#) #Mid(EvePhone, 4, 3)#-#Mid(DayPhone, 7, 4)#</CFIF>
						</TD>
					</TR>
					<TR>
						<TD ALIGN="right">
							<B>When</B>
						</TD>
						<TD ALIGN="left">
							#DateFormat(WhenSubmitted, "mm/dd/yyyy")#
						</TD>
					</TR>
					</CFOUTPUT>
					<CFIF selectLeadDetail.leadTypeID EQ QUOTE_LEAD>
						<CFOUTPUT query="selectQuoteDetail">
						<TR>
							<TD align="right">
								<B>TimeToBuy</B>
							</TD>
							<TD align="left">
								#TimeToBuy#
							</TD>
						</TR>
						<TR>
							<TD align="right">
								<B>HeardAbout</B>
							</TD>
							<TD align="left">
								#HeardAbout#
							</TD>
						</TR>
						<TR>
							<TD align="right">
								<B>Make</B>
							</TD>
							<TD align="left">
								#Make#
							</TD>
						</TR>
						<TR>
							<TD align="right">
								<B>Model</B>
							</TD>
							<TD align="left">
								#Model#
							</TD>
						</TR>
						<TR>
							<TD align="right">
								<B>Year</B>
							</TD>
							<TD align="left">
								#Year#
							</TD>
						</TR>
						<TR>
							<TD align="right">
								<B>BodyStyle</B>
							</TD>
							<TD align="left">
								#BodyStyle#
							</TD>
						</TR>
						<TR>
							<TD align="right">
								<B>Color1</B>
							</TD>
							<TD align="left">
								#Color1#
							</TD>
						</TR>
						<TR>
							<TD align="right">
								<B>Color2</B>
							</TD>
							<TD align="left">
								#Color2#
							</TD>
						</TR>
						<TR>
							<TD align="right">
								<B>Interior1</B>
							</TD>
							<TD align="left">
								#Interior1#
							</TD>
						</TR>
						<TR>
							<TD align="right">
								<B>Interior2</B>
							</TD>
							<TD align="left">
								#Interior2#
							</TD>
						</TR>
						<TR>
							<TD align="right">
								<B>Transmission</B>
							</TD>
							<TD align="left">
								#Transmission#
							</TD>
						</TR>
						<TR>
							<TD align="right">
								<B>Engine</B>
							</TD>
							<TD align="left">
								#Engine#
							</TD>
						</TR>
						<TR>
							<TD align="right">
								<B>HowPay</B>
							</TD>
							<TD align="left">
								#HowPay#
							</TD>
						</TR>
						<TR>
							<TD align="right">
								<B>DownPayment</B>
							</TD>
							<TD align="left">
								#DownPayment#
							</TD>
						</TR>
						<TR>
							<TD align="right">
								<B>TradeInYear</B>
							</TD>
							<TD align="left">
								#TradeInYear#
							</TD>
						</TR>
						<TR>
							<TD align="right">
								<B>TradeInModel</B>
							</TD>
							<TD align="left">
								#TradeInModel#
							</TD>
						</TR>
						<TR>
							<TD align="right">
								<B>TradeInMileage</B>
							</TD>
							<TD align="left">
								#TradeInMileage#
							</TD>
						</TR>
						<TR>
							<TD align="right">
								<B>TradeInEngine</B>
							</TD>
							<TD align="left">
								#TradeInEngine#
							</TD>
						</TR>
						<TR>
							<TD align="right">
								<B>TradeInBalance</B>
							</TD>
							<TD align="left">
								#TradeInBalance#
							</TD>
						</TR>
						<TR>
							<TD align="right">
								<B>TradeInValue</B>
							</TD>
							<TD align="left">
								#TradeInValue#
							</TD>
						</TR>
						<!--- <TR>
							<TD align="right">
								<B>TradeInVin</B>
							</TD>
							<TD align="left">
								#TradeInVin#
							</TD>
						</TR> --->
						<TR>
							<TD align="right">
								<B>Comments</B>
							</TD>
							<TD align="left">
								#Comments#
							</TD>
						</TR>
						</CFOUTPUT>
					<CFELSEIF (selectLeadDetail.leadTypeID EQ PERSONAL_FINANCE_LEAD)
							OR (selectLeadDetail.leadTypeID EQ BUSINESS_FINANCE_LEAD)>
						<CFOUTPUT query="selectFinanceDetail">
						<TR>
							<TD align="right">
								<B>CreditType</B>
							</TD>
							<TD align="left">
								#CreditType#
							</TD>
						</TR>
						<TR>
							<TD align="right">
								<B>JointCreditRelationship</B>
							</TD>
							<TD align="left">
								#JointCreditRelationship#
							</TD>
						</TR>
						<TR>
							<TD align="right">
								<B>SSN</B>
							</TD>
							<TD align="left">
								#SSN#
							</TD>
						</TR>
						<TR>
							<TD align="right">
								<B>DateOfBirth</B>
							</TD>
							<TD align="left">
								#DateFormat(DateOfBirth, "mm/dd/yyyy")#									
							</TD>
						</TR>
						<TR>
							<TD align="right">
								<B>ResidenceLength</B>
							</TD>
							<TD align="left">
								#ResidenceLength#
							</TD>
						</TR>
						<TR>
							<TD align="right">
								<B>PropertyOwner</B>
							</TD>
							<TD align="left">
								#PropertyOwner#
							</TD>
						</TR>
						<TR>
							<TD align="right">
								<B>MonthlyPayment</B>
							</TD>
							<TD align="left">
								#MonthlyPayment#
							</TD>
						</TR>
						<TR>
							<TD align="right">
								<B>PropertySituation</B>
							</TD>
							<TD align="left">
								#PropertySituation#
							</TD>
						</TR>
						<TR>
							<TD align="right">
								<B>BusinessName</B>
							</TD>
							<TD align="left">
								#BusinessName#
							</TD>
						</TR>
						<TR>
							<TD align="right">
								<B>WorkAddress</B>
							</TD>
							<TD align="left">
								#WorkAddress#
							</TD>
						</TR>
						<TR>
							<TD align="right">
								<B>WorkCity</B>
							</TD>
							<TD align="left">
								#WorkCity#
							</TD>
						</TR>
						<TR>
							<TD align="right">
								<B>EmploymentLength</B>
							</TD>
							<TD align="left">
								#EmploymentLength#
							</TD>
						</TR>
						<TR>
							<TD align="right">
								<B>GrossIncome</B>
							</TD>
							<TD align="left">
								#GrossIncome#
							</TD>
						</TR>
						<TR>
							<TD align="right">
								<B>Occupation</B>
							</TD>
							<TD align="left">
								#Occupation#
							</TD>
						</TR>
						<TR>
							<TD align="right">
								<B>Employer</B>
							</TD>
							<TD align="left">
								#Employer#
							</TD>
						</TR>
						</CFOUTPUT>
					<CFELSEIF selectLeadDetail.leadTypeID EQ APPOINTMENT_SERVICE_LEAD>
						<cfoutput query="selectApptServiceDetail">
						<TR>
							<TD align="right">
								<B>Database Says</B>
							</TD>
							<TD align="left">
								#officialVehicleYear# #officialVehicleMake# #officialVehicleModel#
							</TD>
						</TR>
						<TR>
							<TD align="right">
								<B>Owner says</B>
							</TD>
							<TD align="left">
								#vehicleYear# #vehicleMake# #vehicleModel#
							</TD>
						</TR>
						<TR>
							<TD align="right">
								<B>ServiceRequestDesc</B>
							</TD>
							<TD align="left">
								#ServiceRequestDesc#
							</TD>
						</TR>
						<TR>
							<TD align="right">
								<B>PrevCustomer</B>
							</TD>
							<TD align="left">
								#PrevCustomer#
							</TD>
						</TR>
						<TR>
							<TD align="right">
								<B>First Preference</B>
							</TD>
							<TD align="left">
								#Date1# #Time1#
							</TD>
						</TR>
						<TR>
							<TD align="right">
								<B>Second Preference</B>
							</TD>
							<TD align="left">
								#Date2# #Time2#
							</TD>
						</TR>
						<TR>
							<TD align="right">
								<B>Third Preference</B>
							</TD>
							<TD align="left">
								#Date3# #Time3#
							</TD>
						</TR>
						</CFOUTPUT>
					<CFELSEIF selectLeadDetail.leadTypeID EQ PARTS_SERVICE_LEAD>
						<CFOUTPUT query="selectPartsServiceDetail">
						<TR>
							<TD align="right">
								<B>vehicle info</B>
							</TD>
							<TD align="left">
								#vehicleYear# #vehicleMake# #vehicleModel#
							</TD>
						</TR>
						<TR>
							<TD align="right">
								<B>PartRequestDesc</B>
							</TD>
							<TD align="left">
								#PartRequestDesc#
							</TD>
						</TR>
						<TR>
							<TD align="right">
								<B>PrevCustomer</B>
							</TD>
							<TD align="left">
								#PrevCustomer#
							</TD>
						</TR>
						<TR>
							<TD align="right">
								<B>DepositInfo</B>
							</TD>
							<TD align="left">
								#DepositInfo#
							</TD>
						</TR>
						<TR>
							<TD align="right">
								<B>CardType</B>
							</TD>
							<TD align="left">
								#CardType#
							</TD>
						</TR>
						<TR>
							<TD align="right">
								<B>CardNumber</B>
							</TD>
							<TD align="left">
								#CardNumber#
							</TD>
						</TR>
						<TR>
							<TD align="right">
								<B>CardExp</B>
							</TD>
							<TD align="left">
								<cfif IsDefined("CardExp")>#CardExp#</cfif>
							</TD>
						</TR>
						</CFOUTPUT>
					</CFIF>
				</TABLE>
			<CFELSE>
				<CFOUTPUT>#errorString#</CFOUTPUT>
			</CFIF>
			</TD>
		</TR>
		<TR>
			<FORM ACTION="index.cfm" METHOD="POST">
			<INPUT TYPE="hidden" NAME="FromTemplate" VALUE="dsp_leadDetail">
			<INPUT TYPE="hidden" NAME="FuseAction" VALUE="back">
			<INPUT TYPE="hidden" NAME="reportCoverage" VALUE="<CFOUTPUT>#reportCoverage#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="leadType" VALUE="<CFOUTPUT>#leadType#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="orderBy" VALUE="<CFOUTPUT>#orderBy#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="orderDirection" VALUE="<CFOUTPUT>#orderDirection#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="page" VALUE="<CFOUTPUT>#page#</CFOUTPUT>">
			<CFIF reportCoverage EQ "single">
				<INPUT TYPE="hidden" NAME="DealerCode" VALUE="<CFOUTPUT>#DealerCode#</CFOUTPUT>">
			<CFELSEIF reportCoverage EQ "account">
				<INPUT TYPE="hidden" NAME="accountRowID" VALUE="<CFOUTPUT>#accountRowID#</CFOUTPUT>">
			</CFIF>
			<TD ALIGN="center">
			<A HREF="#"
					OnMouseOver="self.status='Back';return true"
					OnMouseOut="self.status='';return true"
					OnClick="history.go(-1);return false"><IMG
					src="<CFOUTPUT>#g_relpath#</CFOUTPUT>/images/admin/back_nav.jpg"
					Border="0"
					ALT="Back"></A>
			</TD>
			</FORM>
		</TR>
		<TR>
			<TD>&nbsp;</TD>
		</TR>

	<!--- footer.htm closes out all tags header.cfm opened --->
	<CFMODULE template="..\footer.cfm" isRedirectable=TRUE>
</HTML>
<CFSETTING ENABLECFOUTPUTONLY="YES">