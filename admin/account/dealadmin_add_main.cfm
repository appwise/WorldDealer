   <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 14, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
	<!--- $Id: dealadmin_add_main.cfm,v 1.6 2000/05/18 23:53:07 lswanson Exp $ --->
	
<div align="center">

<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0>
	<TR>
		<TD>&nbsp;<p></TD>
	</TR>
	<TR ALIGN="center">
		<TD ALIGN="CENTER"><h3><font face="Arial,Helvetica">Dealer Administrator Maintenance</font></h3></TD>
	</TR>
	<TR ALIGN="center">
		<TD ALIGN="CENTER"><FONT FACE="Arial,Helvetica">Use the fields provided to make changes to a Dealer Administrator.  Required fields are bolded.</font></td>
	</TR>
	<TR>
		<TD>&nbsp;<p></TD>
	</TR>
	<TR>
		<TD>
			<CFFORM NAME="AddInfo" ACTION="dealadmin_choose.cfm" ENABLECAB="Yes">
				<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0 WIDTH="90%">
					<TR>
						<TD ALIGN="right"><b><font face="Arial,Helvetica">Name</font></b></TD>
						<TD>&nbsp;&nbsp;&nbsp;</TD>
						<TD>
							<INPUT TYPE=text NAME="Name" SIZE=30 MAXLENGTH=50>
							<INPUT TYPE="hidden" NAME="Name_required" VALUE="A name must be entered in the Name field">
						</TD>
					</TR>
					<TR>
						<TD ALIGN="right"><b><font face="Arial, Helvetica">Login ID</font></b></TD>
						<TD>&nbsp;&nbsp;&nbsp;</TD>
						<TD>
							<INPUT TYPE=text NAME="LoginID" SIZE="30" MAXLENGTH="15">
							<input type="hidden" name="loginid_required" value="You must enter a LoginID">
						</TD>
					</TR>
					<TR>
						<TD ALIGN="right"><b><font face="Arial, Helvetica">Password</font></b></TD>
						<TD>&nbsp;&nbsp;&nbsp;</TD>
						<TD>
							<INPUT TYPE=text NAME="Password" SIZE="30" MAXLENGTH="15">
							<input type="hidden" name="password_required" value="You must enter a password">
						</TD>
					</TR>
					<TR>
						<TD>&nbsp;<p></TD>
					</TR>
				</TABLE>
			</TD>
		</TR>
		<TR ALIGN="center">
			<TD>
				<INPUT TYPE="image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next.gif" NAME="ADD" VALUE="NEXT" BORDER="0">
				</CFFORM>
				<FORM ACTION="dealadmin.cfm" METHOD="POST">
					<INPUT TYPE="image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel.gif" NAME="CANCEL" VALUE="CANCEL" BORDER="0">
				</FORM>
		</TD>
	</TR>
</TABLE>

</div>