<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

    <!-- ----------------------------------------------------------- -->
    <!--     John Turner for sigma6, interactive media, Detroit      -->
    <!--    jturner@sigma6.com   www.sigma6.com    www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
	<!--- $Id: genexe2.cfm,v 1.5 1999/11/29 15:36:34 lswanson Exp $ --->
                 
<HTML>

<HEAD>

     <TITLE>Image Generator Results</TITLE>

			<CFQUERY NAME="getDealerName" datasource="#gDSN#">
              SELECT DealershipName as q_DealershipName
                    FROM Dealers
                   WHERE Dealers.DealerCode = '#URL.dlrcode#'
           </CFQUERY>
		   <CFQUERY NAME="getDLRTemplate" datasource="#gDSN#">
		      SELECT ArtTempID as q_DLRTemplate
			    FROM DealerWebs
			   WHERE DealerWebs.DealerCode = '#URL.dlrcode#'
		   </CFQUERY>

<!---
   final1 and final2 are passed on the URL, as is dlrcode
--->

    <CFIF ParameterExists(URL.dlrcode)>
           <CFSET g_DealerCode = #URL.dlrcode#>
           <CFSET EditMode = TRUE>
           <CFSET NewMode = FALSE>
           <CFSET SaveMode = FALSE>
        <CFELSE>
           <CFSET g_DealerCode = "">
           <CFSET NewMode = TRUE>
           <CFSET EditMode = FALSE>
           <CFSET SaveMode = FALSE>
        </CFIF>
        
        <CFIF ParameterExists(Form.btnSave)>
           <CFSET SaveMode = TRUE>
           <CFSET g_DealerCode = #Form.DealerCode#>
        </CFIF>

    <CFIF ParameterExists(Form.btnCancel)>
           <CFSET CancelMode = TRUE>
           <CFLOCATION URL="webvrfy_s4.cfm?dlrcode=#Form.DealerCode#">
    </CFIF>

    <CFIF EditMode>
	   	<CFIF #getDLRTemplate.q_DLRTemplate# EQ ''>
	   		<CFSET EditMode = FALSE>
		</CFIF>
    </CFIF>
        
    <CFIF SaveMode>
		<!--- Hope this is cool ---->
		<CFLOCATION url="webvrfy_s4.cfm?dlrcode=#URL.dlrcode#">
    </CFIF>
        
	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>

<body>
<br><br><br><br><br>

<div align="center">
<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH="100%" BGCOLOR="FFFFFF">
        <TR><TD>&nbsp;<p></TD></TR>
        <TR ALIGN="center">
                <TD ALIGN="middle"><h3><font face="Arial,Helvetica">Dealer Administration - Create a New Web</font></h3></TD>
        </TR>
        <TR ALIGN="center">
                <TD ALIGN="middle"><h4><font face="Arial,Helvetica">Image Generator results for <CFOUTPUT QUERY="getDealerName"><i>#q_DealershipName#</i></CFOUTPUT></font></h4></TD>
        </TR>
        <TR ALIGN="center">
                <TD ALIGN="middle"><font face="Arial,Helvetica">Select an image to view by clicking a link below.</font></TD>
        </TR>
        <TR><TD>&nbsp;<p></TD></TR>
		<CFOUTPUT>
        <FORM NAME="ImgGen" ACTION="genexe2.cfm?dlrcode=#g_DealerCode#" METHOD="post">
		</CFOUTPUT>
		
        <TR ALIGN=middle>
            <TD><IMG SRC="<CFOUTPUT>#URL.final2#</CFOUTPUT>"></TD>
        </TR>
        <TR><TD>&nbsp;<p></TD></TR>
        <TR ALIGN="center">
            <TD>
                    <CFOUTPUT>
                    <INPUT TYPE="hidden" NAME="DealerCode" VALUE=#g_DealerCode#>
                    </CFOUTPUT>
                    <INPUT TYPE="hidden" NAME="NextStep" VALUE="webnew_s5.cfm">
                        &nbsp;&nbsp;
                    <INPUT TYPE="Image" SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/cancel_nav.jpg" BORDER="0" NAME="btnCancel" VALUE="Cancel">
                        &nbsp;&nbsp;
                    <INPUT TYPE="submit" NAME="btnSave" VALUE="Save">
                        </FORM>
                    <p>
                    <FORM NAME="f_Back" ACTION="redirect.cfm" METHOD="post">
                            <INPUT TYPE="Image"
			SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/backtomain_nav.jpg"
			Border="0"
			NAME="BackToMain"
			VALUE="Back To Main Menu">

                    </FORM></TD>
        </TR>
</TABLE>
<P>
<IMG SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/demosite/logo_gra.gif"
		BORDER=0
		WIDTH=175
		HEIGHT=24
</div>

</BODY>
</HTML>

