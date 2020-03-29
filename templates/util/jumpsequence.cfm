<!---
Created by Sigma6, Inc.
Copyright (c) 1998 Sigma6, Inc.
All Rights Reserved.  Used By Permission.

Sigma6, interactive media, Detroit/NYC
conceive : construct : connect
www.sigma6.com   webmaster@sigma6.com   info@sigma6.com

Last updated: <August 8, 1998>

Tim Taylor for sigma6, interactive media, Detroit
ttaylor@sigma6.com   www.sigma6.com    www.s6313.com
conceive : construct : connect

Sigma6, s6, and the Sigma6 logos are registered trademarks.
All other trademarks and servicemarks are the property of
their respective owners.
--->

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
<CFSET n = 1>
<CFIF IsDefined("attributes.n")>
	<CFIF IsNumeric(attributes.n)>
		<CFSET n = attributes.n>
	</CFIF>
</CFIF>

<CFSET b_n = 10^((n - 1) \ 3)>
<CFSET c_n = n + (3 * (n \ 3)) + Ceiling((n MOD 3) / 3) - 1>
<CFSET caller.s_n = (c_n MOD 6) * b_n>