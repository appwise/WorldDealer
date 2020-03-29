<!--- Created by AppNet, Inc., Detroit
www.appnet.com
Copyright (c) 1999, 2000 AppNet, Inc. 
All other trademarks and servicemarks are the property of   
their respective owners.  All Rights Reserved.  Copyright Does Not Imply Publication.
Appnet, Inc. logos are registered trademarks.  
Created: <January 11, 2000>
webmaster@sigma6.com and info@sigma6.com --->
<!---$Id: jumpsequence.cfm,v 1.3 2000/01/25 19:53:15 lswanson Exp $--->

<!---
jumpsequence.cfm - module to determine an element in the
        seqence S = 1, 2, 5, 10, 20, 50, 100, 200, 500

Factoring S, we get
    S = 1 * 1, 2 * 1, 5 * 1, 1 * 10, 2 * 10, 5 * 10, 1 * 100,...
therefore
    S = a_1 * b_1, a_2 * b_2, a_3 * b_3,...
where
    A = 1, 2, 5, 1, 2, 5, 1,...
    B = 10^0, 10^0, 10^0, 10^1, 10^1, 10^1, 10^2,...

An element in the sequence A is given by the equation
    A(n) = C(n) mod 6
where
    C = 1, 2, 5, 7, 8, 11,...

An element in the sequence C is given by the equation
    C(n) = n + (3 * floor(n / 3)) + ceiling((n mod 3) / 3) - 1
	
Therefore
    S(n) = A(n) * B(n) = (C(n) mod 6) * B(n)
--->
<cfset n = 1>
<cfif isdefined("attributes.n")>
	<cfif isnumeric(attributes.n)>
		<cfset n = attributes.n>
	</cfif>
</cfif>

<cfset b_n = 10^((n - 1) \ 3)>
<cfset c_n = n + (3 * (n \ 3)) + ceiling((n mod 3) / 3) - 1>
<cfset caller.s_n = (c_n mod 6) * b_n>