   <!-- ----------------------------------------------------------- -->
   <!--           Created for WorldDealer by Sigma6, Inc.           -->
   <!--     Copyright (c) 1998, 1999 WorldDealer and Sigma6, Inc.   -->
   <!--         All Rights Reserved.  Used By Permission.           -->
   <!-- ----------------------------------------------------------- -->
   <!-- ----------------------------------------------------------- -->
   <!--           Sigma6, interactive media, Detroit/NYC            -->
   <!--               conceive : construct : connect                -->
   <!--   www.sigma6.com   webmaster@sigma6.com   info@sigma6.com   -->
   <!--                                                             -->
   <!--   Last updated: January 6, 1999                             -->
   <!-- ----------------------------------------------------------- -->
   <!--     Linda Swanson for sigma6, interactive media, Detroit    -->
   <!--    lswanson@sigma6.com   www.sigma6.com    www.s6313.com    -->
   <!--               conceive : construct : connect                -->
   <!-- ----------------------------------------------------------- -->

   <!-- ----------------------------------------------------------- -->
   <!-- Sigma6, s6, and the Sigma6 logos are registered trademarks. -->
   <!-- All other trademarks and servicemarks are the property of   -->
   <!-- their respective owners.                                    -->
   <!-- ----------------------------------------------------------- -->
	<!--- $Id: dealadmin_choose2_main.cfm,v 1.7 2000/05/18 23:53:07 lswanson Exp $ --->

	<!--- this query gets all dealerships.  unable to filter out based on Mid(dealercode) = '0000' within SQL, so have to get all & filter out later when used --->
	<CFQUERY NAME="getCollections" datasource="#gDSN#">
		SELECT	Dealercode, DealershipName
 		FROM Dealers
			<CFIF Left(AccessLevel, 1) EQ application.ACCOUNT_EXECUTIVE_ACCESS>
				WHERE Dealers.AEID = #RemoveChars(AccessLevel,1,2)#
			<CFELSEIF Left(AccessLevel, 1) EQ application.ACCOUNT_COORDINATOR_ACCESS>
				WHERE Dealers.ACID = #RemoveChars(AccessLevel,1,2)#
			</cfif>
		ORDER BY DealershipName
	</CFQUERY>
	
	<!--- find all the dealerships that AE or AC are assigned to, or if it's 1 dealer, just show that 1 dealership --->
    <CFQUERY NAME="findDLR" datasource="#gDSN#">
		SELECT DealerCode, DealershipName
		FROM Dealers
			<CFIF Left(AccessLevel, 1) EQ application.SYSADMIN_ACCESS>
<!--- 				WHERE Dealers.DealerCode GT '#FORM.Collection#' --->
<!--- 				AND Dealers.DealerCode LT 'IncrementValue(Val(#FORM.Collection#))' --->
<!--- 				AND Dealers.DealerCode LT '#Evaluate(FORM.Collection +1)#' --->
			<CFELSEIF Left(AccessLevel, 1) EQ application.ACCOUNT_EXECUTIVE_ACCESS>
				WHERE Dealers.AEID = #RemoveChars(AccessLevel,1,2)#			
			<CFELSEIF Left(AccessLevel, 1) EQ application.ACCOUNT_COORDINATOR_ACCESS>
				WHERE Dealers.ACID = #RemoveChars(AccessLevel,1,2)#
			<CFELSEIF Left(AccessLevel, 1) EQ application.DEALER_ACCESS>			
				WHERE Dealers.DealerCode = #RemoveChars(AccessLevel,1,2)#			
			</cfif>
 		ORDER BY DealershipName
    </CFQUERY>
	
<div align="center">
<TABLE CELLPADDING=2 CELLSPACING=0 BORDER=0 WIDTH=420 BGCOLOR="FFFFFF">
	    <TR ALIGN="center">
		<TD><h3><FONT FACE="Arial,Helvetica">Dealer Administration</FONT></h3></TD>
    </TR>
	
	<TR align="center">
		<TD><FONT FACE="Arial,Helvetica">Select a dealership to assign to this Dealer Administrator from the list below, then click <B>Next</B>.
		<CFIF Left(AccessLevel, 1) EQ application.SYSADMIN_ACCESS>
			
		</CFIF>
		</FONT></TD>
	</TR>

<!--- Collections drop-down & Next button --->
<CFIF ParameterExists(Form.Collection)>
	<CFIF #Form.Collection# NEQ "0000">			
		
	<TR><TD>&nbsp;<p></TD></TR>		
	 	
	<TR ALIGN="center">
		<CFIF #ParameterExists(Form.EDIT)#>
			<!--- Update DA ---> 
			<FORM NAME="FindColl" ACTION="dealadmin_edit_save.cfm" METHOD="post">
			<INPUT TYPE="hidden" NAME="NextStep" VALUE="dealadmin_edit_save.cfm">		
		<CFELSE>
			<!--- Add DA ---> 
			<FORM NAME="FindColl" ACTION="dealadmin_edit_save.cfm" METHOD="post">
			<INPUT TYPE="hidden" NAME="NextStep" VALUE="">					
		</CFIF>
		<!--- drop-down list of collections ---> 
		<INPUT type="hidden" name="DealerCode_required" value="You must select a collection.">
		<TD>
			<SELECT NAME="DealerCode">
				<CFIF ParameterExists(Form.Collection)>
					<CFIF #Form.Collection# EQ "0000">			
						<OPTION VALUE="0000">Dealership Not In A Collection
					</CFIF>
				</CFIF>
			<CFOUTPUT QUERY="getCollections">
			<!--- just get collections (where dealer # is 0000)---> 
			<CFIF Mid(Dealercode, 6, 4) IS '0000'>
				<!--- if sysadmin, just show collection selected on prev. page---> 
								<CFIF ParameterExists(Form.Collection)>
					<CFIF Left(DealerCode, 4) EQ '#FORM.Collection#'>	
						<OPTION VALUE="#DealerCode#">#DealershipName#
					</CFIF>
				<!--- for dealers, show the parent collection---> 
				<CFELSEIF Left(AccessLevel, 1) EQ application.DEALER_ACCESS>
					<CFIF Left(DealerCode, 4) IS #Mid(AccessLevel,3,4)#>
						<OPTION VALUE="#DealerCode#">#DealershipName#
					</CFIF>
				<cfelse>
					<OPTION VALUE="#DealerCode#">#DealershipName#
				</CFIF>
			</CFIF>
			</CFOUTPUT>
			<CFIF #ParameterExists(Form.Name)#>
				<CFOUTPUT>
				<INPUT TYPE="HIDDEN" NAME="Name" VALUE="#Form.Name#">
				<INPUT TYPE="HIDDEN" NAME="LoginID" VALUE="#Form.LoginID#">
				<INPUT TYPE="HIDDEN" NAME="Password" VALUE="#Form.Password#">
				</CFOUTPUT>
			</CFIF>
			<CFIF ParameterExists(Form.EDIT)>
				<CFOUTPUT>
				<INPUT TYPE="HIDDEN" NAME="RowID" VALUE="#Form.RowID#">
				<INPUT TYPE="hidden" NAME="edit" value="edit">
				</CFOUTPUT>
			</CFIF>
			</SELECT>
 		</TD>
	</TR>
	
	</FORM>	
	</CFIF>
</CFIF>		
<!--- Dealer drop-down & Next button --->
<TR ALIGN="center">
	<TD><h4><font face="Arial,Helvetica">Select Dealer</font></h4></TD>
</TR>

<!--- if dealers were found, display them in drop-down list --->	
<CFIF findDLR.RecordCount GT '0'>

	<CFIF #ParameterExists(Form.EDIT)#>
		<!--- Update DA --->
		<FORM NAME="FindForm2" ACTION="dealadmin_edit_save.cfm" METHOD="post">
		<INPUT TYPE="hidden" NAME="NextStep" VALUE="dealadmin_add_save.cfm">		
	<CFELSE>
		<!--- Add DA --->
		<FORM NAME="FindForm2" ACTION="dealadmin_add_save.cfm" METHOD="post">
		<INPUT TYPE="hidden" NAME="NextStep" VALUE="dealadmin_add_save.cfm">					
	</CFIF>
	<!--- 	<INPUT TYPE="hidden" NAME="NextStep" VALUE="webvrfy.cfm"> OLD: why would you want next to go to webvrfy??--->

	<!--- drop-down list of Dealers --->
	<INPUT type="hidden" name="DealerCode_required" value="You must select a dealer.">
	<TR ALIGN=center>
		<TD>
			<SELECT NAME="DealerCode">
			<CFOUTPUT QUERY="findDLR">
			<!--- if sysadmin, just show dealerships within collection selected on prev. page --->
			<CFIF ParameterExists(Form.Collection)>
				<CFIF Left(DealerCode, 4) EQ '#FORM.Collection#'
					AND Mid(DealerCode, 6, 4) NEQ '0000'>
					<OPTION VALUE="#DealerCode#">#DealershipName# (#DealerCode#)
				</cfif>
			<cfelse>
				<OPTION VALUE="#DealerCode#">#DealershipName# (#DealerCode#)
			</cfif>
			</CFOUTPUT>
			<CFIF #ParameterExists(Form.Name)#>		
				<CFOUTPUT>
				<INPUT TYPE="HIDDEN" NAME="Name" VALUE="#Form.Name#">
				<INPUT TYPE="HIDDEN" NAME="LoginID" VALUE="#Form.LoginID#">
				<INPUT TYPE="HIDDEN" NAME="Password" VALUE="#Form.Password#">
				</CFOUTPUT>
			</CFIF>
			<CFIF ParameterExists(Form.EDIT)>
				<CFOUTPUT>
				<INPUT TYPE="HIDDEN" NAME="RowID" VALUE="#Form.RowID#">
				<INPUT TYPE="hidden" NAME="edit" value="edit">					
				</CFOUTPUT>
			</CFIF>
			</SELECT>
		</TD>
	</TR>
	<!--- "Next" button for Dealers --->
	<TR ALIGN="center">
		<TD>
            <INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next.gif" BORDER="0" NAME="btnNext" VALUE="Next">
		</TD>
	</TR>
	</FORM>
	<p>
	<CFIF Left(AccessLevel, 1) EQ application.SYSADMIN_ACCESS>
		<FORM NAME="f_Back" ACTION="dealadmin_choose.cfm" METHOD="post">		
		<CFIF #ParameterExists(Form.Name)#>			
			<CFOUTPUT>
			<INPUT TYPE="HIDDEN" NAME="Name" VALUE="#Form.Name#">
			<INPUT TYPE="HIDDEN" NAME="LoginID" VALUE="#Form.LoginID#">
			<INPUT TYPE="HIDDEN" NAME="Password" VALUE="#Form.Password#">
			<INPUT TYPE="HIDDEN" NAME="
			</CFOUTPUT>
		</CFIF>
		<CFIF ParameterExists(Form.EDIT)>
			<CFOUTPUT>
			<INPUT TYPE="HIDDEN" NAME="RowID" VALUE="#Form.RowID#">
			<INPUT TYPE="hidden" NAME="edit" value="edit">											
			</CFOUTPUT>
		</CFIF>
		<p>
		</FORM>
	</CFIF>
	<FORM NAME="f_Back" ACTION="dealadmin.cfm" METHOD="post">	
	<TR ALIGN="center">
		<TD>	
			<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/back.gif" Border="0" NAME="BackToMain" VALUE="Back To Main Menu">
		</td>
	</tr>		
	</FORM>
	
<CFELSE>
	<!--- if no dealers were found, error msg --->
	<TR ALIGN="center">
		<TD ALIGN="middle"><h4><font face="Arial,Helvetica">No Dealers were found that are assigned to you.
		Click the 'New' button to return to the search form.</font></h4></TD>
	</TR>
	<TR><TD>&nbsp;<p></TD></TR>
	<FORM NAME="NoDealerFound" ACTION="dealadmin.cfm" METHOD="post">
	</FORM>
<!--- 		<p> --->
	<FORM NAME="f_Back" ACTION="dealadmin_choose.cfm" METHOD="post">		
	<TR>
		<TD>
			<CFIF Left(AccessLevel, 1) EQ application.SYSADMIN_ACCESS>
				<CFIF #ParameterExists(Form.Name)#>		
					<CFOUTPUT>
					<INPUT TYPE="HIDDEN" NAME="Name" VALUE="#Form.Name#">
					<INPUT TYPE="HIDDEN" NAME="LoginID" VALUE="#Form.LoginID#">
					<INPUT TYPE="HIDDEN" NAME="Password" VALUE="#Form.Password#">
					</CFOUTPUT>
				</CFIF>
				<CFIF ParameterExists(Form.EDIT)>
					<CFOUTPUT>
					<INPUT TYPE="HIDDEN" NAME="RowID" VALUE="#Form.RowID#">
					<INPUT TYPE="hidden" NAME="edit" value="edit">											
					</CFOUTPUT>
				</CFIF>
				<!--- <INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/newsearch.jpg" Border="0" NAME="NewSearch"  VALUE="    New Search   "> --->				
    	        <p>
			</CFIF>
		</TD>
	</TR>
	</FORM>
	
	<FORM NAME="f_Back" ACTION="dealadmin.cfm" METHOD="post">	
	<TR ALIGN="center">	
		<TD>	
			<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/back.gif" Border="0" NAME="BackToMain" VALUE="Back To Main Menu">
		</td>
	</TR>
	</FORM>
</CFIF>

</TABLE> 
</div>