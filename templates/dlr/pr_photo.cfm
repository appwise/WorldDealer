<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
	
<cfquery name="getvehicle" datasource="#gDSN#">
	SELECT	VIN
	FROM 	UsedVehicles 
	WHERE	UsedVehicleID = #URL.ID#
</cfquery>
	
</head>

<body>
<div align="center">
<cfoutput><img src="#application.RELATIVE_PATH#/images/usedvehicles/#Trim(getvehicle.VIN)#.jpg" border=1 alt=""></cfoutput><p>
<font face="Arial,Verdana,Helvetica" size="1"><a href="javascript:window.close()">CLOSE WINDOW</a></font>
</div>
</body>
</html>
