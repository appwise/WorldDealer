                         <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 17, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: welcome_main.cfm,v 1.31 2000/06/21 13:54:22 jkrauss Exp $ --->
<!--- Home: Welcome --->

<cfif IsDefined("g_dealercode")>
	<cfquery name="getName" datasource="#gDSN#">
		SELECT	DealershipName as Name
		FROM	Dealers
		WHERE 	DealerCode = '#g_dealercode#'
	</cfquery>
<cfelse>
	<cfquery name="getName" datasource="#gDSN#">
		SELECT	Name
		FROM	Accounts
		WHERE 	RowID = #getUserInfo.RowID#
	</cfquery>
</cfif>


<!--- linda, 1/18/00: We can always add another query to get the person's name who logged in, 
if it's an account person & a dealership isn't selected yet.  Not necessary now tho. --->

<table border="0" cellpadding="5" cellspacing="0">
<tr>
	<td>
		<cfif UserID EQ '1'> <!--- sigma6 only view --->
			
			<div align="center">
			<table><tr><td>
			<font face="Comic Sans MS">
			<table align="right"><tr><td align="CENTER"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/xdocmull2.jpg"><br>
			<font face="arial" size="1">me...November, 1572</font></td></tr></table>
			Hi.  It's me.  The <b>Grim Reaper</b>.  You know...<b>Death</b>.<p>
			I've been sent here from the <b>whorry netherworld</b> to collect the soul of <b>WorldDealer</b>.  It's a nasty job, 
			but someone's got to do it.  And I actually kind of like it...I've always had good people skills.  And it's always 
			a good time in <b>Detroit</b>...I do a lot of business here in the <b>Murder City</b>.<p>
			I'm not sure what <b>WorldDealer</b> did to deserve a fate such as this.  What with all the buckets and buckets 
			of bank it's made for <b>Sigma6</b> and <b>AppNet</b>.<p>
			<table align="LEFT"><tr><td align="CENTER"><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/xdocmull.jpg" width="319" height="360"><br>
			<font face="arial" size="1">me...in Vienna during the "Die WorldDealer, Die!" warm-up tour</font></td></tr></table>
			It is with a heavy heart that I collect the soul of <b>WorldDealer</b>.  Or...it would be with a heavy heart if I had 
			a heart.  Mwahahahahahaha.  I kill me.  Mwahahahahaha.  Stop it...seriously.<p>
			Kiss your <b>WorldDealer</b> goodbye, you worthless mortals.  Prepare yourself for the void that will surely remain in 
			your work-day when it passes from this life to the next.  You must live with the tragedy of knowing the answer when your 
			friends and family ask, <b>"Where my WorldDealer at?"</b><p>
			<b>Pittsburgh</b>.  It makes even me shudder...and I am <b>cold, soul-less Death</b>.<p>
			Well...I'm off to my pad in the <b>whorry netherworld</b>.  I've done my duty.  <b>WorldDealer is Dead.</b><p>
			I'll be back for <b>AppNet</b> soon.  Mwahahahahahaha.
<!--- 			Yo, yo, yo.  CodePimps and Scriptified HTML fuh-reaks on the WurldDeala scene.  What up my dogs? This be
			MC Mull busting tha sanctified, officialized inspirationalized greeting type text on all yall.  Yeah.
			Let me start out by sayin dat yall be workin it tight. Damn. Outcreepin tha wack shizits on the downlow,
			cuz why else would ya’ll be here if not to flex? Yeah.  Keeping fools stuh-rate is how you bad mf’s roll.
			Know what I’m sayin’?  Word.  Cuz all yall are the suppa code dawgs TCBing the haps.  Wooof  Woooof! Come
			on. Yeah, dats right, yall is bad and you know it. Keepin it real.  Freezing weak codin mf’s in dey
			tracks.  Dat’s rite, we got Lady el S in the hizhouse, we got Tha mightyB in the hizhouse and we got the
			JKmasterjam in the hizhouse. Word to dat. So all u otha fools betta get up offa this groove cause some
			serious code ‘bout to get thrown down.  Know what I’m sayn.  Hell yeah you do.  MC Mull out. --->
			</font>
			</td></tr></table>
			</div>
		<cfelse>
			<img src="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/images/admin/parkinson.jpg" width="125" height="125" align="left">
			
			Hello, <cfif accesslevel eq application.dealer_access>teammates at</cfif> <b><cfoutput>#getName.Name#</cfoutput></b>.
			Welcome to WorldDealer HomeBase. I'm Ron Parkinson, director of WorldDealer, and if you haven't been to 
			this WorldDealer Admin site for a while, you'll probably notice that we've made some changes.  
			Visit the <a href="features.cfm">New Features</a> section to learn more about what this latest version of 
			WorldDealer has to offer.<br><br>

			To directly access your dealership information, click the 
			<a href="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/admin/mysite/index.cfm">My Site</a> link at the top of this page.  
			From there, you'll be able to access the sections of HomeBase 4.0 that enable you to update the information on your dealer 
			Website, view and manage your leads and create customized coupons and banners. You'll also want to check out 
			the <a href="events.cfm">Upcoming Events</a> link above to learn more about events where you can meet the rest of the WorldDealer team.<br><br>

			To help you keep connected with the latest Industry news and research information, we've also put a news section 
			in the right column of this page.  Feel free to submit news of your own to the WorldDealer community if you come 
			across any articles that interest you.<br><br>

			If you're still unsure of where to start, follow the <a href="<CFOUTPUT>#application.RELATIVE_PATH#</cfoutput>/admin/help/index.cfm">Help Section</a> link located at the top of this page; it should 
			offer you all the information you need about how to maximize your use of HomeBase 4.0.  In the event that you still 
			have questions, our WorldDealer Support Agents are ready to assist you. Just give them a call at 1-800-934-6006.
		</cfif>
	</td>
</tr>
</table>
