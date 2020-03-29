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
<!--- $Id: dsp_leadList.cfm,v 1.7 1999/12/30 19:48:34 bbickel Exp $ --->

<!---
dsp_leadList.cfm - lead reporting screen 2
--->

<CFSETTING ENABLECFOUTPUTONLY="NO">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>

	<!--- header.cfm sets up a table already --->
	<CFMODULE template="..\header.cfm"
			windowTitle="Dealer Administration, Lead Reporting"
			screenTitle="Lead Reporting Leads Listing">

		<TR ALIGN="center">
			<TD>
			<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="5" WIDTH="500">
				<FORM ACTION="index.cfm" METHOD="POST">
				<INPUT TYPE="hidden" NAME="FromTemplate" VALUE="dsp_leadList">
				<CFIF NOT isError>
					<CFOUTPUT>
					<INPUT TYPE="hidden" NAME="reportCoverage" VALUE="#reportCoverage#">
					<INPUT TYPE="hidden" NAME="leadType" VALUE="#leadType#">
					<INPUT TYPE="hidden" NAME="orderBy" VALUE="#orderBy#">
					<INPUT TYPE="hidden" NAME="orderDirection" VALUE="#orderDirection#">
					<INPUT TYPE="hidden" NAME="page" VALUE="#page#">
					<CFIF reportCoverage EQ "single">
						<INPUT TYPE="hidden" NAME="DealerCode" VALUE="#DealerCode#">
					<CFELSEIF reportCoverage EQ "account">
						<INPUT TYPE="hidden" NAME="accountRowID" VALUE="#accountRowID#">
					</CFIF>
					</cfoutput>
				
					<CFIF selectLeadList.RecordCount GT 0>
						<TR ALIGN="left">
							<td>&nbsp;</td>
							<td><b>Name</b></td>
							<td><b>Lead Type</b></td>
							<td><b>Date</b></td>
						</TR>
						<CFSET RecCount = 0>
						<CFOUTPUT QUERY="selectLeadList" STARTROW="#startRow#" MAXROWS="#RECORDS_PER_PAGE#">
							<CFSET RecCount = RecCount +1>
							<TR ALIGN="left">
								<TD WIDTH="5%"><INPUT TYPE="radio" NAME="leadID" VALUE="#RequestInfoID#"<CFIF #RecCount# EQ 1>CHECKED</cfif>></TD>
								<TD WIDTH="40%">#LName#, #FName#</TD>
								<TD WIDTH="40%">#Description#</TD>
								<TD WIDTH="20%">#DateFormat(WhenSubmitted, "mm/dd/yyyy")#</TD>
							</TR>
						</CFOUTPUT>
						<TR>
							<TD COLSPAN="4">&nbsp;</TD>
						</TR>
						<TR ALIGN="center">
							<TD COLSPAN="4">
							<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0">
								<TR>
									<TD COLSPAN="3" ALIGN="center">page&nbsp;<CFOUTPUT>#page#</CFOUTPUT>&nbsp;of&nbsp;<CFOUTPUT>#pageCount#</CFOUTPUT></TD>
								</TR>
								<TR VALIGN="top">
									<TD ALIGN="right" WIDTH="50%"><TT>
									<CFSETTING ENABLECFOUTPUTONLY="YES">
										<CFIF #page# GT 1>
											<CFOUTPUT><A HREF="#location#&FuseAction=jump&page=#Evaluate(page - 1)#">previous</A>&nbsp;|&nbsp;</CFOUTPUT>
										<CFELSE>
											<CFOUTPUT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</CFOUTPUT>
										</CFIF>
									<CFSETTING ENABLECFOUTPUTONLY="NO">
									</TT></TD>
									<TD ALIGN="center"><TT>
									<CFSETTING ENABLECFOUTPUTONLY="YES">
										<CFIF #pageCount# GT 1>
<!--- 											<CFMODULE TEMPLATE="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/templates/util/jumpmenu.cfm" --->
											<CFMODULE TEMPLATE="../../../util/jumpmenu.cfm"
													beginPage="1"
													endPage="#pageCount#"
													currentPage="#page#"
													maxJumps="#MAX_JUMPS#"
													location="#location#">
										<CFELSE>
											&nbsp;
										</CFIF>
									<CFSETTING ENABLECFOUTPUTONLY="NO">
									</TT></TD>
									<TD ALIGN="left" WIDTH="50%"><TT>
									<CFSETTING ENABLECFOUTPUTONLY="YES">
										<CFIF page LT pageCount>
											<CFOUTPUT>|&nbsp;<A HREF="#location#&FuseAction=jump&page=#Evaluate(page + 1)#">next</A></CFOUTPUT>
										<CFELSE>
											<CFOUTPUT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</CFOUTPUT>
										</CFIF>
									<CFSETTING ENABLECFOUTPUTONLY="NO">
									</TT></TD>
								</TR>
							</TABLE>
							</TD>
						</TR>
						<TR>
							<TD>&nbsp;</TD>
						</TR>
						<TR ALIGN="center">
							<TD COLSPAN="4">
							<INPUT TYPE="image" src="<CFOUTPUT>#g_relpath#</CFOUTPUT>/images/admin/back.jpg" BORDER="0" NAME="btnBack">
							<INPUT TYPE="Image" src="<CFOUTPUT>#g_relpath#</CFOUTPUT>/images/admin/showreport.jpg" BORDER="0" NAME="btnShowLeadDetail"></TD>
						</TR>
						<TR>
							<TD COLSPAN="4">&nbsp;</TD>
						</TR>
					<CFELSE>
						<TR ALIGN="center">
							<TD>No leads</TD>
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
			</TABLE>
			</TD>
		</TR>
		
	<!--- footer.htm closes out all tags header.cfm opened --->
	<CFMODULE template="..\footer.cfm" isRedirectable=TRUE>
</HTML>
<CFSETTING ENABLECFOUTPUTONLY="YES">