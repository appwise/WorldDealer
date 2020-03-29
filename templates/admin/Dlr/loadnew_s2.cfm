<CFSET PageAccess = 3>
<CFINCLUDE template="security.cfm">
<CFSET Phone = '#Form.phone1##Form.phone2##Form.phone3#'>
<CFSET FaxPhone = '#Form.faxphone1##Form.faxphone2##Form.faxphone3#'>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>

    <!-- ----------------------------------------------------------- -->
    <!--                Created by sigma6, Detroit                   -->
    <!--         Copyright (c) 1997, 1998, 1999 sigma6.              -->
    <!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->

    <!-- ----------------------------------------------------------- -->
    <!--     Alan Warchuck for sigma6, interactive media, Detroit    -->
    <!--    awarchuck@sigma6.com  www.sigma6.com   www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
	<!--- $Id: loadnew_s2.cfm,v 1.7 1999/11/29 15:34:13 lswanson Exp $ --->

<HEAD>

<TITLE>WorldDealer | Load Dealer Information</TITLE>

<CFIF #Form.ProcVar# IS "New">
	<CFQUERY NAME="getDealerNum" DATASOURCE="#gDSN#">
    	SELECT	Dealercode 
	    FROM 	Dealers 
		Where 	Dealercode > '#Form.Collection#'
		Order BY Dealercode Asc;
	</CFQUERY>
</CFIF>	

<CFSET NewCollection=#FORM.Collection#>
<CFSET NewDealerNum = 0000>
<CFSET NewDealerType = 000>
<CFSET NewDealerTot = "00">
<CFSET NewDealerSuffix = #Trim(FORM.DealerCodeIN)#>

<!--- Figure out Dealer Type --->
<CFQUERY NAME="getDFNumber" DATASOURCE = "#gDSN#">
	SELECT 	Max(DF_Number) as DF_Number
	FROM 	DealerFranchise
</cfquery>

<CFOUTPUT>
<!--- Linda: unsuccessful stab at looping using variable (LoopCount) w/in a variable (Form.DealerType).
<CFLOOP index="LoopCount" from="1" to="6">
	<CFSET tempDealerType = 'Form.DealerType' & #LoopCount#>
	<CFIF #tempDealerType# NEQ "000">
		<CFQUERY NAME="insertDF" DATASOURCE="#gDSN#">
			INSERT INTO DealerFranchise 
						(DFNumber,
						MakeNumber)
			VALUES		(#NewDealerType#,
						Form.DealerType#LoopCount#)
		</CFQUERY>
	</CFIF>
</cfloop>
 --->
 
<!--- Only figure out the DealerTypes for Dealers (skip for Collections)--->
<CFIF #FORM.ProcVar# IS "New" AND #Form.ProcType# IS "Dealer">
	<CFSET NewDealerType = IncrementValue(#getDFNumber.DF_Number#)>

	<CFIF #Form.DealerType1# NEQ "">
		<CFQUERY NAME="insertDF" DATASOURCE="#gDSN#">
			INSERT INTO DealerFranchise 
						(DF_Number,
						MakeNumber)
			VALUES		(#NewDealerType#,
						#Form.DealerType1#)
		</CFQUERY>
	</CFIF>

	<CFIF #Form.DealerType2# NEQ "">
		<CFQUERY NAME="insertDF" DATASOURCE="#gDSN#">
			INSERT INTO DealerFranchise 
						(DF_Number,
						MakeNumber)
			VALUES		(#NewDealerType#,
						#Form.DealerType2#)
		</CFQUERY>
	</CFIF>

	<CFIF #Form.DealerType3# NEQ "">
		<CFQUERY NAME="insertDF" DATASOURCE="#gDSN#">
			INSERT INTO DealerFranchise 
						(DF_Number,
						MakeNumber)
			VALUES		(#NewDealerType#,
						#Form.DealerType3#)
		</CFQUERY>
	</CFIF>

	<CFIF #Form.DealerType4# NEQ "">
		<CFQUERY NAME="insertDF" DATASOURCE="#gDSN#">
			INSERT INTO DealerFranchise 
						(DF_Number,
						MakeNumber)
			VALUES		(#NewDealerType#,
						#Form.DealerType4#)
		</CFQUERY>
	</CFIF>

	<CFIF #Form.DealerType5# NEQ "">
		<CFQUERY NAME="insertDF" DATASOURCE="#gDSN#">
			INSERT INTO DealerFranchise 
						(DF_Number,
						MakeNumber)
			VALUES		(#NewDealerType#,
						#Form.DealerType5#)
		</CFQUERY>
	</CFIF>

	<CFIF #Form.DealerType6# NEQ "">
		<CFQUERY NAME="insertDF" DATASOURCE="#gDSN#">
			INSERT INTO DealerFranchise 
						(DF_Number,
						MakeNumber)
			VALUES		(#NewDealerType#,
						#Form.DealerType6#)
		</CFQUERY>
	</CFIF>
</CFIF>	
</cfoutput>

<!--- ProcVar is either New or Update --->
<CFIF #FORM.ProcVar# IS "New">
	<!--- ProcType is either Collection or Dealer --->
	<CFIF #Form.ProcType# IS "collection">
		<CFSET NewCollection = 0000>
		<!--- find the highest collectcion #, then increment it --->
		<CFLOOP query="getDealerNum">
			<CFIF Left(getDealerNum.Dealercode,4) GT "0000">
			    <CFSET NewCollection=Left(getDealerNum.Dealercode,4)>
			</CFIF>
		</CFLOOP>			
		<CFSET NewCollection = IncrementValue(#NewCollection#)>
		<CFSET NewDealerNum = 0000>
	<CFELSE>
		<!--- Dealer --->
	   	<CFSET NewDealerNum = 0000>
		<CFLOOP query="GetDealerNum">
			<CFIF Left(getDealerNum.Dealercode,4) IS #FORM.Collection#>
		    	<CFIF Mid(getDealerNum.Dealercode,6,4) GT 0>
					<CFSET NewDealerNum = VAL(Mid(getDealerNum.Dealercode,6,4))>
				</cfif>
        	</CFIF>
		</CFLOOP>
		<CFSET NewDealernum = IncrementValue(#NewDealerNum#)>
	</CFIF>
	<CFSET TempCollection="0000" & NewCollection>
	<CFSET NewCollection=Right(TempCollection,4)>

	<CFSET TempNewDealerNum="0000" & NewDealerNum>
	<CFSET NewDealerNum=Right(TempNewDealerNum,4)>

	<CFSET TempNewDealerType="000" & NewDealerType>
	<CFSET NewDealerType=Right(TempNewDealerType,3)>

	<CFSET NewDealerCode = NewCollection & "-" & NewDealerNum & "-" &  NewDealerType & "-" &  NewDealerTot & "-" &  NewDealerSuffix>
	<CFSET #g_DealerCode# = #NewDealerCode#>
</CFIF>

<CFIF #Form.ProcVar# IS "New">
	<CFSET g_DealerCode = #NewDealerCode#>
<CFELSE>
	<CFSET g_DealerCode = #Form.DealerCode#>
</CFIF>	
		
<CFIF #Form.ProcVar# IS "New">
	<CFSET r_dlrcode = #NewDealerCode#>
<CFELSE>
	<CFSET r_dlrcode = #g_DealerCode#>
</CFIF>
		
<!--- Check if this DealerCode is available (not in Dealers Table) --->
<CFQUERY name="CheckDLRCode" datasource="#gDSN#">
	SELECT COUNT(DealerCode) as DealerCount
	FROM Dealers
	WHERE DealerCode = '#Form.DealerCodeIN#';
</CFQUERY>
				
<CFIF (#CheckDLRCode.DealerCount# IS NOT 0) AND (#Form.DealerCodeIN# IS NOT #g_DealerCode#)>
	<!--- That Dealercode is Unavailable --->
	<CFLOCATION url="unavailable.cfm?dlrcode=#r_dlrcode#&dlrcodein=#form.dealercodeIN#">
</CFIF>

<CFIF ParameterExists(VerifyFlag)>
	<!--- Not a new dealer --->		
	<CFQUERY NAME="updateDLR" DATASOURCE="#gDSN#">
		UPDATE Dealers SET WebStateID = 5,
				DealershipName = '#Form.DealershipName#',
				AddressLine1 = '#Form.Address1#',
				AddressLine2 = '#Form.Address2#',
				City = '#Form.City#',
				StateAbbr = '#Form.StateAbbr#',
				Zip = '#Form.Zip#',
				Phone = '#Variables.Phone#',
				FaxPhone = '#Variables.FaxPhone#',
				AEID = #Form.AccountExec#,
				ACID = #Form.AccountCoord#,
				DealerFirstName = '#Form.DealerFirstName#',
				DealerLastName = '#Form.DealerLastName#',
				Email = '#Form.EMailAddress#',
<!--- 				County = '#Form.County#', --->
				DisplayName = '#Form.DisplayName#'
			WHERE Dealers.DealerCode = '#Form.DealerCode#'
	</CFQUERY>                
<CFELSE>
    <!--- this is a new dealer, so we need to insert a row using the information from the first form.
              information entered after this insert will actually be updated to this row ---->
	<!--- insert the row....use a web state of '5', which means 'In Progress' --->
	<CFQUERY NAME="insertDLR" DATASOURCE="#gDSN#">
		INSERT INTO Dealers ( DealerCode,
					WebStateID,
					DealershipName,
					AddressLine1,
					AddressLine2,
					City,
<!--- 					County, --->
					StateAbbr,
					Zip,
					Phone,
					FaxPhone,
					AEID,
				<CFIF #Form.AccountCoord# IS NOT ''>ACID,</CFIF> 
					DealerFirstName,
					DealerLastName,
					Email,
					DisplayName )
			VALUES ( '#NewDealerCode#',
					5,
					'#Form.DealershipName#',
					'#Form.Address1#',
					'#Form.Address2#',
					'#Form.City#',
<!--- 					'#Form.County#', --->
					'#Form.StateAbbr#',
					'#Form.Zip#',
					'#VARIABLES.Phone#',
					'#variables.FaxPhone#',
					#Form.AccountExec#,
				<CFIF #form.AccountCoord# IS NOT ''>#Form.AccountCoord#,</CFIF>
					'#Form.DealerFirstName#',
					'#Form.DealerLastName#',
					'#Form.EMailAddress#',
					'#Form.DisplayName#')
	</CFQUERY>                
</CFIF>

	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>

<body>
<br><br><br><br><br>

<div align="center">
<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
<TR><TD>&nbsp;<p></TD></TR>
<TR ALIGN="center">
	<TD ALIGN="middle"><h3><font face="Arial,Helvetica">Dealer Administration - Dealer Information</font></h3></TD>
</TR>

<TR ALIGN="center">
	<TD ALIGN="middle"><font face="Arial,Helvetica">Processing Complete</font></TD>
</TR>

<TR><TD>&nbsp;<p></TD></TR>
<TR ALIGN="center">
	<TD>
	<FORM NAME="f_Back" ACTION="loadflow.cfm" METHOD="post">
	<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg" Border="0" NAME="BackToMain" VALUE="Back To Main Menu"></FORM></TD>
</TR>
</TABLE>

</div>

</BODY>
</HTML>