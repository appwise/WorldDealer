<!---
Created by Sigma6, Inc.
Copyright (c) 1998 Sigma6, Inc.
All Rights Reserved.  Used By Permission.

Sigma6, interactive media, Detroit/NYC
conceive : construct : connect
www.sigma6.com   webmaster@sigma6.com   info@sigma6.com

Last updated: <Jul 30, 1998>

Tim Taylor for sigma6, interactive media, Detroit
ttaylor@sigma6.com   www.sigma6.com    www.s6313.com
conceive : construct : connect

Sigma6, s6, and the Sigma6 logos are registered trademarks.
All other trademarks and servicemarks are the property of
their respective owners.
--->
<!--- $Id: dsp_reportingOptions.cfm,v 1.8 1999/12/30 19:48:34 bbickel Exp $ --->

<!---
dsp_reportingOptions.cfm - display lead reporting options
--->

<CFSETTING ENABLECFOUTPUTONLY="NO">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>

	<!--- header.cfm sets up a table already --->
	<CFMODULE template="..\header.cfm"
			windowTitle="Dealer Administration, Lead Reporting"
			screenTitle="Lead Reporting Criteria">
	<FORM NAME="lead" ACTION="index.cfm" METHOD="POST">
	<INPUT TYPE="hidden" NAME="FromTemplate" VALUE="dsp_reportingOptions">
	<CFIF NOT isError>
		<!--- BASIC OPTIONS -------------------------------------------------------------------------------->
		<CFIF optionState EQ BASIC_OPTIONS>
		
			<!--- select the type of leads available --->
			<CFQUERY NAME="selectLeadTypes" DATASOURCE="#gDSN#">
			SELECT
				RequestInfoTypeID,
				Description
			FROM
				RequestInfoTypes
			</CFQUERY>
			
			<CFIF (#Left(AccessLevel,1)# EQ application.ACCOUNT_COORDINATOR_ACCESS)
					OR (#Left(AccessLevel,1)# EQ application.ACCOUNT_EXECUTIVE_ACCESS)>
				<CFQUERY NAME="selectAccount" DATASOURCE="#gDSN#">
				SELECT	RowID
				FROM	Accounts
				WHERE	Accounts.AccountKey = '#RemoveChars(AccessLevel,1,2)#'
					<CFIF #Left(AccessLevel,1)# EQ application.ACCOUNT_COORDINATOR_ACCESS>
						AND Accounts.AccountType = 'AC'
					<CFELSE>
						AND Accounts.AccountType = 'AE'
					</CFIF>
				</CFQUERY>
			</CFIF>
		
			<INPUT TYPE="hidden" NAME="FuseAction" VALUE="submitBasicOptions">
			<CFIF #Left(AccessLevel,1)# EQ application.DEALER_ACCESS>
				<INPUT TYPE="hidden" NAME="DealerCode" VALUE="<CFOUTPUT>#RemoveChars(AccessLevel,1,2)#</CFOUTPUT>">
			<CFELSEIF (#Left(AccessLevel,1)# EQ application.ACCOUNT_COORDINATOR_ACCESS)
					OR (#Left(AccessLevel,1)# EQ application.ACCOUNT_EXECUTIVE_ACCESS)>
				<INPUT TYPE="hidden" NAME="accountRowID" VALUE="<CFOUTPUT>#selectAccount.RowID#</CFOUTPUT>">
			</CFIF>
			
 			<!--- <cfquery name="getCollectionDealers" datasource="worlddlr">
				SELECT DealerCode
				FROM CollectionDealers
				WHERE Coll_DealerCode = '#RemoveChars(AccessLevel,1,2)#'
			</cfquery> --->
			
			<TR ALIGN="left">
				<TD>
				
				<!--- display options for reporting on multiple dealers for the appropriate account types --->
				<br><b>Show report for</b> 
				<SELECT NAME="reportCoverage">
					<CFIF #Left(AccessLevel,1)# EQ application.DEALER_ACCESS>
						<!--- A DEALER ONLY EVER VIEWS THEIR OWN LEADS --->
						<!--- <cfif getCollectionDealers.RecordCount GT 0>
							<OPTION VALUE="collect" SELECTED>all dealerships in my collection</OPTION>
							<OPTION VALUE="collect_one">a single dealership in my Collection</OPTION>
							<OPTION VALUE="single">my collection</OPTION>
						<cfelse> --->
							<OPTION VALUE="single" SELECTED>my dealership</OPTION>
						<!--- </cfif> --->
					<CFELSEIF #Left(AccessLevel,1)# EQ application.ACCOUNT_COORDINATOR_ACCESS>
						<OPTION VALUE="single" SELECTED>a single dealership in my account</OPTION>
						<OPTION VALUE="account">all dealerships in my account</OPTION>
					<CFELSEIF #Left(AccessLevel,1)# EQ application.ACCOUNT_EXECUTIVE_ACCESS>
						<OPTION VALUE="single" SELECTED>a single dealership</OPTION>
						<OPTION VALUE="account">all dealerships in my account</OPTION>
						<OPTION VALUE="all">all dealerships</OPTION>
					<CFELSEIF #Left(AccessLevel,1)# EQ application.SYSADMIN_ACCESS>
						<OPTION VALUE="single" SELECTED>a single dealership</OPTION>
						<!--- <option value="collect">all dealerships in a collection</option> --->
						<OPTION VALUE="account">all dealerships in a specific account</OPTION>
						<OPTION VALUE="all">all dealerships</OPTION>
					</cfif>
				<!--- Linda, 3/29/99: for some reason, it didn't like a switch inside a select/option statement.
				<CFOUTPUT>
				<CFSWITCH expression="#Left(AccessLevel,1)#">
					<CFCASE value=application.DEALER_ACCESS>
						--- A DEALER ONLY EVER VIEWS THEIR OWN LEADS ---
						<OPTION VALUE="single" SELECTED>my dealership</OPTION>
					</cfcase>
					
					<cfcase value=application.ACCOUNT_COORDINATOR_ACCESS>
						<OPTION VALUE="single" SELECTED>a single dealership in my account</OPTION>
						<OPTION VALUE="account">all dealerships in my account</OPTION>						
					</cfcase>
					
					<cfcase value=application.ACCOUNT_EXECUTIVE_ACCESS>
						<OPTION VALUE="single" SELECTED>a single dealership</OPTION>
						<OPTION VALUE="account">all dealerships in my account</OPTION>
						<OPTION VALUE="all">all dealerships</OPTION>
					</cfcase>
					
					<cfcase value=application.SYSADMIN_ACCESS>
						<OPTION VALUE="single" SELECTED>a single dealership</OPTION>
						<OPTION VALUE="account">all dealerships in a specific account</OPTION>
						<OPTION VALUE="all">all dealerships</OPTION>
					</cfcase>
				</cfswitch>
				</cfoutput>
				--->			
 				</SELECT>
				
				
				<br><br><b>Include the following type of leads:</b><br>
				<CFOUTPUT QUERY="selectLeadTypes">
					<INPUT TYPE="Checkbox" NAME="leadType" VALUE="#selectLeadTypes.RequestInfoTypeID#" CHECKED>#selectLeadTypes.Description#<BR>
				</CFOUTPUT>
				<INPUT TYPE="hidden" NAME="leadType_required" VALUE="Please specify at least one type of lead to report on">
				
				<br><b>Sort by:</b><BR>
				<INPUT TYPE="Radio" NAME="orderBy" VALUE="lastName">last name<BR>
				<INPUT TYPE="Radio" NAME="orderBy" VALUE="leadType">type of lead<BR>
				<INPUT TYPE="Radio" NAME="orderBy" VALUE="date" CHECKED>date submitted<br>
				
				<br><b>Sort direction:</b><BR>
				<INPUT TYPE="Radio" NAME="orderDirection" VALUE="ASC">ascending&nbsp;&nbsp;
				<INPUT TYPE="Radio" NAME="orderDirection" VALUE="DESC" CHECKED>descending<br>
				
				</TD>
			</TR>
			<TR>
				<TD>&nbsp;</TD>
			</TR>
			<TR ALIGN="center">
				<TD><INPUT TYPE="Image" src="<CFOUTPUT>#g_relpath#</CFOUTPUT>/images/admin/next_nav.jpg" BORDER="0" NAME="btnNext" VALUE="Show Report"></TD>
			</TR>
			
		<!--- CHOOSE COLLECTION --------------------------------------------------------------------------->			
		<CFELSEIF optionState EQ CHOOSE_COLLECTION>
		
			<INPUT TYPE="hidden" NAME="FuseAction" VALUE="limitDealerSearch">
			<INPUT TYPE="hidden" NAME="reportCoverage" VALUE="<CFOUTPUT>#Form.reportCoverage#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="leadType" VALUE="<CFOUTPUT>#Form.leadType#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="orderBy" VALUE="<CFOUTPUT>#Form.orderBy#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="orderDirection" VALUE="<CFOUTPUT>#Form.orderDirection#</CFOUTPUT>">

			<!--- this query gets all dealerships.  unable to filter out based on Mid(dealercode) = '0000' within SQL, so have to get all & filter out later when used --->
			<CFQUERY NAME="getCollections" datasource="#gDSN#">
				SELECT	Dealercode, 
						DealershipName,
						AEID,
						ACID
				FROM 	Dealers
				<CFIF #Left(AccessLevel,1)# LT #application.SYSADMIN_ACCESS#>
				WHERE AEID = #RemoveChars(AccessLevel,1,2)# OR
					  ACID = #RemoveChars(AccessLevel,1,2)#
				</CFIF>
				ORDER BY DealershipName
			</CFQUERY>

			<!--- Drop-down list of collections --->
			<TR><TD>&nbsp;<p></TD></TR>
			<TR>
				<TD>
				<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0 WIDTH="100%">
					<FORM ACTION="index.cfm" METHOD="post">
					<TR>
						<TD ALIGN="right"><b>Choose a Collection:</b></TD>
						<TD>&nbsp;&nbsp;&nbsp;</TD>
						<TD>
							<SELECT NAME="Collection">
							<OPTION VALUE="0000">Dealership Not In A Collection		
							<CFOUTPUT QUERY="getCollections">
								<!--- just get collections (where dealer # is 0000) --->
								<CFIF Mid(#Dealercode#, 6, 4) IS '0000'>
									<OPTION VALUE="#Dealercode#">#DealershipName#
								</CFIF>
							</CFOUTPUT>
							</SELECT>
				 		</TD>
			 		</TR>
					<TR><TD COLSPAN=3>&nbsp;<p></TD></TR>
					<TR ALIGN=center>
			  			<TD COLSPAN=3><INPUT TYPE="image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/go_nav.jpg" Border="0" NAME="btnFindColl" VALUE="GO!"></TD>
					</TR>
					<TR><TD COLSPAN=3>&nbsp;<p></TD></TR>
					</FORM>
				</TABLE>
				</TD>
			</TR>
			<TR ALIGN="center">
				<TD>
				<A HREF="#"
						OnMouseOver="self.status='Back';return true"
						OnMouseOut="self.status='';return true"
						OnClick="history.go(-1);return false"><IMG
						src="<CFOUTPUT>#g_relpath#</CFOUTPUT>/images/admin/back_nav.jpg"
						Border="0"
						ALT="Back"></A>
				</TD>
			</TR>
			
		<!--- CHOOSE DEALER -------------------------------------------------------------------------------->			
		<CFELSEIF optionState EQ CHOOSE_DEALER>
		
			<INPUT TYPE="hidden" NAME="FuseAction" VALUE="chooseDealer">
			<INPUT TYPE="hidden" NAME="reportCoverage" VALUE="<CFOUTPUT>#Form.reportCoverage#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="leadType" VALUE="<CFOUTPUT>#Form.leadType#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="orderBy" VALUE="<CFOUTPUT>#Form.orderBy#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="orderDirection" VALUE="<CFOUTPUT>#Form.orderDirection#</CFOUTPUT>">
			
			<!--- determine which additional options we need to list leads --->
			<CFIF Form.reportCoverage EQ "single">
			
				<!--- this query gets all dealerships.  unable to filter out based on Mid(dealercode) = '0000' within SQL, so have to get all & filter out later when used --->
				<CFQUERY NAME="getCollections" datasource="#gDSN#">
					SELECT	Dealercode, DealershipName
		 			FROM Dealers
					<CFIF #Left(AccessLevel,1)# EQ #application.ACCOUNT_EXECUTIVE_ACCESS#>
						WHERE Dealers.AEID = #RemoveChars(AccessLevel,1,2)#
					<CFELSEIF #Left(AccessLevel,1)# EQ #application.ACCOUNT_COORDINATOR_ACCESS#>
						WHERE Dealers.ACID = #RemoveChars(AccessLevel,1,2)#
					</cfif>
					ORDER BY DealershipName
				</CFQUERY>
	
				<!--- find all the dealerships that AE or AC are assigned to, or if it's 1 dealer, just show that 1 dealership --->
			    <CFQUERY NAME="findDLR" datasource="#gDSN#">
					SELECT DealerCode, DealershipName
					FROM Dealers
						<CFIF #Left(AccessLevel,1)# EQ #application.SYSADMIN_ACCESS#>
			 				<!--- WHERE Dealers.DealerCode GT '#FORM.Collection#' 
			 				AND Dealers.DealerCode LT 'IncrementValue(Val(#FORM.Collection#))' 
			 				AND Dealers.DealerCode LT '#Evaluate(FORM.Collection +1)#' ---> 
						<CFELSEIF #Left(AccessLevel,1)# EQ #application.ACCOUNT_EXECUTIVE_ACCESS#>
							WHERE Dealers.AEID = #RemoveChars(AccessLevel,1,2)#
						<CFELSEIF Left(AccessLevel, 1) EQ #application.ACCOUNT_COORDINATOR_ACCESS#>
							WHERE Dealers.ACID = #RemoveChars(AccessLevel,1,2)#
						<CFELSEIF Left(AccessLevel, 1) EQ #application.DEALER_ACCESS#>			
							WHERE Dealers.DealerCode = #RemoveChars(AccessLevel,1,2)#
						</cfif>
			 		ORDER BY DealershipName
			    </CFQUERY>
				

				 <CFIF ParameterExists(Form.Collection)>
					<CFIF #Form.Collection# NEQ "0000">			
						<TR align="center">		
							<TD>
								
								<CFOUTPUT QUERY="getCollections">
								<!--- just get collections (where dealer # is 0000) --->
								<CFIF Mid(Dealercode, 6, 4) IS '0000'>
									<!--- if sysadmin, just show collection selected on prev. page --->
									<CFIF ParameterExists(Form.Collection)>
										<CFIF DealerCode EQ '#FORM.Collection#'>
											<b>#DealershipName#</b><BR>
										</CFIF>
									<!--- for dealers, show the parent collection --->
									<CFELSEIF Left(AccessLevel, 1) EQ #application.DEALER_ACCESS# OR
												Left(AccessLevel, 1) EQ #application.COLLECTION_ACCESS#>
										<CFIF Left(DealerCode, 4) IS #Mid(AccessLevel,3,4)#>
											<b>#DealershipName#</b><BR>
										</CFIF>
									<cfelse>
										<b>#DealershipName#</b><BR>
									</CFIF>
								</CFIF>
								</CFOUTPUT>
								</SELECT>
								
		 					</TD>
						</TR>
					</CFIF>
				</CFIF>  
			
				<!--- if dealers were found, display them in drop-down list --->	
				<TR ALIGN=center>
					<CFIF findDLR.RecordCount GT '0'>
						<FORM ACTION="index.cfm" METHOD="post">
						<INPUT TYPE="hidden" NAME="NextStep" VALUE="webvrfy.cfm">
						<INPUT type="hidden" name="DealerCode_required" value="You must select a dealer.">
						<TD>
							
							<b>Choose a Dealer:</b><BR>
							<SELECT NAME="DealerCode">
							<CFOUTPUT QUERY="findDLR">
							<!--- if sysadmin, just show dealerships within collection selected on prev. page --->
							<CFIF ParameterExists(Form.Collection)>
								<CFIF Left(DealerCode, 4) EQ '#Left(FORM.Collection, 4)#'
									AND Mid(DealerCode, 6, 4) NEQ '0000'>
									<OPTION VALUE="#DealerCode#">#DealershipName# (#DealerCode#)
								</cfif>
							<cfelse>
								<OPTION VALUE="#DealerCode#">#DealershipName# (#DealerCode#)
							</cfif>
							</CFOUTPUT>
							</SELECT>
							<INPUT TYPE="hidden" NAME="DealerCode_required" VALUE="Please choose a dealer from the list.">
							
						</TD>
					<CFELSE>
						<TD ALIGN="center">No dealers found.</TD>
					</CFIF>						
				</TR>
				
				<!--- ACCOUNT ------------------------------------------------------------------------------>
			<CFELSEIF (Form.reportCoverage EQ "account")
						AND (#Left(AccessLevel,1)# EQ application.SYSADMIN_ACCESS)>
	
					<!--- get coordinator and executive accounts --->
					<CFQUERY NAME="selectAccounts" DATASOURCE="#gDSN#">
					SELECT	RowID,
							Name
					FROM	Accounts
					WHERE	Accounts.AccountType = 'AC' OR
							Accounts.AccountType = 'AE'
					ORDER BY Accounts.Name
					</CFQUERY>
						
					<CFIF selectAccounts.RecordCount GT 0>
						<TD>Choose an account:
						<SELECT NAME="accountRowID">
							<CFOUTPUT query="selectAccounts">
								<OPTION VALUE="#RowID#">#Name#</OPTION>
							</CFOUTPUT>
						</SELECT>
						<INPUT TYPE="hidden" NAME="accountRowID_required" VALUE="Please select an account to report on.">
						
						</TD>
					<CFELSE>
						<TD ALIGN="center">No accounts found</TD>
					</CFIF>
				
				<cfelseif (Form.reportCoverage EQ "collect")>
					<cfif getCollectionDealers.RecordCount GT 0>
						<td>eff off</td>
					<cfelse>
						<td align="center">No accounts found</td>
					</cfif>
				
				
				</CFIF>
			</TR>
			<TR>
				<TD>&nbsp;</TD>
			</TR>
			<TR ALIGN="center">
				<TD>
				<A HREF="#"
						OnMouseOver="self.status='Back';return true"
						OnMouseOut="self.status='';return true"
						OnClick="history.go(-1);return false"><IMG
						src="<CFOUTPUT>#g_relpath#</CFOUTPUT>/images/admin/back_nav.jpg"
						Border="0"
						ALT="Back"></A>&nbsp;&nbsp;<INPUT
						TYPE="Image"
						src="<CFOUTPUT>#g_relpath#</CFOUTPUT>/images/admin/next_nav.jpg"
						BORDER="0"
						NAME="btnNext"
						VALUE="Next"></TD>
			</TR>
		</CFIF>
	<CFELSE>
		<TR ALIGN="center">
			<TD><CFOUTPUT>#errorString#</CFOUTPUT></TD>
		</TR>
		<TR>
			<TD>&nbsp;</TD>
		</TR>
		<TR ALIGN="center">
			<TD>
			<A HREF="#"
					OnMouseOver="self.status='Back';return true"
					OnMouseOut="self.status='';return true"
					OnClick="history.go(-1);return false"><IMG
					src="<CFOUTPUT>#g_relpath#</CFOUTPUT>/images/admin/back_nav.jpg"
					Border="0"
					ALT="Back"></A>
			</TD>
		</TR>
	</CFIF>
	</FORM>
		
	<!--- footer.htm closes out all tags header.cfm opened --->
	<CFMODULE template="..\footer.cfm" isRedirectable=TRUE>
</HTML>
<CFSETTING ENABLECFOUTPUTONLY="YES">