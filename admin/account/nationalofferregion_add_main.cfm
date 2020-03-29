<!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 14, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: nationalofferregion_add_main.cfm,v 1.4 2000/05/18 23:53:08 lswanson Exp $--->

<table align="center" border="0" cellspacing="0" cellpadding="0">
<form name="insertmake" action="nationalofferregion_add_save.cfm" method="post">	
	<tr>	
		<td>
			<h4>Please type in the name of the region you would like to add.</h4>		
		</td>
	</tr>
	<tr>	
		<td>
			<input type="text" name="RegionName" size=25 maxlength=50>
			<input type="hidden" name="makenumber" value="<cfoutput>#URL.makenumber#</cfoutput>">
		</td>
	</tr>
	<tr>
		<td align="center">
			<br><input type="image" src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/save.gif" name="save" value="save" BORDER="0">
		</td>
	</tr>	
	</form>
</table>		