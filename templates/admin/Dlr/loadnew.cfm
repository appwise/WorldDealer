<CFSET PageAccess = 1>
<CFINCLUDE template="security.cfm">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>

    <!-- ----------------------------------------------------------- -->
    <!--                Created by sigma6, Detroit                   -->
    <!--         Copyright (c) 1997, 1998, 1999 sigma6.              -->
    <!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->

    <!-- ----------------------------------------------------------- -->
    <!--    Alan Warchuck for sigma6, interactive media, Detroit     -->
    <!--    awarchuck@sigma6.com  www.sigma6.com   www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
	<!--- $Id: loadnew.cfm,v 1.9 1999/11/24 22:54:09 lswanson Exp $ --->
	
<!--- loadnew.cfm and loadnew2.cfm are almost identical to the "add new dealer" functionality of webnew.cfm --->


<HEAD>

	<TITLE>WorldDealer | Create Dealer Listing</TITLE>

<!--- Check to see if this is a new request or an Update Request --->
<!--- Linda, 3/17/99: I don't think DlrSelected will exist anymore, now that it's no longer called from loadfind2.cfm --->
<CFIF ParameterExists(Form.DealerCode)>
   <CFSET DlrSelected = 'Y'>
   <CFSET g_DealerCode = #Form.DealerCode#>
<CFELSE>
   <CFSET DlrSelected = 'N'>
   <CFSET g_DealerCode = ''>
</CFIF>


<CFIF DlrSelected EQ 'Y'>

	<!--- user is coming at this page with a dealer/Collection already selected --->
	<CFQUERY name="CheckDealerWebs" datasource="#gDSN#">
		SELECT Dealercode
		FROM DealerWebs
		WHERE DealerCode = '#g_Dealercode#';
	</CFQUERY>

	<!--- If This Dealership/Collection is already in DealerWebs, redirect to webnew.cfm --->	
	<CFIF #CheckDealerWebs.RecordCount# IS NOT 0>
		<CFLOCATION url="webnew.cfm?dlrcode=#g_Dealercode#">
	</CFIF>
	
	<!--- Dealer/Collection Query used below --->
    <CFQUERY NAME="getDealerInfo" datasource="#gDSN#">
	      SELECT DealershipName as q_DealershipName,
				 AddressLine1 as q_AddressLine1,
				 AddressLine2 as q_AddressLine2,
				 City as q_City,
				 StateAbbr as q_StateAbbr,
				 Zip as q_Zip,
				 Phone as q_Phone,
				 FaxPhone as q_FaxPhone,
                 AEID as q_AEID,
		         ACID as q_ACID,
				 DealerFirstName as q_DealerFirstName,
				 DealerLastName as q_DealerLastName,
				 Email as q_EMail,
				 DisplayName as q_DisplayName
		    FROM Dealers
		   WHERE Dealers.DealerCode = '#g_DealerCode#'
	</CFQUERY>

	<!--- Dealer/Collection Account Executive Query used below --->
    <CFQUERY NAME="getAEInfo" datasource="#gDSN#">
         SELECT AEID as lq_AEID,
		        FirstName as lq_AEFirstName,
				LastName as lq_AELastName
		   FROM AccountExecs
          WHERE AccountExecs.AEID
		     IN (SELECT AEID FROM Dealers WHERE Dealers.DealerCode = '#g_DealerCode#')
	</CFQUERY>
	
	<!--- Dealer/Collection Account Coordinator Query used below --->
    <CFQUERY NAME="getACInfo" datasource="#gDSN#">
         SELECT ACID as lq_ACID,
		        FirstName as lq_ACFirstName,
				LastName as lq_ACLastName
		   FROM AccountCoordinators
          WHERE AccountCoordinators.ACID
		     IN (SELECT ACID FROM Dealers WHERE Dealers.DealerCode = '#g_DealerCode#')
	</CFQUERY>

</CFIF>  
<!--- End DlrSelected EQ 'Y' --->

<!--- Dealer/Collection Dealer Type Query used in drop down list below --->
<!--- 
<CFQUERY NAME="getDealerTypes" datasource="#gDSN#">
	SELECT 	DF_Number,
		   	MakeNumber
	FROM 	DealerFranchise
	ORDER BY DF_Number
</CFQUERY>
 --->
<CFQUERY NAME="getMakes" datasource="#gDSN#">
	SELECT	MakeNumber,
			MakeName
	FROM 	Makes
	ORDER BY MakeName
</CFQUERY>

<!--- Dealer/Collection State Information Query used for drop down list below --->
<CFQUERY NAME="getStates" datasource="#gDSN#">
	SELECT 	StateAbbr as q_StateAbbr,
			Description as q_Description
	FROM 	States
	ORDER BY Description
</CFQUERY>

<!--- Dealer/Collection Query used below --->
<CFQUERY NAME="getDealerships" datasource="#gDSN#">
    SELECT	Dealercode, 
                 DealershipName as q2_DealershipName,
		    	 AddressLine1 as q2_AddressLine1,
				 AddressLine2 as q2_AddressLine2,
				 City as q2_City,
				 StateAbbr as q2_StateAbbr,
				 Zip as q2_Zip,
				 Phone as q2_Phone,
				 FaxPhone as q2_FaxPhone,
                 AEID as q2_AEID,
		         ACID as q2_ACID,
				 DealerFirstName as q2_DealerFirstName,
				 DealerLastName as q2_DealerLastName,
				 Email as q2_EMail,
<!--- 				 County as q2_County, --->
				 DisplayName as q2_DisplayName
		    FROM Dealers 
			Order BY DealershipName
	</CFQUERY>

	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>

<body>
<br><br><br><br><br>

<div align="center">
<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=520 BGCOLOR="FFFFFF">
<TR><TD>&nbsp;<p></TD></TR>

<!--- Decide which Title (Dealership/Collection to display on page --->
<CFIF ((ParameterExists(URL.Addtype)) And (#URL.Addtype# IS "collection"))>
	<TR ALIGN="center">
		<TD ALIGN="middle"><h3><FONT FACE="Arial,Helvetica">Collection Administration - Enter Collection Information</FONT></h3></TD>
	</TR>
<CFELSE>
	<TR ALIGN="center">
		<TD ALIGN="middle"><h3><FONT FACE="Arial,Helvetica">Dealer Administration - Enter Dealer Information</FONT></h3></TD>
	</TR>
</CFIF>

<CFIF ((ParameterExists(URL.Addtype)) And (#URL.Addtype# IS "collection"))>		
	<TR ALIGN="center">
		<TD ALIGN="middle"><FONT FACE="Arial,Helvetica">Enter or verify Collection information below, as appropriate.<BR>Required fields are bolded.</FONT></TD>
	</TR>
<CFELSE>
	<TR ALIGN="center">
		<TD ALIGN="middle"><FONT FACE="Arial,Helvetica">Enter or verify dealership information below, as appropriate.<BR>Required fields are bolded.</FONT></TD>
	</TR>
</CFIF>
<!--- End Title Selection --->


<TR><TD>&nbsp;<p></TD></TR>

<TR>
	<TD>
	<FORM NAME="StepOne" ACTION="loadnew_s2.cfm" METHOD="post">
	<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0 WIDTH="90%">

		<!--- Hidden variable used for loadnew_s2.cfm to tell if it's a collection or dealership --->
		<CFIF ((ParameterExists(URL.Addtype)) And (#URL.Addtype# IS "collection"))>
			<INPUT type="hidden" name="ProcType" value="Collection">
		<CFELSE>
			<INPUT type="hidden" name="ProcType" value="Dealer">
		</CFIF>	

		<!--- Hidden variable used for loadnew_s2.cfm to tell if it's an add or update --->
		<CFIF DlrSelected EQ 'Y'>
			<INPUT type="hidden" name="ProcVar" value="Update">	
		<CFELSE>
			<INPUT type="hidden" name="ProcVar" value="New">	
		</CFIF>	
		
		<!--- if it's a collection and it's an add, set the collection to zeroes (First four digits of dealer code) --->		
		<!--- We will calculate the collection number on the next screen (loadnew_s2.cfm) --->		
		<CFIF ((ParameterExists(URL.Addtype)) And (#URL.Addtype# IS "collection") And (DlrSelected EQ 'N'))>
			<INPUT type="hidden" name="Collection" value="0000">
		<CFELSE>
			<!--- This is a Collection Update or Dealer so we will display the Drop down list of collections --->		
			<TR>
				<TD ALIGN="right"><b><font face="Arial,Helvetica">Collection</font></b></TD>
				<TD>&nbsp;&nbsp;&nbsp;</TD>
				<!--- We have a Collection/dealer code to work with --->
				<CFIF DlrSelected EQ 'Y'>
					<CFOUTPUT QUERY="getDealerships">
					<CFSET hold_Collection = #Left(g_DealerCode,4)#>
					</CFOUTPUT>
					<TD>
					<SELECT NAME="Collection">
					<CFOUTPUT QUERY="getDealerships">
					<!--- Collection Check --->
					<CFIF Mid(getDealerships.Dealercode,6,4) IS "0000">
						<CFSET tmp_Collection=Left(getDealerships.Dealercode,4)>
						<!--- Set selection box to collection we are updating --->
						<CFIF  #tmp_Collection# EQ #hold_Collection#>
							<OPTION VALUE="#tmp_Collection#" SELECTED>#q2_DealershipName#
						<CFELSE>
							<OPTION VALUE="#tmp_Collection#">#q2_DealershipName#
						</CFIF>
					</CFIF>
					<CFSET tmp_Desc="">
					</CFOUTPUT>
					</SELECT>
					</TD>
				<CFELSE>
					<TD>
					<!--- this is an Add Dealer, so display all collections --->
					<SELECT NAME="Collection">
					<CFOUTPUT>
			    		<Option Value="0000">None
					</cfoutput>
					<CFOUTPUT QUERY="getDealerShips">
					<CFIF Mid(getDealerShips.Dealercode,6,4) IS "0000">
						<CFSET tmp_Collection=Left(getDealerShips.Dealercode,4)>
						<OPTION VALUE="#tmp_Collection#">#q2_DealershipName#
						<CFSET tmp_Collection="">
					</CFIF>	
					</CFOUTPUT>
					</SELECT>
					</TD>
				</CFIF>
			</tr>
		</CFIF>

	<!--- if it's a collection set the DealerType to zeroes (third set of three digits of dealer code) --->		
	<!--- We will also keep from displaying this text box on the screen --->		
	<CFIF ((ParameterExists(URL.Addtype)) And (#URL.Addtype# IS "collection"))>
	      <INPUT TYPE="hidden" NAME="DealerType" Value="000">
	<CFELSE>	
		<TR>	
			<!--- This will be displayed for Dealers Add/Update ---> 		
			<!--- The DealerType is the third set of numbers in the dealercode(three digits) --->		
			<TD ALIGN="right" valign="top">
				<b><font face="Arial,Helvetica">Dealer Type</font></b>
			</TD>
			<TD>&nbsp;&nbsp;&nbsp;</TD>
				<INPUT type="hidden" name="DealerType1_required" value="Please select a Dealer Type.">
<!--- linda 3/17/99: don't think this is called as an update anymore.  just for adding new dealers.	
				<CFIF DlrSelected EQ 'Y'>
				--- If this is a dealer update, set the list to the correct Dealer type ---
					<CFOUTPUT QUERY="getDealerTypes">
					<CFSET holdDealerType = Mid(#g_DealerCode#,11,3)>
					</CFOUTPUT>
					<TD>
						<SELECT NAME="DealerType">
						<CFOUTPUT QUERY="getDealerTypes">
						<CFSET tmp_Desc = Trim(#MakeNumber#)>
						<CFIF tmp_Desc EQ #holdDealerType#>
							<OPTION VALUE="#DF_Number#" SELECTED>#tmp_Desc#
						<CFELSE>
							<OPTION VALUE="#DF_Number#">#tmp_Desc#
						</CFIF>
						<CFSET tmp_Desc="">
						</CFOUTPUT>
						</SELECT>
					</TD>
				<CFELSE>
 --->				<!--- If this is a dealer add, Display the entire list with none selected ---> 		
					<TD>
						<SELECT NAME="DealerType1">
						<OPTION VALUE="">Select Make 1
						<CFOUTPUT QUERY="getMakes">
							<CFSET tmp_Desc = Trim(#MakeName#)>
							<OPTION VALUE=#MakeNumber#>#tmp_Desc#
							<CFSET tmp_Desc="">
						</CFOUTPUT>
						</SELECT>
						
						<SELECT NAME="DealerType2">
						<OPTION VALUE="">Select Make 2
						<CFOUTPUT QUERY="getMakes">
							<CFSET tmp_Desc = Trim(#MakeName#)>
							<OPTION VALUE=#MakeNumber#>#tmp_Desc#
							<CFSET tmp_Desc="">
						</CFOUTPUT>
						</SELECT>
						
						<SELECT NAME="DealerType3">
						<OPTION VALUE="">Select Make 3
						<CFOUTPUT QUERY="getMakes">
							<CFSET tmp_Desc = Trim(#MakeName#)>
							<OPTION VALUE=#MakeNumber#>#tmp_Desc#
							<CFSET tmp_Desc="">
						</CFOUTPUT>
						</SELECT>
						
						<SELECT NAME="DealerType4">
						<OPTION VALUE="">Select Make 4
						<CFOUTPUT QUERY="getMakes">
							<CFSET tmp_Desc = Trim(#MakeName#)>
							<OPTION VALUE=#MakeNumber#>#tmp_Desc#
							<CFSET tmp_Desc="">
						</CFOUTPUT>
						</SELECT>
						
						<SELECT NAME="DealerType5">
						<OPTION VALUE="">Select Make 5
						<CFOUTPUT QUERY="getMakes">
							<CFSET tmp_Desc = Trim(#MakeName#)>
							<OPTION VALUE=#MakeNumber#>#tmp_Desc#
							<CFSET tmp_Desc="">
						</CFOUTPUT>
						</SELECT>

						<SELECT NAME="DealerType6">
						<OPTION VALUE="">Select Make 6
						<CFOUTPUT QUERY="getMakes">
							<CFSET tmp_Desc = Trim(#MakeName#)>
							<OPTION VALUE=#MakeNumber#>#tmp_Desc#
							<CFSET tmp_Desc="">
						</CFOUTPUT>
						</SELECT>

						<SELECT NAME="DealerType7">
						<OPTION VALUE="">Select Make 7
						<CFOUTPUT QUERY="getMakes">
							<CFSET tmp_Desc = Trim(#MakeName#)>
							<OPTION VALUE=#MakeNumber#>#tmp_Desc#
							<CFSET tmp_Desc="">
						</CFOUTPUT>
						</SELECT>

						<SELECT NAME="DealerType8">
						<OPTION VALUE="">Select Make 8
						<CFOUTPUT QUERY="getMakes">
							<CFSET tmp_Desc = Trim(#MakeName#)>
							<OPTION VALUE=#MakeNumber#>#tmp_Desc#
							<CFSET tmp_Desc="">
						</CFOUTPUT>
						</SELECT>

						<SELECT NAME="DealerType9">
						<OPTION VALUE="">Select Make 9
						<CFOUTPUT QUERY="getMakes">
							<CFSET tmp_Desc = Trim(#MakeName#)>
							<OPTION VALUE=#MakeNumber#>#tmp_Desc#
							<CFSET tmp_Desc="">
						</CFOUTPUT>
						</SELECT>

						<SELECT NAME="DealerType10">
						<OPTION VALUE="">Select Make 10
						<CFOUTPUT QUERY="getMakes">
							<CFSET tmp_Desc = Trim(#MakeName#)>
							<OPTION VALUE=#MakeNumber#>#tmp_Desc#
							<CFSET tmp_Desc="">
						</CFOUTPUT>
						</SELECT>
					</TD>
<!--- 				</CFIF> --->
		</TR>
	</CFIF>

	<!--- if it's a collection and it's an add set the dealerNo to zeroes (last set of 10 digits of dealer code) --->
	<!--- We will also keep from displaying this text box on the screen --->
	<CFIF ((ParameterExists(URL.Addtype)) And (#URL.Addtype# IS "collection") And (DlrSelected EQ 'N'))>
	      <INPUT TYPE="hidden" NAME="DealerCodeIN" Value="0000000000">
	<CFELSE>
		<TR>
			<!--- This will be displayed for Dealer Add/Update or Collection Update ---> 		
			<!--- Lets decide what we will call the caption Dealer code or Collection code --->		
			<CFIF ((ParameterExists(URL.Addtype)) And (#URL.Addtype# IS "collection"))>
				<TD ALIGN="right"><b><font face="Arial,Helvetica">Collection Code</font></b></TD>
			<CFELSE>		
				<TD ALIGN="right"><b><font face="Arial,Helvetica">Dealer Code</font></b></TD>
			</CFIF>
			<TD>&nbsp;&nbsp;&nbsp;</TD>
			<INPUT type="hidden" name="DealerCodeIN_required" value="Please enter a Dealer Code.">
			<INPUT type="hidden" name="DealerCodeIN_integer" value="Please enter a numeric Dealer Code.">
			<TD><INPUT TYPE="text" NAME="DealerCodeIN" SIZE="40" <CFIF DlrSelected EQ 'Y'><cfoutput>VALUE="#g_DealerCode#"</cfoutput></CFIF> MAXLENGTH=40></TD>
		</TR>
	</CFIF>

	<TR>
		<!--- Decide which Name Title (Dealership/Collection) to display on page --->
		<CFIF ((ParameterExists(URL.Addtype)) And (#URL.Addtype# IS "collection"))>
			<TD ALIGN="right"><b><font face="Arial,Helvetica">Collection Name</font></b></TD>
		<CFELSE>	
			<TD ALIGN="right"><b><font face="Arial,Helvetica">Dealership Name</font></b></TD>
		</CFIF>	
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<CFIF ((ParameterExists(URL.Addtype)) And (#URL.Addtype# IS "collection"))>
			<INPUT type="hidden" name="DealershipName_required" value="Please select a name for this Collection.">
		<CFELSE>
			<INPUT type="hidden" name="DealershipName_required" value="Please select a name for this Dealership.">		
		</CFIF>
		<CFIF DlrSelected EQ 'Y'>
			<TD><CFOUTPUT><INPUT TYPE=text NAME="DealershipName" SIZE=40 MAXLENGTH=40 VALUE="#getDealerInfo.q_DealershipName#"></CFOUTPUT></TD>
		<CFELSE>
			<TD><INPUT TYPE=text NAME="DealershipName" SIZE=40 MAXLENGTH=40></TD>
		</CFIF>
	</TR>

	<!--- Address1 Field --->
	<TR>
		<TD ALIGN="right"><b><font face="Arial,Helvetica">Address 1</font></b></TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<INPUT type="hidden" name="Address1_required" value="Please enter an address for this dealership.">
		<CFIF DlrSelected EQ 'Y'>
			<TD><cfoutput><INPUT TYPE=text NAME="Address1" SIZE=40 VALUE="#getDealerInfo.q_AddressLine1#" MAXLENGTH=40></cfoutput></TD>
		<CFELSE>
			<TD><INPUT TYPE=text NAME="Address1" SIZE=40 MAXLENGTH=40></TD>
		</CFIF>
	</TR>

	<!--- Address2 Field --->
	<TR>
		<TD ALIGN="right"><font face="Arial,Helvetica">Address 2</font></TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<CFIF DlrSelected EQ 'Y'>
			<CFOUTPUT QUERY="getDealerInfo">
			<TD><INPUT TYPE=text NAME="Address2" SIZE=40 MAXLENGTH=40 TABINDEX=3 VALUE="#q_AddressLine2#"></TD>
			</CFOUTPUT>
		<CFELSE>
			<TD><INPUT TYPE=text NAME="Address2" SIZE=40 MAXLENGTH=40 TABINDEX=3></TD>
		</CFIF>
	</TR>

	<!--- City Field --->
	<TR>
		<TD ALIGN="right"><b><font face="Arial,Helvetica">City</font></b></TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<INPUT type="hidden" name="City_required" value="Please enter a city for this dealership.">
		<CFIF DlrSelected EQ 'Y'>
			<TD><cfoutput><INPUT TYPE=text NAME="City" SIZE=35 VALUE="#getDealerInfo.q_City#" MAXLENGTH=35></cfoutput></TD>
		<CFELSE>
			<TD><INPUT TYPE=text NAME="City" SIZE=35 MAXLENGTH=35></TD>
		</CFIF>
	</TR>

	<!--- County Field (Not required) --->
<!--- Linda, 3/16/99: Not useful info...  entered here & then it's never used again.
	<TR>
		<TD ALIGN="right"><font face="Arial,Helvetica">County</font></TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<CFIF DlrSelected EQ 'Y'>
			<TD><cfoutput><INPUT TYPE=text NAME="County" SIZE=20 VALUE="#getDealerInfo.q_COunty#" MAXLENGTH=20></cfoutput></TD>
		<CFELSE>
			<TD><INPUT TYPE=text NAME="County" SIZE=20 MAXLENGTH=20></TD>
		</CFIF>
	</TR>
 --->
	<!--- State Field (dropdown list populated from DataBase) --->
	<TR>
		<TD ALIGN="right"><b><font face="Arial,Helvetica">State</font></b></TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<INPUT type="hidden" name="StateAbbr_required" value="Please select the state where this Dealership is located.">
		<!--- If this is an update set the Dealers/Collections state from the list --->
		<CFIF DlrSelected EQ 'Y'>
			<CFOUTPUT QUERY="getDealerInfo">
				<CFSET tmpStateAbbr = #q_StateAbbr#>
			</CFOUTPUT>
			<TD><SELECT NAME="StateAbbr">
			<CFOUTPUT query="getStates">
				<OPTION value="#q_stateAbbr#" <CFIF #q_stateAbbr# EQ #tmpStateAbbr#>SELECTED</CFIF>>#q_Description#</OPTION>
				
			</CFOUTPUT>
			</SELECT></TD>
		<CFELSE>
		<!--- If this is an add, display the states unselected --->
			<TD><SELECT NAME="StateAbbr">
			<CFOUTPUT query="getstates">
			<OPTION value="#q_stateAbbr#">#q_Description#</OPTION>
			</CFOUTPUT>
			</SELECT></TD>
		</CFIF>
	</TR>

	<!--- Zip Code --->
	<TR>
		<TD ALIGN="right"><b><font face="Arial,Helvetica">Zip Code</font></b></TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<INPUT type="hidden" name="Zip_required" value="Please enter a valid USPS Zip Code for this Dealership.">
		<CFIF DlrSelected EQ 'Y'>
			<TD><cfoutput><INPUT TYPE=text NAME="Zip" SIZE=10 VALUE="#getDealerInfo.q_Zip#" MAXLENGTH=10></cfoutput>
			&nbsp;<b>XXXXX</b> or <b>XXXX-XXXXX</b></TD>
		<CFELSE>
			<TD><INPUT TYPE=text NAME="Zip" SIZE=10 MAXLENGTH=10>&nbsp;<b>XXXXX</b> or <b>XXXX-XXXXX</b></TD>
		</CFIF>
	</TR>

	<!--- Phone Number --->
	<TR>
		<TD ALIGN="right"><b><font face="Arial,Helvetica">Phone Number</font></b></TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<INPUT type="hidden" name="Phone1_required" value="Please enter a valid Area Code.">
		<INPUT type="hidden" name="Phone2_required" value="Please enter a valid phone number.">
		<INPUT type="hidden" name="Phone3_required" value="Please enter a valid phone number.">
		<CFIF (DlrSelected EQ 'Y')>
			<CFIF (#Len(getDealerInfo.q_Phone)# EQ 10)>
				<TD><cfoutput>
				<INPUT TYPE=text NAME="Phone1" SIZE=3 VALUE="#RemoveChars(getDealerInfo.q_Phone,4,10)#" MAXLENGTH=3>
				<INPUT TYPE=text NAME="Phone2" SIZE=3 VALUE="#Mid(getDealerInfo.q_Phone,4,3)#" MAXLENGTH=3>
				<INPUT TYPE=text NAME="Phone3" SIZE=4 VALUE="#RemoveChars(getDealerInfo.q_Phone,1,6)#" MAXLENGTH=4>
				</CFOUTPUT>
				</TD>
			<CFELSE>
				<TD><INPUT TYPE=text NAME="Phone1" SIZE=3 MAXLENGTH=3>
				<INPUT TYPE=text NAME="Phone2" SIZE=3 MAXLENGTH=3>
				<INPUT TYPE=text NAME="Phone3" SIZE=4 MAXLENGTH=4>
				</TD>					
			</CFIF>
		<CFELSE>
			<TD><INPUT TYPE=text NAME="Phone1" SIZE=3 MAXLENGTH=3>
			<INPUT TYPE=text NAME="Phone2" SIZE=3 MAXLENGTH=3>
			<INPUT TYPE=text NAME="Phone3" SIZE=4 MAXLENGTH=4>
			</TD>
		</CFIF>
	</TR>

	<!--- Fax Number --->
	<TR>
		<TD ALIGN="right"><b><font face="Arial,Helvetica">Fax Number</font></b></TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<INPUT type="hidden" name="FaxPhone1_required" value="Please enter a valid area code for your fax phone.">
		<INPUT type="hidden" name="FaxPhone2_required" value="Please enter a valid fax phone number.">
		<INPUT type="hidden" name="FaxPhone3_required" value="Please enter a valid fax phone number.">
		<CFIF (DlrSelected EQ 'Y')>
			<CFIF (#Len(getDealerInfo.q_FaxPhone)# EQ 10)>
				<TD><cfoutput>
				<INPUT TYPE=text NAME="FaxPhone1" SIZE=3 VALUE="#RemoveChars(getDealerInfo.q_FaxPhone,4,10)#" MAXLENGTH=3>
				<INPUT TYPE=text NAME="FaxPhone2" SIZE=3 VALUE="#Mid(getDealerInfo.q_FaxPhone,4,3)#" MAXLENGTH=3>
				<INPUT TYPE=text NAME="FaxPhone3" SIZE=4 VALUE="#RemoveChars(getDealerInfo.q_FaxPhone,1,6)#" MAXLENGTH=4>
				</CFOUTPUT></TD>
			<CFELSE>
				<TD><INPUT TYPE=text NAME="FaxPhone1" SIZE=3 MAXLENGTH=3>
					<INPUT TYPE=text NAME="FaxPhone2" SIZE=3 MAXLENGTH=3>
					<INPUT TYPE=text NAME="FaxPhone3" SIZE=4 MAXLENGTH=4></TD>
			</CFIF>
		<CFELSE>
			<TD><INPUT TYPE=text NAME="FaxPhone1" SIZE=3 MAXLENGTH=3>
			<INPUT TYPE=text NAME="FaxPhone2" SIZE=3 MAXLENGTH=3>
			<INPUT TYPE=text NAME="FaxPhone3" SIZE=4 MAXLENGTH=4>
			</TD>
		</CFIF>
	</TR>

	<!--- Account Executive --->
	<TR>
		<TD ALIGN="right"><b><font face="Arial,Helvetica">Account Executive</font></b></TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<CFIF DlrSelected EQ 'Y'>
			<CFOUTPUT QUERY="getDealerInfo">
			<CFSET tmpAEID=#q_AEID#>
			<CFSET tmpACID=#q_ACID#>
			</CFOUTPUT>
			<TD><SELECT NAME="AccountExec">
			<CFOUTPUT QUERY="getAcctExecs">
			<CFIF q_AELastName EQ " ">
				<OPTION VALUE="#q_AEID#">
			<CFELSE>
				<CFSET tmp_Name =Trim(#q_AELastName#) & ', ' & Trim(#q_AEFirstName#)>
				<CFIF tmpAEID EQ #q_AEID#>
					<OPTION VALUE="#q_AEID#" SELECTED>#tmp_Name#
				<CFELSE>
					<OPTION VALUE="#q_AEID#">#tmp_Name#
				</CFIF>
				<CFSET tmp_Name="">
			</CFIF>
			</CFOUTPUT>
			</SELECT></TD>
		<CFELSE>
			<TD><SELECT NAME="AccountExec">
			<!---  <OPTION VALUE="NOT_SELECTED" SELECTED> --->
			<OPTION value="" SELECTED>
			<CFOUTPUT QUERY="getAcctExecs">
			<CFSET tmp_Name =Trim(#q_AELastName#) & ', ' & Trim(#q_AEFirstName#)>
			<OPTION VALUE="#q_AEID#">#tmp_Name#
			<CFSET tmp_Name="">
			</CFOUTPUT>
			</SELECT></TD>
		</CFIF>
	</TR>
	<INPUT type="hidden" name="AccountExec_Required" value="You must select an Account Executive.">

	<!--- Account Coordinator (Not Required) --->
	<TR>
		<TD ALIGN="right"><font face="Arial,Helvetica">Account Coordinator</font></TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<CFIF DlrSelected EQ 'Y'>
			<TD><SELECT NAME="AccountCoord">
			<CFOUTPUT QUERY="getAcctCoordinators">
			<CFIF q_ACLastName EQ " ">
				<OPTION VALUE="#q_ACID#">
			<CFELSE>
				<CFSET tmp_Name =Trim(#q_ACLastName#) & ', ' & Trim(#q_ACFirstName#)>
				<CFIF tmpACID EQ #q_ACID#>
					<OPTION VALUE="#q_ACID#" SELECTED>#tmp_Name#
				<CFELSE>
					<OPTION VALUE="#q_ACID#">#tmp_Name#
				</CFIF>
				<CFSET tmp_Name="">
			</CFIF>
			</CFOUTPUT>
			</SELECT></TD>
		<CFELSE>
			<TD><SELECT NAME="AccountCoord">
			<!--- <OPTION VALUE="NOT_SELECTED" SELECTED> --->
			<OPTION value="" SELECTED>
			<CFOUTPUT QUERY="getAcctCoordinators">
			<CFSET tmp_Name =Trim(#q_ACLastName#) & ', ' & Trim(#q_ACFirstName#)>
			<OPTION VALUE="#q_ACID#">#tmp_Name#
			<CFSET tmp_Name="">
			</CFOUTPUT>
			</SELECT></TD>
		</CFIF>
	</TR>


	<!--- Dealer/Collection First Name --->
	<!--- Decide which Title (Dealership(Dealer's)/Collection(Owner's) to display on page --->
	<TR>
		<CFIF ((ParameterExists(URL.Addtype)) And (#URL.Addtype# IS "collection"))>
			<TD ALIGN="right"><b><font face="Arial,Helvetica">Owner's First Name</font></b></TD>
		<CFELSE>
			<TD ALIGN="right"><b><font face="Arial,Helvetica">Dealer's First Name</font></b></TD>		
		</CFIF>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<CFIF ((ParameterExists(URL.Addtype)) And (#URL.Addtype# IS "collection"))>
			<INPUT type="hidden" name="DealerFirstName_required" value="Please enter the Owner's first name.">
		<CFELSE>
			<INPUT type="hidden" name="DealerFirstName_required" value="Please enter the dealer's first name.">
		</CFIF>

		<CFIF DlrSelected EQ 'Y'>
			<TD><cfoutput><INPUT TYPE=text NAME="DealerFirstName" SIZE=20 VALUE="#getDealerInfo.q_DealerFirstName#" MAXLENGTH=20></cfoutput></TD>
		<CFELSE>
			<TD><INPUT TYPE=text NAME="DealerFirstName" SIZE=20 MAXLENGTH=20></TD>
		</CFIF>
	</TR>

	<!--- Dealer/Collection Last Name --->
	<!--- Decide which Title (Dealership(Dealer's)/Collection(Owner's) to display on page --->
	<TR>
		<CFIF ((ParameterExists(URL.Addtype)) And (#URL.Addtype# IS "collection"))>
			<TD ALIGN="right"><b><font face="Arial,Helvetica">Owner's Last Name</font></b></TD>
		<CFELSE>
			<TD ALIGN="right"><b><font face="Arial,Helvetica">Dealer's Last Name</font></b></TD>
		</CFIF>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<CFIF ((ParameterExists(URL.Addtype)) And (#URL.Addtype# IS "collection"))>
			<INPUT type="hidden" name="DealerLastName_required" value="Please enter the Owner's last name.">
		<CFELSE>
			<INPUT type="hidden" name="DealerLastName_required" value="Please enter the dealer's last name.">
		</CFIF>
		<CFIF DlrSelected EQ 'Y'>
			<TD><cfoutput><INPUT TYPE=text NAME="DealerLastName" SIZE=30 VALUE="#getDealerInfo.q_DealerLastName#" MAXLENGTH=30></cfoutput></TD>
		<CFELSE>
			<TD><INPUT TYPE=text NAME="DealerLastName" SIZE=30 MAXLENGTH=30></TD>
		</CFIF>
	</TR>

	<!--- E-Mail Address --->
	<TR>
		<TD ALIGN="right"><font face="Arial,Helvetica">E-Mail Address</font></TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<CFIF DlrSelected EQ 'Y'>
			<CFOUTPUT QUERY="getDealerInfo">
			<TD><INPUT TYPE=text NAME="EMailAddress" SIZE=30 MAXLENGTH=30 TABINDEX=1 VALUE="#q_Email#"></TD>
			</CFOUTPUT>
		<CFELSE>
			<TD><INPUT TYPE=text NAME="EMailAddress" SIZE=30 MAXLENGTH=30 TABINDEX=1></TD>
		</CFIF>
	</TR>

	<!--- Display Name --->
	<TR>
		<TD align="right"><b><FONT FACE="arial,Helvetica">Display Name</FONT></TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<CFIF ((ParameterExists(URL.Addtype)) And (#URL.Addtype# IS "collection"))>
			<INPUT type="hidden" name="DisplayName_required" value="You must enter a Display Name for this Collection.">
		<CFELSE>
			<INPUT type="hidden" name="DisplayName_required" value="You must enter a Display Name for this Dealership.">
		</CFIF>
		<CFIF DlrSelected EQ 'Y'>
			<TD><cfoutput>
			<INPUT type="text" NAME="DisplayName" SIZE="40" VALUE="#GetDealerInfo.q_DisplayName#" MAXLENGTH="50">
			</cfoutput></TD>
		<CFELSE>
			<TD><INPUT type="text" NAME="DisplayName" SIZE="40" MAXLENGTH="50">
		</CFIF>
		</TD>
	</TR>

	<!--- Display Line Selection (Dealer/Collection) --->
	<TR>
		<TD COLSPAN=3 align="center"><FONT FACE="Arial,Helvetica" size="-1"><i>
			<CFIF ((ParameterExists(URL.Addtype)) And (#URL.Addtype# IS "collection"))>
				(Collection name which will appear on your custom graphics)
			<CFELSE>
				(Dealership name which will appear on your custom graphics)
			</CFIF>
		</i></FONT>
		</TD>
	</TR>
	<TR><TD>&nbsp;<p></TD></TR>
	</TABLE>
	</TD>
</TR>

<TR ALIGN="center">
	<TD>
	<CFIF DlrSelected EQ 'Y'>
		<INPUT TYPE="hidden" NAME="VerifyFlag" VALUE="TRUE">
	</CFIF>

	<A HREF="#" OnClick="JavaScript:document.StepOne.reset();"><IMG SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/reset_nav.jpg" Border="0" NAME="Reset" value="Reset"></a>
	<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/savedealer_nav.jpg" Border="0" NAME="SaveDealerInfo"  VALUE="Save Info">

	<CFOUTPUT><INPUT type="hidden" name="DealerCode" value="#g_DealerCode#"></CFOUTPUT>
	</FORM>

	<P>
   	<FORM NAME="f_Back" ACTION="loadflow.cfm" METHOD="post">
	<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/newsearch.jpg" Border="0" NAME="FindDealer"  VALUE="New Search">
    <P>
	<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg" Border="0" NAME="BackToMain" VALUE="Back To Main Menu">
	</FORM></TD>

</TR>
</TABLE>



</div>
</BODY>
</HTML>