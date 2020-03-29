<!---
execute query entered in form...very dangerous but no more so than other
administrative features in production

Copyright (c) 1998 Sigma6 Inc.  All rights reserved.
$Id: update.cfm,v 1.5 1999/11/10 00:59:52 jwalker Exp $
--->
<!--- 
sure, it's incredibly insecure, but let's limit the potential damage to
Jacobsons data, only
--->

<CFSET VALID_DATASOURCE_LIST = "jacobsons">
<CFPARAM NAME="w" DEFAULT="0">
<CFPARAM NAME="webID" DEFAULT="#w#">
<CFPARAM NAME="webItemID" DEFAULT="#webID#">
<CFPARAM NAME="m" DEFAULT=" ">
<CFPARAM NAME="maxrows" DEFAULT="#m#">
<CFPARAM NAME="itemCopy" default=" ">
<CFPARAM NAME="itemDesc" default=" ">
<CFPARAM NAME="filename" default=" ">
<CFPARAM NAME="caption" default=" ">
<CFPARAM NAME="largestImageSize" default=" ">
<CFPARAM NAME="IT" default=" ">
<CFPARAM NAME="IM" default=" ">
<CFPARAM NAME="UPDATE" default="NO">

<CFQUERY NAME="getDistinctWebItemIDS" DATASOURCE="jacobsons">
	Select Distinct 
		webItemID 
	from
		tblJproduct 
</CFQUERY>

<CFIF UPDATE EQ 'UPDATE'>
	<CFIF IT eq "nITEM">
		<CFQUERY NAME="UPDATE" datasource="jacobsons">
			INSERT INTO 
				tblItem(webItemID, itemCopy, itemDesc, fileName)
			VALUES
				(#webID#, '#itemCopy#', '#itemDesc#', '#fileName#')
		</CFQUERY>
	<CFELSEIF IT EQ "uITEM">

		<CFQUERY NAME="UPDATE" datasource="jacobsons">
			UPDATE 
				tblItem
			SET
				tblItem.itemCopy = '#itemCopy#',
			    tblItem.itemDesc = '#itemDesc#',
				tblItem.fileName = '#fileName#'
			WHERE
				tblItem.webItemID = #webItemID#
		</CFQUERY>
	<CFELSEIF IT EQ "rITEM">
	<CFQUERY NAME="UPDATE" datasource="jacobsons">
			DELETE FROM 
				tblItem
			WHERE
				tblItem.itemCopy LIKE '#itemCopy#'
			    AND tblItem.itemDesc = '#itemDesc#'			
				AND tblItem.fileName = '#fileName#'
				AND tblItem.webItemID = #webItemID#
		</CFQUERY>
	</CFIF>
	<CFIF IM eq "nIMAGE">

	<CFQUERY NAME="UPDATE" datasource="jacobsons">
			INSERT INTO 
				tblImage(fileName, caption, largestImageSize)
			VALUES
				('#fileName#', '#caption#', #largestImageSize#)
		</CFQUERY>
	<CFELSEIF IM EQ "uIMAGE">

	<CFQUERY NAME="UPDATE" datasource="jacobsons">
			UPDATE 
				tblImage
			SET
				tblImage.caption = '#caption#',
			    tblImage.largestImageSize = #largestImageSize#
			WHERE
				fileName = '#fileName#'
		</CFQUERY>
	<CFELSEIF IM EQ "rIMAGE">
	<CFQUERY NAME="UPDATE" datasource="jacobsons">
			DELETE FROM 
				tblImage
			WHERE
				tblImage.caption = '#caption#'
			    AND tblImage.largestImageSize = #largestImageSize#			
				AND fileName = '#fileName#'
		</CFQUERY>
	
	</CFIF>
</CFIF>
<CFSETTING ENABLECFOUTPUTONLY="NO">

<CFQUERY NAME="gatherItem" DATASOURCE="jacobsons">
		SELECT 
			* 
		FROM 
			tblItem 
		WHERE 
			tblItem.webItemID = #webID# 			
	</CFQUERY>
<CFQUERY NAME="gatherImage" DATASOURCE="jacobsons">
		SELECT 
			* 
		FROM 
			tblImage, tblItem
		WHERE 
			tblImage.fileName = tblItem.fileName
			AND tblItem.webItemID = #webID#
			 			
	</CFQUERY>
	
<!--- I am HTML! --->
<HTML>
<HEAD>
<TITLE>Jacobsons update page</TITLE>
</HEAD>
<BODY>
<form name="exchange" ACTION="update.cfm" METHOD="GET"> 
		<P>
			Available webItemIDS: <SELECT NAME="swebItemID" onchange="document.exchange.webID.value=this.options[this.selectedIndex].value;document.exchange.submit()">
			<CFOUTPUT QUERY="getDistinctWebItemIDS"> 
			<OPTION VALUE="#webItemID#">#webItemID#
			</CFOUTPUT>
			</SELECT>
			<BR />
			webItemID: <INPUT TYPE="TEXT" name="webID" VALUE="<CFOUTPUT>#webID#</CFOUTPUT>"> 		
<BR>
			
			
		</P>
	
	
<CFOUTPUT>
	<INPUT TYPE="HIDDEN" NAME="webItemID"	VALUE="#gatherItem.webItemID#">
	<INPUT TYPE="HIDDEN" NAME="itemCopy"	VALUE="#gatherItem.itemCopy#">
	<INPUT TYPE="HIDDEN" NAME="itemDesc"	VALUE="#gatherItem.itemDesc#">
	<INPUT TYPE="HIDDEN" NAME="fileName"	VALUE="#gatherItem.fileName#">
	<INPUT TYPE="HIDDEN" NAME="caption"	VALUE="#gatherImage.caption#">
	<INPUT TYPE="HIDDEN" NAME="largestImageSize"	VALUE="#gatherImage.largestImageSize#">
	
webItemID: #gatherItem.webItemID# &nbsp;&nbsp;<B>WARNING THIS IS THE ACTUAL CURRENT WEBITEMID.  HIT UPDATE TO REFRESH.</B><br />
<TABLE>
	<TR>
		<TD COLSPAN=2>
		tblItem
		</TD>
		<TD>BOTH</TD>
		<TD COLSPAN=2>
		tblImage
		</TD>
	</TR>
	<TR>
		<TD> itemCopy: <INPUT TYPE="TEXT" NAME="itemCopy" VALUE="#gatherItem.itemCopy#"> </TD>
		<TD> itemDesc: <INPUT TYPE="TEXT" NAME="itemDesc" VALUE="#gatherItem.itemDesc#"> </TD>
		<TD> fileName: <INPUT TYPE="TEXT" NAME="fileName" VALUE="#gatherItem.fileName#"> </TD>
		<TD> caption: <INPUT TYPE="TEXT" NAME="caption" VALUE="#gatherImage.caption#">	</TD>
		<TD> largestImageSize: <INPUT TYPE="TEXT" NAME="largestImageSize" VALUE="#gatherImage.largestImageSize#"></TD>
	</TR>
	<P>
	<INPUT TYPE="Radio" NAME="IT" VALUE="nITEM">Insert new Item with this data<BR />
	<INPUT TYPE="Radio" NAME="IT" VALUE="uITEM">Update Item fields with this data<BR />
	<INPUT TYPE="Radio" NAME="IT" VALUE="rITEM">Remove Item entry with these stats<BR />
    <INPUT TYPE="Radio" NAME="IT" VALUE="" CHECKED>Do Nothing<BR /></P><P>
    <INPUT TYPE="Radio" NAME="IM" VALUE="nIMAGE">Insert new Image with this data<BR />
	<INPUT TYPE="Radio" NAME="IM" VALUE="uIMAGE">Updat Image with this data<BR />
	<INPUT TYPE="Radio" NAME="IM" VALUE="rIMAGE">Remove Image entry with these stats<BR />
    <INPUT TYPE="Radio" NAME="IM" VALUE="" CHECKED>Do Nothing<BR /></P><P>
    </P><BR />
	

<INPUT TYPE="SUBMIT" NAME="UPDATE" VALUE="UPDATE">

</TABLE>
</CFOUTPUT>
</form>
</BODY>
</HTML>
