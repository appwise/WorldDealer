<!---
display ConnectionPool info and statistics.

Copyright (c) 1999, 2000 AppNet Inc.  All rights reserved.
$Id: ConnectionPool.cfm,v 1.3 2000/04/25 23:07:22 ttaylor Exp $

Usage:

<CFMODULE TEMPLATE="main.cfm"
	POOL=#pool#
	ARGS=#args#>

	POOL - the ConnectionPool to display.

See: s6/cfml/util/pool.cfm
--->

<CFPARAM NAME="attributes.pool">
<CFSET pool = attributes.pool>

<CFOUTPUT>
<HEAD>
	<TITLE>Connection Pool Stats</TITLE>
	<STYLE TYPE="text/css"><!--
		/* text alignments */
		th, .data td.numeric { text-align: right; }
		.data th, .data td { text-align: left; }
		.formlayout td, .formlayout th, .data td, .data th { 
			vertical-align: bottom; 
		}

		/* borders */
		/* NS 4.x: counteract border=1 for CSS compliant browsers */
		table.data, .data td, .data th { border: none; }

		table.data { 
			border-width: thin;
			border-style: solid none;
		}
		.data thead th { border-bottom: solid thin; }
		table.data tr.separator th, table.data tr.separator td {
			border-bottom: solid thin;
		}
	//--></STYLE>
</HEAD>
<BODY>
	<FORM METHOD="POST">
		<TABLE CLASS="formlayout" CELLSPACING="0" CELLPADDING="2">
			<CAPTION>ConnectionPool</CAPTION>
			<TBODY>
				<TR>
					<TH SCOPE="row">url:</TH>
					<TD>#pool.getURL()#</TD>
				</TR>
				<TR>
					<TH SCOPE="row">driver:</TH>
					<TD>#pool.getDriver()#</TD>
				</TR>
				<TR>
					<TH SCOPE="row">user:</TH>
					<TD>#pool.getUser()#</TD>
				</TR>
				<TR>
					<TH SCOPE="row">low water mark:</TH>
					<TD class="numeric">#pool.getLowWaterMark()#</TD>
				</TR>
				<TR>
					<TH SCOPE="row">pool size:</TH>
					<TD class="numeric">#pool.getPoolSize()# 
					<INPUT TYPE="submit" NAME="flush" VALUE="flush"></TD>
				</TR>
				<TR>
					<TH SCOPE="row">high water mark:</TH>
					<TD class="numeric">#pool.getHighWaterMark()#</TD>
				</TR>
			</TBODY>
		</TABLE>
	</FORM>

	<TABLE class="data" BORDER=1 CELLSPACING=0 CELLPADDING=2>
		<CAPTION>connection statistics</CAPTION>
		<TBODY>
			<TR>
				<TH SCOPE="row">acquired</TH>
				<TD class="numeric">#pool.getAcquireCount()#</TD>
			</TR>
			<TR class="separator">
				<TH SCOPE="row">released</TH>
				<TD class="numeric">#pool.getReleaseCount()#</TD>
			</TR>
		</TBODY>

		<TBODY>
			<TR>
				<TH SCOPE="row">created</TH>
				<TD class="numeric">#pool.getCreateCount()#</TD>
			</TR>
			<TR class="separator">
				<TH SCOPE="row">expired</TH>
				<TD class="numeric">#pool.getExpireCount()#</TD>
			</TR>
			<TR>
				<TH SCOPE="row">destroyed</TH>
				<TD class="numeric">#pool.getDestroyCount()#</TD>
			</TR>
		</TBODY>

		<TBODY>
			<TR>
				<TH SCOPE="row">empty</TH>
				<TD class="numeric">#pool.getEmptyCount()#</TD>
			</TR>
			<TR>
				<TH SCOPE="row">errors</TH>
				<TD class="numeric">#pool.getErrorCount()#</TD>
			</TR>
		</TBODY>
	</TABLE>
</BODY>
</CFOUTPUT>
