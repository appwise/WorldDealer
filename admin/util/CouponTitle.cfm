<!--- JOEL:  this utility splits the description field in the virtualcoupon table into two
			fields...title, and description.  That way, it makes sense.  The old way didn't.
			WD 4.0 RULES!!! --->

<cfquery name="getCouponStuff" datasource="WorldDlr">
	SELECT VirtualCouponID, Description, Title
	FROM VirtualCoupons
</cfquery>

<cfloop query="getCouponStuff" startrow="100">
	
	<cfif #findnocase("<P>", Description)#>
		<cfset section_break = #findnocase("<P>", Description)#>
 		
		<cfset coupontitle = #LTrim(left(getCouponStuff.description, (section_break - 1)))#>
		<cfset coupondescription = #LTrim(RemoveChars(getCouponStuff.description, 1, (section_break + 2)))#>
				
		<cfoutput>
		<b>#virtualcouponid#</b><br>
		<b>section_break:</b>  #section_break#<br>
		<b>TITLE:</b>  #coupontitle#<br>
		<b>DESC:</b>  #coupondescription#
		<hr>
		</cfoutput>
		
		<cfquery name="fixCouponTable" datasource="WorldDlr">
			UPDATE 	VirtualCoupons
			SET		Title = '#coupontitle#',
					Description = '#coupondescription#'
			WHERE 	VirtualCouponID = #getCouponStuff.VirtualCouponID#
		</cfquery>
		
	</cfif>
</cfloop>