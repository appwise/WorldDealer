        <!---list of words that should not be searched for by themselves--->
        <CFSET excludeList = "and,or,a,an,the,of,at,on,##">
 
        <!---list of keywords (need quotes for proper search query)--->
        <CFSET quoteList =  "and,or,CASE,MANY,ORDER,not,CONTAINS,PHRASE,ENDS,SENTENCE,MATCHES,STARTS,NEAR,STEM,SUBSTRING,Accrue,WILDCARD,PARAGRAPH,WORD">
        
        <!---list of characters that can be searched for but need to be escaped with a "\"
             the backslash character ('\') MUST be first in this list--->
        <CFSET escapeCharList = "\,(,),=,!,',@,`,{,},[,],!,##">
        <CFSET escapeCharList = #ListAppend(escapeCharList, Chr(62))#>
                <CFSET escapeCharList = #ListAppend(escapeCharList, Chr(60))#>

        <!---list of characters users are allowed to search for--->
        <CFSET validCharList = "&,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,1,2,3,4,5,6,7,8,9,0," & escapeCharList>
        

<!---escape characters that need it--->

                <cfloop index="escapeIndex" list="#escapeCharList#" delimiters=",">
                        <CFSET newText = '\' & escapeIndex>
                        <CFSET originalSearchText = Replace(originalSearchText, escapeIndex, newText, "ALL")>
                </cfloop>

                <CFSET #OrSearchTest#=''>

                <CFSET specialCharText = ''>

                <cfloop index="tmpIndex" from="1" to="#Len(originalSearchText)#">
                
                        <CFIF Mid(originalSearchText, tmpIndex, 1) eq '&'>
                                <CFSET specialCharText = specialCharText & ' and '>
                        <CFELSE>
                                <CFSET specialCharText = specialCharText & Mid(originalSearchText, tmpIndex, 1)>
                        </cfif>
                
                </CFLOOP>
                
                <CFSET preserveRawText = specialCharText>

                <CFSET alphaNumText = ''>

<!---remove unwanted characters (leaving only those in validCharList)--->

                <cfloop condition="(Len(specialCharText) gt 0)">
                        <CFSET tempText = SpanIncluding(specialCharText, validCharList)>
                        <CFSET specialCharText = RemoveChars(specialCharText, 1, Len(tempText) +1)>
                        <CFIF Len(tempText) GT 0>
                                <CFSET alphaNumText = ListAppend(alphaNumText, tempText, " ")>
                        </CFIF>
                </cfloop>

                <CFSET #StartSearchTest#=#Replace(alphaNumText, " ", ",","ALL")#>
                
<!---put quotes around words that need them---> 
                
                <cfloop index="TempIndex" from="1" to="#ListLen(StartSearchTest)#">
                        <cfloop index="listIndex" from="1" to="#ListLen(quoteList)#">
                                <CFIF (CompareNoCase(Replace(ListGetAt(StartSearchTest, tempIndex)," ","","ALL"),   Replace(ListGetAt(quoteList, listIndex)," ","","ALL")) eq 0)>
                                        <CFSET TempInsert = '"' & #Replace(ListGetAt(StartSearchTest, tempIndex), " ","","ALL")# & '"'>
                                        <CFSET OrSearchTest = ListAppend(OrSearchTest, TempInsert)>
                                        <CFBREAK>
                                <CFELSE>
                                        <CFIF listIndex eq ListLen(quoteList)>
                                                <CFSET OrSearchTest = ListAppend(OrSearchTest, #ListGetAt(StartSearchTest, tempIndex)#)>
                                        </cfif>
                                </cfif>
                        </cfloop>
                </cfloop>

                <CFSET #AndSearchText#=#Replace(OrSearchTest, ",", " AND ","ALL")#>
                
                <CFSET #preExcludeCriteria# = OrSearchTest>

                <CFSET finalOrCriteria = ''>

                <!---remove words that are too common to search for except as the search string or an AND search--->

                <cfloop index="TempIndex" from="1" to="#ListLen(preExcludeCriteria)#">
                        <cfloop index="listIndex" from="1" to="#ListLen(excludeList)#">
                                <CFSET tempQuoteCompare = '"' & Replace(ListGetAt(excludeList, listIndex)," ","","ALL") & '"'>
                                <CFIF ((CompareNoCase(tempQuoteCompare, Replace(ListGetAt(preExcludeCriteria, tempIndex)," ","","ALL")) eq 0)
                                      OR (CompareNoCase(Replace(ListGetAt(excludeList, listIndex)," ","","ALL"), Replace(ListGetAt(preExcludeCriteria, tempIndex)," ","","ALL")) eq 0))>
                                        <CFBREAK>
                                <CFELSE>
                                        <CFIF listIndex eq ListLen(excludeList)>
                                                <CFSET finalOrCriteria = ListAppend(finalOrCriteria, #ListGetAt(preExcludeCriteria, tempIndex)#)>
                                        </cfif>
                                </cfif>
                        </cfloop>
                </cfloop>

                <CFIF Len(finalOrCriteria) LTE 0>
                        <CFIF AndSearchText neq OrSearchTest>
                                <CFSET #useSearchCriteria# = '(CF_TITLE <matches>"' & originalSearchText & '")'>
                        <CFELSE>        
                                <CFSET #useSearchCriteria# = '(CF_TITLE <matches>"' & AndSearchText & '")'>
                        </CFIF>         
                <CFELSE>
                        <CFSET #useSearchCriteria# = '(CF_TITLE <matches>"' & originalSearchText & '"),(' & AndSearchText & '), <ORDER><NEAR/2>(' & finalOrCriteria & ')'>

                </CFIF>