<CFINCLUDE template="security.cfm">
<CFOUTPUT>
#Replace(form.disclaimer_body,Chr(13),"<BR>","ALL")#
<INPUT type="hidden" name="disclaimer_body" value="#form.disclaimer_body#">
<INPUT type="hidden" name="templateID" value="0">
</CFOUTPUT>