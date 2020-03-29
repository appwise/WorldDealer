<CFSET PageAccess = 2>
<CFINCLUDE template="security.cfm">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
    <!-- ----------------------------------------------------------- -->
    <!--               Created by sigma6, Detroit                    -->
    <!--         Copyright (c) 1997, 1998, 1999 sigma6.              -->
    <!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->

    <!-- ----------------------------------------------------------- -->
    <!--    Alan Warchuck for sigma6, interactive media, Detroit     -->
    <!--   Awarchuck@sigma6.com   www.sigma6.com    www.s6313.com    -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
    <!--                  Last Updated on 08-21-98                   -->
    <!-- ----------------------------------------------------------- -->
	<!--- $Id: logons.cfm,v 1.6 1999/11/24 22:54:09 lswanson Exp $ --->

<HEAD>
	<TITLE>Administrative Logon Tracking</TITLE>
	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>
<body>
<br><br><br><br><br>

<CFIF NOT IsDefined("sub")>
	<CFSET sub = 1>
</CFIF>

<CFSET todaymm=Month(Now())>
<CFSET todaydd=Day(Now())>
<CFSET todayyy=Year(Now())>
<CFSET yesterdaymm=Month(DateAdd("d", -7, Now()))>
<CFSET yesterdaydd=Day(DateAdd("d", -7, Now()))>
<CFSET yesterdayyy=Year(DateAdd("d", -7, Now()))>
<CFSET MAX_JUMPS = 20>
<CFSET RECORDS_PER_PAGE = 10>
<CFSET theCFID=#URLEncodedFormat(URL.CFID)#>
<CFSET theCFTOKEN=#URLEncodedFormat(URL.CFTOKEN)#>

<CFIF sub IS 1>
    <CFSET Nextsub=11>
    <CFIF Left(#variables.AccessLevel#,1) GREATER THAN 1>
           <CFOUTPUT>
           <div align="center">
           <TABLE CELLPADDING=5 CELLSPACING=0 WIDTH=450 BORDER=0 BGCOLOR="FFFFFF">
		   <TR>
		     <TD>&nbsp;<p></TD>
		   </TR>
		   <TR ALIGN="center">
		     <TD ALIGN="center"><h3><FONT FACE="Arial,Helvetica">Administrative Logon Tracking</FONT></h3></TD>
		   </TR>
           <FORM NAME="logons" ACTION="logons.cfm?CFID=#theCFID#&CFTOKEN=#theCFTOKEN#&sub=#Nextsub#" METHOD="POST">
           <TR ALIGN="left">
             <TD>
               <FONT SIZE=2 FACE="arial,helvetica"><P>
	           <B>Show Logons for:</B>
               <SELECT NAME="LogonRpt">
                 <OPTION VALUE="single" SELECTED>A Single Dealership</OPTION>
                 <OPTION VALUE="account">All Dealerships in a Specific Account</OPTION>
                 <OPTION VALUE="all">All Dealerships</OPTION>
               </SELECT><P>
	           <B>Reporting Date Range:</B><P>
	           <B>From:</B> <Input Type="text" Name="frommonth" size="2" MAXLENGTH=2 value="#yesterdaymm#">
			   				<Input Type="text" Name="fromday" size="2" MAXLENGTH=2 value="#yesterdaydd#">
							<Input Type="text" Name="fromyear" MAXLENGTH=4 size=4 value="#yesterdayyy#"><BR>
							<Input Type="hidden" Name="frommonth_integer">
							<Input Type="hidden" Name="fromday_integer">
							<Input Type="hidden" Name="fromyear_integer">
				&nbsp;&nbsp;&nbsp;
	           <B>To:</B>	<Input Type="text" Name="toomonth" size="2" MAXLENGTH=2 value="#todaymm#">
			   				<Input Type="text" Name="tooday" size="2" MAXLENGTH=2 value="#todaydd#">
							<Input Type="text" Name="tooyear" MAXLENGTH=4 size="4" value="#todayyy#"><P>
							<Input Type="hidden" Name="toomonth_integer">
							<Input Type="hidden" Name="tooday_integer">
							<Input Type="hidden" Name="tooyear_integer">
               <B>Sort by:</B><BR>
	           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<INPUT TYPE="Radio" NAME="orderBy" VALUE="Date" CHECKED>Date<BR>
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<INPUT TYPE="Radio" NAME="orderBy" VALUE="Dealer">Dealer<BR>
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<INPUT TYPE="Radio" NAME="orderBy" VALUE="User">User<BR>
               <P><B>Sort Preference:</B><BR>
	           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<INPUT TYPE="Radio" NAME="orderDirection" VALUE="ASC">ascending&nbsp;&nbsp;<INPUT TYPE="Radio" NAME="orderDirection" VALUE="DESC" CHECKED>descending</P>
               </FONT>
             </TD>
           </TR>
           <TR>
              <TD>&nbsp;</TD>
           </TR>
           <TR ALIGN="center">
             <TD><INPUT TYPE="Image" SRC="#application.RELATIVE_PATH#/images/admin/next_nav.jpg" NAME="btnNext" BORDER=0 VALUE="Show Report"></TD>
           </TR>
           </FORM>
           <TR ALIGN="center">
             <TD><FORM NAME="f_Back" ACTION="#g_relpath#/templates/admin/dlr/redirect.cfm" METHOD="post">
                 <INPUT TYPE="Image" SRC="#application.RELATIVE_PATH#/images/admin/backtomain_nav.jpg" BORDER=0 NAME="BackToMain" VALUE="Back To Main Menu">
                 </FORM>
             </TD>
          </TR>
         </CFOUTPUT>
    </CFIF>
</CFIF>
<!---------------------------------------------------------- SUB 11 ------------------------------------------------------>
<CFIF sub IS 11>
          
     <CFIF IsDefined("URL.StartCheckDate")>
	     <CFSET StartCheckDate=URL.StartCheckDate>
	 <CFELSE>
         <CFSET StartCheckDate=Dateformat(Dateadd("d", 0, "#frommonth#/#fromday#/#fromyear#"))>	 
     </CFIF>

     <CFIF IsDefined("URL.EndCheckDate")>
	     <CFSET EndCheckDate=URL.EndCheckDate>
	 <CFELSE>
         <CFSET EndCheckDate=Dateformat(Dateadd("d", 1, "#toomonth#/#tooday#/#tooyear#"))>
     </CFIF>

     <CFIF IsDefined("URL.Orderby")>
	     <CFSET Orderby=Url.Orderby>
	 </CFIF>
	 
     <CFIF IsDefined("URL.orderDirection")>
	     <CFSET orderDirection=URL.orderDirection>
	 </CFIF>	 

     <CFIF IsDefined("URL.LogonRpt")>
	     <CFSET LogonRpt=URL.LogonRpt>
     </CFIF>

    <!--- --------------------------- Start processing for All Request   ------------------------------------- --->

        <CFIF #LogonRpt# IS "all">
         	<CFSET Nextsub = 11>
		    <CFSET location = "logons.cfm?CFID=#URLEncodedFormat(URL.CFID)#&CFTOKEN=#URLEncodedFormat(URL.CFTOKEN)#&LogonRpt=#LogonRpt#&sub=#Nextsub#&StartCheckDate=#StartCheckDate#&EndCheckDate=#EndCheckDate#&Orderby=#Orderby#&orderDirection=#orderDirection#"> 
                        
            <CFQUERY NAME="Loginall" datasource="#gDSN#">
            SELECT 
                AccountSecurity.UserID,
	            AccountSecurity.LastAction,
	            AccountSecurity.ActionCode,
	            AccountSecurity.SessionID,
	            Accounts.RowID,
                Accounts.Name,
                Dealers.DealerCode,
                Dealers.DealershipName
	        FROM (Dealers  RIGHT JOIN
		             (Accounts RIGHT JOIN AccountSecurity ON Accounts.RowID=AccountSecurity.UserID)
			                                              ON Dealers.DealerCode=AccountSecurity.ActionCode)
		                       WHERE AccountSecurity.LastAction > #CreateODBCDate(StartCheckDate)#
                               And   AccountSecurity.LastAction < #CreateODBCDate(EndCheckDate)#
							   And   (Not (AccountSecurity.ActionCode)='login')
                <CFIF (#Orderby# IS "Date") AND (#orderDirection# IS "DESC") >ORDER BY AccountSecurity.LastAction DESC;</CFIF>
                <CFIF (#Orderby# IS "Date") AND (#orderDirection# IS "ASC") >ORDER BY AccountSecurity.LastAction ASC;</CFIF>
                <CFIF (#Orderby# IS "User") AND (#orderDirection# IS "DESC") >ORDER BY Accounts.Name DESC;</CFIF>
                <CFIF (#Orderby# IS "User") AND (#orderDirection# IS "ASC") >ORDER BY Accounts.Name ASC;</CFIF>
        
            </CFQUERY>
       
        <!--- initialize start row first time --->
        <CFPARAM NAME="page" DEFAULT="1">
        <CFSET recordCount = Loginall.RecordCount>
        <CFSET pageCount = Ceiling(recordCount / RECORDS_PER_PAGE)>
        <CFSET startRow = ((page - 1) * RECORDS_PER_PAGE) + 1>
        <CFSET endRow = startRow + RECORDS_PER_PAGE - 1>
        <CFIF endRow GT recordCount>
            <CFSET endRow = recordCount>
        </CFIF>

        <div align="center">
        <TABLE CELLPADDING=5 CELLSPACING=0 WIDTH=450 BORDER=0 BGCOLOR="#FFFFFF">
        <TR ALIGN="center">
             <TD ALIGN="center" Colspan=4><h3><FONT FACE="Arial,Helvetica">Administrative Logon Tracking</FONT></h3></TD>
        </TR>
        <CFIF Loginall.RecordCount GT 0>
               <tr>
               <td><FONT FACE="arial,helvetica"><B>Name</B></FONT></td>
               <td><FONT FACE="arial,helvetica"><B>Date</B></FONT></td>
               <td><FONT FACE="arial,helvetica"><B>Time</B></FONT></td>  
	           <td><FONT FACE="arial,helvetica"><B>Dealership</B></FONT></td>
               </tr>
               <CFSET theActionCode=RTrim(#Loginall.ActionCode#)>
               <CFSET theSize=Len(theActionCode)>
               <CFIF theSize GT 3>
                  <CFSET theDLRtype="DLR">
               </CFIF>
               <CFIF theSize LT 4>
               <CFSET theDLRtype="DMG">
               </CFIF>
	             <CFOUTPUT QUERY="Loginall" STARTROW="#startRow#" MAXROWS="#RECORDS_PER_PAGE#">
                 <tr>
		         <td valign="top"><FONT FACE="arial,helvetica" SIZE=2>#RTrim(Loginall.Name)#</FONT></td>
                 <td valign="top"><FONT FACE="arial,helvetica" SIZE=2>#Dateformat(Loginall.LastAction,"mm/dd/yyyy")#</FONT></td>
                 <td valign="top"><FONT FACE="arial,helvetica" SIZE=2>#DatePart("h", Loginall.LastAction)#:#DatePart("m", Loginall.LastAction)#:#DatePart("s", Loginall.LastAction)#</FONT></td>
                 <td valign="top">
				 	<FONT FACE="arial,helvetica" SIZE=2>
                 <CFIF RTrim(Len(Loginall.DealershipName)) GT 0>  
           	        #Loginall.DealershipName# (#Loginall.ActionCode#)
                    </FONT>
					</TD></TR>
                 <CFELSEIF RTrim(Len(Loginall.DisplayName)) GT 0>  
          	        #Loginall.DisplayName# (#DMGCode#)
					</FONT>
                    </TD></TR> 
                 <CFELSE>
		             Dealership/DMG info Not Available
					 </FONT>
			        </TD></TR> 
		         </CFIF>
                 </CFOUTPUT>
                 <TR>
                 <TD COLSPAN="4" ALIGN="center"><FONT SIZE=2 FACE="arial,helvetica">page&nbsp;<CFOUTPUT>#page#</CFOUTPUT>&nbsp;of&nbsp;<CFOUTPUT>#pageCount#</CFOUTPUT></FONT></TD>
                 </TR>
                 <TR VALIGN="top">
                 <TD ALIGN="right" WIDTH="50%"><FONT SIZE=1 FACE="arial,helvetica"><TT>
                 <CFSETTING ENABLECFOUTPUTONLY="YES">
	             <CFIF page GT 1>
	                 <CFOUTPUT><A HREF="#location#&FuseAction=jump&page=#Evaluate(page - 1)#">previous</A>&nbsp;|&nbsp;</CFOUTPUT>
	             <CFELSE>
	                 <CFOUTPUT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</CFOUTPUT>
	             </CFIF>
	             <CFSETTING ENABLECFOUTPUTONLY="NO">
                 </TT></FONT></TD>
                 <TD Colspan=2 ALIGN="center"><FONT SIZE=1 FACE="arial,helvetica"><TT>
	             <CFSETTING ENABLECFOUTPUTONLY="YES">
<!--- 	             <CFMODULE TEMPLATE="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/templates/util/jumpmenu.cfm" --->
	             <CFMODULE TEMPLATE="../../util/jumpmenu.cfm"
			      beginPage="1"
			      endPage="#pageCount#"
			      currentPage="#page#"
			      maxJumps="#MAX_JUMPS#"
			      location="#location#">
	             <CFSETTING ENABLECFOUTPUTONLY="NO">
                 </TT></FONT></TD>
                 <TD ALIGN="left" WIDTH="50%"><FONT SIZE=1 FACE="arial,helvetica"><TT>
	             <CFSETTING ENABLECFOUTPUTONLY="YES">
	             <CFIF page LT pageCount>
	                 <CFOUTPUT>|&nbsp;<A HREF="#location#&FuseAction=jump&page=#Evaluate(page + 1)#">next</A></CFOUTPUT>
	             <CFELSE>
	                 <CFOUTPUT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</CFOUTPUT>
	             </CFIF>
	             <CFSETTING ENABLECFOUTPUTONLY="NO">
                 </TT></FONT></TD>
                 </TR>
                 <TR>
                 <CFOUTPUT>
		         <TD ALIGN="center" COLSPAN="4">
		           <A HREF="logons.cfm?CFID=#URLEncodedFormat(URL.CFID)#&CFTOKEN=#URLEncodedFormat(URL.CFTOKEN)#&sub=1"><IMG
				   		SRC="#application.RELATIVE_PATH#/images/admin/back_nav.jpg"
						Border="0"
						ALT="Back To Logon Reporting Selections"></A>
		         </TD>
                 </CFOUTPUT>
				 </TR>
         <CFELSE>
        		 <TR>
		         <TD ALIGN="center" Colspan="4"><FONT SIZE=2 FACE="arial,helvetica">No dealers found</FONT></TD>
                 </TR>
                 <TR ALIGN="center">
                 <TD>&nbsp;</TD>
				 <TD Colspan="2"> <A HREF="#" OnMouseOver="self.status='Back';return true"
		                OnMouseOut="self.status='';return true"
				        OnClick="history.go(-1);return false"><IMG
							SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/back_nav.jpg"
							Border="0"
							ALT="Back"></A>
                 </TD>
                 <TD>&nbsp;</TD>                
				</TR>
        </CFIF>	
				 <TR>
                <TD ALIGN="center" COLSPAN="4">
	    	    <FORM NAME="f_main" ACTION="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/templates/admin/dlr/redirect.cfm" METHOD="post">
                   <INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg" Border="0" NAME="BackToMain" VALUE="Back To Main Menu">
                </FORM>
                </TD>
                
                </TR>
    
<!--- -------------------------------- End processing for All Request   ------------------------------------- --->
   </CFIF>
<!--- -------------------------- Start processing for All Dealerships Request Screen 2----------------------------- --->
   <CFIF #LogonRpt# IS "single">
        <CFSET Nextsub=14>
        <CFQUERY NAME="selectDMGNames" datasource="#gDSN#">
		 SELECT
			DealerMarketingGroups.DMGID as q_DMGID,
			DealerMarketingGroups.Name as q_Name
		 FROM
			DealerMarketingGroups
		 ORDER BY
			DealerMarketingGroups.Name ASC;
		</CFQUERY>
        <CFQUERY NAME="selectStates" datasource="#gDSN#">
		SELECT
			StateAbbr as q_StateAbbr,
			Description as q_Description
		FROM
			States
		WHERE
			States.StateAbbr IN (
				SELECT DISTINCT
					StateAbbr
				FROM
					Dealers
				)
		ORDER BY
			Description;
		</CFQUERY>
        <div align="center">
		   <TABLE CELLPADDING=5 CELLSPACING=0 WIDTH=450 BORDER=0 BGCOLOR="FFFFFF">
		   <TR>
		     <TD>&nbsp;<p></TD>
		   </TR>
		   <TR ALIGN="center">
              <TD ALIGN="center"><h3><FONT FACE="Arial,Helvetica">Administrative Logon Tracking</FONT></h3></TD>
		   </TR>
          <CFOUTPUT>
		   <FORM NAME="logons2" ACTION="logons.cfm?CFID=#theCFID#&CFTOKEN=#theCFTOKEN#&sub=#Nextsub#" METHOD="POST">
		  </CFOUTPUT>
              <INPUT TYPE="hidden" NAME="StartDate" VALUE="<CFOUTPUT>#Form.frommonth#/#Form.fromday#/#Form.fromyear#</CFOUTPUT>">
			  <INPUT TYPE="hidden" NAME="EndDate" VALUE="<CFOUTPUT>#Form.toomonth#/#Form.tooday#/#Form.tooyear#</CFOUTPUT>">
              <INPUT TYPE="hidden" NAME="LogonRPT" VALUE="<CFOUTPUT>#Form.LogonRpt#</CFOUTPUT>">
			  <INPUT TYPE="hidden" NAME="orderBy" VALUE="<CFOUTPUT>#Form.orderBy#</CFOUTPUT>">
			  <INPUT TYPE="hidden" NAME="orderDirection" VALUE="<CFOUTPUT>#Form.orderDirection#</CFOUTPUT>">
		     <TR ALIGN="center">
				<TD ALIGN="middle"><FONT FACE="Arial,Helvetica">Use the fields below to find a dealer.</FONT></TD>
             </TR>
			<TR>
				<TD>&nbsp;<p></TD>
			</TR>
			<TR>
				<TD>
				<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0 WIDTH="100%">
					<TR>
						<TD ALIGN="right"><b><font face="Arial,Helvetica">List dealers by this DMG:</font></b></TD>
						<TD>&nbsp;&nbsp;&nbsp;</TD>
						<TD>
						<FONT SIZE=2 FACE="arial,helvetica">
                        <CFOUTPUT>              
						<SELECT NAME="dmgID">
						</CFOUTPUT>
		  					<CFOUTPUT QUERY="selectDMGNames">
								<OPTION VALUE="#q_DMGID#">#q_Name#</OPTION>
							</CFOUTPUT>
                        <CFOUTPUT> 
             			</SELECT>
					  	</FONT>
                        </CFOUTPUT>
						</TD>
					</TR>
					<TR ALIGN=center>
						<TD COLSPAN=3><INPUT TYPE="image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/go_nav.jpg" Border="0" NAME="buttonDealersInDMG" VALUE="GO!"></TD>
					</TR>
					<TR>
						<TD COLSPAN=3>&nbsp;<p></TD>
					</TR>
					<TR>
						<TD ALIGN="right"><b><font face="Arial,Helvetica">List dealers by this state:</font></b></TD>
						<TD>&nbsp;&nbsp;&nbsp;</TD>
						<TD>
						<FONT SIZE=2 FACE="arial,helvetica">
						<SELECT name="stateAbbr">
						<OPTION VALUE=""></OPTION>
						<CFOUTPUT QUERY="selectStates">
							<OPTION VALUE="#q_StateAbbr#">#q_Description#</OPTION>
						</CFOUTPUT>
						</SELECT>
						</FONT>
						</TD>
					</TR>
					<TR ALIGN=center>
						<TD COLSPAN=3><INPUT TYPE="image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/go_nav.jpg" Border="0" NAME="buttonDealersInState" VALUE="GO!"></TD>
					</TR>
					<TR>
						<TD COLSPAN=3>&nbsp;<p></TD>
					</TR>
					<TR>
						<TD ALIGN="right"><b><font face="Arial,Helvetica">List dealers in this Zip Code:</font></b></TD>
						<TD>&nbsp;&nbsp;&nbsp;</TD>
						<TD><font face="Arial,Helvetica"><INPUT TYPE=text NAME="zipCode" SIZE=9 MAXLENGTH=10></FONT></TD>
					</TR>
					<TR ALIGN=center>
						<TD COLSPAN=3><INPUT TYPE="image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/go_nav.jpg" Border="0" NAME="buttonDealersInZipCode" VALUE="GO!"></TD>
					</TR>
					<TR>
						<TD>&nbsp;<p></TD>
					</TR>
                </FORM> 
				</TABLE>
				</TD>
			</TR>
			<TR>
				<TD>&nbsp;</TD>
			</TR>
        <TR>
       <CFOUTPUT>
		<TD ALIGN="center">
			<A HREF="logons.cfm?CFID=#URLEncodedFormat(URL.CFID)#&CFTOKEN=#URLEncodedFormat(URL.CFTOKEN)#&sub=1"><IMG
				   	SRC="#application.RELATIVE_PATH#/images/admin/back_nav.jpg"
					Border="0"
					ALT="Back To Logon Reporting Selections"></A>
		</TD>
		</TR>
			<TR>
				<TD>&nbsp;</TD>
			</TR>
	  </CFOUTPUT>
    </CFIF>
<!--- ------------------------------------ By Specific Account (Screen 2 all Selection ----------------- --->
    <CFIF #LogonRpt# IS "account">
        <CFSET Nextsub=15>

	     <CFIF IsDefined("URL.StartCheckDate")>
		     <CFSET StartCheckDate=URL.StartCheckDate>
	 	<CFELSE>
        	 <CFSET StartCheckDate=Dateformat(Dateadd("d", 0, "#frommonth#/#fromday#/#fromyear#"))>	 
     	</CFIF>

	     <CFIF IsDefined("URL.EndCheckDate")>
		     <CFSET EndCheckDate=URL.EndCheckDate>
	 	<CFELSE>
        	 <CFSET EndCheckDate=Dateformat(Dateadd("d", 1, "#toomonth#/#tooday#/#tooyear#"))>
     	</CFIF>

	     <CFIF IsDefined("URL.Orderby")>
		     <CFSET Orderby=Url.Orderby>
	 	</CFIF>
	 
    	 <CFIF IsDefined("URL.orderDirection")>
	    	 <CFSET orderDirection=URL.orderDirection>
	 	</CFIF>	 

	     <CFIF IsDefined("URL.LogonRpt")>
		     <CFSET LogonRpt=URL.LogonRpt>
     	</CFIF>

        <CFQUERY NAME="selectAccounts" datasource="#gDSN#">
			SELECT
				RowID,
				Name
			FROM
				Accounts
			WHERE
				Accounts.AccountType = 'AC'
				OR Accounts.AccountType = 'AE'
				OR Accounts.AccountType = 'AA'
			ORDER BY
				Accounts.Name ASC
			</CFQUERY>
			<div align="center">
			<TABLE CELLPADDING=5 CELLSPACING=0 WIDTH=450 BORDER=0 BGCOLOR="FFFFFF">
	          <TR>
	             <TD>&nbsp;<p></TD>
	          </TR>
	          <TR ALIGN="center">
		         <TD ALIGN="center"><h3><FONT FACE="Arial,Helvetica">Administrative Logon Tracking</FONT></h3></TD>
	         </TR>
             <TR>
	            <CFOUTPUT>
                <FORM NAME="getDealer" ACTION="logons.cfm?CFID=#theCFID#&CFTOKEN=#theCFTOKEN#&sub=#Nextsub#&StartCheckDate=#StartCheckDate#&EndCheckDate=#EndCheckDate#&Orderby=#Orderby#&orderDirection=#orderDirection#" METHOD="POST">
                <INPUT TYPE="hidden" NAME="StartDate" VALUE="#StartCheckDate#">
	            <INPUT TYPE="hidden" NAME="EndDate" VALUE="#EndCheckDate#">
			    <INPUT TYPE="hidden" NAME="LogonRPT" VALUE="#LogonRpt#">
			    <INPUT TYPE="hidden" NAME="orderBy" VALUE="#orderBy#">
			    <INPUT TYPE="hidden" NAME="orderDirection" VALUE="#orderDirection#">
                </CFOUTPUT>				
	            <CFIF selectAccounts.RecordCount GT 0>
			    <TD><FONT SIZE=2 FACE="arial,helvetica">Choose an account:
					<SELECT NAME="accountRowID">
			    		<CFOUTPUT query="selectAccounts">
				    	<OPTION VALUE="#RowID#">#Name#</OPTION>
					    </CFOUTPUT>
					</SELECT>
					<INPUT TYPE="hidden" NAME="accountRowID_required" VALUE="Must select an account to report on"></FONT>
				</TD>
             </TR> 
			 <TR ALIGN="center">
			    <TD> <A HREF="#" OnMouseOver="self.status='Back';return true"
					             OnMouseOut="self.status='';return true"
					             OnClick="history.go(-1);return false"><IMG
								 	SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/back_nav.jpg"
									Border="0"
									ALT="Back"></A>
								 &nbsp;&nbsp;
								 <INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next_nav.jpg" BORDER="0" NAME="btnNext" VALUE="Next"></TD>
			 </TR>
				<CFELSE>
					<TD ALIGN="center"><FONT SIZE=2 FACE="arial,helvetica">No accounts found</FONT></TD>
              </tr>
        	  <TR ALIGN="center">
		        <TD> <A HREF="#" OnMouseOver="self.status='Back';return true"
			    	             OnMouseOut="self.status='';return true"
					             OnClick="history.go(-1);return false"><IMG
								 	SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/back_nav.jpg"
									Border="0"
									ALT="Back"></A>
                 </TD>
             </TR>
				</CFIF>
             <tr>
                <td>&nbsp;</td>
	         </tr>
		       </Form>
     </CFIF>
</CFIF>
<!-- -------------------------------- By DMG Code Screen 3------------------------------------------- -->
<CFIF sub IS 14>
          <CFSET Nextsub=16>
          <CFQUERY NAME="selectDealers" datasource="#gDSN#">
			SELECT
				Dealers.DealerCode,
				Dealers.DisplayName,
                Dealers.DealershipName
			FROM
				Dealers
			WHERE
				<!--- determine the WHERE clause fragment --->
					<CFIF IsDefined("Form.buttonDealersInDMG.X")>
						Dealers.DMGID = #Form.dmgID#
                        <CFSET Searcher="DealerID">
		            <CFELSEIF IsDefined("Form.buttonDealersInState.X")>
						Dealers.StateAbbr = '#Form.stateAbbr#'
					    <CFSET Searcher="State">	
					<CFELSEIF IsDefined("Form.buttonDealersInZipCode.X")>
						Dealers.Zip = '#Form.ZipCode#'
						<CFSET Searcher="Zip">
					<CFELSE>
						Dealers.DealerCode = ''
					</CFIF>
			ORDER BY DisplayName
 		</CFQUERY>
    <div align="center">
    <div align="center">
	<TABLE CELLPADDING=5 CELLSPACING=0 WIDTH=450 BORDER=0 BGCOLOR="FFFFFF">
	   <TR>
	     <TD>&nbsp;<p></TD>
	   </TR>
	   <TR ALIGN="center">
		     <TD ALIGN="center"><h3><FONT FACE="Arial,Helvetica">Administrative Logon Tracking</FONT></h3></TD>
	   </TR>
		<CFOUTPUT>
       <FORM NAME="getDealer" ACTION="logons.cfm?CFID=#theCFID#&CFTOKEN=#theCFTOKEN#&sub=#Nextsub#&StartCheckDate=#Form.StartDate#&EndCheckDate=#Form.EndDate#&Orderby=#Form.orderBy#&orderDirection=#Form.orderDirection#" METHOD="POST">
	   <INPUT TYPE="hidden" NAME="StartDate" VALUE="#Form.StartDate#">
       <INPUT TYPE="hidden" NAME="EndDate" VALUE="#Form.EndDate#">
	   <INPUT TYPE="hidden" NAME="LogonRPT" VALUE="#Form.LogonRPT#">
	   <INPUT TYPE="hidden" NAME="orderBy" VALUE="#Form.orderBy#">
	   <INPUT TYPE="hidden" NAME="orderDirection" VALUE="#Form.orderDirection#">
       <INPUT TYPE="hidden" NAME="Searcher" VALUE="#Searcher#">
       </CFOUTPUT>
	   <CFIF selectDealers.RecordCount GT 0>
         <TR>
		     <TD ALIGN="center"><FONT SIZE=2 FACE="arial,helvetica">
			     <B>Choose a dealer:</B>
		       <SELECT NAME="dealerID">
		    	   <CFOUTPUT query="selectDealers">
						<OPTION VALUE="#DealerCode#">#DealershipName#</OPTION>
			       </CFOUTPUT>
		      </SELECT></FONT>
            </TD>
         </TR> 
		 <TR ALIGN="center">
		    <TD> <A HREF="#" OnMouseOver="self.status='Back';return true"
				             OnMouseOut="self.status='';return true"
				             OnClick="history.go(-1);return false"><IMG
							 	SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/back_nav.jpg"
								Border="0"
								ALT="Back"></A>
							 &nbsp;&nbsp;
							 <INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next_nav.jpg" BORDER="0" NAME="btnNext" VALUE="Next">
			</TD>
		  </TR>	
	   <CFELSE>
 		 <TR>
			<TD ALIGN="center"><FONT SIZE=2 FACE="arial,helvetica">No dealers found</FONT></TD>
         </TR>
         <TR ALIGN="center">
		   <TD> <A HREF="#" OnMouseOver="self.status='Back';return true"
		                    OnMouseOut="self.status='';return true"
				            OnClick="history.go(-1);return false"><IMG
								SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/back_nav.jpg"
								Border="0"
								ALT="Back"></A>
           </TD>
        </TR>
       </CFIF>	
       <TR>
	     <TD>&nbsp;</TD>
	   </TR>
     </Form>
</CFIF>
<!--- --------------------------------------------  Called from account lookup  -------------------------------------- --->
<CFIF sub IS 15>
    <CFSET Nextsub=15>
	     <CFIF IsDefined("URL.StartCheckDate")>
		     <CFSET StartCheckDate=URL.StartCheckDate>
	 	<CFELSE>
        	 <CFSET StartCheckDate=Dateformat(Dateadd("d", 0, "#frommonth#/#fromday#/#fromyear#"))>	 
     	</CFIF>

	     <CFIF IsDefined("URL.EndCheckDate")>
		     <CFSET EndCheckDate=URL.EndCheckDate>
	 	<CFELSE>
        	 <CFSET EndCheckDate=Dateformat(Dateadd("d", 1, "#toomonth#/#tooday#/#tooyear#"))>
     	</CFIF>

	     <CFIF IsDefined("URL.accountRowID")>
		     <CFSET accountRowID=URL.accountRowID>
	 	<CFELSE>
        	 <CFSET accountRowID=#Form.accountRowID#>
     	</CFIF>

	     <CFIF IsDefined("URL.Orderby")>
		     <CFSET Orderby=Url.Orderby>
	 	</CFIF>
	 
    	 <CFIF IsDefined("URL.orderDirection")>
	    	 <CFSET orderDirection=URL.orderDirection>
	 	</CFIF>	 

	     <CFIF IsDefined("URL.LogonRpt")>
		     <CFSET LogonRpt=URL.LogonRpt>
     	</CFIF>

		<CFSET location = "logons.cfm?CFID=#URLEncodedFormat(URL.CFID)#&CFTOKEN=#URLEncodedFormat(URL.CFTOKEN)#&LogonRpt=#LogonRpt#&sub=#Nextsub#&StartCheckDate=#StartCheckDate#&EndCheckDate=#EndCheckDate#&Orderby=#Orderby#&orderDirection=#orderDirection#&accountRowID=#accountRowID#"> 
                        
        <CFSET StartCheckDate=Dateformat(Dateadd("d", 0, "#StartCheckDate#"))>	 
        <CFSET EndCheckDate=Dateformat(Dateadd("d", 0, "#EndCheckDate#"))>


            <CFQUERY NAME="Loginaccount" datasource="#gDSN#">
             SELECT 
                AccountSecurity.UserID,
	            AccountSecurity.LastAction,
	            AccountSecurity.ActionCode,
	            AccountSecurity.SessionID,
	            Accounts.RowID,
                Accounts.Name,
                Dealers.DealerCode,
                Dealers.DealershipName,
                DMGAdmin.DMGcode,
                DMGAdmin.DMG,
                DMGAdmin.DisplayName
         
		        FROM (Dealers  RIGHT JOIN
		             (Accounts RIGHT JOIN AccountSecurity ON Accounts.RowID =AccountSecurity.UserID)
			                                              ON Dealers.DealerCode =AccountSecurity.ActionCode)
			                   LEFT JOIN DMGAdmin ON AccountSecurity.ActionCode =DMGAdmin.DMGcode
		                       WHERE AccountSecurity.LastAction > #CreateODBCDate(StartCheckDate)#
                               And   AccountSecurity.LastAction < #CreateODBCDate(EndCheckDate)#
                               AND   Accounts.RowID = #accountRowID#
							   And   (Not (AccountSecurity.ActionCode)='login')							   
                <CFIF (#Orderby# IS "Date") AND (#orderDirection# IS "DESC") >ORDER BY AccountSecurity.LastAction DESC;</CFIF>
                <CFIF (#Orderby# IS "Date") AND (#orderDirection# IS "ASC") >ORDER BY AccountSecurity.LastAction ASC;</CFIF>
                <CFIF (#Orderby# IS "User") AND (#orderDirection# IS "DESC") >ORDER BY Accounts.Name DESC;</CFIF>
                <CFIF (#Orderby# IS "User") AND (#orderDirection# IS "ASC") >ORDER BY Accounts.Name ASC;</CFIF>
        
        
            </CFQUERY>
       
        <!--- initialize start row first time --->
        <CFPARAM NAME="page" DEFAULT="1">
        <CFSET recordCount = Loginaccount.RecordCount>
        <CFSET pageCount = Ceiling(recordCount / RECORDS_PER_PAGE)>
        <CFSET startRow = ((page - 1) * RECORDS_PER_PAGE) + 1>
        <CFSET endRow = startRow + RECORDS_PER_PAGE - 1>
        <CFIF endRow GT recordCount>
           <CFSET endRow = recordCount>
        </CFIF>

        <div align="center">
        <TABLE CELLPADDING=5 CELLSPACING=0 WIDTH=450 BORDER=0 BGCOLOR="#FFFFFF">
        <TR ALIGN="center">
             <TD ALIGN="center" Colspan=4><h3><FONT FACE="Arial,Helvetica">Administrative Logon Tracking</FONT></h3></TD>
        </TR>
        <CFIF Loginaccount.RecordCount GT 0>
            <tr>
                <td><FONT FACE="arial,helvetica"><B>Name</B></FONT></td>
                <td><FONT FACE="arial,helvetica"><B>Date</B></FONT></td>
                <td><FONT FACE="arial,helvetica"><B>Time</B></FONT></td>
	            <td><FONT FACE="arial,helvetica"><B>Dealership</B></FONT></td>
            </tr>
            <CFOUTPUT QUERY="Loginaccount" STARTROW="#startRow#" MAXROWS="#RECORDS_PER_PAGE#">
            <tr>
		    <td valign="top"><FONT FACE="arial,helvetica" SIZE=2>#RTrim(loginaccount.Name)#</FONT></td>
            <td valign="top"><FONT FACE="arial,helvetica" SIZE=2>#Dateformat(Loginaccount.LastAction,"mm/dd/yyyy")#</FONT></td>
            <td valign="top"><FONT FACE="arial,helvetica" SIZE=2>#DatePart("h", Loginaccount.LastAction)#:#DatePart("m", Loginaccount.LastAction)#:#DatePart("s", Loginaccount.LastAction)#</FONT></td>
            <td valign="top">
			<FONT FACE="arial,helvetica" SIZE=2>
            <CFIF RTrim(Len(Loginaccount.DealershipName)) GT 0>  
           	    #Loginaccount.DealershipName# (#Loginaccount.ActionCode#)
				</FONT>
                 </TD></TR>
            <CFELSEIF RTrim(Len(Loginaccount.DisplayName)) GT 0>  
                #Loginaccount.DisplayName# (#DMGCode#)
				</FONT>
                </TD></TR> 
            <CFELSE>
		        Dealership/DMG info Not Available
				</FONT>
			    </TD></TR> 
		    </CFIF>
            </CFOUTPUT>
            <TR>
               <TD COLSPAN="4" ALIGN="center"><FONT SIZE=2 FACE="arial,helvetica">page&nbsp;<CFOUTPUT>#page#</CFOUTPUT>&nbsp;of&nbsp;<CFOUTPUT>#pageCount#</CFOUTPUT></FONT></TD>
            </TR>
            <TR VALIGN="top">
            <TD ALIGN="right" WIDTH="50%"><FONT SIZE=1 FACE="arial,helvetica"><TT>
            <CFSETTING ENABLECFOUTPUTONLY="YES">
	        <CFIF page GT 1>
	            <CFOUTPUT><A HREF="#location#&FuseAction=jump&page=#Evaluate(page - 1)#">previous</A>&nbsp;|&nbsp;</CFOUTPUT>
	        <CFELSE>
	            <CFOUTPUT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</CFOUTPUT>
	        </CFIF>
	        <CFSETTING ENABLECFOUTPUTONLY="NO">
            </TT></FONT></TD>
            <TD Colspan=2 ALIGN="center"><FONT SIZE=1 FACE="arial,helvetica"><TT>
	        <CFSETTING ENABLECFOUTPUTONLY="YES">
<!--- 	        <CFMODULE TEMPLATE="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/templates/util/jumpmenu.cfm" --->
	        <CFMODULE TEMPLATE="../../util/jumpmenu.cfm"
			  beginPage="1"
			  endPage="#pageCount#"
			  currentPage="#page#"
			  maxJumps="#MAX_JUMPS#"
			  location="#location#">
	         <CFSETTING ENABLECFOUTPUTONLY="NO">
             </TT></FONT></TD>
             <TD ALIGN="left" WIDTH="50%"><FONT SIZE=1 FACE="arial,helvetica"><TT>
	         <CFSETTING ENABLECFOUTPUTONLY="YES">
	         <CFIF page LT pageCount>
	             <CFOUTPUT>|&nbsp;<A HREF="#location#&FuseAction=jump&page=#Evaluate(page + 1)#">next</A></CFOUTPUT>
	         <CFELSE>
	             <CFOUTPUT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</CFOUTPUT>
	         </CFIF>
	         <CFSETTING ENABLECFOUTPUTONLY="NO">
             </TT></FONT></TD>
             </TR>
             <TR>
             <CFOUTPUT>
		     <TD ALIGN="center" COLSPAN="4">
		         <A HREF="logons.cfm?CFID=#URLEncodedFormat(URL.CFID)#&CFTOKEN=#URLEncodedFormat(URL.CFTOKEN)#&sub=1"><IMG
				 	SRC="#application.RELATIVE_PATH#/images/admin/back_nav.jpg"
					Border="0"
					ALT="Back To Logon Reporting Selections"></A>
		     </TD>
		     </TR>
		     <TR>
             <TD ALIGN="center" COLSPAN="4">
			     <FORM NAME="f_main" ACTION="#g_relpath#/templates/admin/dlr/redirect.cfm" METHOD="post">
                    <INPUT TYPE="Image" SRC="#g_relpath#/images/admin/backtomain_nav.jpg" Border="0" NAME="BackToMain" VALUE="Back To Main Menu">
                 </FORM>
             </TD>
             </CFOUTPUT>
             </TR>
	  <CFELSE>
             <CFOUTPUT>   
             <TR>
		     <TD ALIGN="center" colspan="4"><FONT SIZE=2 FACE="arial,helvetica">No Information found</FONT></TD>
             </TR>
		     <TR ALIGN="center">
             </CFOUTPUT>
		     <TD colspan="4"> <A HREF="#" OnMouseOver="self.status='Back';return true"
		                    OnMouseOut="self.status='';return true"
				            OnClick="history.go(-1);return false"><IMG
								SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/back_nav.jpg" Border="0" ALT="Back"></A>
             </TD>
             </TR>
	  </CFIF>				 
  </CFIF>
<! --- ------------------------------------ Start Reports from Option Screen  ----------------------------------------------- --->
<CFIF sub IS 16>
    <CFSET Nextsub=16>
	
	<CFIF IsDefined("URL.StartCheckDate")>
		     <CFSET StartCheckDate=Dateformat(URL.StartCheckDate)>
	 	<CFELSE>
        	 <CFSET StartCheckDate=Dateformat("#Form.StartDate#")>	 
     	</CFIF>

	     <CFIF IsDefined("URL.EndCheckDate")>
		     <CFSET EndCheckDate=Dateformat(URL.EndCheckDate)>
	 	<CFELSE>
             <CFSET EndCheckDate=Dateformat(Dateadd("d", 1, "#Form.EndDate#"))>
     	</CFIF>

	     <CFIF IsDefined("URL.DealerID")>
		     <CFSET accountRowID=URL.DealerID>
	 	<CFELSE>
        	 <CFSET accountRowID=#Form.DealerID#>
     	</CFIF>

	     <CFIF IsDefined("URL.Orderby")>
		     <CFSET Orderby=Url.Orderby>
	 	</CFIF>
	 
    	 <CFIF IsDefined("URL.orderDirection")>
	    	 <CFSET orderDirection=URL.orderDirection>
	 	</CFIF>	 

	     <CFIF IsDefined("URL.LogonRpt")>
		     <CFSET LogonRpt=URL.LogonRpt>
     	</CFIF>
	
	
		<CFSET location = "logons.cfm?CFID=#URLEncodedFormat(URL.CFID)#&CFTOKEN=#URLEncodedFormat(URL.CFTOKEN)#&LogonRpt=#LogonRpt#&sub=#Nextsub#&StartCheckDate=#StartCheckDate#&EndCheckDate=#EndCheckDate#&Orderby=#Orderby#&orderDirection=#orderDirection#&DealerID=#DealerID#"> 

                        
       <CFSET StartCheckDate=Dateformat(Dateadd("d", 0, "#StartCheckDate#"))>	 
       <CFSET EndCheckDate=Dateformat(Dateadd("d", 1, "#EndCheckDate#"))>

            <CFQUERY NAME="Loginother" datasource="#gDSN#">
             SELECT 
                AccountSecurity.UserID,
	            AccountSecurity.LastAction,
	            AccountSecurity.ActionCode,
	            AccountSecurity.SessionID,
	            Accounts.RowID,
                Accounts.Name,
                Dealers.DealerCode,
                Dealers.DealershipName,
                DMGAdmin.DMGcode,
                DMGAdmin.DMG,
                DMGAdmin.DisplayName
         
		        FROM (Dealers  RIGHT JOIN
		             (Accounts RIGHT JOIN AccountSecurity ON Accounts.RowID =AccountSecurity.UserID)
			                                              ON Dealers.DealerCode =AccountSecurity.ActionCode)
			                   LEFT JOIN DMGAdmin ON AccountSecurity.ActionCode =DMGAdmin.DMGcode
		                       WHERE AccountSecurity.LastAction > #CreateODBCDate(StartCheckDate)#
                               And   AccountSecurity.LastAction < #CreateODBCDate(EndCheckDate)#
                               And   AccountSecurity.ActionCode = '#DealerID#'
							   And   (Not (AccountSecurity.ActionCode)='login')
	                           <CFIF (#Orderby# IS "Date") AND (#orderDirection# IS "DESC") >ORDER BY AccountSecurity.LastAction DESC;</CFIF>
                               <CFIF (#Orderby# IS "Date") AND (#orderDirection# IS "ASC") >ORDER BY AccountSecurity.LastAction ASC;</CFIF>
                               <CFIF (#Orderby# IS "User") AND (#orderDirection# IS "DESC") >ORDER BY Accounts.Name DESC;</CFIF>
                               <CFIF (#Orderby# IS "User") AND (#orderDirection# IS "ASC") >ORDER BY Accounts.Name ASC;</CFIF>
        
        
            </CFQUERY>
       
        <!--- initialize start row first time --->
        <CFPARAM NAME="page" DEFAULT="1">
        <CFSET recordCount = Loginother.RecordCount>
        <CFSET pageCount = Ceiling(recordCount / RECORDS_PER_PAGE)>
        <CFSET startRow = ((page - 1) * RECORDS_PER_PAGE) + 1>
        <CFSET endRow = startRow + RECORDS_PER_PAGE - 1>
        <CFIF endRow GT recordCount>
           <CFSET endRow = recordCount>
        </CFIF>

        <div align="center">
        <TABLE CELLPADDING=5 CELLSPACING=0 WIDTH=450 BORDER=0 BGCOLOR="#FFFFFF">
        <TR ALIGN="center">
             <TD ALIGN="center" Colspan=4><h3><FONT FACE="Arial,Helvetica">Administrative Logon Tracking</FONT></h3></TD>
        </TR>
            <CFIF Loginother.RecordCount GT 0>
               <tr>
                   <td><FONT FACE="arial,helvetica"><B>Name</B></FONT></td>
                   <td><FONT FACE="arial,helvetica"><B>Date</B></FONT></td>
                   <td><FONT FACE="arial,helvetica"><B>Time</B></FONT></td>
	               <td><FONT FACE="arial,helvetica"><B>Dealership</B></FONT></td>
               </tr>
               <CFOUTPUT QUERY="Loginother" STARTROW="#startRow#" MAXROWS="#RECORDS_PER_PAGE#">
               <tr>
		       <td valign="top"><FONT FACE="arial,helvetica" SIZE=2>#RTrim(loginother.Name)#</FONT></td>
               <td valign="top"><FONT FACE="arial,helvetica" SIZE=2>#Dateformat(Loginother.LastAction,"mm/dd/yyyy")#</FONT></td>
               <td valign="top"><FONT FACE="arial,helvetica" SIZE=2>#DatePart("h", Loginother.LastAction)#:#DatePart("m", Loginother.LastAction)#:#DatePart("s", Loginother.LastAction)#</FONT></td>
               <td valign="top">
			   <FONT FACE="arial,helvetica" SIZE=2>
               <CFIF RTrim(Len(Loginother.DealershipName)) GT 0>  
           	      #Loginother.DealershipName# (#Loginother.ActionCode#)
				</FONT>
				  </TD></TR>
               <CFELSEIF RTrim(Len(Loginother.DisplayName)) GT 0>  
          	      #Loginother.DisplayName# (#DMGCode#)
					</FONT>
				   </TD></TR> 
               <CFELSE>
		           Dealership/DMG info Not Available
				   </FONT>
			       </TD></TR> 
		       </CFIF>
               </CFOUTPUT>
               <TR>
               <TD COLSPAN="4" ALIGN="center"><FONT SIZE=2 FACE="arial,helvetica">page&nbsp;<CFOUTPUT>#page#</CFOUTPUT>&nbsp;of&nbsp;<CFOUTPUT>#pageCount#</CFOUTPUT></FONT></TD>
               </TR>
               <TR VALIGN="top">
               <TD ALIGN="right" WIDTH="50%"><FONT SIZE=1 FACE="arial,helvetica"><TT>
               <CFSETTING ENABLECFOUTPUTONLY="YES">
	           <CFIF page GT 1>
	               <CFOUTPUT><A HREF="#location#&FuseAction=jump&page=#Evaluate(page - 1)#">previous</A>&nbsp;|&nbsp;</CFOUTPUT>
	           <CFELSE>
	               <CFOUTPUT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</CFOUTPUT>
	           </CFIF>
	           <CFSETTING ENABLECFOUTPUTONLY="NO">
               </TT></FONT></TD>
               <TD Colspan=2 ALIGN="center"><FONT SIZE=1 FACE="arial,helvetica"><TT>
	           <CFSETTING ENABLECFOUTPUTONLY="YES">
<!--- 	           <CFMODULE TEMPLATE="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/templates/util/jumpmenu.cfm" --->
	           <CFMODULE TEMPLATE="../../util/jumpmenu.cfm"
			    beginPage="1"
			    endPage="#pageCount#"
			    currentPage="#page#"
			    maxJumps="#MAX_JUMPS#"
			    location="#location#">
	           <CFSETTING ENABLECFOUTPUTONLY="NO">
               </TT></FONT></TD>
               <TD ALIGN="left" WIDTH="50%"><FONT SIZE=1 FACE="arial,helvetica"><TT>
	           <CFSETTING ENABLECFOUTPUTONLY="YES">
	           <CFIF page LT pageCount>
	                <CFOUTPUT>|&nbsp;<A HREF="#location#&FuseAction=jump&page=#Evaluate(page + 1)#">next</A></CFOUTPUT>
	           <CFELSE>
	                <CFOUTPUT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</CFOUTPUT>
	           </CFIF>
	           <CFSETTING ENABLECFOUTPUTONLY="NO">
               </TT></FONT></TD>
               </TR>
               <TR>
               <CFOUTPUT>
		       <TD ALIGN="center" COLSPAN="4">
		       <A HREF="logons.cfm?CFID=#URLEncodedFormat(URL.CFID)#&CFTOKEN=#URLEncodedFormat(URL.CFTOKEN)#&sub=1"><IMG
			   		SRC="#application.RELATIVE_PATH#/images/admin/back_nav.jpg"
					Border="0"
					ALT="Back To Logon Reporting Selections"></A>
		       </TD>
		       </TR>
		       <TR>
               <TD ALIGN="center" COLSPAN="4">
			   <FORM NAME="f_main" ACTION="#g_relpath#/templates/admin/dlr/redirect.cfm" METHOD="post">
               <INPUT TYPE="Image" SRC="#application.RELATIVE_PATH#/images/admin/backtomain_nav.jpg" Border="0" NAME="BackToMain" VALUE="Back To Main Menu">
               </FORM>
               </TD>
               </TR>
               </CFOUTPUT>
		  <CFELSE>
               <CFOUTPUT>
			   <TR>
		       <TD ALIGN="center" colspan="4"><FONT SIZE=2 FACE="arial,helvetica">No Information found</FONT></TD>
               </TR>
		       <TR ALIGN="center">
               </CFOUTPUT>
		       <TD colspan="4"> <A HREF="#" OnMouseOver="self.status='Back';return true"
		                    OnMouseOut="self.status='';return true"
				            OnClick="history.go(-1);return false"><IMG
								SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/back_nav.jpg" Border="0" ALT="Back"></A>
               </TD>
               </TR>
		  </CFIF>	  
  </CFIF>
<! --- ------------------------------------ That's all Folks  ----------------------------------------------- --->
</div>
<CFINCLUDE template="footer.cfm">
</HTML>
