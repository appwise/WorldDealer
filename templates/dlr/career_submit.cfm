                        <!--- Created by AppNet, Inc., Detroit 
                                      www.appnet.com
                            Copyright (c) 1999, 2000 AppNet, Inc. 
                  All other trademarks and servicemarks are the property of   
      their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
                           Appnet, Inc. logos are registered trademarks.  
                                 Created: <March 30, 2000>
                          webmaster@sigma6.com and info@sigma6.com --->            
<!---$Id: career_submit.cfm,v 1.2 2000/05/05 15:39:26 lswanson Exp $--->
<!--- jon weitz 3/30/00 --->
<!--- Code is reusable for any dealer as long as a form is created in a memo field (like Banner's Special Promotion)
within admin that has a Submit button that calls this.  See sample form below. --->

<!doctype html public "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<body>

<cfif isdefined("form.email")>
	<cfif len(trim(form.email))>
		<cfset email = form.email>
	<cfelse>
		<cfset email = 'n/a'>
	</cfif>
<cfelse>
	<cfset email = 'n/a'>
</cfif>

<cfmail 
	to="#dealerinfo.email#"
	from="#email#"
	subject="Career Application from your WorldDealer Web site">

	The following career application has been submitted from your Web site:

	Name: <cfif isdefined("form.name")>#form.name#<cfelse>none given</cfif>
	Social Security: <cfif isdefined("form.soc")>#form.soc#<cfelse>none given</cfif>
	Street Address: <cfif isdefined("form.address")>#form.address#<cfelse>none given</cfif>
	Apt. : <cfif isdefined("form.apt")>#form.apt#<cfelse>none given</cfif>
	City: <cfif isdefined("form.city")>#form.city#<cfelse>none given</cfif>
	State: <cfif isdefined("form.state")>#form.state#<cfelse>none given</cfif>
	Zip: <cfif isdefined("form.zip")>#form.zip#<cfelse>none given</cfif>
	E-mail Address: <cfif isdefined("form.email")>#form.email#<cfelse>none given</cfif>
	Phone: <cfif isdefined("form.phone")>#form.phone#<cfelse>none given</cfif>
	
	Position Applying For: <cfif isdefined("form.position")>#form.position#<cfelse>none given</cfif>
	Seeking other: <cfif isdefined("form.otherposition")>#form.otherposition#<cfelse>none given</cfif>
	
	18 or older? <cfif isdefined("form.ofage")>#form.ofage#<cfelse>none given</cfif>
	
	Birth Date: <cfif isdefined("form.birthdate")>#form.birthdate#<cfelse>none given</cfif>
	
	Have you worked at #dealerinfo.dealershipname# before? <cfif isdefined("form.previouslyemployedhere")>#form.previouslyemployedhere#<cfelse>none given</cfif>
	Location? <cfif isdefined("form.locationemployed")>#form.locationemployed#<cfelse>none given</cfif>
	Dates: <cfif isdefined("form.dateemployed")>#form.dateemployed#<cfelse>none given</cfif>
	
	Reason For Leaving: <cfif isdefined("form.reasonforleaving")>#form.reasonforleaving#<cfelse>none given</cfif>
	
	Valid License? <cfif isdefined("form.validlicense")>#form.validlicense#<cfelse>none given</cfif>
	State:<cfif isdefined("form.stateoflicense")>#form.stateoflicense#<cfelse>none given</cfif>
	
	Seeking: <cfif isdefined("form.jobtype")>#form.jobtype#<cfelse>none given</cfif>
	
	Total hours available per week: <cfif isdefined("form.hours_available")>#form.hours_available#<cfelse>none given</cfif>
</cfmail>

<!--- linda, 5/5/00: right now, this redirects to home page, which is kind of annoying.  
Since this is called from a banner, there's no way to know which page to return to. --->
<cfif #dealerinfo.url# eq "">
	<cflocation url = "index.cfm?dealercode=#dealerinfo.DealerCode#">
<cfelse>
	<cfif #left(#dealerinfo.url#, 6)# eq "wddemo">
		<cflocation url = "http://#dealerinfo.url#">
	<cfelse>
		<cflocation url = "http://www.#dealerinfo.url#">
	</cfif>
</cfif>

</body>
</html>


<!--- this is the form that calls this file --->
<!--- 
<h3><b>Careers</b></h3>
<br><br>
<b>Your Chance to Climb the Ladder to Success</b>
<br><br>
<b>Careers Available at the Baierl Family of Dealerships</b>
<br><br>
Whether you are experienced or aspire to work in sales or the highly technical parts and service areas of an automobile dealership, we are interested in you joining our Baierl team.
<br><br>
We are looking for qualified personnel and apprentices in a variety of areas, including, but not limited to the following:


<ul>
<li>New and Used Car Sales</li>
<li>Technicians (Service and Body Shop)</li>
<li>Advisors</li>
<li>Cashiers</li>
<li>Lot Attendants</li>
<li>Parts Counterpersons</li>
</ul>

If you desire a long-term relationship with an employer, Baierl is committed to providing stability for its employees and an opportunity for training and advancement in this rewarding field.  
<br><br>
If you are interested in submitting an application on-line, please complete the following mini-application.  Upon completion, your application will be forwarded via e-mail to <a href="mailto:lswanson@sigma6.com">lswanson@sigma6.com</a>. All applications will be maintained on file for a period of six months.
<br><br>
Applications can also be submitted in person at any of our Baierl locations.  

<b>Baierl Mini-Application</b>

<br>
<form method="post" action="career_submit.cfm">
<table border="0" cellpadding="2" cellspacing="2" width="100%">
	<tr>
		<td><b>Name</b></td>
		<td><input name="name" type="text" size="20" maxlength="100"></td>
	</tr>

	<tr>
		<td><b>Social Security #</b></td>
		<td><input name="soc" type="text" size="20" maxlength="11"></td>
	</tr>
	<tr>
		<td><b>Street Address</b></td>
		<td><input name="address" type="text" size="20" maxlength="100"></td>
	</tr>

	<tr>
		<td><b>Apt. #</b></td>
		<td><input name="apt" type="text" size="20" maxlength="100"></td>
	</tr>


	<tr>
		<td><b>City</b></td>
		<td><input name="city" type="text" size="20" maxlength="100"></td>
	</tr>

	<tr>
		<td><b>State</b></td>
		<td><input name="state" type="text" size="20" maxlength="20"></td>
	</tr>

	<tr>
		<td><b>Zip</b></td>
		<td><input name="zip" type="text" size="10" maxlength="10"></td>
	</tr>

	<tr>
		<td><b>E-mail Address</b></td>
		<td><input name="email" type="text" size="20" maxlength="100"></td>
	</tr>

	<tr>
		<td><b>Phone</b></td>
		<td><input name="phone" type="text" size="20" maxlength="20"></td>
	</tr>

	<tr><td> </td></tr>
	
	<tr>
		<td rowspan="11" valign="top">
			<p><b>Position Applying For:</b></p>
		</td>
		<td>
			<input type="radio" name="position" value="new_vehicle_sales">
			New Vehicle Sales
		</td>
	</tr>
	
	<tr>
		<td>
			<input type="radio" name="position" value="used_vehicle_sales">
			Used Vehicle Sales
		</td>
	</tr>
		
	<tr>
		<td>
			<input type="radio" name="position" value="cashier">
			Cashier
		</td>
	</tr>

	<tr>
		<td>
			<input type="radio" name="position" value="Service_Technician">
			Service Technician
		</td>
	</tr>
		
	<tr>
		<td>
			<input type="radio" name="position" value="Body_Shop_Technician">
			Body Shop Technician
		</td>
	</tr>
		
	<tr>
		<td>
			<input type="radio" name="position" value="Service_Advisor">
			Service Advisor
		</td>
	</tr>
		
	<tr>
		<td>
			<input type="radio" name="position" value="Parts_Counterperson">
			Parts Counterperson
		</td>
	</tr>
		
	<tr>
		<td>
			<input type="radio" name="position" value="Parts _Driver">
			Parts Driver
		</td>
	</tr>
		
	<tr>
		<td>
			<input type="radio" name="position" value="Lot_Attendant">
			Lot Attendant
		</td>
	</tr>
		
	<tr>
		<td>
			<input type="radio" name="position" value="Clerical">
			Clerical/Receptionist
		</td>
	</tr>
		
	<tr>
		<td>
			<input type="radio" name="position" value="Other">
			Other
			<input name="otherposition" type="text" size="20" maxlength="100">
		</td>
	</tr>
		
	<tr>
		<td>
			<b>Are you 18 or older?</b>
		</td>
		<td>
			<input type="radio" name="ofage" value="yes">
			Yes
			<input type="radio" name="ofage" value="no">
			No
		</td>
	</tr>

	<tr>
		<td>
			<b>Birth Date (MM/DD/YYYY)</b>
		</td>
		<td>
			<input name="birthdate" type="text" size="20" maxlength="100">
		</td>
	</tr>
		
	<tr>
		<td>
			<b>Have you worked at Baierl before?</b>
		</td>
		<td>
			<input type="radio" name="previouslyemployedhere" value="yes">
			Yes
			<input type="radio" name="previouslyemployedhere" value="no">
			No
		</td>
	</tr>
		
	<tr>
		<td>
			<b>Which location?</b>
		</td>
		<td>
			<input name="locationemployed" type="text" size="20" maxlength="100">
		</td>
	</tr>
		
	<tr>
		<td>
			<b>Dates</b>
		</td>
		<td>
			<input name="dateemployed" type="text" size="20" maxlength="100">
		</td>
	</tr>
		
	<tr>
		<td>
			<b>Reason For Leaving</b>
		</td>
		<td>
			<input name="reasonforleaving" type="text" size="20" maxlength="100">
		</td>
	</tr>
		
	<tr>
		<td>
			<b>Do you have a valid state driver’s license?</b>
		</td>
		<td>
			<input type="radio" name="validlicense" value="yes">
			Yes
			<input type="radio" name="validlicense" value="yes">
			No
		</td>
	<tr>
		
	<tr>
		<td>
			<b>State you are licensed in</b>
		</td>
		<td>
			<input name="stateoflicense" type="text" size="2" maxlength="2">
		</td>
	</tr>
		
	<tr>
		<td>
			<b>I am seeking</b>
		</td>
		<td>
			<input type="radio" name="jobtype" value="fulltime">Full-time
			<input type="radio" name="jobtype" value="parttime">Part-time
		</td>
	</tr>
		
	<tr>
		<td>
			<b>Total hours available per week</b>
		</td>
		<td>
			<input name="hours_available" type="text" size="2" maxlength="2">
		</td>
	</tr>
		
	<tr>
		<td colspan="2" align="center">
			<br>
			<input type="reset" name="Reset" value="Reset">
			<input type="submit" name="Submit" value="Submit">
		</td>
	</tr>
</table>
</form>
 --->


