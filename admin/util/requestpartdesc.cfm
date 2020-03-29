                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <April 11, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!--- $Id: requestpartdesc.cfm,v 1.1 2000/05/11 19:35:10 lswanson Exp $ --->						  

<!--- Utility to move data from RequestInfoParts.PartRequestDesc_OLD to RequestInfoParts.PartRequestDesc.
The old one was text 255; new one is memo, unlimited text. --->					  

<!doctype html public "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Convert Parts Request Description</title>
	
	<cfquery name="upgradeDescr" datasource="#gDSN#">
		UPDATE	RequestinfoParts
		SET		PartRequestDesc = PartRequestDesc_OLD 		
	</cfquery>	
		
	<cfquery name="blankOldDescr" datasource="#gDSN#">
		UPDATE	RequestinfoParts
		SET		PartRequestDesc_OLD = '' 		
	</cfquery>
</head>

<body>
	Done converting Parts Request Descriptions
</body>
</html>