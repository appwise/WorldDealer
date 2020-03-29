                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 14, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: arttemp_edit_main.cfm,v 1.3 2000/06/19 14:46:51 jkrauss Exp $--->
<!--- Art Template Default Settings --->

<cfset editmode = "false">
<cfset newmode = "false">

<cfif parameterexists(url.arttempid)>
	<cfset editmode = "true">
<cfelse>
	<cfset newmode = "true">
</cfif>

<cfif editmode>
	<cfquery name="getTemplate" datasource="#gDSN#">
		SELECT *
		FROM artTemplates
		WHERE artTempID = #URL.arttempid#
	</cfquery>
<cfelse>
	<cfquery name="getTemplate" datasource="#gDSN#">
		SELECT MAX(ArtTempID) as number
		FROM ArtTemplates
	</cfquery>	
	<cfset ArtTempID = #getTemplate.number# + 1>
</cfif>

&nbsp;<br>&nbsp;
<div align="center">
<table border="0" cellspacing="0" cellpadding="0">
<tr>
	<td align="CENTER" valign="TOP">
	<form action="arttemp_save.cfm" method="POST">
		<table border="0" cellspacing="0" cellpadding="2">
		<cfoutput query="getTemplate">
		<cfif FileExists("#g_rootdir#\images\admin\tmp_#arttempid#_sp_sm.gif")>
			<tr>
				<td colspan="3" align="CENTER">
				<img src="#application.RELATIVE_PATH#/images/admin/tmp_#arttempid#_sp_sm.gif" border=1>&nbsp;&nbsp;
				<img src="#application.RELATIVE_PATH#/images/admin/tmp_#arttempid#_in_sm.gif" border=1>
				</td>
			</tr>
		</cfif>
		<tr>
			<td align="RIGHT">Template Name:</td>
			<td width="5">&nbsp;</td>
			<td><input type="Text" name="description" value="<cfif editmode>#description#</cfif>" size="15"></td>
		</tr>
		<tr>
			<td align="RIGHT">Template ID:</td>
			<td width="5">&nbsp;</td>
			<td>#arttempID#<input type="Hidden" name="arttempid" value="#arttempid#"></td>
		</tr>
		<!--- all this code is not used...the body defaults are set in the global_##.cfm pages.  set the text and colors there
		<tr bgcolor="##FCCA00">
			<td colspan="3"><b>Body</b></td>
		</tr>
		<tr>
			<td align="RIGHT">Font:</td>
			<td width="5">&nbsp;</td>
			<td>
				<select name="FontName">
					<option value="Times New Roman,Serif"<cfif editmode><cfif #FontName# contains "Times"> selected</cfif></cfif>>Times New Roman
					<option value="Arial,Helvetica,Sans Serif"<cfif editmode><cfif #FontName# contains "Arial"> selected</cfif><cfelse> selected</cfif>>Arial, Helvetica
				</select>
			</td>
		</tr>
		<tr>
			<td align="RIGHT">Font Style:</td>
			<td width="5">&nbsp;</td>
			<td>
				<select name="FontStyle">
					<option value="Plain"<cfif editmode><cfif #FontStyle# eq "Plain"> selected</cfif><cfelse> selected</cfif>>Plain
					<option value="Bold"<cfif editmode><cfif #FontStyle# eq "Bold"> selected</cfif></cfif>>Bold
					<option value="Italic"<cfif editmode><cfif #FontStyle# eq "Italic"> selected</cfif></cfif>>Italic
				</select>
			</td>
		</tr>
		<tr>
			<td align="RIGHT">Font Color:</td>
			<td width="5">&nbsp;</td>
			<td>
				<select name="FontColor">
					<option value="black"<cfif editmode><cfif #FontColor# eq "black"> selected</cfif><cfelse> selected</cfif>>Black
					<option value="cyan"<cfif editmode><cfif #FontColor# eq "cyan"> selected</cfif></cfif>>Cyan
					<option value="darkGray"<cfif editmode><cfif #FontColor# eq "darkGray"> selected</cfif></cfif>>Dark Gray
					<option value="gray"<cfif editmode><cfif #FontColor# eq "gray"> selected</cfif></cfif>>Gray
					<option value="lightGray"<cfif editmode><cfif #FontColor# eq "lightGray"> selected</cfif></cfif>>Silver
					<option value="magenta"<cfif editmode><cfif #FontColor# eq "magenta"> selected</cfif></cfif>>Magenta
					<option value="orange"<cfif editmode><cfif #FontColor# eq "orange"> selected</cfif></cfif>>Orange
					<option value="pink"<cfif editmode><cfif #FontColor# eq "pink"> selected</cfif></cfif>>Pink
					<option value="red"<cfif editmode><cfif #FontColor# eq "red"> selected</cfif></cfif>>Red
					<option value="white"<cfif editmode><cfif #FontColor# eq "white"> selected</cfif></cfif>>White
					<option value="yellow"<cfif editmode><cfif #FontColor# eq "yellow"> selected</cfif></cfif>>Yellow
				</select>
			</td>
		</tr> --->
		<tr bgcolor="##FCCA00">
			<td colspan="3"><b>Logo Defaults</b></td>
		</tr>
		<tr>
			<td align="RIGHT">Logo Font:</td>
			<td width="5">&nbsp;</td>
			<td>
				<select name="FontName">
					<option value="Serif"<cfif editmode><cfif #FontName# eq "Serif"> selected</cfif></cfif>>Times Roman
					<option value="SansSerif"<cfif editmode><cfif #FontName# eq "SansSerif"> selected</cfif><cfelse> selected</cfif>>Helvetica
					<option value="Monospaced"<cfif editmode><cfif #FontName# eq "Monospaced"> selected</cfif></cfif>>Courier
				</select>
			</td>
		</tr>
		<tr>
			<td colspan="3"><b>Splash Logo</b></td>
		</tr>
		<cfif FileExists("#g_rootdir#\images\blank_logos\f_sp_x_#arttempid#_hea.gif")>
			<tr>
				<td colspan="3" align="CENTER"><img src="#application.RELATIVE_PATH#/images/blank_logos/f_sp_x_#arttempid#_hea.gif" border=1></td>
			</tr>
		</cfif>
		<tr>
			<td align="RIGHT">Text Box Top Left:</td>
			<td width="5">&nbsp;</td>
			<td><input type="Text" name="sp_textboundsx" size="3" maxlength="3" value="<cfif editmode>#sp_textboundsx#</cfif>">, <input type="Text" name="sp_textboundsy" size="3" maxlength="3" value="<cfif editmode>#sp_textboundsy#</cfif>"></td>
		</tr>
		<tr>
			<td align="RIGHT">Text Box Width:</td>
			<td width="5">&nbsp;</td>
			<td><input type="Text" name="sp_textboundswidth" size="3" maxlength="3" value="<cfif editmode>#sp_textboundswidth#</cfif>"></td>
		</tr>
		<tr>
			<td align="RIGHT">Text Box Height:</td>
			<td width="5">&nbsp;</td>
			<td><input type="Text" name="sp_textboundsheight" size="3" maxlength="3" value="<cfif editmode>#sp_textboundsheight#</cfif>"></td>
		</tr>
		<tr>
			<td align="RIGHT">Font Size:</td>
			<td width="5">&nbsp;</td>
			<td>
				<select name="sp_fontsize">
				<cfloop index="num" from="12" to="28" step="2">
					<option value = #num# <cfif editmode><cfif sp_fontsize eq #num#>selected</cfif></cfif>>#num#
				</cfloop>
				</select>
			</td>
		</tr>
		<tr>
			<td align="RIGHT">Font Style:</td>
			<td width="5">&nbsp;</td>
			<td>
				<select name="sp_FontStyle">
					<option value="Plain"<cfif editmode><cfif #sp_FontStyle# eq "Plain"> selected</cfif><cfelse> selected</cfif>>Plain
					<option value="Bold"<cfif editmode><cfif #sp_FontStyle# eq "Bold"> selected</cfif></cfif>>Bold
					<option value="Italic"<cfif editmode><cfif #sp_FontStyle# eq "Italic"> selected</cfif></cfif>>Italic
				</select>
			</td>
		</tr>
		<tr>
			<td align="RIGHT">Text Color:</td>
			<td width="5">&nbsp;</td>
			<td>
				<select name="sp_textcolor">
					<option value="Black"<cfif editmode><cfif #sp_textcolor# eq "Black"> selected</cfif><cfelse> selected</cfif>>Black
					<option value="Cyan"<cfif editmode><cfif #sp_textcolor# eq "Cyan"> selected</cfif></cfif>>Cyan
					<option value="DarkGray"<cfif editmode><cfif #sp_textcolor# eq "DarkGray"> selected</cfif></cfif>>Dark Gray
					<option value="Gray"<cfif editmode><cfif #sp_textcolor# eq "Gray"> selected</cfif></cfif>>Gray
					<option value="LightGray"<cfif editmode><cfif #sp_textcolor# eq "LightGray"> selected</cfif></cfif>>Silver
					<option value="Magenta"<cfif editmode><cfif #sp_textcolor# eq "Magenta"> selected</cfif></cfif>>Magenta
					<option value="Orange"<cfif editmode><cfif #sp_textcolor# eq "Orange"> selected</cfif></cfif>>Orange
					<option value="Pink"<cfif editmode><cfif #sp_textcolor# eq "Pink"> selected</cfif></cfif>>Pink
					<option value="Red"<cfif editmode><cfif #sp_textcolor# eq "Red"> selected</cfif></cfif>>Red
					<option value="White"<cfif editmode><cfif #sp_textcolor# eq "White"> selected</cfif></cfif>>White
					<option value="Yellow"<cfif editmode><cfif #sp_textcolor# eq "Yellow"> selected</cfif></cfif>>Yellow
				</select>
			</td>
		</tr>
		<tr>
			<td align="RIGHT">Font Alignment:</td>
			<td width="5">&nbsp;</td>
			<td>
				<select name="sp_textAlign">
					<option value="Centered"<cfif editmode><cfif #sp_textAlign# eq "Centered"> selected</cfif><cfelse> selected</cfif>>Centered
					<option value="Left"<cfif editmode><cfif #sp_textAlign# eq "Left"> selected</cfif></cfif>>Left
					<option value="Right"<cfif editmode><cfif #sp_textAlign# eq "Right"> selected</cfif></cfif>>Right
				</select>
			</td>
		</tr>
		<tr>
			<td colspan="3"><b>Inside Pages Logo</b></td>
		</tr>
		<cfif FileExists("#g_rootdir#\images\blank_logos\f_x_#arttempid#_logo_hea.gif")>
			<tr>
				<td colspan="3" align="CENTER"><img src="#application.RELATIVE_PATH#/images/blank_logos/f_x_#arttempid#_logo_hea.gif" border=1></td>
			</tr>
		</cfif>
		<tr>
			<td align="RIGHT">Text Box Top Left:</td>
			<td width="5">&nbsp;</td>
			<td><input type="Text" name="logo_textboundsx" size="3" maxlength="3" value="<cfif editmode>#logo_textboundsx#</cfif>">, <input type="Text" name="logo_textboundsy" size="3" maxlength="3" value="<cfif editmode>#logo_textboundsy#</cfif>"></td>
		</tr>
		<tr>
			<td align="RIGHT">Text Box Width:</td>
			<td width="5">&nbsp;</td>
			<td><input type="Text" name="logo_textboundswidth" size="3" maxlength="3" value="<cfif editmode>#logo_textboundswidth#</cfif>"></td>
		</tr>
		<tr>
			<td align="RIGHT">Text Box Height:</td>
			<td width="5">&nbsp;</td>
			<td><input type="Text" name="logo_textboundsheight" size="3" maxlength="3" value="<cfif editmode>#logo_textboundsheight#</cfif>"></td>
		</tr>
		<tr>
			<td align="RIGHT">Font Size:</td>
			<td width="5">&nbsp;</td>
			<td>
				<select name="logo_fontsize">
				<cfloop index="num" from="12" to="28" step="2">
					<option value = #num# <cfif editmode><cfif logo_fontsize eq #num#>selected</cfif></cfif>>#num#
				</cfloop>
				</select>
			</td>
		</tr>
		<tr>
			<td align="RIGHT">Font Style:</td>
			<td width="5">&nbsp;</td>
			<td>
				<select name="logo_FontStyle">
					<option value="Plain"<cfif editmode><cfif #logo_FontStyle# eq "Plain"> selected</cfif><cfelse> selected</cfif>>Plain
					<option value="Bold"<cfif editmode><cfif #logo_FontStyle# eq "Bold"> selected</cfif></cfif>>Bold
					<option value="Italic"<cfif editmode><cfif #logo_FontStyle# eq "Italic"> selected</cfif></cfif>>Italic
				</select>
			</td>
		</tr>
		<tr>
			<td align="RIGHT">Text Color:</td>
			<td width="5">&nbsp;</td>
			<td>
				<select name="logo_textcolor">
					<option value="Black"<cfif editmode><cfif #logo_textcolor# eq "Black"> selected</cfif><cfelse> selected</cfif>>Black
					<option value="Cyan"<cfif editmode><cfif #logo_textcolor# eq "Cyan"> selected</cfif></cfif>>Cyan
					<option value="DarkGray"<cfif editmode><cfif #logo_textcolor# eq "DarkGray"> selected</cfif></cfif>>Dark Gray
					<option value="Gray"<cfif editmode><cfif #logo_textcolor# eq "Gray"> selected</cfif></cfif>>Gray
					<option value="LightGray"<cfif editmode><cfif #logo_textcolor# eq "LightGray"> selected</cfif></cfif>>Silver
					<option value="Magenta"<cfif editmode><cfif #logo_textcolor# eq "Magenta"> selected</cfif></cfif>>Magenta
					<option value="Orange"<cfif editmode><cfif #logo_textcolor# eq "Orange"> selected</cfif></cfif>>Orange
					<option value="Pink"<cfif editmode><cfif #logo_textcolor# eq "Pink"> selected</cfif></cfif>>Pink
					<option value="Red"<cfif editmode><cfif #logo_textcolor# eq "Red"> selected</cfif></cfif>>Red
					<option value="White"<cfif editmode><cfif #logo_textcolor# eq "White"> selected</cfif></cfif>>White
					<option value="Yellow"<cfif editmode><cfif #logo_textcolor# eq "Yellow"> selected</cfif></cfif>>Yellow
				</select>
			</td>
		</tr>
		<tr>
			<td align="RIGHT">Font Alignment:</td>
			<td width="5">&nbsp;</td>
			<td>
				<select name="logo_textAlign">
					<option value="Centered"<cfif editmode><cfif #logo_textAlign# eq "Centered"> selected</cfif><cfelse> selected</cfif>>Centered
					<option value="Left"<cfif editmode><cfif #logo_textAlign# eq "Left"> selected</cfif></cfif>>Left
					<option value="Right"<cfif editmode><cfif #logo_textAlign# eq "Right"> selected</cfif></cfif>>Right
				</select>
			</td>
		</tr>
		<tr bgcolor="##FCCA00">
			<td colspan="3"><b>Coupon Defaults</b></td>
		</tr>
		<cfif FileExists("#g_rootdir#\images\blank_coupons\f_#arttempid#_dlr_coupon_blank.gif")>
			<tr>
				<td colspan="3" align="CENTER"><img src="#application.RELATIVE_PATH#/images/blank_coupons/f_#arttempid#_dlr_coupon_blank.gif" border=1></td>
			</tr>
		</cfif>
		<tr>
			<td align="RIGHT">Text Box Top Left:</td>
			<td width="5">&nbsp;</td>
			<td><input type="Text" name="coup_textboundsx" size="3" maxlength="3" value="<cfif editmode>#coup_textboundsx#</cfif>">, <input type="Text" name="coup_textboundsy" size="3" maxlength="3" value="<cfif editmode>#coup_textboundsy#</cfif>"></td>
		</tr>
		<tr>
			<td align="RIGHT">Text Box Width:</td>
			<td width="5">&nbsp;</td>
			<td><input type="Text" name="coup_textboundswidth" size="3" maxlength="3" value="<cfif editmode>#coup_textboundswidth#</cfif>"></td>
		</tr>
		<tr>
			<td align="RIGHT">Text Box Height:</td>
			<td width="5">&nbsp;</td>
			<td><input type="Text" name="coup_textboundsheight" size="3" maxlength="3" value="<cfif editmode>#coup_textboundsheight#</cfif>"></td>
		</tr>
		<tr>
			<td colspan="3" align="CENTER"><br>&nbsp;
			<a href="arttemp.cfm"><IMG SRC="#application.RELATIVE_PATH#/images/admin/cancel.gif" NAME="Cancel" border="0"></a>&nbsp;&nbsp;
			<cfif editmode>
				<INPUT TYPE="image" SRC="#application.RELATIVE_PATH#/images/admin/save.gif" NAME="Save" VALUE="Save" border="0">
			<cfelse>
				<INPUT TYPE="image" SRC="#application.RELATIVE_PATH#/images/admin/save.gif" NAME="SaveNew" VALUE="SaveNew" border="0">
			</cfif>
			</td>
		</tr>
		</cfoutput>
		</table>
	</form>
	</td>
</tr>
</table>
</div>
