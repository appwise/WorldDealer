<cfset PageAccess = application.dealer_access>
<cfinclude template = "../security.cfm">

                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <February 17, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!--- $Id: preowned_hours_def.cfm,v 1.2 2000/03/03 17:54:27 jkrauss Exp $ --->
<!--- Pre-Owned: Set Default Hours of Operation --->

<input type="hidden" name="openingtime" value="#form.openingtime#">
<input type="hidden" name="closingtime" value="#form.closingtime#">

<!--- This sets all 5 depts' hours of operation, whether they're used or not.
So that when user goes to the next section, at least their default hours are there, instead of all saying "Closed". --->
<cfinclude template="hours_default.cfm">

<cflocation url="preowned.cfm">
