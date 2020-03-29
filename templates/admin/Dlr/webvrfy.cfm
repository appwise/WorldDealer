<CFSET webverifystep = 1>
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
    <!--     John Turner for sigma6, interactive media, Detroit      -->
    <!--    jturner@sigma6.com   www.sigma6.com    www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
	<!--- $Id: webvrfy.cfm,v 1.9 1999/11/29 15:31:00 lswanson Exp $ --->
	<!--- Dealership info: name, address, contact, phone, tag line, display name --->

<HEAD>

        <TITLE>WorldDealer | Create a New Web</TITLE>

	<CFIF ParameterExists(Form.btnNext.X)>
		<CFLOCATION URL="#Form.NextStep#?dlrcode=#Form.DealerCode#">
	</CFIF>
        
	<CFIF ParameterExists(Form.btnModify.X)>
		<CFLOCATION URL="webnew.cfm?dlrcode=#Form.DealerCode#">
	<CFELSE>
		<CFIF ParameterExists(URL.dlrcode)>
			<CFSET VerifyMode = TRUE>
			<CFSET g_DealerCode = #URL.dlrcode#>
		<CFELSE>
			<CFSET VerifyMode = FALSE>
		</CFIF>
	</CFIF>

    <CFIF VerifyMode>
    <!--- user is coming at this page with a dealer already selected --->
       <CFQUERY NAME="getDealerInfo" datasource="#gDSN#">
		SELECT *
		FROM
			Dealers
		WHERE
			Dealers.DealerCode = '#g_DealerCode#'
		</CFQUERY>

		<!--- Dealer Makes Query used in drop down list below --->
		<CFQUERY NAME="getDealerMakes" datasource="#gDSN#">
			SELECT 	Makes.MakeName, Makes.MakeNumber
			FROM 	Makes INNER JOIN DealerFranchise ON Makes.MakeNumber = DealerFranchise.MakeNumber
			WHERE 	DealerFranchise.DF_Number = #Mid(g_DealerCode,11,3)#
			ORDER BY DealerFranchise.RowID
		</CFQUERY>
		
		<cfset dealerMakes = ArrayNew(1)>
		<cfset counter = 0>		
		<cfloop query="getDealerMakes" startrow="1" endrow="10">
			<cfset counter = counter + 1>
			<cfif #getDealerMakes.MakeNumber# NEQ 0>
				<cfset dealerMakes[counter] = #getDealerMakes.MakeNumber#>
			</cfif>
		</cfloop>
		<cfset dealerLen = ArrayLen(dealerMakes)>

    </CFIF>

	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>

<body>
<br><br><br><br><br>

<CFIF VerifyMode>
<!--- user is coming at this page with a dealer already selected --->

<div align="center">
<TABLE CELLPADDING=5 CELLSPACING=0 BORDER=0 WIDTH=520 BGCOLOR="FFFFFF">
<TR>
	<TD ALIGN="center">
		<h3>
			Maintain Your Web Site
		</h3>
	</TD>
</TR>
<TR>
	<TD ALIGN="center">
		<h4>
			Dealer Information
		</h4>
	</TD>
</TR>
<TR>
	<TD>
			Verify the information below for this dealership.  To change
			an entry, click the <b>'Modify'</b> button.
	</TD>
</TR>
<TR><TD>&nbsp;<p></TD></TR>
<TR>
	<TD ALIGN=CENTER>
	<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0>
 	<TR>
		<TD>
				Dealer Code
		</TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<TD>
			<b>
				<CFOUTPUT QUERY="getDealerInfo">
					#DealerCode#
				</CFOUTPUT>
			</b>
		</TD>
	</TR>
	<TR>
		<TD>
				Dealer Type
		</TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<TD>
			<b>
				<cfset count = 0>
				<CFOUTPUT QUERY="getDealerMakes">
				<cfset count = count + 1>
					#MakeName#<cfif count LT dealerLen>, </cfif>
				</CFOUTPUT>
			</b>
		</TD>
	</TR>
	<TR>
		<TD>
				Dealership Name
		</TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<TD>
			<b>
				<CFOUTPUT QUERY="getDealerInfo">
					#DealershipName#
				</CFOUTPUT>
			</b>
		</TD>
	</TR>
	<TR>
		<TD>
				Address 1
		</TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<TD>
			<b>
				<CFOUTPUT QUERY="getDealerInfo">
					#AddressLine1#
				</CFOUTPUT>
			</b>
		</TD>
	</TR>
	<TR>
		<TD>
				Address 2
		</TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<TD>
			<b>
				<CFOUTPUT QUERY="getDealerInfo">
					#AddressLine2#
				</CFOUTPUT>
			</b>
		</TD>
	</TR>
	<TR>
		<TD>
				City
		</TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<TD>
			<b>
				<CFOUTPUT QUERY="getDealerInfo">
					#City#
				</CFOUTPUT>
			</b>
		</TD>
	</TR>
	<TR>
		<TD>
				State
		</TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<TD>
			<b>
				<CFOUTPUT QUERY="getDealerInfo">
					#StateAbbr#
				</CFOUTPUT>
			</b>
		</TD>
	</TR>
	<TR>
		<TD>
				Zip Code
		</TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<TD>
			<b>
				<CFOUTPUT QUERY="getDealerInfo">
					#Zip#
				</CFOUTPUT>
			</b>
		</TD>
	</TR>
	<TR>
		<TD>
				Phone Number
		</TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<TD>
			<b>
				<CFIF #Len(getDealerInfo.Phone)# eq 10>
					<CFOUTPUT QUERY="getDealerInfo">
						#RemoveChars(phone,4,10)#-#Mid(phone,4,3)#-#RemoveChars(phone,1,6)#
					</CFOUTPUT>
				<CFELSE>
					<CFOUTPUT QUERY="getDealerInfo">
						<font color="red">#phone#</font>
					</CFOUTPUT>
				</CFIF>
			</b>
		</TD>
	</TR>
	<TR>
		<TD>
				Second Phone Number
		</TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<TD>
			<b>
				<CFIF #Len(getDealerInfo.secondPhone)# eq 10>
					<CFOUTPUT QUERY="getDealerInfo">
						#RemoveChars(secondPhone,4,10)#-#Mid(secondPhone,4,3)#-#RemoveChars(secondPhone,1,6)#
					</CFOUTPUT>
				<CFELSE>
					<CFOUTPUT QUERY="getDealerInfo">
						<font color="red">#secondPhone#</font>
					</CFOUTPUT>
				</CFIF>
			</b>
		</TD>
	</TR>
	<TR>
		<TD>
				Fax Number
		</TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<TD>
			<b>
				<CFIF #Len(getDealerInfo.faxPhone)# eq 10>
					<CFOUTPUT QUERY="getDealerInfo">
						#RemoveChars(faxphone,4,10)#-#Mid(faxphone,4,3)#-#RemoveChars(faxphone,1,6)#
					</CFOUTPUT>
				<CFELSE>
					<CFOUTPUT QUERY="getDealerInfo">
						<font color="red">#faxphone#</font>
					</CFOUTPUT>
				</CFIF>
			</b>
		</TD>
	</TR>
	<TR>
		<TD>
				Quote Fax Number
		</TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<TD>
			<b>
				<CFIF #Len(getDealerInfo.QuoteFax)# eq 10>
					<CFOUTPUT QUERY="getDealerInfo">
						#RemoveChars(QuoteFax,4,10)#-#Mid(QuoteFax,4,3)#-#RemoveChars(QuoteFax,1,6)#
					</CFOUTPUT>
				<CFELSE>
					<CFOUTPUT QUERY="getDealerInfo">
						<font color="red">#QuoteFax#</font>
					</CFOUTPUT>
				</CFIF>
			</b>
		</TD>
	</TR>
	<TR>
		<TD>
				Financing Fax Number
		</TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<TD>
			<b>
				<CFIF #Len(getDealerInfo.FinanceFax)# eq 10>
					<CFOUTPUT QUERY="getDealerInfo">
						#RemoveChars(FinanceFax,4,10)#-#Mid(FinanceFax,4,3)#-#RemoveChars(FinanceFax,1,6)#
					</CFOUTPUT>
				<CFELSE>
					<CFOUTPUT QUERY="getDealerInfo">
						<font color="red">#FinanceFax#</font>
					</CFOUTPUT>
				</CFIF>
			</b>
		</TD>
	</TR>
	<!--- If it's a collection, skip Service and Parts fax numbers --->
	<CFIF Mid(g_DealerCode, 6,4) EQ '0000'>
		<!--- do nothing --->
	<CFELSE>
	<TR>
		<TD>
			Service Fax Number
		</TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<TD>
			<b>
			<CFIF #Len(getDealerInfo.ServiceFax)# eq 10>
				<CFOUTPUT QUERY="getDealerInfo">
					#RemoveChars(ServiceFax,4,10)#-#Mid(ServiceFax,4,3)#-#RemoveChars(ServiceFax,1,6)#
				</CFOUTPUT>
			<CFELSE>
				<CFOUTPUT QUERY="getDealerInfo">
					<font color="red">#ServiceFax#</font>
				</CFOUTPUT>
			</CFIF>
			</b>
		</TD>
	</TR>
	<TR>
		<TD>
				Parts Fax Number
		</TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<TD>
			<b>
				<CFIF #Len(getDealerInfo.PartsFax)# eq 10>
					<CFOUTPUT QUERY="getDealerInfo">
						#RemoveChars(PartsFax,4,10)#-#Mid(PartsFax,4,3)#-#RemoveChars(PartsFax,1,6)#
					</CFOUTPUT>
				<CFELSE>
					<CFOUTPUT QUERY="getDealerInfo">
						<font color="red">#PartsFax#</font>
					</CFOUTPUT>
				</CFIF>
			</b>
		</TD>
	</TR>
	</cfif>
	<TR>
		<TD>
				Contact Name
		</TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<TD>
			<b>
				<CFOUTPUT QUERY="getDealerInfo">
					#ContactName#
				</CFOUTPUT>
			</b>
		</TD>
	</TR>
	<TR>
		<TD>
				Contact Phone
		</TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<TD>
			<b>
				<CFIF #Len(getDealerInfo.ContactPhone)# eq 10>
					<CFOUTPUT QUERY="getDealerInfo">
						#RemoveChars(contactphone,4,10)#-#Mid(contactphone,4,3)#-#RemoveChars(contactphone,1,6)#
					</CFOUTPUT>
				<CFELSE>
					<CFOUTPUT QUERY="getDealerInfo">
						<font color="red">#contactphone#</font>
					</CFOUTPUT>
				</CFIF>
			</b>
		</TD>
	</TR>
	<TR>
		<TD>
				Tag Line
		</TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<TD>
			<B>
				<CFOUTPUT QUERY="getDealerInfo">
					#tagline#
				</CFOUTPUT>
			</b>
		</TD>
	</TR>
	<TR>
		<TD>
				Display Name
		</TD>
		<TD>&nbsp;&nbsp;&nbsp;</TD>
		<TD>
			<B>
				<CFOUTPUT QUERY="getDealerInfo">
					#DisplayName#
				</CFOUTPUT>
			</b>
		</TD>
	</TR>
	<TR>
		<TD COLSPAN=3>
			<i>
				(This name appears on your custom graphics)
			</i>
		</TD>
	</TR>
	<TR><TD COLSPAN="3">&nbsp;<p></TD></TR>
	</TABLE>
	</TD>
</TR>
<TR ALIGN="center">
	<TD>
		<CFOUTPUT QUERY="getDealerInfo">
		<FORM NAME="VrfyOne" ACTION="webvrfy.cfm?dlrcode=#g_DealerCode#" METHOD="post">
			<INPUT TYPE="hidden" NAME="DealerCode" VALUE="#g_DealerCode#">
			<INPUT TYPE="hidden" NAME="NextStep" VALUE="webvrfy_webcheck.cfm">
			<INPUT TYPE="Image"
				SRC="#application.RELATIVE_PATH#/images/admin/modify_nav.jpg"
				Border="0"
				NAME="btnModify"
				VALUE="Modify">
			&nbsp;&nbsp;
			<INPUT TYPE="Image"
				SRC="#application.RELATIVE_PATH#/images/admin/next_nav.jpg"
				Border="0"
				NAME="btnNext"
				VALUE="Next">
		</FORM>
		</CFOUTPUT>
		<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
			<INPUT TYPE="Image"
				SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg"
				Border="0"
				NAME="BackToMain"
				VALUE="Back To Main Menu">
		</FORM>
	</TD>
</TR>
</TABLE>

</div>
</CFIF>

</BODY>
</HTML>