<!--- optional attributes --->
<!--- Breakdown of World Dealer Key --->

<!--- Alpha Values Returned to programs --->
<CFPARAM name="Attributes.ImaCollection" default=FALSE>
<CFPARAM name="Attributes.Collection" default="0000">
<CFPARAM name="Attributes.CollectionNo" default="0000">
<CFPARAM name="Attributes.DealerType" default="000">
<CFPARAM name="Attributes.DealerTot" default="00">
<CFPARAM name="Attributes.DealerCode" default=" ">

<!--- Numeric Values Returned to programs --->
<CFPARAM name="Attributes.Collection_numeric" default=0000>
<CFPARAM name="Attributes.CollectionNo_numeric" default=00000>
<CFPARAM name="Attributes.DealerTot_Numeric" default="00">

<!--- check for required attributes  Dealer code in is the only one required --->
<CFLOOP index="Attribute" list="DealerCodeIn">
	<CFIF not IsDefined( 'Attributes.' & Attribute )>
		<HR>
		<H4>Missing Attribute</H4>
				You need to specify a value for the '<B><CFOUTPUT>#Attribute#</CFOUTPUT></B>' attribute. This attribute is required for the <B>WorldDealer</B> tag.
		<HR>
		<CFABORT>
	</CFIF>
</CFLOOP>

<!--- Set temporary Values --->
<CFSET KeyLength = LEN(DealerCodeIn)>
<CFSET stdDealerCode = (KeyLength - 17)>

<!--- Set Alpha Values Returned to programs --->
<CFSET Attributes.Collection = LEFT(DealerCodeIn,1,4)>
<CFSET Attributes.CollectionNo = MID(DealerCodeIn,6,4)>
<CFSET Attributes.DealerType = LEFT(DealerCodeIn,11,3)>
<CFSET Attributes.DealerTot = LEFT(DealerCodeIn,15,2)>
<CFSET Attributes.DealerCode = LEFT(DealerCodeIn,18,stdDealerCode)>

<!--- Set Numeric Values Returned to programs --->
<CFSET Attributes.Collection_numeric = VAL(Attributes.Collection)
<CFSET Attributes.CollectionNo_numeric = VAL(Attributes.CollectionNo)
<CFSET Attributes.DealerTot_Numeric = VAL(Attributes.DealerTot)

<!--- Set Boolean Value for Collection Checks --->
<CFIF Dealer_Collection GT 0>
   <CFSET ImaCollection = TRUE>
</CFIF>