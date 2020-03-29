                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 14, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: index_main.cfm,v 1.16 2000/05/30 21:06:32 lswanson Exp $--->
<!--- Help --->

<!--- Not pulling in Account Coordinator info in copy anymore.
<cfif IsDefined("g_dealercode")>
	<cfquery name="getAC" datasource="#gDSN#">
		SELECT	FirstName, 
				LastName, 
				AccountCoordinators.EMail
		FROM 	Dealers 
				INNER JOIN AccountCoordinators ON Dealers.ACID = AccountCoordinators.ACID
		WHERE 	Dealers.DealerCode = '#g_dealercode#'
	</cfquery>
</cfif>
--->
 
<table border="0" cellpadding="5" cellspacing="0">
<tr>
	<td>
		<table border="0" cellpadding="5" cellspacing="0">
		<tr>
			<td valign="TOP">
				<img src="../../images/admin/Snyder.jpg" width=75 height=75 align="left" border=0 alt=""> 
			</td>
			<td valign="bottom">
				<!--- 2/9/2000 revisions: --->
				Hello, my name is Amy Precour, your Client Service Manager here at WorldDealer. 
				<br><br>
				My goal is to ensure that you get the most you possibly can out of 
				your WorldDealer Website.  Customer satisfaction and feedback are important 
				to us, and our support team is dedicated to answering all of your Website and 
				automotive online retailing questions.  If you have any comments, questions, 
				or concerns, please don't hesitate to call or send an e-mail.  We will do 
				everything we can to help, and if we don't have an immediate answer, we will 
				find it for you.
			</td>
		</tr>
		<tr>
			<td colspan="2">
				E-mail: <a href="mailto:support@worlddealer.net?subject=Customer Services from Admin Help"
				onmouseover="self.status='Send E-mail to WorldDealer';return true"
				onmouseout="self.status='';return true">support@worlddealer.net</a><br>
				Phone: 1-800-934-6006<br>
				Fax: 1-412-257-2939 
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
