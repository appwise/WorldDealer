<CFSET webnewstep = 9>
<CFINCLUDE template="security.cfm">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
	<!-- ----------------------------------------------------------- -->
	<!--                Created by sigma6, Detroit                   -->
	<!--         Copyright (c) 1997, 1998, 1999 sigma6.              -->
	<!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
	<!--               conceive : construct : connect                -->
	<!-- ----------------------------------------------------------- -->

	<!-- ----------------------------------------------------------- -->
	<!--     Tim Taylor for sigma6, interactive media, Detroit      -->
	<!--    ttaylor@sigma6.com   www.sigma6.com    www.s6313.com     -->
	<!--               conceive : construct : connect                -->
	<!-- ----------------------------------------------------------- -->
	<!--- $Id: webnew_s9.cfm,v 1.9 1999/12/15 23:12:46 lswanson Exp $ --->
	<!--- Used Vehicles --->

<HEAD>
	<TITLE>WorldDealer | Create a New Web</TITLE>
	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>

<body>
<br><br><br><br><br>
	<div align="center">
	<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=410 BGCOLOR="FFFFFF">
		<TR ALIGN="center">
			<TD ALIGN="middle"><h3><font face="Arial,Helvetica">Dealer Administration - Create a New Web</font></h3></TD>
		</TR>
		<TR ALIGN="center">
			<TD ALIGN="middle"><h4><font face="Arial,Helvetica">Used Vehicle Maintenance</font></h4></TD>
		</TR>
		
		<!--- XXX: replace modes with single state variable --->
		<CFSET SaveMode = FALSE>
		<CFSET ModifyMode1 = FALSE>
		<CFSET ModifyMode2 = FALSE>
		<CFSET ModifyMode3 = FALSE>
		<CFSET ModifyMode4 = FALSE>
		<CFSET NewMode1 = FALSE>
		<CFSET NewMode2 = FALSE>
		<CFSET NewMode3 = FALSE>
		<CFSET NewMode4 = FALSE>
		<CFSET DeleteMode = FALSE>
		<CFSET KillMode = FALSE>
		<CFSET EditMode = FALSE>
		<CFSET ImageMode = FALSE>
		<CFSET ConfirmMode = FALSE>

		<!--- figure out the dealer code --->		
		<CFIF IsDefined("URL.dlrcode")>
			<CFSET g_DealerCode = #URL.dlrcode#>
		<CFELSEIF IsDefined("Form.DealerCode")>
			<CFSET g_DealerCode = #Form.DealerCode#>
		<CFELSE>
			<CFSET g_DealerCode = "">
		</CFIF>

		<!--- choose action --->		
		<CFIF IsDefined("URL.dlrcode") OR IsDefined("Form.btnEdit.X")>
			<CFSET EditMode = TRUE>
<!--- 		<CFELSE>
			<CFSET NewMode1 = TRUE> --->
		</CFIF>
		
		<!--- chose to modify an existing vehicle --->
		<CFIF IsDefined("Form.btnModify.X")>
			<CFSET ModifyMode1 = TRUE>
		</CFIF>
		
		<!--- chose to add a vehicle --->
		<CFIF IsDefined("Form.BtnAdd.X")>
			<CFSET NewMode1 = TRUE>
		</CFIF>

		<!--- chose to delete a vehicle --->
		<CFIF IsDefined("Form.BtnDelete.X")>
			<CFSET DeleteMode = TRUE>
		</CFIF>
			        
		<!--- chose a make while modifying a vehicle --->
		<CFIF IsDefined("Form.btnSave1.X")>
			<CFSET ModifyMode2 = TRUE>
		</CFIF>

		<!--- chose a make while creating a new vehicle --->
		<CFIF IsDefined("Form.btnNew1.X")>
			<CFSET NewMode2 = TRUE>
		</CFIF>

		<!--- chose a model name while modifying a vehicle --->
		<CFIF IsDefined("Form.btnSave2.X")>
			<CFSET ModifyMode3 = TRUE>
		</CFIF>
	
		<!--- chose a model name while creating a new vehicle --->
		<CFIF IsDefined("Form.btnNew2.X")>
			<CFSET NewMode3 = TRUE>
		</CFIF>

		<!--- next from primary info, extra features, or image ?? while modifying  --->
		<CFIF IsDefined("Form.btnSave3.X")>
			<CFIF #Form.ExtraFeatures# IS NOT 0>
				<!--- Go to the Extra Features Page --->
				<CFSET ModifyMode4 = TRUE>
			<CFELSE>
				<!--- No Extra Features --->
				<CFIF #form.Image# EQ 'Y'>
					<!--- Choose an Image --->
					<CFSET ImageMode = TRUE>
				<CFELSE>
					<!--- Don't need to choose an image --->
					<!--- Forward to Save Mode --->
					<CFSET SaveMode = TRUE>
				</CFIF>
			</CFIF>
		</CFIF>

		<!--- next from primary info, extra features, or image ?? while creating --->
		<CFIF IsDefined("Form.btnNew3.X")>
			<CFIF Form.ExtraFeatures IS NOT 0>
				<!--- Go to the Extra Features Page --->
				<CFSET NewMode4 = TRUE>
			<CFELSE>
				<!--- No Extra Features --->
				<CFIF #form.Image# EQ 'Y'>
					<!--- Choose an Image --->
					<CFSET ImageMode = TRUE>
				<CFELSE>
					<!--- Don't need to choose and image --->
					<!--- Forward to Save Mode --->
					<CFSET SaveMode = TRUE>
				</CFIF>
			</CFIF>
		</CFIF>

		<CFIF IsDefined("Form.btnSave4.X")>
			<CFSET SaveMode = TRUE>
        </CFIF>

		<!--- chose an image to add for vehicle --->
		<CFIF IsDefined("Form.BtnChooseImage.X")>
			<CFSET ImageMode = TRUE>
		</CFIF>

		<!--- confirmed ??? --->
		<CFIF IsDefined("Form.btnConfirm.X")>
			<CFSET ConfirmMode = TRUE>
        </CFIF> 
		
		<!--- confirmed deleting a vehicle --->
		<CFIF IsDefined("Form.BtnKill.X")>
			<CFSET KillMode = TRUE>
		</CFIF>
	
		<!--- chose to cancel --->
		<CFIF IsDefined("Form.btnCancel.X")>
			<CFSET CancelMode = TRUE>
			<CFLOCATION URL="webvrfy_s9.cfm?dlrcode=#Form.DealerCode#">
		</CFIF>
		
		<!--- do some queries necessary for different modes --->
		<CFIF EditMode>
			<CFQUERY NAME="selectUsedVehicles" datasource="#gDSN#">
			SELECT
				UsedVehicleID as q_UsedVehicleID,
				DealerCode as q_DealerCode,
				VIN as q_VIN,
				ModelName as q_ModelName,
				make as q_make,
				intcolor as q_intcolor,
				extcolor as q_extcolor,
				transmission as q_transmission,
				mileage as q_mileage,
				price as q_price,
				stock as q_stock,
				CarYear as q_CarYear,
				Features as q_Features,
				image as q_image
			FROM
				UsedVehicles
			WHERE
				UsedVehicles.DealerCode = '#g_DealerCode#' 
			ORDER BY
				Make,
				ModelName,
				CarYear
			</CFQUERY>
			<CFQUERY NAME="selectUsedVehiclesMax" datasource="#gDSN#">
			SELECT
				Max(UsedVehicleID) as q_MaxUsedVehicleID
			FROM
				UsedVehicles
			WHERE
				UsedVehicles.DealerCode = '#g_DealerCode#'
			</CFQUERY>
		</CFIF>
		
		<CFIF ModifyMode1 OR ModifyMode2 OR ModifyMode3>
			<CFQUERY NAME="selectUsedVehicle" datasource="#gDSN#">
			SELECT
				UsedVehicleID as q_UsedVehicleID,
				DealerCode as q_DealerCode,
				VIN as q_VIN,
				ModelName as q_ModelName,
				make as q_make,
				intcolor as q_intcolor,
				extcolor as q_extcolor,
				transmission as q_transmission,
				mileage as q_mileage,
				price as q_price,
				stock as q_stock,
				CarYear as q_CarYear,
				Features as q_Features,
				Image as q_Image
			FROM
				UsedVehicles
			WHERE
				UsedVehicles.UsedVehicleID = #form.VehicleID#
			</CFQUERY>
			
			<CFQUERY NAME="selectExtraFeatures" datasource="#gDSN#">
			SELECT
				COUNT(UsedVehicleID) AS NumOfExtraFeatures
			FROM
				UsedVehiclesOptions
			WHERE
				UsedVehicleID = #form.VehicleID#
			</CFQUERY> 	        
		</CFIF>
		
		<CFIF ModifyMode4>
			<CFQUERY NAME="selectOptions" datasource="#gDSN#">
			SELECT
				Options
			FROM
				UsedVehiclesOptions
			WHERE
				UsedVehicleID = #Form.VehicleID#
			</CFQUERY>
			
			<!--- XXX: use selectOptions.RecordCount instead --->
			<CFQUERY NAME="getNumOfOptions" datasource="#gDSN#">
			SELECT
				COUNT(Options) AS NumOfOptions
			FROM
				UsedVehiclesOptions
			WHERE
				UsedVehicleID = #form.VehicleID#
			</CFQUERY>
		</CFIF>
		
		<CFIF ModifyMode1 OR NewMode1>
			<CFQUERY NAME="selectVehicleMakes" datasource="#gDSN#">
			SELECT	DISTINCT
				make
			FROM
				UsedVehiclesModels
			ORDER BY
				make
			</CFQUERY>
		</CFIF>

		<CFIF ModifyMode2 OR NewMode2>  <!---run queries to populate javascript dropdowns--->
			<CFQUERY NAME="selectVehicleModelNames" datasource="#gDSN#">
			SELECT DISTINCT
				ModelName
			FROM
				UsedVehiclesModels
			WHERE
				UsedVehiclesModels.Make='#Form.Make#'
			ORDER BY
				ModelName;
			</CFQUERY>
		</CFIF>
	
		<CFIF ModifyMode3 OR NewMode3>  <!---run queries to populate javascript dropdowns--->
			<CFQUERY NAME="selectUsedVehicleModelYears" datasource="#gDSN#">
			SELECT DISTINCT
				Year
			FROM
				UsedVehiclesModels
			WHERE
				UsedVehiclesModels.Make = '#Form.Make#'
				AND UsedVehiclesModels.ModelName = '#Form.ModelName#'
			ORDER BY
				Year
			</CFQUERY>
			<!---
 			<CFQUERY NAME="selectUsedVehicleyears" datasource="#gDSN#">
			SELECT DISTINCT
				Year
			FROM
				UsedVehiclesModels
			WHERE
				UsedVehiclesModels.Make='#Form.Make#'
			ORDER BY
				Year
			</CFQUERY>
			--->
		</CFIF>
	
		<CFIF SaveMode>
			<CFIF IsDefined("Form.ModifyFlag")>
				<CFQUERY NAME="updVehicle" datasource="#gDSN#">
				UPDATE UsedVehicles
				SET
					UsedVehicles.VIN = '#Form.VIN#',
					UsedVehicles.ModelName = '#Form.ModelName#',
					UsedVehicles.make = '#Form.make#',
					UsedVehicles.intcolor =<CFIF #Form.intcolor# IS NOT ''>'#Form.intcolor#'<CFELSE>'none'</CFIF>,
					UsedVehicles.extcolor =<CFIF #Form.extcolor# IS NOT ''>'#Form.extcolor#'<CFELSE>'none'</CFIF>,
					UsedVehicles.transmission =<CFIF #Form.transmission# IS NOT ''>'#Form.transmission#'<CFELSE>'none'</CFIF>,
					UsedVehicles.mileage =<CFIF #Form.mileage# IS NOT ''>#Form.mileage#<CFELSE>0</CFIF>,
					UsedVehicles.price =<CFIF #Form.price# IS NOT ''>#Form.price#<CFELSE>0</CFIF>,
					UsedVehicles.stock =<CFIF #Form.stock# IS NOT ''>'#Form.stock#'<CFELSE>'none'</CFIF>,
					UsedVehicles.CarYear =<CFIF #Form.caryear# IS NOT ''>#Form.CarYear#<CFELSE>0</CFIF>,
					UsedVehicles.Features =<CFIF #Form.features# IS NOT ''>'#Form.Features#'<CFELSE>'none'</CFIF>,
					UsedVehicles.Image = '#Form.Image#'
				WHERE
					UsedVehicles.UsedVehicleID = #Form.VehicleID#
	                </CFQUERY>
				<CFQUERY NAME="delVehicleOptions" datasource="#gDSN#">
				DELETE FROM UsedVehiclesOptions
				WHERE
					UsedVehiclesOptions.UsedVehicleID = #Form.VehicleID#
				</CFQUERY>				
	
				<CFLOOP INDEX="LoopIndex" From="1" To="#Form.extrafeatures#">
					<CFSET tmp= Evaluate('form.extrafeature' & #loopindex#)>
					<CFQUERY NAME="addextrafeatures" datasource="#gDSN#">
					INSERT INTO UsedVehiclesOptions (
						UsedVehicleID,
						options
						)
					VALUES (
						#Form.VehicleID#,
						'#tmp#'
						)
					</CFQUERY>
				</CFLOOP>												
			</CFIF>
			<CFIF IsDefined("Form.NewFlag")>
				<CFTRANSACTION>
					<CFQUERY NAME="addVehicle" datasource="#gDSN#">
					INSERT INTO UsedVehicles (
						DealerCode,
						VIN,
						ModelName,
						make,
						intcolor,
						extcolor,
						transmission,
						mileage,
						price,
						stock,
						CarYear,
						Features,
						Image
						)
					VALUES (
						'#Form.DealerCode#',
					 	'#Form.VIN#',
						'#Form.ModelName#',
						'#Form.make#',
						<CFIF #Form.intcolor# IS NOT ''>
							'#Form.intcolor#',
						<CFELSE>
							'none',
						</CFIF>
						<CFIF #Form.extcolor# IS NOT ''>
							'#Form.extcolor#',
						<CFELSE>
							'none',
						</CFIF>
						<CFIF #Form.transmission# IS NOT ''>
							'#Form.transmission#',
						<CFELSE>
							'none',
						</CFIF>
						<CFIF #Form.mileage# IS NOT ''>
							#Form.mileage#,
						<CFELSE>
							0,
						</CFIF>
						<CFIF #Form.price# IS NOT ''>
							#Form.price#,
						<CFELSE>
							0,
						</CFIF>
						<CFIF #Form.stock# IS NOT ''>
							'#Form.stock#',
						<CFELSE>
							'none',
						</CFIF>
						<CFIF #Form.CarYear# IS NOT ''>
							#Form.CarYear#,
						<CFELSE>
							0,
						</CFIF>
						<CFIF #Form.features# IS NOT ''>
							'#FORM.features#',
						<CFELSE>
							'none',
						</CFIF>
						'#FORM.Image#'
						)
					</CFQUERY>
						
					<CFQUERY NAME="selectVehicleID" datasource="#gDSN#">
					SELECT
						MAX(UsedVehicleID) as UsedVehicleID
					FROM
						UsedVehicles
					<!---
					WHERE
						UsedVehicles.DealerCode = '#Form.DealerCode#' AND
						UsedVehicles.VIN = '#Form.VIN#' AND
						UsedVehicles.ModelName = '#Form.ModelName#' AND
						UsedVehicles.make = '#Form.make#' AND
						UsedVehicles.intcolor = <CFIF #Form.intcolor# IS NOT ''>'#Form.intcolor#'<CFELSE>'none'</CFIF> AND
						UsedVehicles.extcolor = <CFIF #Form.extcolor# IS NOT ''>'#Form.extcolor#'<CFELSE>'none'</CFIF> AND
						UsedVehicles.transmission = '#Form.transmission#' AND
						UsedVehicles.mileage = <CFIF #Form.mileage# IS NOT ''>#Form.mileage#<CFELSE>0</CFIF> AND
						UsedVehicles.price = <CFIF #Form.price# IS NOT ''>#Form.price#<CFELSE>0</CFIF> AND
						UsedVehicles.stock = <CFIF #Form.stock# IS NOT ''>'#Form.stock#'<CFELSE>'none'</CFIF> AND
						UsedVehicles.CarYear = <CFIF #Form.CarYear# IS NOT ''>#Form.CarYear#<CFELSE>0</CFIF> AND
						UsedVehicles.Features = <CFIF #Form.features# IS NOT ''>'#FORM.features#'<CFELSE>'none'</CFIF>;
					--->
					</CFQUERY>
						
					<CFLOOP INDEX="LoopIndex" From="1" To="#Form.extrafeatures#">
						<CFSET tmp= Evaluate('form.extrafeature' & #loopindex#)>
						<CFQUERY NAME="addextrafeatures" datasource="#gDSN#">
						INSERT INTO UsedVehiclesOptions (
							UsedVehicleID,
							options
							)
						VALUES (
							#selectVehicleID.UsedVehicleID#,
							'#tmp#'
							)
						</CFQUERY>
					</CFLOOP>
				</CFTRANSACTION>
			</CFIF>
		
			<CFIF form.Image EQ 'Y'>    <!--- They chose to include a custom Image --->
				<CFIF form.tmpid IS NOT 0>    <!--- They actually submitted a new image --->
					<CFIF IsDefined("Form.NewFlag")>
						<CFSET Vehicle_ID = #selectVehicleID.UsedVehicleID#>
					<CFELSE>
						<CFSET Vehicle_ID = #Form.VehicleID#>
					</CFIF>
					<!--- Rename the uploaded image --->
						
					<CFFILE action="copy"
						source="#g_rootdir#\images\usedvehicles\temp_#form.tmpid#_.jpg"
						DESTINATION="#g_rootdir#\images\usedvehicles\#form.VIN#.jpg">
				</CFIF>
			</CFIF>
			<CFLOCATION url="webvrfy_s9.cfm?dlrcode=#g_dealercode#">
		</CFIF>
		
		<CFIF DeleteMode>
			<CFQUERY NAME="selectUsedVehicle" datasource="#gDSN#">
			SELECT
				UsedVehicleID as q_UsedVehicleID,
				DealerCode as q_DealerCode,
				VIN as q_VIN,
				ModelName as q_ModelName,
				make as q_make,
				intcolor as q_intcolor,
				extcolor as q_extcolor,
				transmission as q_transmission,
				mileage as q_mileage,
				price as q_price,
				stock as q_stock,
				CarYear as q_CarYear,
				Features as q_Features
			FROM
				UsedVehicles
			WHERE
				UsedVehicles.DealerCode = '#g_DealerCode#' 
				AND UsedVehicles.UsedVehicleID = #form.VehicleID#
			</CFQUERY>        
		</CFIF>
		
		<CFIF KillMode>
			<CFQUERY name="KillVehicle" datasource="#gDSN#">
			DELETE FROM UsedVehicles
			WHERE
				DealerCode = '#g_DealerCode#'
				AND UsedVehicleID = #form.VehicleID#
			</CFQUERY>
			<CFQUERY name="KillExtraFeatures" datasource="#gDSN#">
			DELETE FROM UsedVehiclesOptions
			WHERE
				UsedVehicleID = #form.VehicleID#
			</CFQUERY>
			<CFLOCATION url="webvrfy_s9.cfm?dlrcode=#g_dealercode#">
		</CFIF>

		<CFIF EditMode>
			<FORM NAME="StepNine" ACTION="webnew_s9.cfm" METHOD="post">
			<CFIF #selectUsedVehicles.RecordCount# IS NOT '0'>
				<TR>
					<TD ALIGN="center">
					<font face="Arial,Helvetica">
						Please select the Pre-Owned Vehicle you wish to Modify
					</FONT>
					</TD>
				</TR>
				<TR ALIGN="center">
					<TD ALIGN="center">
						&nbsp;
					</TD>
				</TR>
				<TR>
					<TD ALIGN=CENTER>
					<TABLE BORDER=0 CELLSPACING=5>
					<TR><TD>
						<FONT SIZE=2 FACE="arial,helvetica">
							&nbsp;
						</FONT>
					</TD><TD>
						<FONT SIZE=2 FACE="arial,helvetica">
							<B>Make</B>
						</FONT>
					</TD><TD>
						<FONT SIZE=2 FACE="arial,helvetica">
							<B>Model</B>
						</FONT>
					</TD><TD>
						<FONT SIZE=2 FACE="arial,helvetica">
							<B>Year</B>
						</FONT>
					</TD><TD>
						<FONT SIZE=2 FACE="arial,helvetica">
							<B>VIN</B>
						</FONT>
					</TD><TD>
						<FONT SIZE=2 FACE="arial,helvetica">
							<B>Stock</B>
						</FONT>
					</TD><TD>
						<FONT SIZE=2 FACE="arial,helvetica">
							<B>Img</B>
						</FONT>
					</TD></TR>
					<CFOUTPUT query="selectUsedVehicles">
					<TR><TD>
						<FONT SIZE=2 FACE="arial,helvetica">
							<!--- Linda, 4/9/99: i think the MaxUsedVvehicleID is silly.  It invariably highlights a record in the middle of the list & appears random.  i think it should just select the 1st rec. --->
							<INPUT NAME="VehicleID" TYPE="Radio" value="#q_UsedVehicleID#" <CFIF #q_UsedVehicleID# IS "#selectUsedVehiclesMax.q_MaxUsedVehicleID#">CHECKED</CFIF>>
						</FONT>
					</TD><TD>
						<FONT SIZE=2 FACE="arial,helvetica">
							#q_make#
						</FONT>
					</TD><TD>
						<FONT SIZE=2 FACE="arial,helvetica">
							#q_ModelName#
						</FONT>
					</TD><TD>
						<FONT SIZE=2 FACE="arial,helvetica">
							#q_caryear#
						</FONT>
					</TD><TD>
						<FONT SIZE=1 FACE="arial,helvetica">
							#q_VIN#
						</FONT>
					</TD><TD>
						<FONT SIZE=1 FACE="arial,helvetica">
							#q_stock#
						</FONT>
					</TD><TD>
						<FONT SIZE=2 FACE="arial,helvetica">
							#q_image#
						</FONT>
					</TD></TR>
					</CFOUTPUT>
					</TABLE>
					</TD>
				</TR>
			<CFELSE>
				<TR align="center">
					<TD><FONT Face="Arial,Helvetica">There are currently NO Used Vehicles Associated with this Dealership.</FONT></TD>
				</TR>
			</CFIF>
			<TR>
				<TD>&nbsp;</TD>
			</TR>
			<INPUT TYPE="hidden" name="dealercode" value="<CFOUTPUT>#g_dealercode#</CFOUTPUT>">
			<CFIF #selectUsedVehicles.RecordCount# IS NOT 0>
				<TR>
					<TD>&nbsp;&nbsp;&nbsp;</TD>
				</TR>
				<TR align="center">
					<TD><FONT SIZE=2 FACE="arial,helvetica">
					<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/deletevehicle.jpg" BORDER="0" name="BtnDelete" value="Delete Vehicle">&nbsp;&nbsp;&nbsp;<INPUT
					TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/modifyvehicle.jpg" BORDER="0" name="BtnModify" value="Modify Vehicle">
					</FONT>
					</TD>
				</TR>
			</CFIF>
			<TR>
				<TD>&nbsp;&nbsp;&nbsp;</TD>
			</TR>
			<TR align="center">
				<TD><FONT SIZE=2 FACE="arial,helvetica">
				<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg" BORDER="0" NAME="btnCancel" VALUE="Cancel">&nbsp;&nbsp;&nbsp;<INPUT
				TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/addpreowned.jpg" BORDER="0" name="BtnAdd" value="Add Pre-Owned Vehicle">
				</FONT>
				</TD>
			</TR>
			</FORM>
			<TR>
				<TD>&nbsp;&nbsp;&nbsp;</TD>
			</TR>
			<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
			<TR>
				<TD>&nbsp;&nbsp;&nbsp;</TD>
			</TR>
			<TR ALIGN=CENTER>
				<TD><FONT SIZE=2 FACE="arial,helvetica">
				<INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg"
			Border="0"
			NAME="BackToMain"
			VALUE="Back To Main Menu">
				</FONT></TD>
			</TR>
			</FORM>
			<TR>
				<TD>&nbsp;</TD>
			</TR>
		</CFIF>

		<CFIF DeleteMode>
			<FORM NAME="StepNine" ACTION="webnew_s9.cfm" METHOD="post">
			<TR align="center">
				<TD><FONT Face="arial,Helvetica">You are about to permanently Delete the following Pre-Owned Vehicle.  Are you sure you wish to proceed?</FONT></TD>
			</TR>
			<TR>
				<TD>&nbsp;&nbsp;&nbsp;</TD>
			</TR>
			<TR align="center"><TD>
				<TABLE BORDER=0>
					<CFOUTPUT query="selectUsedVehicle">
					<TR>
						<TD><FONT SIZE=2 FACE="arial,helvetica"><b>Model Make</b></FONT></TD>
						<TD><FONT SIZE=2 FACE="arial,helvetica">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#q_make#</FONT></TD>
					</TR>
					<TR>
						<TD><FONT SIZE=2 FACE="arial,helvetica"><b>Model Name</b></FONT></TD>
						<TD><FONT SIZE=2 FACE="arial,helvetica">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#q_modelName#</FONT></TD>
					</TR>
					<TR>
						<TD><FONT SIZE=2 FACE="arial,helvetica"><b>Car Year</b></FONT></TD>
						<TD><FONT SIZE=2 FACE="arial,helvetica">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#q_caryear#</FONT></TD>
					</TR>
					<TR>
						<TD><FONT SIZE=2 FACE="arial,helvetica"><b>Interior Color</b></FONT></TD>
						<TD><FONT SIZE=2 FACE="arial,helvetica">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#q_intcolor#</FONT></TD>
					</TR>
					<TR>
						<TD><FONT SIZE=2 FACE="arial,helvetica"><b>Exterior Color</b></FONT></TD>
						<TD><FONT SIZE=2 FACE="arial,helvetica">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#q_extcolor#</FONT></TD>
					</TR>
					<TR>
						<TD><FONT SIZE=2 FACE="arial,helvetica"><b>Transmission</b></FONT></TD>
						<TD><FONT SIZE=2 FACE="arial,helvetica">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#q_transmission#</FONT></TD>
					</TR>
					<TR>
						<TD><FONT SIZE=2 FACE="arial,helvetica"><b>Mileage</b></FONT></TD>
						<TD><FONT SIZE=2 FACE="arial,helvetica">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#q_mileage#</FONT></TD>
					</TR>
					<TR>
						<TD><FONT SIZE=2 FACE="arial,helvetica"><b>Price</b></FONT></TD>
						<TD><FONT SIZE=2 FACE="arial,helvetica">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#q_price#</FONT></TD>
					</TR>
					<TR>
						<TD><FONT SIZE=2 FACE="arial,helvetica"><b>Stock</b></FONT></TD>
						<TD><FONT SIZE=2 FACE="arial,helvetica">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#q_stock#</FONT></TD>
					</TR>								
					<TR>
						<TD><FONT SIZE=2 FACE="arial,helvetica"><b>VIN</b></FONT></TD>
						<TD><FONT SIZE=2 FACE="arial,helvetica">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#q_VIN#</FONT></TD>
					</TR>
					<TR>
						<TD><FONT SIZE=2 FACE="arial,helvetica"><b>Comments</b></FONT></TD>
						<TD><FONT SIZE=2 FACE="arial,helvetica">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#q_features#</FONT></TD>
					</TR>
					</CFOUTPUT>
				</TABLE>
				</TD>
			</TR>	
			<TR>
				<TD>&nbsp;&nbsp;&nbsp;</TD>
			</TR>
			<TR align="center">
				<TD><INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg" BORDER="0" NAME="btnCancel" VALUE="Cancel">&nbsp;&nbsp;&nbsp;<INPUT
				TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/deletevehicle.jpg" BORDER="0" name="BtnKill" value="Delete Pre-Owned Vehicle"></TD>
			</TR>
			<INPUT type="hidden" name="VehicleID" value="<CFOUTPUT>#form.vehicleID#</CFOUTPUT>">
			<INPUT type="hidden" name="dealercode" value="<CFOUTPUT>#g_dealercode#</CFOUTPUT>">
			</FORM>
			<TR>
				<TD>&nbsp;&nbsp;&nbsp;</TD>
			</TR>
			<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
			<TR align="center">
				<TD><INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg"
			Border="0"
			NAME="BackToMain"
			VALUE="Back To Main Menu"></TD>
			</TR>
			</FORM>
			<TR>
				<TD>&nbsp;</TD>
			</TR>
		</CFIF>
	
		<CFIF (NewMode1) OR (ModifyMode1)>
			<FORM NAME="StepNine" ACTION="webnew_s9.cfm" METHOD="post">
			<TR align="center">
				<TD>
				<TABLE BORDER=0 WIDTH="90%">
					<TR ALIGN="center">
						<TD><FONT FACE="Arial,Helvetica">Enter the following information. Required fields are bolded.</FONT></TD>
					</TR>
					<TR>
						<TD>&nbsp;</TD>
					</TR>
					<TR align="center">
						<TD><FONT SIZE=2 FACE="arial,helvetica"><b>Model Make:</b>&nbsp;&nbsp;&nbsp;
						<SELECT NAME="make">
						<OPTION VALUE="">Please select a vehicle make</OPTION>
						<CFOUTPUT QUERY="selectVehicleMakes">
						<CFIF ModifyMode1>
							<OPTION VALUE="#make#" <CFIF Make EQ RTrim(selectUsedVehicle.q_Make)>SELECTED</CFIF>>#make#</OPTION>
						<CFELSE>
							<OPTION VALUE="#make#">#make#</OPTION>
						</CFIF>
						</CFOUTPUT>
						</SELECT>
						</FONT><INPUT TYPE="hidden" name="Make_required"></TD>
					</TR>
					<TR>
						<TD>&nbsp;&nbsp;</TD>
					</TR>
					<INPUT type="hidden" name="dealercode" value="<CFOUTPUT>#g_dealercode#</CFOUTPUT>">
					<CFIF ModifyMode1>
						<INPUT type="hidden" name="vehicleID" value="<CFOUTPUT>#form.vehicleID#</CFOUTPUT>">
					</CFIF>
					<TR align="center">
						<TD><INPUT TYPE="hidden" NAME="NextStep" VALUE="webvrfy_s10.cfm">
						<CFIF ModifyMode1>
							<INPUT type="hidden" name="ModifyFlag" value="1">
						</CFIF>
						<CFIF NewMode1>
							<INPUT type="hidden" name="NewFlag" value="1">
						</CFIF>
						<A HREF="webvrfy_s9.cfm?dlrcode=<CFOUTPUT>#FORM.dealercode#</CFOUTPUT>">
						<IMG SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg" BORDER="0" NAME="btnCancel" VALUE="Cancel"></A>
						&nbsp;&nbsp;&nbsp;
						<CFIF ModifyMode1>
							<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next_nav.jpg" BORDER="0" NAME="btnSave1" VALUE="Next">
						<CFELSE>
							<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next_nav.jpg" BORDER="0" NAME="btnNew1" VALUE="Next">
						</CFIF>
						</TD>
					</TR>
					</FORM>
					<TR>
						<TD ALIGN="CENTER">
						<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
						<INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg"
			Border="0"
			NAME="BackToMain"
			VALUE="Back To Main Menu">
						</FORM>
						</TD>
					</TR>
					<TR>
						<TD>&nbsp;</TD>
					</TR>
				</TABLE>
				</TD>
			</TR>
		</CFIF>

		<CFIF (NewMode2) OR (ModifyMode2)>
			<FORM NAME="StepNine" ACTION="webnew_s9.cfm" METHOD="post">
			<TR align="center">
				<TD>
				<TABLE BORDER=0 WIDTH="90%">
					<TR ALIGN="center">
						<TD><FONT FACE="Arial,Helvetica">Enter the following information. Required fields are bolded.</FONT></TD>
					</TR>
					<TR>
						<TD>&nbsp;</TD>
					</TR>
					<TR align="center">
						<TD><FONT SIZE=2 FACE="arial,helvetica"><b>Model Name:</b>&nbsp;&nbsp;&nbsp;
						<SELECT NAME="modelname">
						<OPTION VALUE="">Please select a model</OPTION>
						<CFOUTPUT QUERY="selectVehicleModelNames">
						<CFIF ModifyMode2>
							<OPTION VALUE="#ModelName#" <CFIF #ModelName# EQ #selectUsedVehicle.q_ModelName#>SELECTED</CFIF>>#ModelName#</OPTION>
						<CFELSE>
							<OPTION VALUE="#ModelName#">#ModelName#</OPTION>
						</CFIF>
						</CFOUTPUT>
						</SELECT></FONT></TD>
					</TR>
					<TR>
						<TD>&nbsp;&nbsp;</TD>
					</TR>
					<INPUT type="hidden" name="ModelName_required">
					<INPUT TYPE="hidden" NAME="make" VALUE="<CFOUTPUT>#Form.make#</CFOUTPUT>">
					<INPUT type="hidden" name="dealercode" value="<CFOUTPUT>#g_dealercode#</CFOUTPUT>">
					<CFIF ModifyMode2>
						<INPUT type="hidden" name="vehicleID" value="<CFOUTPUT>#form.vehicleID#</CFOUTPUT>">
					</CFIF>
					<TR align="center">
						<TD><INPUT TYPE="hidden" NAME="NextStep" VALUE="webvrfy_s10.cfm">
						<CFIF ModifyMode2>
							<INPUT type="hidden" name="ModifyFlag" value="1">
						</CFIF>
						<CFIF NewMode2>
							<INPUT type="hidden" name="NewFlag" value="1">
						</CFIF>
						<A HREF="webvrfy_s9.cfm?dlrcode=<CFOUTPUT>#FORM.dealercode#</CFOUTPUT>">
						<IMG SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg" BORDER="0" NAME="btnCancel" VALUE="Cancel"></A>
						&nbsp;&nbsp;&nbsp;
						<CFIF ModifyMode2>
							<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next_nav.jpg" BORDER="0" NAME="btnSave2" VALUE="Next">
						<CFELSE>
							<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next_nav.jpg" BORDER="0" NAME="btnNew2" VALUE="Next">
						</CFIF>
						</TD>
					</TR>
					</FORM>
					<TR>
						<TD ALIGN="CENTER">
						<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
						<INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg"
			Border="0"
			NAME="BackToMain"
			VALUE="Back To Main Menu">
						</FORM>
						</TD>
					</TR>
					<TR>
						<TD>&nbsp;</TD>
					</TR>
				</TABLE>
				</TD>
			</TR>
		</CFIF>

		<CFIF (NewMode3) OR (ModifyMode3)>
			<FORM NAME="StepNine" ACTION="webnew_s9.cfm" METHOD="post">
			<TR ALIGN="center">
				<TD><FONT FACE="Arial,Helvetica">Enter the following information. Required fields are bolded.</FONT></TD>
			</TR>
			<TR>
				<TD>&nbsp;</TD>
			</TR>
			<TR align="center">
				<TD width="90%">
				<TABLE BORDER=0>
					<TR>
						<TD><FONT SIZE=2 FACE="arial,helvetica"><b>Model Make</b></FONT></TD>
						<TD><FONT SIZE=2 FACE="arial,helvetica"><CFOUTPUT>#Form.make#</CFOUTPUT></FONT></TD>
						<!-------pass along the make to the next page------->
						<INPUT type="hidden" name="Make" Value="<CFOUTPUT>#Form.Make#</CFOUTPUT>">
					</TR>
					<TR>
						<TD><FONT SIZE=2 FACE="arial,helvetica"><b>Model Name</b></FONT></TD>
						<TD><FONT SIZE=2 FACE="arial,helvetica"><CFOUTPUT>#Form.ModelName#</CFOUTPUT>
						<INPUT type="hidden" name="ModelName" VALUE="<CFOUTPUT>#Form.ModelName#</CFOUTPUT>">
						</TD>
					</TR>
					<TR>
						<TD><FONT SIZE=2 FACE="arial,helvetica"><b>Car Year</b></FONT></TD>
						<TD><FONT SIZE=2 FACE="arial,helvetica">
						
						<SELECT NAME="CarYear">
						<OPTION VALUE="">Please select a vehicle year
						<CFOUTPUT QUERY="selectUsedVehicleModelYears">
						<CFIF ModifyMode3>
							<OPTION VALUE="#Year#" <CFIF #Year# EQ #selectUsedVehicle.q_CarYear#>SELECTED</CFIF>>#Year#
						<CFELSE>
							<OPTION VALUE="#Year#">#Year#
						</CFIF>
						</CFOUTPUT>
						</SELECT>
						</FONT>
						<INPUT type="hidden" name="CarYear_required">
						</TD>
					</TR>
					<TR>
						<TD><FONT SIZE=2 FACE="arial,helvetica"><b>Interior Color</b></FONT></TD>
						<TD><FONT SIZE=2 FACE="arial,helvetica">
						<CFIF ModifyMode3>
							<CFOUTPUT query="selectUsedVehicle">
							<INPUT type="text" name="intcolor" value="#q_intcolor#" size=30 maxlength=20>
							</CFOUTPUT>
						<CFELSE>
							<INPUT type="text" name="intcolor"  size=30 maxlength=20>
						</CFIF>
						</FONT>
						<!--- <INPUT type="hidden" name="intcolor_required"> --->
						</TD>
					</TR>
					<TR>
						<TD><FONT SIZE=2 FACE="arial,helvetica"><b>Exterior Color</b></FONT></TD>
						<TD>
						<FONT SIZE=2 FACE="arial,helvetica">
						<CFIF ModifyMode3>
							<CFOUTPUT query="selectUsedVehicle">
							<INPUT type="text" name="extcolor" value="#q_extcolor#" size=30 maxlength=20>
							</CFOUTPUT>
						<CFELSE>
							<INPUT type="text" name="extcolor"  size=30 maxlength=20>
						</CFIF>
						</FONT>
						<!--- <INPUT type="hidden" name="extcolor_required"> --->
						</TD>
					</TR>
					<TR>
						<TD><FONT SIZE=2 FACE="arial,helvetica"><b>Transmission</b></FONT></TD>
						<TD>
						<FONT SIZE=2 FACE="arial,helvetica">
						<CFIF ModifyMode3>
							<CFOUTPUT query="selectUsedVehicle">
							<SELECT name="transmission">
							<CFIF #Trim(q_transmission)# IS 'Automatic'>
								<OPTION VALUE="">Select Transmission Type
								<OPTION VALUE="Automatic" SELECTED>Automatic
								<OPTION VALUE="Manual">Manual
							<CFELSEIF #Trim(q_transmission)# IS 'Manual'>
								<OPTION VALUE="">Select Transmission Type
								<OPTION VALUE="Automatic">Automatic
								<OPTION VALUE="Manual" SELECTED>Manual
							<CFELSE>
								<OPTION VALUE="" SELECTED>Select Transmission Type
								<OPTION VALUE="Automatic">Automatic
								<OPTION VALUE="Manual">Manual
							</CFIF>
							</SELECT>
							</CFOUTPUT>
						<CFELSE>
							<SELECT name="transmission">
							<OPTION VALUE="" SELECTED>Select Transmission Type
							<OPTION VALUE="Automatic">Automatic
							<OPTION VALUE="Manual">Manual
							</SELECT>
						</CFIF>
						</FONT>
						</TD>
					</TR>
					<TR>
						<TD><FONT SIZE=2 FACE="arial,helvetica"><b>Mileage</b></FONT></TD>
						<TD>
						<FONT SIZE=2 FACE="arial,helvetica">
						<CFIF ModifyMode3>
							<CFOUTPUT query="selectUsedVehicle">
							<INPUT type="text" name="mileage" value="#q_mileage#" size=30 maxlength=7>
							</CFOUTPUT>
						<CFELSE>
							<INPUT type="text" name="mileage"  size=30 maxlength=7>
						</CFIF>
						</FONT>
						<!--- <INPUT type="hidden" name="mileage_required"> --->
						<INPUT TYPE="hidden" name="mileage_integer">
						</TD>
					</TR>			
					<TR>
						<TD><FONT SIZE=2 FACE="arial,helvetica"><b>Price</b></FONT></TD>
						<TD>
						<FONT SIZE=2 FACE="arial,helvetica">
						<CFIF ModifyMode3>
							<CFOUTPUT query="selectUsedVehicle">
							<INPUT type="text" name="price" value="#q_price#" size=30 maxlength=11>
							</CFOUTPUT>
						<CFELSE>
							<INPUT type="text" name="price"  size=30 maxlength=11>
						</CFIF>
						</FONT>
						<!--- <INPUT type="hidden" name="price_required"> --->
						<INPUT TYPE="hidden" name="price_integer">
						</TD>
					</TR>
					<TR>
						<TD><FONT SIZE=2 FACE="arial,helvetica"><b>Stock</b></FONT></TD>
						<TD>
						<FONT SIZE=2 FACE="arial,helvetica">
						<CFIF ModifyMode3>
							<CFOUTPUT query="selectUsedVehicle">
							<INPUT type="text" name="stock" value="#q_stock#" size=30 maxlength=15>
							</CFOUTPUT>
						<CFELSE>
							<INPUT type="text" name="stock"  size=30 maxlength=15>
						</CFIF>
						</FONT>
						<!--- <INPUT type="hidden" name="stock_required"> --->
						</TD>
					</TR>
					<TR>
						<TD><FONT SIZE=2 FACE="arial,helvetica"><B>VIN</B></FONT></TD>
						<TD>
						<FONT SIZE=2 FACE="arial,helvetica">
						<CFIF ModifyMode3>
							<CFOUTPUT query="selectUsedVehicle">
							<INPUT type="text" name="VIN" size="20" maxlength="17" value="#q_VIN#">
							</CFOUTPUT>
						<CFELSE>
							<INPUT type="text" name="VIN" size="20" maxlength="17">
						</CFIF>
						</FONT>
						 <INPUT type="hidden" name="VIN_required"> 
						</TD>
					</TR>
					<TR>
						<TD><FONT SIZE=2 FACE="arial,helvetica"><B>Comments</B></FONT></TD>
						<TD>
						<FONT SIZE=2 FACE="arial,helvetica">
						<CFIF ModifyMode3>
							<CFOUTPUT query="selectUsedVehicle">
							<textarea name="Features" rows="5" cols="40" wrap="virtual">#q_Features#</textarea>
							</CFOUTPUT>
						<CFELSE>
							<textarea name="Features" rows="5" cols="40" wrap="virtual"></textarea>
						</CFIF>
						</FONT>
						</TD>
					</TR>
					<TR>
						<TD><FONT SIZE=2 FACE="arial,helvetica"><B>Extra Features</B></FONT></TD>
						<TD>
						<FONT SIZE=2 FACE="arial,helvetica">
						<SELECT name="extrafeatures">
						<CFIF ModifyMode3>
							<CFLOOP INDEX="LoopCount" FROM="0" TO="20">
							<CFOUTPUT>
							<OPTION value="#LoopCount#" <CFIF #selectExtraFeatures.NumOfExtraFeatures# EQ #LoopCount#>SELECTED</CFIF>>#LoopCount#
							</CFOUTPUT>
							</CFLOOP>
						<CFELSE>
							<CFLOOP INDEX="LoopCount" FROM="0" TO="20">
							<CFOUTPUT>
							<OPTION value="#LoopCount#">#LoopCount#
							</CFOUTPUT>
							</CFLOOP>
						</CFIF>
						</SELECT>
						</FONT>
						</TD>
					</TR>
				</TABLE>
				</TD>
			</TR>
			<TR>
				<TD>&nbsp;</TD>
			</TR>
			<TR>
				<TD align="center"><FONT FACE="Arial,Helvetica">Would you like to include a picture of this vehicle?</FONT></TD>
			</TR>
			<TR>
				<TD ALIGN="Center">
				<FONT FACE="Arial,Helvetica">
				<CFIF ModifyMode3>
					<INPUT type="radio" name="image" value="Y"
					<CFIF #selectUsedVehicle.q_Image# EQ 'Y'>CHECKED</CFIF>>Yes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<INPUT
					type="radio" name="image" value="N" <CFIF #selectUsedVehicle.q_Image# EQ 'N'>CHECKED</CFIF>>No
				<CFELSE>
					<INPUT type="radio" name="image" value="Y">Yes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<INPUT
					type="radio" name="image" value="N" CHECKED>No
				</CFIF>
				</FONT></TD>
			</TR>
			<TR>
				<TD>&nbsp;&nbsp;</TD>
			</TR>
			<INPUT type="hidden" name="dealercode" value="<CFOUTPUT>#g_dealercode#</CFOUTPUT>">
			<CFIF IsDefined("form.vehicleID")>
				<INPUT type="hidden" name="vehicleID" value="<CFOUTPUT>#form.vehicleID#</CFOUTPUT>">
			</CFIF>
			<TR align="center">
				<TD><FONT FACE="Arial,Helvetica" size="-1">
				<A HREF="webvrfy_s9.cfm?dlrcode=<CFOUTPUT>#FORM.dealercode#</CFOUTPUT>">
				<IMG SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg" BORDER="0" NAME="btnCancel" VALUE="Cancel"></A>&nbsp;&nbsp;&nbsp;
				<INPUT TYPE="hidden" NAME="NextStep" VALUE="webvrfy_s10.cfm">
				<CFIF ModifyMode3>
					<INPUT type="hidden" name="ModifyFlag" value="1">
				</CFIF>
			
				<CFIF NewMode3>
					<INPUT type="hidden" name="NewFlag" value="1">
				</CFIF>
			 
				<CFIF ModifyMode3>
					<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next_nav.jpg" BORDER="0" NAME="btnSave3" VALUE="Next">
				<CFELSE>
					<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next_nav.jpg" BORDER="0" NAME="btnNew3" VALUE="Next">
				</CFIF>
				</FONT></TD>
			</TR>
			</FORM>
			<TR>
				<TD COLSPAN=2>&nbsp;&nbsp;&nbsp;</TD>
			</TR>
			<TR align="center">
				<TD>
				<FORM action="webnew_s9.cfm" method="post">
				<CFOUTPUT>
				<INPUT type="hidden" name="dealercode" value="#g_dealercode#">
				<CFIF IsDefined("form.vehicleID")>
					<INPUT type="hidden" name="vehicleID" value="#form.vehicleID#">
				</CFIF>
				</CFOUTPUT>
				</FORM>					
				<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
				<INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg"
			Border="0"
			NAME="BackToMain"
			VALUE="Back To Main Menu">
				</FORM></TD>
			</TR>
			<TR>
				<TD>&nbsp;</TD>
			</TR>
		</CFIF>

		<CFIF (NewMode4) OR (ModifyMode4)>
			<FORM NAME="StepNine" ACTION="webnew_s9.cfm" METHOD="post">
			<TR ALIGN="center">
				<TD><FONT FACE="Arial,Helvetica">Enter the following information.</FONT></TD>
			</TR>
			<TR>
				<TD>&nbsp;&nbsp;&nbsp;</TD>
			</TR>
			<TR align="center">
				<TD><FONT SIZE=3 FACE="arial,helvetica"><b>Extra Features</b></FONT></TD>
			</TR>
			<TR>
				<TD>&nbsp;&nbsp;&nbsp;</TD>
			</TR>
			<TR>
				<TD>
				<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH="100%">
					<CFIF ModifyMode4>
						<CFIF Form.extrafeatures GT getNumOfOptions.NumOfOptions>
							<CFSET LoopCount = 1>
							<CFLOOP QUERY="selectOptions">
								<TR>
									<TD><font face="Arial, Helvetica" SIZE=2>&nbsp;&nbsp;Feature <CFOUTPUT>#LoopCount#</CFOUTPUT></font></TD>
									<TD><font face="Arial, Helvetica" SIZE=2>
									<INPUT NAME="extrafeature<CFOUTPUT>#LoopCount#</CFOUTPUT>" TYPE="TEXT" SIZE="30" VALUE="<CFOUTPUT>#Options#</CFOUTPUT>">
									<INPUT NAME="extrafeature<CFOUTPUT>#LoopCount#</CFOUTPUT>_required" TYPE="hidden">
									</font>
									</TD>
								</TR>
								<CFSET LoopCount = (LoopCount + 1)>
							</CFLOOP>
							<CFLOOP INDEX="LoopIndex" FROM="#Variables.LoopCount#" TO="#Form.extrafeatures#">
								<TR>
									<TD><font face="Arial, Helvetica" SIZE=2>&nbsp;&nbsp;Feature <CFOUTPUT>#LoopIndex#</CFOUTPUT></font></TD>
									<TD><font face="Arial, Helvetica" SIZE=2>
									<INPUT NAME="extrafeature<CFOUTPUT>#LoopIndex#</CFOUTPUT>" TYPE="TEXT" SIZE="30">
									<INPUT NAME="extrafeature<CFOUTPUT>#LoopIndex#</CFOUTPUT>_required" TYPE="hidden">
									</font>
									</TD>
								</TR>
							</CFLOOP>
						<CFELSEIF getNumOfOptions.NumOfOptions GT Form.extrafeatures>
	 						<CFSET SpecialCase = 0>
							<CFSET LoopCount = 1>
							<CFLOOP QUERY="selectOptions">
								<CFIF SpecialCase EQ 0>
									<TR>
										<TD><font face="Arial, Helvetica" SIZE=2>&nbsp;&nbsp;Feature <CFOUTPUT>#LoopCount#</CFOUTPUT></font></TD>
										<TD><font face="Arial, Helvetica" SIZE=2>
										<INPUT NAME="extrafeature<CFOUTPUT>#LoopCount#</CFOUTPUT>" TYPE="TEXT" SIZE="30" VALUE="<CFOUTPUT>#Options#</CFOUTPUT>">
										<INPUT NAME="extrafeature<CFOUTPUT>#LoopCount#</CFOUTPUT>_required" TYPE="hidden">
										</font>
										</TD>
									</TR>
								</CFIF>
								<CFIF LoopCount EQ #Form.extrafeatures#>
									<CFSET SpecialCase = 1>
								</CFIF>
								<CFSET LoopCount = (LoopCount + 1)>
							</CFLOOP>
						<CFELSE>
							<CFSET LoopCount = 1>
							<CFLOOP QUERY="selectOptions">
								<TR>
									<TD><font face="Arial, Helvetica" SIZE=2>&nbsp;&nbsp;Feature <CFOUTPUT>#LoopCount#</CFOUTPUT></font></TD>
									<TD><font face="Arial, Helvetica" SIZE=2>
									<INPUT NAME="extrafeature<CFOUTPUT>#LoopCount#</CFOUTPUT>" TYPE="TEXT" SIZE="30" VALUE="<CFOUTPUT>#Options#</CFOUTPUT>">
									<INPUT NAME="extrafeature<CFOUTPUT>#LoopCount#</CFOUTPUT>_required" TYPE="hidden">
									</font>
									</TD>
								</TR>
								<CFSET LoopCount = (LoopCount + 1)>
							</CFLOOP>
						</CFIF>
					<CFELSE>
						<CFLOOP INDEX="LoopCount" FROM="1" TO="#Form.extrafeatures#">
							<TR>
								<TD><font face="Arial, Helvetica" size="2">&nbsp;&nbsp;Extra Feature <CFOUTPUT>#LoopCount#</CFOUTPUT></font></TD>
								<TD><font face="Arial, Helvetica" size="2">
								<INPUT NAME="extrafeature<CFOUTPUT>#LoopCount#</CFOUTPUT>" TYPE="TEXT" SIZE="30">
								<INPUT NAME="extrafeature<CFOUTPUT>#LoopCount#</CFOUTPUT>_required" TYPE="hidden">
								</font>
								</TD>
							</TR>
						</CFLOOP>
					</CFIF>
				</TABLE>
				</TD>
			</TR>
			<TR>
				<TD>
				<INPUT TYPE="hidden" NAME="Make" VALUE="<CFOUTPUT>#Trim(Form.Make)#</CFOUTPUT>">
				<INPUT TYPE="hidden" NAME="ModelName" VALUE="<CFOUTPUT>#Trim(Form.ModelName)#</CFOUTPUT>">
				<INPUT TYPE="hidden" NAME="CarYear" VALUE="<CFOUTPUT>#Trim(Form.CarYear)#</CFOUTPUT>">
				<INPUT TYPE="hidden" NAME="intcolor" VALUE="<CFOUTPUT>#Trim(Form.intcolor)#</CFOUTPUT>">
				<INPUT TYPE="hidden" NAME="extcolor" VALUE="<CFOUTPUT>#Trim(Form.extcolor)#</CFOUTPUT>">
				<INPUT TYPE="hidden" NAME="transmission" VALUE="<CFOUTPUT>#Trim(Form.transmission)#</CFOUTPUT>">
				<INPUT TYPE="hidden" NAME="Mileage" VALUE="<CFOUTPUT>#Trim(Form.Mileage)#</CFOUTPUT>">
				<INPUT TYPE="hidden" NAME="price" VALUE="<CFOUTPUT>#Trim(Form.price)#</CFOUTPUT>">
				<INPUT TYPE="hidden" NAME="stock" VALUE="<CFOUTPUT>#Trim(Form.stock)#</CFOUTPUT>">
				<INPUT TYPE="hidden" NAME="VIN" VALUE="<CFOUTPUT>#Trim(Form.VIN)#</CFOUTPUT>">
				<INPUT TYPE="hidden" NAME="Features" VALUE="<CFOUTPUT>#Trim(Form.Features)#</CFOUTPUT>">
				<INPUT TYPE="hidden" NAME="extrafeatures" VALUE="<CFOUTPUT>#Trim(Form.extrafeatures)#</CFOUTPUT>">
				<INPUT type="hidden" name="image" value="<CFOUTPUT>#Form.Image#</CFOUTPUT>">
				<INPUT type="hidden" name="dealercode" value="<CFOUTPUT>#g_dealercode#</CFOUTPUT>">
				<CFIF IsDefined("form.vehicleID")>
					<INPUT type="hidden" name="vehicleID" value="<CFOUTPUT>#form.vehicleID#</CFOUTPUT>">
				</CFIF>
				<INPUT TYPE="hidden" NAME="NextStep" VALUE="webvrfy_s10.cfm">&nbsp;&nbsp;</TD>
			</TR>
			<TR align="center">
				<TD>
				<CFIF IsDefined("Form.NewFlag")>
					<INPUT type="hidden" name="NewFlag" value="1">
				<CFELSE>
					<INPUT type="hidden" name="ModifyFlag" value="1">
				</CFIF>
				<CFIF Form.Image EQ 'Y'>
					<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next_nav.jpg" BORDER="0" NAME="btnChooseImage" VALUE="Next">
				<CFELSE>
					<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/saveandcontinue_nav.jpg" BORDER="0" NAME="btnSave4" VALUE="Save">
				</CFIF>
				</TD>
			</TR>
			</FORM>
			<TR>
				<TD>&nbsp;&nbsp;&nbsp;</TD>
			</TR>
			<FORM action="webnew_s9.cfm" method="post">
			<INPUT type="hidden" name="dealercode" value="<CFOUTPUT>#g_dealercode#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="Make" VALUE="<CFOUTPUT>#Trim(Form.Make)#</CFOUTPUT>">
			<CFIF IsDefined("form.vehicleID")>
				<INPUT type="hidden" name="vehicleID" value="<CFOUTPUT>#form.vehicleID#</CFOUTPUT>">
			</CFIF>
			<FORM action="webvrfy_s9.cfm?dlrcode=<CFOUTPUT>#g_dealercode#</CFOUTPUT>" method="post">
			<TR align="center">
				<TD><INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg" BORDER="0" NAME="btnCancel" VALUE="Cancel"></TD>
			</TR>
			<TR>
				<TD>&nbsp;</TD>
			</TR>
			<TR align="center">
				<TD>
				<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
            	<INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg"
			Border="0"
			NAME="BackToMain"
			VALUE="Back To Main Menu">
				</FORM>
				</TD>
			</TR>
		</CFIF>

		<CFIF ImageMode>
			<CFIF IsDefined("Form.ModifyFlag")>
				<CFSET Modify = TRUE>
				<CFQUERY name="CheckImage" datasource="#gDSN#">
				SELECT Image
				FROM UsedVehicles
				WHERE UsedVehicleID = #Form.VehicleID#;
				</CFQUERY>
				
				<CFIF #CheckImage.Image# IS 'N'>
					<CFSET Modify = FALSE>
				</CFIF>
			<CFELSE>
				<CFSET Modify = FALSE>
			</CFIF>
			<FORM NAME="StepNine" ACTION="webnew_s9.cfm" METHOD="post" ENCTYPE="multipart/form-data">
			<CFIF IsDefined("Url.Redirect")>
				<INPUT type="hidden" name="FileContents_required" value="<A HREF='Javascript:history.back();'>You must select a file to Upload.</A>">
				<TR align="center">
					<TD><FONT FACE="Arial,Helvetica">
					The image you chose, shown below, is larger than the acceptable size (320 pixels wide by 240 pixels high).
					<b>Please choose another image</b>.<br><p></FONT></TD>
				</TR>
				<TR>
					<TD>&nbsp;</TD>
				</TR>
				<TR align="center">
					<TD><IMG SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/usedvehicles/temp_<CFOUTPUT>#tmpid#</CFOUTPUT>_.jpg"></TD>
				</TR>
				<TR>
					<TD>&nbsp;</TD>
				</TR>
			<CFELSEIF IsDefined("URL.mime")>
				<INPUT type="hidden" name="FileContents_required" value="<A HREF='Javascript:history.back();'>You must select a file to Upload.</A>">
				<TR align="center">
					<TD><FONT FACE="Arial,Helvetica">The image you chose, shown below, is not a JPEG file<br>(.jpg extension)
					<br>
					Please choose another image.</FONT>
					<p>
					<IMG SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/usedvehicles/temp_<CFOUTPUT>#tmpid#</CFOUTPUT>_.jpg">
					</TD>
				</TR>
				<TR>
					<TD>&nbsp;</TD>
				</TR>
			<CFELSE>
				<CFIF Modify EQ FALSE>
					<TR align="center">
						<TD><FONT FACE="Arial,Helvetica">Enter the name of the file you wish to upload, or click <i>Browse</i> to choose from a list of files.</FONT>
						<br>
						<FONT FACE="Arial,Helvetica" SIZE="-1"><i>Note:</i> The file you upload must be a JPEG file (.jpg file extension) and must be less than 320 pixels wide by 240 pixels high.</FONT>
						</TD>
					</TR>
					<TR>
						<TD>&nbsp;</TD>
					</TR>
					<INPUT type="hidden" name="FileContents_required" value="<A HREF='Javascript:history.back();'>You must select a file to Upload.</A>">
				</CFIF>
				<CFIF Modify EQ TRUE>
					<TR align="center">
						<TD><FONT FACE="Arial,Helvetica">
						The image below will be displayed with this Used Vehicle.</FONT>
						<br>
						<FONT FACE="Arial,Helvetica" size="-1"><i>Note:</i> If the image shown below is incorrect, please click the
						<b>Reload</b> button on your browser.</FONT>
						<br></td>
					</TR>
					<TR align="center">
						<TD><IMG SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/usedvehicles/<CFOUTPUT>#form.VIN#</CFOUTPUT>.jpg"></TD>
					</TR>
					<TR>
						<TD>&nbsp;</TD>
					</TR>
					<TR align="center">
						<TD><FONT FACE="Arial,Helvetica">
						If you wish to replace this image, enter the name of the file you wish to upload, or click the <i>Browse</i> button
						to choose from a list of files.
						<br>
						Leave this field blank to continue displaying the image above.
						<br>
						</FONT>
						<FONT FACE="Arial,Helvetica" SIZE="-1"><i>Note:</i> The file you upload must be a JPEG file (.jpg file extension) and must be less than 320 pixels wide by 240 pixels high.</FONT></TD>
					</TR>
				</CFIF>
				<TR>
					<TD align="center"><br><p></TD>
				</TR>
				<TR>
					<TD align="center"><FONT FACE="Arial,Helvetica" SIZE="-1"><i>Note:</i> You must be using Netscape (version 3 or higher) or Microsoft Internet Explorer (version 4 or higher) to upload images.</FONT><br></TD>
				</TR>
				<TR>
					<TD align="center"><br><p></TD>
				</TR>
			</CFIF>
			<TR align="center">
				<!--- Linda: is there any way to make the default type in the drop-down of "browse" be .jpg?  instead of .html? --->
				<TD><FONT FACE="Arial,Helvetica"><INPUT TYPE="file" NAME="FileContents"></FONT></TD>
			</TR>
			<TR>
				<TD>&nbsp;</TD>
			</TR>
			<INPUT TYPE="hidden" NAME="Make" VALUE="<CFOUTPUT>#Trim(Form.Make)#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="ModelName" VALUE="<CFOUTPUT>#Trim(Form.ModelName)#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="CarYear" VALUE="<CFOUTPUT>#Trim(Form.CarYear)#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="intcolor" VALUE="<CFOUTPUT>#Trim(Form.intcolor)#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="extcolor" VALUE="<CFOUTPUT>#Trim(Form.extcolor)#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="transmission" VALUE="<CFOUTPUT>#Trim(Form.transmission)#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="Mileage" VALUE="<CFOUTPUT>#Trim(Form.Mileage)#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="price" VALUE="<CFOUTPUT>#Trim(Form.price)#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="stock" VALUE="<CFOUTPUT>#Trim(Form.stock)#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="VIN" VALUE="<CFOUTPUT>#Trim(Form.VIN)#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="Features" VALUE="<CFOUTPUT>#Trim(Form.Features)#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="extrafeatures" VALUE="<CFOUTPUT>#Trim(Form.extrafeatures)#</CFOUTPUT>">
			<INPUT type="hidden" name="image" value="<CFOUTPUT>#Form.Image#</CFOUTPUT>">
			<CFLOOP FROM=1 TO="#Trim(Form.ExtraFeatures)#" INDEX="mycount">
				<CFSET tmp= Evaluate('form.extrafeature' & #mycount#)>
				<INPUT type="hidden" name="extrafeature<CFOUTPUT>#mycount#</CFOUTPUT>" value="<CFOUTPUT>#tmp#</CFOUTPUT>">
			</CFLOOP>
			<INPUT type="hidden" name="dealercode" value="<CFOUTPUT>#g_dealercode#</CFOUTPUT>">
			<CFIF IsDefined("form.vehicleID")>
				<INPUT type="hidden" name="vehicleID" value="<CFOUTPUT>#form.vehicleID#</CFOUTPUT>">
			</CFIF>
			<INPUT TYPE="hidden" NAME="NextStep" VALUE="webvrfy_s10.cfm">
			<CFIF IsDefined("Form.NewFlag")>
				<INPUT type="hidden" name="NewFlag" value="1">
			<CFELSE>
				<INPUT type="hidden" name="ModifyFlag" value="1">
			</CFIF>
			
			<TR align="center">
				<TD><FONT FACE="Arial,Helvetica" SIZE="-1">
				<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/next_nav.jpg" BORDER="0" NAME="btnConfirm" VALUE="Next"></FONT></TD>
			</TR>
			</FORM>
			<TR>
				<TD>&nbsp;</TD>
			</TR>
			<FORM ACTION="webnew_s9.cfm" method="post">
			<INPUT type="hidden" name="dealercode" value="<CFOUTPUT>#g_dealercode#</CFOUTPUT>">
			<CFIF IsDefined("form.vehicleID")>
				<INPUT type="hidden" name="vehicleID" value="<CFOUTPUT>#form.vehicleID#</CFOUTPUT>">
			</CFIF>
			<CFIF IsDefined("Form.NewFlag")>
				<INPUT type="hidden" name="NewFlag" value="1">
			<CFELSE>
				<INPUT type="hidden" name="ModifyFlag" value="1">
			</CFIF>
			
			<INPUT TYPE="hidden" NAME="Make" VALUE="<CFOUTPUT>#Trim(Form.Make)#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="ModelName" VALUE="<CFOUTPUT>#Trim(Form.ModelName)#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="CarYear" VALUE="<CFOUTPUT>#Trim(Form.CarYear)#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="intcolor" VALUE="<CFOUTPUT>#Trim(Form.intcolor)#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="extcolor" VALUE="<CFOUTPUT>#Trim(Form.extcolor)#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="transmission" VALUE="<CFOUTPUT>#Trim(Form.transmission)#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="Mileage" VALUE="<CFOUTPUT>#Trim(Form.Mileage)#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="price" VALUE="<CFOUTPUT>#Trim(Form.price)#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="stock" VALUE="<CFOUTPUT>#Trim(Form.stock)#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="VIN" VALUE="<CFOUTPUT>#Trim(Form.VIN)#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="Features" VALUE="<CFOUTPUT>#Trim(Form.Features)#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="extrafeatures" VALUE="<CFOUTPUT>#Trim(Form.extrafeatures)#</CFOUTPUT>">
			<INPUT type="hidden" name="image" value="<CFOUTPUT>#Form.Image#</CFOUTPUT>">
			<CFLOOP FROM=1 TO="#Trim(Form.ExtraFeatures)#" INDEX="mycount">
				<CFSET tmp= Evaluate('form.extrafeature' & #mycount#)>
				<INPUT type="hidden" name="extrafeature<CFOUTPUT>#mycount#</CFOUTPUT>" value="<CFOUTPUT>#tmp#</CFOUTPUT>">
			</CFLOOP>
			<FORM action="webnew_s9.cfm" method="post">
			<INPUT type="hidden" name="Dealercode" value="<CFOUTPUT>#g_dealercode#</CFOUTPUT>">
			<TR align="center">
				<TD><FONT FACE="Arial,Helvetica" SIZE="-1">
				<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg" BORDER="0" NAME="btnCancel" VALUE="Cancel"></FONT></TD>
			</TR>
			</FORM>
			<TR>
				<TD>&nbsp;</TD>
			</TR>
			<TR align="center">
				<TD>
				<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
				<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg" Border="0" NAME="BackToMain" VALUE="Back To 		Main Menu">&nbsp;&nbsp;&nbsp;
				</FORM>
				</TD>
			</TR>
			<TR>
				<TD>&nbsp;</TD>
			</TR>
		</CFIF>

		<CFIF ConfirmMode>
			<CFIF Form.FileContents EQ ''>
				<CFSET GoodFileType = TRUE>
				<CFSET Display = #g_dealercode# & '_' & #form.vehicleID# & '_gra.jpg'>
				<CFSET tmpID = 0>
			<CFELSE>
				<!--- Find the next available Temp ID --->
				<CFX_DIRECTORYLIST DIRECTORY="#g_rootdir#\images\usedvehicles"
				        NAME="image_query"
				        SORT="type ASC, name ASC">
				<CFIF #image_query.recordcount# IS NOT 0>
					<CFSET max_id = 0>
					<CFLOOP query="image_query">
						<CFIF #Mid(name,1,4)# IS 'temp'>
							<CFSET the_ID = #GetToken(name,2, "_")#>
							<CFIF #the_ID# GT #max_ID#>
								<CFSET #max_ID# = #the_ID#>
							</CFIF>
						</CFIF> 
					</CFLOOP>
					<CFSET #tmpID# = #max_ID# + 1>
				<CFELSE>
					<CFSET tmpID = '1'>
				</CFIF>
				<CFSET WhereYouAt=(#Find("/", "#HTTP_USER_AGENT#")# +1)>
				<CFSET BVer=#Mid(#HTTP_USER_AGENT#, #WhereYouAt#, 3)#>
				<CFIF #HTTP_USER_AGENT# CONTAINS "Mozilla" AND #BVer# GTE 3>
					<CFSET #goodbrowser#="yes">
					<FORM Name="redirectinfo" Action="webnew_s9.cfm?redirect=yes" Method="Post">
					<input type="hidden" Name="Dealercode" Value="<CFOUTPUT>#g_DealerCode#</CFOUTPUT>">
					<CFIF IsDefined("Form.VehicleID")>
						<input type="hidden" Name="vehicleID" Value="#form.VehicleID#">
					</CFIF>
					<input type="hidden" Name="btnChooseImage">
					<INPUT TYPE="hidden" NAME="Make" VALUE="<CFOUTPUT>#Trim(Form.Make)#</CFOUTPUT>">
					<INPUT TYPE="hidden" NAME="ModelName" VALUE="<CFOUTPUT>#Trim(Form.ModelName)#</CFOUTPUT>">
					<INPUT TYPE="hidden" NAME="CarYear" VALUE="<CFOUTPUT>#Trim(Form.CarYear)#</CFOUTPUT>">
					<INPUT TYPE="hidden" NAME="intcolor" VALUE="<CFOUTPUT>#Trim(Form.intcolor)#</CFOUTPUT>">
					<INPUT TYPE="hidden" NAME="extcolor" VALUE="<CFOUTPUT>#Trim(Form.extcolor)#</CFOUTPUT>">
					<INPUT TYPE="hidden" NAME="transmission" VALUE="<CFOUTPUT>#Trim(Form.transmission)#</CFOUTPUT>">
					<INPUT TYPE="hidden" NAME="Mileage" VALUE="<CFOUTPUT>#Trim(Form.Mileage)#</CFOUTPUT>">
					<INPUT TYPE="hidden" NAME="price" VALUE="<CFOUTPUT>#Trim(Form.price)#</CFOUTPUT>">
					<INPUT TYPE="hidden" NAME="stock" VALUE="<CFOUTPUT>#Trim(Form.stock)#</CFOUTPUT>">
					<INPUT TYPE="hidden" NAME="VIN" VALUE="<CFOUTPUT>#Trim(Form.VIN)#</CFOUTPUT>">
					<INPUT TYPE="hidden" NAME="Features" VALUE="<CFOUTPUT>#Trim(Form.Features)#</CFOUTPUT>">
					<INPUT TYPE="hidden" NAME="extrafeatures" VALUE="<CFOUTPUT>#Trim(Form.extrafeatures)#</CFOUTPUT>">
					<INPUT type="hidden" name="image" value="<CFOUTPUT>#Form.Image#</CFOUTPUT>">
					<CFIF IsDefined("Form.ModifyFlag")>
						<INPUT type="hidden" name="ModifyFlag" value="<CFOUTPUT>#Form.ModifyFlag#</CFOUTPUT>">
					</CFIF>
					<CFIF IsDefined("Form.NewFlag")>
						<INPUT type="hidden" name="NewFlag" value="<CFOUTPUT>#Form.NewFlag#</CFOUTPUT>">
					</CFIF>
					<INPUT type="hidden" name="tmpid" value="<CFOUTPUT>#tmpid#</CFOUTPUT>">
	
					<CFLOOP FROM=1 TO="#Trim(Form.ExtraFeatures)#" INDEX="mycount">
						<CFSET tmp= Evaluate('form.extrafeature' & #mycount#)>
						<INPUT type="hidden" name="extrafeature<CFOUTPUT>#mycount#</CFOUTPUT>" value="<CFOUTPUT>#tmp#</CFOUTPUT>">
					</CFLOOP>
					</FORM>
					<SCRIPT Language="Javascript">
					function showImageSize() {
					if(document.checkit.width > 320) {
					parent.document.redirectinfo.submit();  //bounce 'em back to the image page
					}
					}
					</script>
				<CFELSE>
					<CFSET #goodbrowser#="no">
				</CFIF>
				<CFERROR type="request" template="uploaderror.cfm">
				<CFFILE ACTION="UPLOAD"
				FILEFIELD="FileContents"
				DESTINATION="#g_rootdir#\images\usedvehicles\temp_#tmpid#_.jpg"
				NAMECONFLICT="Overwrite">
			
				<CFIF #file.ClientFileExt# IS NOT 'jpg'>
					<CFSET goodfiletype = FALSE>
				<CFELSE>
					<CFSET goodfiletype = TRUE>
				</CFIF> 
				
				<CFSET Display = 'temp_' & #tmpid# & '_.jpg'>
			</CFIF>
			<TR>
				<TD>&nbsp;</TD>
			</TR>
			<CFIF goodfiletype>
				<TR align="center">
					<TD><FONT FACE="Arial,Helvetica">
					Do you wish to display the image below with this Pre-Owned Vehicle?</FONT></TD>
				</TR>
			<CFELSE>
				<TR align="center">
					<TD><FONT FACE="Arial,Helvetica">
					Sorry, the file you uploaded was invalid.  You must choose a JPEG file (.JPG extension).</FONT></TD>
				</TR>
				<TR>
					<TD>&nbsp;</TD>
				</TR>
				<TR>
					<TD><FONT FACE="Arial,Helvetica">
					&nbsp;&nbsp;Click <b>Back</b> to try again.
					<br>
					&nbsp;&nbsp;Click <b>Cancel</b> to return to the Pre-Owned vehicles menu.
					</FONT></TD>
				</TR>
			</CFIF>
			<TR>
				<TD>&nbsp;</TD>
			</TR>
			<TR align="center">
				<TD><IMG SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/usedvehicles/<CFOUTPUT>#display#</CFOUTPUT>" Name="checkit"></TD>
			<TR>
				<TD>&nbsp;</TD>
			</TR>
			<CFIF GoodFileType>
				<FORM NAME="StepNine" ACTION="webnew_s9.cfm" METHOD="post">
			<CFELSE>
				<FORM NAME="StepNine" ACTION="webnew_s9.cfm?mime=<CFOUTPUT>#file.clientfileext#</CFOUTPUT>" method="post">
			</CFIF>
			<INPUT TYPE="hidden" NAME="Make" VALUE="<CFOUTPUT>#Trim(Form.Make)#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="ModelName" VALUE="<CFOUTPUT>#Trim(Form.ModelName)#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="CarYear" VALUE="<CFOUTPUT>#Trim(Form.CarYear)#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="intcolor" VALUE="<CFOUTPUT>#Trim(Form.intcolor)#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="extcolor" VALUE="<CFOUTPUT>#Trim(Form.extcolor)#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="transmission" VALUE="<CFOUTPUT>#Trim(Form.transmission)#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="Mileage" VALUE="<CFOUTPUT>#Trim(Form.Mileage)#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="price" VALUE="<CFOUTPUT>#Trim(Form.price)#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="stock" VALUE="<CFOUTPUT>#Trim(Form.stock)#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="VIN" VALUE="<CFOUTPUT>#Trim(Form.VIN)#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="Features" VALUE="<CFOUTPUT>#Trim(Form.Features)#</CFOUTPUT>">
			<INPUT TYPE="hidden" NAME="extrafeatures" VALUE="<CFOUTPUT>#Trim(Form.extrafeatures)#</CFOUTPUT>">
			<INPUT type="hidden" name="image" value="<CFOUTPUT>#Form.Image#</CFOUTPUT>">
			<INPUT type="hidden" name="tmpid" value="<CFOUTPUT>#tmpid#</CFOUTPUT>">

			<CFLOOP FROM=1 TO="#Trim(Form.ExtraFeatures)#" INDEX="mycount">
				<CFSET tmp= Evaluate('form.extrafeature' & #mycount#)>
				<CFOUTPUT><INPUT type="hidden" name="extrafeature#mycount#" value="#tmp#"></CFOUTPUT>
			</CFLOOP>
			<INPUT type="hidden" name="dealercode" value="<CFOUTPUT>#g_dealercode#</CFOUTPUT>">
			<CFIF IsDefined("form.vehicleID")>
				<INPUT type="hidden" name="vehicleID" value="<CFOUTPUT>#form.vehicleID#</CFOUTPUT>">
			</CFIF>
			<INPUT TYPE="hidden" NAME="NextStep" VALUE="webvrfy_s10.cfm">
			<CFIF IsDefined("Form.NewFlag")>
				<INPUT type="hidden" name="NewFlag" value="1">
			<CFELSE>
				<INPUT type="hidden" name="ModifyFlag" value="1">
			</CFIF>
			<TR align="center">
				<TD><FONT FACE="Arial,Helvetica" SIZE="-1">
				<CFIF GoodFileType>
					<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/saveandcontinue_nav.jpg" BORDER="0" NAME="btnSave4" VALUE="Save">
				</CFIF>
				</FONT></TD>
			</TR>
			<TR>
				<TD>&nbsp;</TD>
			</TR>
			</FORM>
			<FORM action="webnew_s9.cfm" method="post">
			<INPUT type="hidden" name="Dealercode" value="<CFOUTPUT>#g_dealercode#</CFOUTPUT>">
			<TR align="center">
				<TD><FONT FACE="Arial,Helvetica" SIZE="-1">
				<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg" BORDER="0" NAME="btnCancel" VALUE="Cancel"></FONT>
				</TD>
			</TR>
			</FORM>
			<TR>
				<TD>&nbsp;</TD>
			</TR>
			<TR align="center">
				<TD>
				<FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
				<INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg" Border="0" NAME="BackToMain" VALUE="Back To 		Main Menu">&nbsp;&nbsp;&nbsp;
				</FORM>
				</TD>
			</TR>
	</CFIF>
	
	</TABLE>
	
	</div>
</BODY>
</HTML>