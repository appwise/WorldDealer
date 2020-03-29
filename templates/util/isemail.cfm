<!---
Custom Tag: CF_IsEmail
    Author: Angelo McComis (angelo@promonet.com)

This file should be named "IsEmail.cfm" and should reside
either in your C:\CFUSION\CustomTags directory or within
the directory of the application where you intend to use it.

This tag is distributed as Freeware. However, if you'd like
to donate to my cause, please feel free to do so.
   
    
    
 $Revision: 1.2 $
     $Date: 1999/08/23 22:33:43 $
   History:
$History: ISEMAIL.CFM $
 * 
 * *****************  Version 5  *****************
 * User: Amccomis     Date: 3/05/98    Time: 9:09a
 * Updated in $/McComis
 * Changed the way .gov is handled. Somteimes Internic returns properly
 * formatted data, sometimes it doesn't. Added checking to gracefully
 * handle either.
 * 
 * *****************  Version 4  *****************
 * User: Amccomis     Date: 2/24/98    Time: 10:28a
 * Updated in $/McComis
 * Fixed problem with some domains being registered with Internic but not
 * outputting data in the standard format. What will happen in this case
 * is a null company name and a 0 for the age. Status of 2 because it
 * indeed was found, but the data couldn't be extracted.
 * 
 * *****************  Version 3  *****************
 * User: Amccomis     Date: 2/24/98    Time: 10:15a
 * Updated in $/McComis
 * Changed doco as follows: -2 now returned for domain not found. Also
 * changed behaviour or setting return code to match.
 * 
 * Fixed bug that caused .net, .edu, .org., and .gov to not be looked up
 * properly.
 * 
 * *****************  Version 2  *****************
 * User: Amccomis     Date: 2/12/98    Time: 3:05p
 * Updated in $/McComis
 * Added instructions to header, removed debug output.
 * 
 * *****************  Version 1  *****************
 * User: Amccomis     Date: 2/12/98    Time: 2:52p
 * Created in $/McComis
 * Initial Version

Usage:
In your application, call:

	<CF_IsEmail EMAIL="Email address">

From IsEmail, the return variables are:
     Valid = "return code"
     where return code 2 = validated the domain
                       1 = fits the format but domain not handled by Internic
                       0 = no way it's real - doesn't fit the format 
                      -1 = not valid, contains invalid characters.
                      -2 = domain would be handled by Internic but is not registered
                      

     Company = "Company Name"
     the company that the domain is registered to in the Internic database
     
     Age = "months"
     how long the domain has been registered in months.
     Useful for determining if a business is new or established on the web.
     
Note: The rules that this tag follows are based on my experience 
      of determining a valid e-mail address.
      Please feel free to send comments to me if you find that
      I have missed something.
--->

<CFIF IsDefined("Attributes.email") is "FALSE">   
<HR>
<h1>An error has occurred in your application</h1>
<DIV CLASS="list"><UL><LI>CF_IsEmail requires the attribute "EMail"</UL></DIV>
<HR>

<CFELSE> <!--- begin processing --->

<!--- set initial values for variables --->
<CFSET CALLER.VALID = "0">
<CFSET CALLER.COMPANY = "undefined">
<CFSET CALLER.AGE = "0">
<CFSET DB = "http://rs.internic.net/cgi-bin/itts/whois">
<CFSET BRKCHAR = "|">


<CFIF FindOneOf("~`!##$%^&*()=+}]{[\|;:/?><,","#ATTRIBUTES.EMAIL#",1)>
<CFSET CALLER.VALID="-1">
<CFELSE>

<CFSET PARTS = ListLen("#attributes.email#","@")>


<CFIF PARTS is "2"> 

<CFSET USER = ListFirst("#Attributes.email#","@")>
<CFSET MACHINE = ListRest("#Attributes.email#","@")>

<CFIF ListLen("#Machine#",".") ge "2"> 

   <CFSET TLD = ListLast("#MACHINE#",".")>
   
     
   <CFIF ListFindNoCase("COM,NET,ORG,EDU,GOV","#tld#")> 
      <CFIF ListLen("#MACHINE#",".") ge "2"> 
         <CFSET machine1 = GetToken("#MACHINE#",(ListLen("#MACHINE#",".")-1),".")>
         <CFSET MACHINE2 = ListLast("#MACHINE#",".")>
         <CFSET MACHINE = "#MACHINE1#"&"."&"#MACHINE2#">
		 <!---
        <CFHTTP URL="#DB#"
         	METHOD="POST"
         	RESOLVEURL="NO">
         <CFHTTPPARAM NAME="whois_nic" VALUE="dump #MACHINE#" TYPE="FORMFIELD">
         </CFHTTP>	
         
         <CFIF FindNoCase("no match for","#CFHTTP.FILECONTENT#") is false >
         
            <CFIF FindNoCase("#BRKCHAR#", "#CFHTTP.FILECONTENT#") GE "1">

               <CFSET tempcompany=GetToken("#CFHTTP.FILECONTENT#","3","#BRKCHAR#")>
               <CFSET tempcompany=Replace("#tempcompany#",CHR(13),"","ALL")>
               <CFSET tempcompany=Replace("#tempcompany#",CHR(10),"","ALL")>
               <CFSET CALLER.COMPANY=Replace("#tempcompany#","(2) name: ","","ALL")>
               <CFSET tempdate=GetToken("#CFHTTP.FILECONTENT#","11","#BRKCHAR#")>
               <CFSET tempdate=Replace("#tempdate#","(10) activation_date: ","","ALL")>
               <CFIF IsDate("#tempdate#")>
    	               <CFSET CALLER.AGE=DateDiff("m","#tempdate#",Now())>
    	       <CFELSE>
	               <CFSET CALLER.AGE= "0">
  	       </CFIF>
  	       <CFSET CALLER.VALID="2">
  	     <CFELSE>  

  	       <CFSET CALLER.AGE = "0">
  	       <CFSET CALLER.VALID = "2">
             </CFIF>
  	       

         <CFELSE>
        
         </CFIF>    
            --->

		<!---to un-HACK:  remove the line below, then uncomment the above block.--->

			    <CFSET CALLER.VALID="-2">
			
      </CFIF>
   </CFIF>
   
   <CFSET Mtemp = Reverse("#MACHINE#")>
   
   <CFSET FTLD = Reverse(ListFirst("#MTEMP#","."))> 
   
   <CFIF Len(#FTLD#) is 2>
         <CFSET CALLER.VALID=1>
   </CFIF>
   
     
</CFIF> 
</CFIF> 
</CFIF>	
</CFIF>