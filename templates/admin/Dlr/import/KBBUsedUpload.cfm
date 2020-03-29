<!-- ----------------------------------------------------------- -->
<!--                 Created by Sigma6, Inc.                     -->
<!--             Copyright (c) 1997, 1998, 1999 Sigma6, Inc.     -->
<!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
<!-- ----------------------------------------------------------- -->
<!-- ----------------------------------------------------------- -->
<!--           Sigma6, interactive media, Detroit/NYC            -->
<!--               conceive : construct : connect                -->
<!--   www.sigma6.com   webmaster@sigma6.com   info@sigma6.com   -->
<!--                                                             -->
<!--   Last updated: <May 6, 1999>                               -->
<!-- ----------------------------------------------------------- -->
<!--     Linda Swanson for sigma6, interactive media, Detroit    -->
<!--   lswanson@sigma6.com   www.sigma6.com    www.s6313.com     -->
<!--               conceive : construct : connect                -->
<!-- ----------------------------------------------------------- -->
<!-- ----------------------------------------------------------- -->
<!-- Sigma6, s6, and the Sigma6 logos are registered trademarks. -->
<!-- All other trademarks and servicemarks are the property of   -->
<!-- their respective owners.                                    -->
<!-- ----------------------------------------------------------- -->
<!--- $Id: KBBUsedUpload.cfm,v 1.2 1999/11/24 22:19:02 lswanson Exp $ --->
<!--- Upload Makes, Models, & Years from Kelly Blue Book, in tab-delimited text format --->
<!--- to populate the UsedVehiclesModels table --->

<CFFILE action="read" 
		file="#g_rootdir#/templates/admin/dlr/import/modelslist_tabdel.txt"
		variable="Contents">
		
<!--- we need to break on carriage-control (ASCII #13) and linefeed (ASCII #10) --->
<CFSET CarriageControl = Chr(13)>
<CFSET LineFeed = Chr(10)>
<CFSET Tab = Chr(9)>

<!--- Loop through the text file (=Contents) line by line (=ModelInfo) (until CRLF) --->
<!--- It's in the format Make<tab>Model<tab>Year<tab>Year<tab>Year<CRLF> --->
<!--- For each line (=ModelInfo), get the Make & Model, then loop through the rest of the line, --->
<!--- getting each year (until tab) --->
<!--- & do an insert of the Make, Model, & Year for each year as we go. --->


<CFLOOP index="ModelInfo" list="#Contents#" delimiters="#CarriageControl##LineFeed#">
	
	<CFOUTPUT>
	<CFSET Make = GetToken(ModelInfo, 1, #Tab#)>
	<CFSET Model = GetToken(ModelInfo, 2, #Tab#)>
	<CFSET YearsList = RemoveChars(#ModelInfo#, 1, Len(#make#) + Len(#model#) +2)>
	
	<CFLOOP index="Year" list="#YearsList#" delimiters="#Tab#">
		
	    <!---  Change the year from two digits to 4 digits, and hope they aren't using this 30 years down the road. --->
		<CFSET theYear = val("#year#")>
		<CFIF TheYear GE 30>
			<CFSET convertedmodelyear = "19" & #year#>
		<CFELSE>
			<CFSET convertedmodelyear = "20" & #year#>
		</CFIF>
		
		<!--- Query to see if Make, Model, Year already exists in the UsedVehiclesModels Table --->
		<CFQUERY NAME="Check4Model" DATASOURCE="#gDSN#">
				SELECT	ID
      			FROM	UsedVehiclesModels
	     		WHERE	UsedVehiclesModels.Make = '#make#'
				AND		UsedVehiclesModels.ModelName = '#model#'
				AND		UsedVehiclesModels.Year = #convertedmodelyear#
		</CFQUERY>
		
		<!--- Check to see if Make, Model, Year already exists in the UsedVehiclesModels Table --->
    	<CFIF #Check4Model.RecordCount# IS 0>
	        <!--- OK, it doesn't exist, lets add it --->
			adding: #make# #model# #convertedmodelyear#<br>
			
 			<CFQUERY NAME="addKBBUsed" DATASOURCE="#gDSN#">
				INSERT INTO UsedVehiclesModels
			 				(Make, ModelName, Year)
				VALUES		('#Make#', '#Model#', #convertedmodelyear#)
		    </CFQUERY>
		<CFELSE>
			already exists: #make# #model# #convertedmodelyear#<br>
		</CFIF>
	</cfloop>	
	</cfoutput>	
</CFLOOP>