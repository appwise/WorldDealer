<cfmodule template="/util/DumpDebug.cfm" text="begin $RCSfile: rightnav.cfm,v $">

                         <!--- Created by AppNet, Inc., Detroit
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <January 11, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->            
                                    <!---$Id: rightnav.cfm,v 1.33 2000/06/14 14:11:29 lswanson Exp $--->

<!--- Right Navigation for News headlines --->
<table width="131" border="0" cellspacing="0" cellpadding="0" bgcolor="Black">
<tr>
	<!--- skinny black stripe down the left.  if # of rows changes, change here too. --->
	<td rowspan="6" width="7">&nbsp;&nbsp;</td>
	<!--- &nbsp; is too tall for this space.  it throws off the alignment --->
	<td width="113"> </td>
	<td><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/rnav_3.gif" border=0 width=11 height=10 alt=""></td>
</tr>
<tr>
	<td><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/r_mynews.gif" border=0 width=113 height=16 alt="News"></td>
	<!--- phat yellow stripe down the right.  if # of rows changes, change here too --->
	<td bgcolor="#FCCA00" rowspan="4">&nbsp;</td>
</tr>
<tr>
	<td>
		<img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/r_auto.gif" border=0 width=113 height=34 alt="Automotive Retailing">
		<font size="-1" color="white">
		<a href="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/admin/news/news1.cfm" class="news">November 1, 2000</a>
		<br>
		Jersey dealer buys back stores from AutoNation
		</font>
		<br><br>
	</td>
</tr>
<tr>
	<td> 
		<img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/r_industry.gif" border=0 width=113 height=15 alt="Industry News"> 
		<font size="-1" color="white">
		<a href="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/admin/news/news2.cfm" class="news">November 1, 2000</a>
		<br>
		Dealership People & Profits - Old argument stays alive - Salary vs. flat rate for service
		<!--- <a href="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/admin/news/news4.cfm" class="news">February 10, 2000 -- 
		Delphi's New Four-Wheel Steering System Featured on GM Concept 
		Truck at Detroit Auto Show</a> --->
		</font>
		<br><br>
      </td>
</tr>
<tr>
	<td>
		<img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/r_research.gif" border=0 width=113 height=17 alt="Automotive Research"><br>
		<font size="-1" color="white">
		<a href="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/admin/news/news3.cfm" class="news">November 1, 2000</a>
		<br>
		What do women want?
		</font>
		<br><br>
	</td>
</tr>
<tr>
	<td>&nbsp;</td>
	<td><img src="<cfoutput>#application.RELATIVE_PATH#</cfoutput>/images/admin/r_btm.gif" border=0 width=11 height=22 alt=""></td>
</tr>
</table>

<cfmodule template="/util/DumpDebug.cfm" text="end   $RCSfile: rightnav.cfm,v $">
