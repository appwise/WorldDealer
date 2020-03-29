<CFINCLUDE template="security.cfm">
    <!-- ----------------------------------------------------------- -->
    <!--                Created by sigma6, Detroit                   -->
    <!--         Copyright (c) 1997, 1998, 1999 sigma6.              -->
    <!-- All Rights Reserved.  Copyright Does Not Imply Publication. -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->

    <!-- ----------------------------------------------------------- -->
    <!--     John Turner for sigma6, interactive media, Detroit      -->
    <!--    jturner@sigma6.com   www.sigma6.com    www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
	<!--- $Id: loadflow.cfm,v 1.4 1999/11/29 19:44:32 lswanson Exp $ --->
                 
	<!--- 
                                   redirect.cfm

         this template takes input from any form and redirects Cold
                 Fusion accordingly using CFLOCATION.
	 --->                 

        
<CFIF ParameterExists(Form.BackToMain.X)>
    <CFLOCATION URL="index2.cfm">
</CFIF>

<CFIF ParameterExists(Form.NewDealer.X)>
    <CFLOCATION URL="loadnew.cfm">
</CFIF>

<CFIF ParameterExists(Form.FindDealer.X)>
<!---     <CFLOCATION URL="loadfind.cfm"> --->
    <CFLOCATION URL="webfind.cfm">
</CFIF>

<CFIF ParameterExists(Form.AE.X)>
    <CFLOCATION URL="loadAE.cfm">
</CFIF>

<CFIF ParameterExists(Form.AC.X)>
    <CFLOCATION URL="loadAC.cfm">
</CFIF>

<CFIF ParameterExists(Form.ViewPrint.X)>
    <CFLOCATION URL="viewprint.cfm">
</CFIF>

<!---

<CFIF ParameterExists(Form.WebModify)>
    <CFLOCATION URL="webmodify.htm">
</CFIF>

--->

</BODY>
</HTML>

