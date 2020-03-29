<!----------------------- Created by Sigma6, Inc. 1998 ------------------------------>
<!--- $Id: application.cfm,v 1.4 1999/10/28 18:50:27 lswanson Exp $ --->
<CFAPPLICATION NAME="dealercode" CLIENTMANAGEMENT="YES">
<CFSET g_relpath = '/worlddealer'>  <!--- Path from the web root directory to Worlddearler root, if they're not the same --->
<CFSET application.RELATIVE_PATH = g_relpath>

<!--- global DataSource Name --->
<CFSET gDSN="WorldDlr">

<CFQUERY NAME="dealerinfo" DATASOURCE="#gDSN#">
	SELECT	dealercode,
			dealershipname,
			addressline1,
			addressline2,
			city,
			stateabbr,
			zip,
			email,
			phone,
			FaxPhone,
			TagLine
	FROM	Dealers
	WHERE	dealercode='#url.dealercode#';
</CFQUERY>