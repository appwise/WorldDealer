                         <!--- Created by AppNet, Inc., Detroit
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 11, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->            
                                    <!---$Id: titlebar.cfm,v 1.8 2000/02/05 02:11:28 lswanson Exp $--->
<!--- Linda, 1/18/00: no longer used.  Using the generic titlebar in admin\. --->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr bgcolor="#66666">
	<td width="5">&nbsp;</td>
	<td align="LEFT"><font color="#ffcc00"><b>WorldDealer Account Page</b></font></td>
	<!--- today's date --->
	<td align="RIGHT">
 		<font size=-1 color="ffcc00">
		<cfoutput>
 		#DateFormat(Now(), "mmmm d, yyyy")#
		</cfoutput>
		</font>
	</td>
	<td width="5">&nbsp;</td>
</tr>
<tr bgcolor="888888">
	<td width="5">&nbsp;</td>
	<td>&nbsp;</td>
	<td align="RIGHT">&nbsp;</td>
	<td width="5">&nbsp;</td>
</tr>
</table>
