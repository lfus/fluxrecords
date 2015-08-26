<!--- <cfinclude template="_index_queries.cfm"> --->

<CFQUERY NAME="reviews" DATASOURCE="#ds#">
select DateTime,
       ID,
       album,
       tagline,
       author,
       company
       from reviews 
UNION
select ReleaseDate as 'DateTime',
       ID,
       keywords as 'album',
       Headline as 'tagline',  
       ProjectID as 'author',
       links as 'company'
       from news 
where ProjectID > 0
ORDER by DateTime Desc
</CFQUERY>

<CFQUERY NAME="AllReviews" DATASOURCE="#ds#" >
select ID from reviews
</CFQUERY>

<CFQUERY NAME="dupAlbums" DATASOURCE="#ds#" >
select ID from reviews where Album like '%,%';
</CFQUERY>

<CFQUERY NAME="maxAlbums" DATASOURCE="#ds#" >
SELECT distinct(Album) 
FROM reviews
</CFQUERY>

<CFSET ReviewedAlbums = maxAlbums.recordcount-dupAlbums.recordcount>

<CFQUERY NAME="news" DATASOURCE="#ds#">
select * from news
where ProjectID > 0
ORDER BY ReleaseDate DESC
</CFQUERY>

<CFQUERY NAME="newsvals" DATASOURCE="#ds#">
select releasedate from news
where ProjectID > 0
ORDER BY ReleaseDate
</CFQUERY>

<CFQUERY NAME="solo" DATASOURCE="rothkamm">
SELECT  * from Album
where solo = '1' and Released < '#DateFormat(now(),"M-D-YYYY")#'
ORDER by Released DESC
</CFQUERY>

<CFSET METAcontent="#news.Headline#">

<HTML>

<HEAD>
<META NAME="verify-v1" CONTENT="Znf3LgcYgvMshvND5YVOxh1hBEl8XGp6fEoC/7piqBc=" />
<META NAME="alexaVerifyID" CONTENT="YS3DLmw1gS2NFD-kiaT0J9ZS324" />
<TITLE>Rothkamm | <CFOUTPUT>#AllReviews.recordcount#</CFOUTPUT>  reviews | 1995-2015</TITLE>
<CFINCLUDE TEMPLATE="_javascript.cfm">
<LINK HREF="css.css" REL="stylesheet" TYPE="text/css">
</HEAD>
<BODY>
<div id="margin-left:auto; margin-right:auto;">
<!--- <DIV ID="menue"><CFINCLUDE TEMPLATE="_menue2.cfm"></DIV> --->
<DIV ID="Layer2"><CFINCLUDE TEMPLATE="_header.cfm"></DIV>

  <CFINCLUDE template="_layers.cfm">

<DIV ID="Layer1"><!--- CONTENT --->
<TABLE WIDTH="100%" BORDER="0" ALIGN="right" CELLPADDING="1" CELLSPACING="0"  BGCOLOR="3F3F3F">
 
  <TR>     
  <TD VALIGN="top"><TABLE BORDER="0" WIDTH="100%" CELLPADDING="0" CELLSPACING="0" BGCOLOR="FFFFFF">
          <TD  ALIGN="center" VALIGN="TOP" CLASS="style3" ><BR><BR><IMG SRC="http://chart.apis.google.com/chart?cht=p&chco=990000|5A5A5A|FFCC33|00AF00|AAAAAA&chd=t:<CFOUTPUT>#AllReviews.recordcount#,#ReviewedAlbums#,#news.recordcount#</CFOUTPUT>&chs=400x200&chl=<CFOUTPUT>#AllReviews.recordcount# reviews|#ReviewedAlbums# albums|#news.recordcount# press releases</CFOUTPUT>"><BR><BR><!---<BR><IMG SRC="<cfoutput>#pictures#</cfoutput>/shimblack.gif" WIDTH="100%" HEIGHT="1">--->
            <TABLE BORDER="0" WIDTH="100%" CELLPADDING="10" CELLSPACING="0" BGCOLOR="FFFFFF"><TR><TD><TABLE CELLPADDING="0" CELLSPACING="0" BORDER="0" CLASS="style2c" WIDTH="100%">

<CFOUTPUT QUERY="reviews">

<TR>
<TD ALIGN="right" VALIGN="top" CLASS="style2" COLSPAN="2"><IMG WIDTH="#Evaluate(Int((580/recordcount)*currentrow))#" HEIGHT="2" SRC="pictures/3F3F3F.gif"></TD>
</TR>

<CFIF album NEQ ''> 

<TR >
<TD CLASS="style3" VALIGN="TOP" COLSPAN="2" >
 <CFLOOP list="#album#" index="i" delimiters=","><A HREF="http://rothkamm.com?#i#"><IMG SRC="pictures/icons/#lcase(Replace(trim(i),' ','_','ALL'))#.jpg" BORDER="0" ALIGN="absmiddle" ></A> <SPAN CLASS="subT1">#i#</SPAN> </CFLOOP><BR>
<A HREF='review.cfm?ID=#ID#'>#tagline#</A>
<BR>
<SPAN CLASS="style2cfade">#DateFormat(DateTime,"MM/YYYY")#</SPAN>
<BR>
<IMG SRC="pictures/icon_illustration.gif"> #author# <EM>#Ucase(company)#</EM></TD>
</TR>

<CFELSE>
<!--- news release --->

<CFIF FileExists('#GetDirectoryFromPath(ExpandPath("*.*"))#press\FluxRecords[#NumberFormat(ID,'00')#].pdf')>
 <CFSET PDFlink = "press/FluxRecords[#NumberFormat(ID,'00')#].pdf">
<CFELSE>
 <CFSET PDFlink = "#ID#">
</CFIF>

	      <TR onMouseOver="this.style.backgroundColor='EBCD29'" onMouseOut='this.style.backgroundColor=""' >
<TD CLASS="style2cTrans"><IMG SRC="press/FluxRecords[#NumberFormat(ID,'00')#].pdf.png"></TD>          
<TD VALI="middle" CLASS="style2cTrans" ALIGN="center"><A HREF="#PDFlink#"  CLASS="style5">#trim(tagline)#</A><SPAN CLASS="style2cfade"><BR>
  <BR>
  Flux Records Public Document Format No. <EM>#Trim(ID)#</EM>|#DateFormat(DateTime, 'm/d/yyyy')#</SPAN></TD>
</TR>
 

</CFIF>
</CFOUTPUT>

<!---
<CFOUTPUT QUERY="news">

<CFIF FileExists('#GetDirectoryFromPath(ExpandPath("*.*"))#press\FluxRecords[#NumberFormat(ID,'00')#].pdf')>
 <CFSET PDFlink = "press/FluxRecords[#NumberFormat(ID,'00')#].pdf">
<CFELSE>
 <CFSET PDFlink = "#ID#">
</CFIF>

	      <TR onMouseOver="this.style.backgroundColor='EBCD29'" onMouseOut='this.style.backgroundColor=""' >
<!---<TD CLASS="style2cTrans" valign="top"><STRONG>[#DateFormat(releasedate, 'mm/yy')#]</STRONG><br />
  <span class="secHead1">#NumberFormat(evaluate(int(recordcount-currentrow+1)),'00')#</span></TD>---> 
<TD CLASS="style2cTrans"><IMG SRC="press/FluxRecords[#NumberFormat(ID,'00')#].pdf.png"></TD>          
<TD VALIGN="top" CLASS="style2cTrans" ><A HREF="#PDFlink#" TITLE="#trim(summary)#" CLASS="style5">#trim(Headline)#</A><SPAN CLASS="style2cfade">#DateFormat(releasedate, 'm/d/yyyy')#<STRONG><BR>
  <BR>
  </STRONG>|Flux Records Public Document Format No. #NumberFormat(evaluate(int(recordcount-currentrow+1)),'00')# <EM>ID#Trim(ID)#</EM>|</SPAN></TD>
</TR>
  
</CFOUTPUT>
--->

</TABLE></TD></TR></TABLE></TD>
</TR>
</TABLE></TD>
</TR>
</TABLE></TD></TR></TABLE>
</DIV>
<BR>

</BODY>
</HTML>
