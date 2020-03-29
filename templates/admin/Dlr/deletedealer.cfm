<CFSET PageAccess = 1>
<CFINCLUDE template="security.cfm">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

   <!-- ----------------------------------------------------------- -->
   <!--               Created  by Sigma6, Inc.                      -->
   <!--     Copyright (c) 1998, 1999 Sigma6, Inc.                   -->
   <!--         All Rights Reserved.  Used By Permission.           -->
   <!-- ----------------------------------------------------------- -->
   <!-- ----------------------------------------------------------- -->
   <!--           Sigma6, interactive media, Detroit/NYC            -->
   <!--               conceive : construct : connect                -->
   <!--   www.sigma6.com   webmaster@sigma6.com   info@sigma6.com   -->
   <!--                                                             -->
   <!--   Last updated: Tuesday, April 14, 1998                     -->
   <!-- ----------------------------------------------------------- -->
   <!--     Howard Levine for sigma6, interactive media, Detroit    -->
   <!--    hlevine@sigma6.com   www.sigma6.com    www.s6313.com     -->
   <!--               conceive : construct : connect                -->
   <!-- ----------------------------------------------------------- -->
   <!-- ----------------------------------------------------------- -->
   <!-- Sigma6, s6, and the Sigma6 logos are registered trademarks. -->
   <!-- All other trademarks and servicemarks are the property of   -->
   <!-- their respective owners.                                    -->
   <!-- ----------------------------------------------------------- -->

<HTML>

	<!--- $Id: deletedealer.cfm,v 1.6 1999/11/24 22:54:03 lswanson Exp $ --->

<HEAD>
	<TITLE>WorldDealer - Delete a Dealer</TITLE>
	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>

<CFSET FirstMode = FALSE>
<CFSET DeleteMode = FALSE>
<CFSET KillMode = FALSE>

<CFIF IsDefined("Form.btnNext.X")>
	<CFSET DeleteMode = TRUE>
	<CFSET g_DealerCode = ''>
<CFELSEIF IsDefined("Form.BtnDelete.X")>
	<CFSET KillMode = TRUE>
	<CFSET g_DealerCode = #form.DealerCode#>
<CFELSE>
	<CFSET FirstMode = TRUE>
	<CFSET g_DealerCode = ''>
</CFIF>

<body>
<br><br><br><br><br>

<CFIF FirstMode>
	<CFQUERY NAME="getDealerships" datasource="#gDSN#">
		SELECT	Dealercode as q_Dealercode, 
				DealershipName as q_DealershipName,
				AEID as q_AEID,
				ACID as q_ACID
		FROM Dealers
				<CFIF VAL(Left(#Accesslevel#,1)) LT 3>
				Where AEID = #RemoveChars(AccessLevel,1,2)# or
			  		  ACID = #RemoveChars(AccessLevel,1,2)#
				</CFIF>
				Order BY DealershipName
	</CFQUERY>
	<div align="center">
	<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=420 BGCOLOR="FFFFFF">
	<TR>
		<TD>
			<P>&nbsp;</p>
		</TD>
	</TR>
	<TR ALIGN="center">
		<TD ALIGN="middle">
			<h3><FONT FACE="Arial,Helvetica">Collection/Dealer Administration</FONT></h3>
		</TD>
	</TR>
	<TR ALIGN="center">
		<TD ALIGN="middle"><h4><font face="Arial,Helvetica">Delete a Dealer</font></h4></TD>
	</TR>
	<TR>
		<TD>
			<P>&nbsp;</P>
		</td>
	</tr>
	<!--- just get true dealerships; ignore Collections --->
	<CFSET #DealerCount# = 0>
	<CFOUTPUT QUERY="getDealerships">
		<CFIF VAL(MID(q_Dealercode,6,4)) GT 0>
			<CFSET #DealerCount# = #DealerCount# + 1>
		</CFIF>
	</CFOUTPUT>
	
	<CFIF #DealerCount# GT 0>
		<TR>
			<TD><div align="center"><FONT FACE="Arial,Helvetica">Select a <B>Dealer</B> from the list below then click <B>Next</b>.</b></FONT></div></TD>
		</TR>
		<TR>
			<TD>
				<P>&nbsp;</P>
			</td>
		</tr>	
		<TR>
			<FORM NAME="FindDealer" ACTION="deletedealer.cfm" METHOD="post">
			<TD>
			<div align="center">
			<SELECT NAME="DealerCode" SIZE=1>
				<CFOUTPUT QUERY="getDealerships">
					<CFIF VAL(MID(q_Dealercode,6,4)) GT 0>
						<OPTION VALUE="#q_DealerCode#">#q_DealershipName#
					</CFIF>
				</CFOUTPUT>
			</SELECT>
			<P>&nbsp;</P>
			<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next_nav.jpg" BORDER="0" NAME="btnNext" VALUE="Next">
			</div>
			</TD>
			</FORM>
		</TR>
	<CFELSE>
		<TR>	
			<TD>
				<div align="center"><FONT FACE="Arial,Helvetica">There were no Dealerships found meeting your Security Requirements.</FONT></div>
			</TD>
		</TR>			
	</CFIF>
		
	<TR>
		<TD>
			<P>&nbsp;</P>
		</td>
	</tr>
	<TR ALIGN="center">
		<TD>
			<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
			<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg" Border="0" NAME="BackToMain" VALUE="Back To Main Menu"></FORM>
		</TD>
	</TR>
	</TABLE>
	
</CFIF>
<!--- End FirstMode --->


<CFIF DeleteMode>
	<CFQUERY name="getDealer" datasource="#gDSN#">
		SELECT Dealers.DealershipName,
			   Dealers.City,
			   Dealers.StateAbbr
		FROM Dealers
		WHERE DealerCode = '#form.DealerCode#'
	</CFQUERY>

	<CFIF #getDealer.RecordCount# GT 0>
		<!--- Dealer has a site in DealerWebs --->	
		<CFQUERY name="GetDealerWeb" datasource="#gDSN#">
		SELECT DealerWebs.WebstateID,
			   Webstates.Description as q_Webstate,
			   DealerWebs.BaseURL
		FROM Dealerwebs,
			 Webstates
		WHERE DealerWebs.Dealercode = '#Form.DealerCode#' AND
			  DealerWebs.WebstateID = Webstates.WebstateID;
		</CFQUERY>
	</CFIF>

	<div align="center">
	<TABLE CELLPADDING=10 CELLSPACING=0 BORDER=0 WIDTH=420 BGCOLOR="FFFFFF">
	<TR ALIGN="center">
		<TD ALIGN="middle">
			<h3><FONT FACE="Arial,Helvetica">Collection/Dealer Administration</FONT></h3>
		</TD>
	</TR>
	<TR ALIGN="center">
		<TD ALIGN="middle"><h4><font face="Arial,Helvetica">Delete a Dealer</font></h4></TD>
	</TR>
	<CFIF #getDealer.RecordCount# GT 0>
		<TR>
			<TD align="center">
				<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0>
					<TR>
						<TD BGCOLOR="ff0000">
							&nbsp;
						</TD>
					</TR>
					<TR>
						<TD BGCOLOR="ff0000">
							<FONT FACE="Arial,Helvetica" size="+1">&nbsp;&nbsp;C A U T I O N ! !&nbsp;&nbsp;</FONT>
						</TD>
					</TR>
					<TR>
						<TD BGCOLOR="ff0000">
							&nbsp;
						</TD>
					</TR>
				</TABLE>
			</TD>
		</TR>
		<TR align="center">
			<TD>
				<FONT FACE="Arial,Helvetica">
					You are about to permanently DELETE all websites and references to the following Dealership.
					<p>Are you sure you wish to completely erase this dealership?
				</FONT>
			</TD>
		</TR>
		<TR align="center">
			<TD>
				<TABLE BORDER=0 cellspacing=0 cellpadding=0>
					<CFOUTPUT query="GetDealer">
					<TR>
						<TD align="right">
							<FONT FACE="Arial,Helvetica">Dealership:</FONT>
						</TD>
						<TD>
							&nbsp;&nbsp;
						</TD>
						<TD align="left">
							<FONT face="Arial,Helvetica"><b>#DealershipName#</b></FONT>
						</TD>
					</TR>
					<TR>
						<TD>
							&nbsp;
						</TD>
						<TD>
							&nbsp;&nbsp;
						</TD>
						<TD align="left">
							<FONT FACE="Arial,Helvetica"><b>#City#, #StateAbbr#</b></FONT>
						</TD>
					</TR>
					</CFOUTPUT>
					<CFOUTPUT query="GetDealerWeb">
					<TR>
						<TD align="right">
							<FONT FACE="Arial,Helvetica">Primary URL:</FONT>
						</TD>
						<TD>
							&nbsp;&nbsp;
						</TD>
						<TD align="left">
							<FONT FACE="Arial,Helvetica"><b>#BaseURL#</b></FONT>
						</TD>
						</TR>
						<TR>
							<TD align="right">
								<FONT FACE="Arial,Helvetica">Web State:</FONT>
							</TD>
						<TD>
							&nbsp;&nbsp;
						</TD>
						<TD align="left">
							<FONT FACE="Arial,Helvetica"><b>#q_WebState#</b></FONT>
						</TD>
					</TR>
					</CFOUTPUT>
				</TABLE>
			</TD>
		</TR>
		<FORM Action="deletedealer.cfm" method="post">
		<CFOUTPUT>
			<INPUT type="hidden" name="DealerCode" value="#Form.DealerCode#">
		</CFOUTPUT>
		<TR align="Center">
			<TD>
				<FONT FACE="Arial,Helvetica"><INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/deletedealer.jpg" Border="0" name="BtnDelete" value="Delete Dealer"></FONT>
			</TD>
		</TR>
		</FORM>
	<CFELSE>
		<TR>
			<TD>
				&nbsp;
			</TD>
		</TR>
		<TR align="center">
			<TD COLSPAN=3>
				<FONT FACE="Arial,Helvetica">
				<b>This Dealership does not have a web site.</b></FONT>
			</TD>
		</TR>
		<TR>
			<TD>
				&nbsp;
			</TD>
		</TR>
	</CFIF>	
	<FORM ACTION="redirect.cfm" method="post">
	<TR align="center">
		<TD>
			<FONT FACE="Arial,Helvetica"><INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg"
			Border="0"
			NAME="BackToMain"
			VALUE="Back To Main Menu">
			</FONT>
		</TD>
	</TR>
	</FORM>
	</TABLE>
</CFIF> <!--- CFIF DeleteMode --->


<CFIF KillMode>
	<cfinclude template="deletedealerKill.cfm">

	<div align="center">
	<TABLE CELLPADDING=5 CELLSPACING=0 BORDER=0 WIDTH=420 BGCOLOR="FFFFFF">
	<TR><TD>&nbsp;<p></TD></TR>
	<TR ALIGN="center">
		<TD ALIGN="middle"><h3><FONT FACE="Arial,Helvetica">Dealer Administration</FONT></h3></TD>
	</TR>
	<TR ALIGN="center">
		<TD ALIGN="middle"><h4><font face="Arial,Helvetica">Delete a Dealer</font></h4></TD>
	</TR>
	<TR><TD align="center">
	<FONT FACE="Arial,Helvetica">Processing Complete.</FONT>
	</TD></TR>
	<TR><TD>&nbsp;</TD></TR>
	<FORM ACTION="redirect.cfm" method="post">
	<TR align="center"><TD><FONT FACE="Arial,Helvetica"><INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg"
			Border="0"
			NAME="BackToMain"
			VALUE="Back To Main Menu">
</FONT>
	</TD></TR>
	<TR><TD>&nbsp;</TD></TR>
	</TABLE>		
</CFIF>
<!--- End Kill Mode --->


<!--- All Modes --->

</div>

</BODY>
</HTML>
