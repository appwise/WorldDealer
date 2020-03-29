                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <February 25, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!--- $Id: makemodel_edit_main.cfm,v 1.6 2000/05/18 23:53:08 lswanson Exp $ --->
<!--- Maintain Makes --->

<cfif isdefined("Form.Save.X")>
	<!----- update existing manuf data----->
	<cfquery name="updMake" datasource="#gDSN#">
		UPDATE 	Makes
		SET		MakeName = '#Form.MakeName#',
				WebAddr = '#Form.WebAddr#',
				ManufAdv = '#Form.ManufAdv#',
				LeasevsBuy = '#Form.LeasevsBuy#'
		WHERE	MakeNumber = #Form.MakeNumber#
	</cfquery>	
	<cflocation url="makemodel.cfm" addtoken="no">
<cfelseif isdefined("Form.Save_New.X")>
	<!--- Manually increment the MakeNumber --->
	<cfquery name="findMaxMakeNum" datasource="#gDSN#">
		SELECT MAX(MakeNumber) as MaxNum
		FROM Makes
	</cfquery>
	<cfquery name="newMake" datasource="#gDSN#">
		INSERT INTO Makes (MakeNumber, MakeName, WebAddr, ManufAdv, LeasevsBuy)
		VALUES (#findMaxMakeNum.MaxNum# +1, '#Form.MakeName#', '#Form.WebAddr#', '#Form.ManufAdv#', '#Form.LeasevsBuy#')
	</cfquery>
	<cflocation url="makemodel.cfm" addtoken="no">
</cfif>

<cfif isdefined("url.make")>
	<!--- get updated Make record --->
	<cfquery name="getMake" datasource="#gDSN#">
		SELECT 	*
		FROM	Makes
		WHERE	MakeNumber = #url.make#
	</cfquery>
	
	<cfset editmode = "true">
<cfelse>
	<cfset editmode = "false">
</cfif>
	
<!--- Edit Make data --->
<cfoutput>
<form name="add_r_edit" action="makemodel_edit.cfm" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="5">
<!--- Make logo --->
<cfif editmode>
	<tr align="center">
		<td colspan="2">
			<img src="#application.RELATIVE_PATH#/images/make_logo/#getMake.MakeNumber#.gif" border=0 alt="#getMake.MakeName# Logo">
		</td>
	</tr>
</cfif>
<tr>
	<td><b>Manufacturer:</b></td>
	<td>
		<input type="text" name="MakeName" size="25" maxlength="50" value="<cfif editMode>#getMake.MakeName#</cfif>">
		<input type="hidden" name="MakeName_required" value="Please enter a manufacturer name.">
		<input type="hidden" name="MakeNumber" value="<cfif editMode>#getMake.MakeNumber#</cfif>">
	</td>
</tr>
<tr>
	<td><b>Web Address:</b></td>
	<td>
		<input type="text" name="WebAddr" size="25" maxlength="50" value="<cfif editMode>#getMake.WebAddr#</cfif>">
		<input type="hidden" name="WebAddr_required" value="Please enter the manufacturer's web address.">
	</td>
</tr>
<tr>
	<td colspan="2"><b>Manufacturer's Advantage:</b></td>
</tr>
<tr>
	<td colspan="2" align="CENTER">
		<textarea name="ManufAdv" cols="40" rows="10" wrap="PHYSICAL"><cfif editmode>#getMake.ManufAdv#</cfif></textarea>
	</td>	
</tr>
<tr>
	<td colspan="2"><b>Lease vs. Buy:</b></td>
</tr>
<tr>
	<td colspan="2" align="CENTER">
		<textarea name="LeasevsBuy" cols="40" rows="10" wrap="PHYSICAL"><cfif editmode>#getMake.LeasevsBuy#</cfif></textarea>
	</td>	
</tr>
<!--- Save button --->		
<tr align="center">
	<td colspan="2">
	<cfif editmode>
		<input type="Image" src="#application.RELATIVE_PATH#/images/admin/save.gif" name="Save" value="Save" border="0">
	<cfelse>
		<input type="Image" src="#application.RELATIVE_PATH#/images/admin/save.gif" name="Save_New" value="Save" border="0">
	</cfif>
	&nbsp;&nbsp;<a href="javascript:history.back()"><img src="#application.RELATIVE_PATH#/images/admin/cancel.gif" border="0"></a>
	</td>
</tr>
</table>
</form>
</cfoutput>
