<CFSETTING ENABLECFOUTPUTONLY="NO">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
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
<!--- $Id: default.cfm,v 1.5 1999/12/15 23:53:31 lswanson Exp $ --->

<!---
default.cfm - default lead screen, there's been an error
--->

<!--- header.cfm sets up a table already --->
<CFMODULE template="..\header.cfm"
		windowTitle="Dealer Administration, Lead Reporting"
		screenTitle="Lead Reporting Error">
		<TR ALIGN="center">
			<TD>
			<TABLE BORDER="0" CELLPADDING="1" CELLSPACING="0">
				<TR>
					<TD>
						There was an error while using Lead Reporting
					</TD>
				</TR>
			</TABLE>
			</TD>
		</TR>

	<!--- footer.htm closes out all tags header.cfm opened --->
	<CFMODULE template="..\footer.cfm" isRedirectable=TRUE>
</HTML>
<CFSETTING ENABLECFOUTPUTONLY="YES">