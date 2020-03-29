<!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 14, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: acccoord_main.cfm,v 1.4 2000/05/18 23:53:07 lswanson Exp $ --->
<!--- Account Coord --->

<CFQUERY NAME="getACs" datasource="#gDSN#">
	SELECT ACID as lq_ACID,
	FirstName as lq_ACFirstName,
	LastName as lq_ACLastName,
	EMail as lq_EMail
	FROM AccountCoordinators
	ORDER BY LastName, FirstName
</CFQUERY>

<div align="center">

<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=520 BGCOLOR="FFFFFF">
	<TR>
		<TD>&nbsp;<p></TD>
	</TR>
	<TR ALIGN="center">
		<TD ALIGN="middle"><h3><FONT FACE="Arial,Helvetica">Dealer Administration<br>Maintain Account Coordinators List</FONT></h3></TD>
	</TR>
	<TR ALIGN="center">
		<TD ALIGN="middle"><FONT FACE="Arial,Helvetica">Select an Account Coordinator to Edit or Delete, or select Add Account Coordinator to add an Account Coordinator. Required fields are bolded.</FONT></TD>
	</TR>
	<TR>
		<TD>&nbsp;<p></TD>
	</TR>
	<TR>
		<TD>
			<CFFORM NAME="FormOne" ACTION="acccoord_edit.cfm" ENABLECAB="Yes">
			<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0 WIDTH="90%">
				<TR>
					<TD ALIGN="right"><b><font face="Arial,Helvetica">Account<br>Coordinators</font></b></TD>
					<TD>&nbsp;&nbsp;&nbsp;</TD>
					<TD><SELECT NAME="AccountCoordinator">
						<OPTION VALUE="">
						<CFOUTPUT QUERY="getACs">
						<CFIF lq_ACLastName IS NOT " ">
							<CFSET tmp_Name=Trim(#lq_ACLastName#) & ', ' & Trim(#lq_ACFirstName#)>
							<OPTION VALUE="#lq_ACID#">#tmp_Name#
							<CFSET tmp_Name="">
						</CFIF>
						</CFOUTPUT>
						</SELECT>
						<INPUT TYPE="hidden" NAME="AccountCoordinator_required">
					</TD>
				</TR>
			</TABLE>
		</TD>
	</TR>
	<TR>
		<TD>&nbsp;</TD>
	</TR>
	<TR ALIGN="center">
		<TD>
			<INPUT TYPE="image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/modify.gif" VALUE="Modify" NAME="EDIT" BORDER="0">
			&nbsp;&nbsp;&nbsp;
			<input type="image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/deletebutton.gif" value="DELETE" name="DELETE" BORDER="0">
			<P>
			</CFFORM>
			<form name="addacinfo" action="acccoord_add.cfm" method="post">
				<input type="image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/add.gif" border="0" name="Add" value="Add Account Exec">
			</form>
			<p>
			<form name="f_Back" action="accstaff.cfm" method="post">
				<INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/back.gif"
			Border="0"
			NAME="BackToMain"
			VALUE="Back To Main Menu">
			</form>
		</TD>
	</TR>
</TABLE>
</div>