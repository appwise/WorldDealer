  <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <February 8, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
	<!--- $Id: dealadmin_choose_main.cfm,v 1.5 2000/05/18 23:53:07 lswanson Exp $ --->


<!--- If not Sys Admin, forward to loadDA_dchoose2 --->
<CFIF #Left(AccessLevel,1)# LT application.SYSADMIN_ACCESS>
	<CFLOCATION url="dealadmin_choose2.cfm">
</CFIF>

<CFSET OK = 0>   <!--- Originally we'll set this to 'BAD' because we need to set it to something --->

<!--- See how many logins there are of the same name --->
<CFQUERY NAME="CheckLoginID" datasource="#gDSN#">
	SELECT Count(LoginID) As NumOfLogins
	FROM   Accounts
	WHERE  LoginID = '#Form.LoginID#'
</CFQUERY>

<!--- If there is one of the same name, and we are editing a dealer administrator, then we have to see --->
<!--- if we are keeping the name the same, or if there really is one account with the same name. --->
<CFIF ((CheckLoginID.NumOfLogins EQ 1) AND (ParameterExists(Form.EDIT.X)))>
	<CFQUERY NAME="CheckRowID" datasource="#gDSN#">
		SELECT RowID
		FROM   Accounts
		WHERE  LoginID = '#Form.LoginID#'
	</CFQUERY>
	<CFIF CheckRowID.RowID EQ Form.RowID>
		<CFSET OK = 1>   <!--- GOOD --->
	<CFELSE>
		<CFSET OK = 0>   <!--- BAD --->
	</CFIF>
</CFIF>

<CFIF ((CheckLoginID.NumOfLogins EQ 0) OR (OK EQ 1))>
	<!--- this query gets all dealerships.  unable to filter out based on Mid(dealercode) = '0000' within SQL, so have to get all & filter out later when used --->
	<CFQUERY NAME="getCollections" datasource="#gDSN#">
		SELECT	Dealercode, DealershipName
 		FROM Dealers
		ORDER BY DealershipName
	</CFQUERY>

	<CFSET OK = 1>
</CFIF>

<div align="center">
<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=420 BGCOLOR="FFFFFF">
<TR><TD>&nbsp;<p></TD></TR>

<TR ALIGN="center">
	<TD ALIGN="middle"><h3><FONT FACE="Arial,Helvetica">Maintain Dealer Administrator List</FONT></h3></TD>
</TR>

<CFIF OK EQ 1> 
	<TR ALIGN="center">
		<TD ALIGN="middle"><FONT FACE="Arial,Helvetica">Select a collection from the list below.</FONT></TD>
	</TR>

	<!--- Drop-down list of collections --->
	<TR><TD>&nbsp;<p></TD></TR>
	<TR>
		<TD>
			<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0 WIDTH="100%">
			<FORM NAME="Find1" ACTION="dealadmin_choose2.cfm" METHOD="post">
			<TR>
				<TD ALIGN="right"><b><font face="Arial,Helvetica">Choose a Collection:</font></b></TD>
				<TD>&nbsp;&nbsp;&nbsp;</TD>
				<TD>
					<SELECT NAME="Collection">
					<OPTION VALUE="0000">Dealership Not In A Collection
					<CFOUTPUT QUERY="getCollections">
					<!--- just get collections (where dealer # is 0000) --->
					<CFIF Mid(#Dealercode#, 6, 4) IS '0000'>
						<OPTION VALUE="#Left(Dealercode, 4)#">#DealershipName#
					</CFIF>
					</CFOUTPUT>
					</SELECT>
	 			</TD>
	 		</TR>
			<TR><TD COLSPAN=3>&nbsp;<p></TD></TR>
			<TR ALIGN=center>
  				<TD COLSPAN=3><INPUT TYPE="image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next.gif" Border="0" NAME="btnFind1" VALUE="GO!"></TD>
			</TR>
		
			<CFIF ParameterExists(Form.EDIT.X)>
				<CFOUTPUT>
				<INPUT TYPE="HIDDEN" NAME="RowID" VALUE="#Form.RowID#">
				<INPUT TYPE="hidden" NAME="edit" value="edit">
				</CFOUTPUT>
			</CFIF>
			<CFIF #ParameterExists(Form.Name)#>
				<CFOUTPUT>
				<INPUT TYPE="HIDDEN" NAME="Name" VALUE="#Form.Name#">
				<INPUT TYPE="HIDDEN" NAME="LoginID" VALUE="#Form.LoginID#">
				<INPUT TYPE="HIDDEN" NAME="Password" VALUE="#Form.Password#">
				</CFOUTPUT>
			</CFIF>

			</FORM>
			</TABLE>
		</TD>
	</TR>
<CFELSE>
	<TR ALIGN="CENTER"><TD>Sorry, somebody has already chosen that ID.</TD></TR>
</CFIF>
<TR><TD>&nbsp;<p></TD></TR>
<TR ALIGN=CENTER>
	<TD>
		<FORM ACTION="dealadmin.cfm" METHOD="POST">
		<INPUT TYPE="image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel.gif" VALUE="CANCEL" NAME="CANCEL" BORDER="0">
		</FORM>
	</TD>
</TR>

<!--- "Back to Main Menu" button--->
<TR ALIGN="center">
	<TD>
		<p>
		<FORM NAME="f_Back" ACTION="dealadmin.cfm" METHOD="post">
		<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/back.gif" Border="0" NAME="BackToMain" VALUE="Back To Main Menu">
		</FORM>
	</TD>
</TR>
</TABLE>

</div>