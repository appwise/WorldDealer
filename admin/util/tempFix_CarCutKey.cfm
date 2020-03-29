<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Add CarCutKey records</title>
</head>

<body>
<!--- linda, 11/18/99: temporary file, until we integrate this into Admin, with picture uploads. --->
<!--- this will create carcut records for pictures we've already uploaded. --->
<cfloop index="modelnumber" from="210" to="213">
	<cfquery name="addcarcuts" datasource="#gDSN#">
		INSERT INTO carcutkey (ModelID, CarCutID)
		VALUES (#modelnumber#, 1)
	</cfquery>
</cfloop>


</body>
</html>
