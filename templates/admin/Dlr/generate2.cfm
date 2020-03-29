

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

    <!-- ----------------------------------------------------------- -->
    <!--     John Turner for sigma6, interactive media, Detroit      -->
    <!--    jturner@sigma6.com   www.sigma6.com    www.s6313.com     -->
    <!--               conceive : construct : connect                -->
    <!-- ----------------------------------------------------------- -->
	<!--- $Id: generate2.cfm,v 1.5 1999/11/29 15:36:34 lswanson Exp $ --->
                 
<HTML>

<HEAD>

        <TITLE>|| Dealers - Admin ||</TITLE>

    <CFQUERY NAME="getTemplates" datasource="#gDSN#">
            SELECT 	ArtTempID as q_TemplateID,
					TemplateLocation as q_TemplateLocation,
                    Description as q_Description
            FROM 	ArtTemplates
        </CFQUERY>
                
	<!--- so the background doesn't repeat --->
	<link rel=stylesheet href="admin.css" type="text/css">

</HEAD>

<body>
<br><br><br><br><br>


<div align="center"><h3>Logo Generator</h3></div>

<form name=generator action="genexe.cfm" method=post>
<table cellpadding=0 cellspacing=0 border=0 width=450 align=center>
   <tr>
      <td colspan=3>Please type the Dealership Name in the field provided.
          <p>
          When finished, click the 'Create' button.  Your browser will
          automatically show you the completed image.</td>
   </tr>
   <tr><td colspan=3>&nbsp;<p></td></tr>
   <tr>
       <td align="right"><em><FONT SIZE="-1">Dealer Code</FONT></em></td>
       <td>&nbsp;&nbsp;</td>
       <td><input type="text" size="6" name="dealercode"></td>
   </tr>
   <tr><td colspan=3>&nbsp;<p></td></tr>
   <tr>
       <td align="right"><em><FONT SIZE="-1">Dealership Name</FONT></em></td>
       <td>&nbsp;&nbsp;</td>
       <td><input type="text" size="50" name="dealership"></td>
   </tr>
   <tr><td colspan=3>&nbsp;<p></td></tr>
   <tr>
       <td align="right"><em><FONT SIZE="-1">Template</FONT></em></td>
       <td>&nbsp;&nbsp;</td>
       <td><SELECT NAME="template" SIZE=1>
                  <CFOUTPUT QUERY="getTemplates">
                          <OPTION VALUE="#q_TemplateID#">#q_Description#
                          </CFOUTPUT>
                   </SELECT></td>
   </tr>
   <tr><td colspan=3>&nbsp;<p></td></tr>
   <tr>
       <td colspan=3 align=center><input type="submit" value="Create Logo"> <p>
           <A HREF="#" OnClick="JavaScript:document.myform.reset();"><IMG SRC="<CFOUTPUT>#application.RELATIVE_PATH#</CFOUTPUT>/images/admin/reset_nav.jpg" Border="0" NAME="Reset" value="Reset"></a></td>
   </tr>
   <tr><td colspan=3>&nbsp;<p></td></tr>
</table>
</form>

</BODY>

</HTML>

 

</BODY>
</HTML>

