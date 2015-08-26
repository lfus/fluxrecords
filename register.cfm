<CFINCLUDE TEMPLATE="_loginlogic.cfm">
<!--- <CFQUERY DATASOURCE="#ds#" NAME="cat">
SELECT DISTINCT category FROM links
</CFQUERY> --->

<CFSET errormessage = ''>



<!--- <CFIF IsDefined('address')> 
<!--- <CFIF FindNoCase('http://',address)> --->
<CFQUERY NAME="newlink" DATASOURCE="#ds#">
INSERT INTO links 
(FirstName, 
LastName, 
CompanyName, 
Address1, 
Address2, 
city, 
state,
ZIP  ,
country  ,
email  ,
address  ,
phone  ,
category  , 
created) 

VALUES 

('#Trim(FirstName)#' ,
'#Trim(LastName)#'  ,
'#Trim(CompanyName)#' ,
'#Trim(Address1)#'  ,
'#Trim(Address2)#'  ,
'#Trim(city)#'      ,
'#Trim(state)#'     ,
'#Trim(ZIP)#'       ,
'#Trim(country)#'   ,
'#Trim(email)#'     ,
'#Trim(address)#'   ,
'#Trim(phone)#'     ,
'#Trim(category)#'  ,
#CreateODBCDateTime(Now())#)


</CFQUERY>
</CFIF> --->
<HTML>

<!-- (c) rothkamm 2004/2006 | rothkamm.com case study | bluedragon server 6.2 | coldfusion 5.0 | dreamweaver mx 7.0 | sql server 2000 | fireworks MX 6.0 | photoshop 8.0 | flash 6.0 | windows 2000 server | -->

<HEAD>
<TITLE><CFOUTPUT>Log-in OR Register</CFOUTPUT></TITLE>

<meta name="viewport" content="width=622">

<CFINCLUDE TEMPLATE="_javascript.cfm">
<LINK HREF="css.css" REL="stylesheet" TYPE="text/css">
</HEAD>
<BODY><div id="margin-left:auto; margin-right:auto;">
<!--- <DIV ID="menue"><CFINCLUDE TEMPLATE="_menue2.cfm"></DIV> --->
<DIV ID="Layer2"><CFINCLUDE TEMPLATE="_header.cfm"></DIV>
<CFINCLUDE template="_layers.cfm">

<div id="Layer1"><!--- CONTENT --->
<TABLE WIDTH="100%" BORDER="0" ALIGN="right" CELLPADDING="1" CELLSPACING="0"  BGCOLOR="#3F3F3F">
 
  <TR>
  
    <TD width="100%" VALIGN="top"><TABLE BORDER="0" WIDTH="100%" CELLPADDING="0" CELLSPACING="0" BGCOLOR="#FFFFFF">
       <TD  ALIGN="LEFT" VALIGN="TOP" CLASS="style1" > <br> <br> <br>
<TABLE WIDTH="100%" BORDER="0" ALIGN="center" CELLPADDING="20" CELLSPACING="0" BGCOLOR="ffffff">
<TR>
<TD WIDTH="650"  ALIGN="CENTER"  VALIGN="MIDDLE" CLASS="style3"><a href="https://www.youtube.com/channel/UCxXM8NaAs5lF0g-ueiZwHqw"><IMG SRC="pictures/icons/icon-youtube-b.png" WIDTH="80" HSPACE=10 VSPACE=10></a><a href="https://www.facebook.com/rothkamm"><IMG SRC="pictures/icons/icon-facebook-b.png" WIDTH="80" HSPACE=10 VSPACE=10></a><a href="https://github.com/lfus"><IMG SRC="pictures/icons/icon_GitHub-Mark.png" WIDTH="80" HSPACE=10 VSPACE=10></a><a href="https://twitter.com/rothkamm"><IMG SRC="pictures/icons/twitter.jpg" WIDTH="80"  HSPACE=10 VSPACE=10></a><a href="https://lfus.org/register.cfm"><IMG SRC="pictures/icons/lfus.png" WIDTH="80" HSPACE=10 VSPACE=10></a></TD>
</TR>
</TABLE>
<FORM NAME="form1" ID="form1" METHOD="POST" ACTION="<CFOUTPUT>#script_name#?#CGI.QUERY_STRING#</CFOUTPUT>">
<TABLE WIDTH="100%" BORDER="0" ALIGN="center" CELLPADDING="0" CELLSPACING="10" BGCOLOR="ffffff" CLASS="style3">

<TR>
  <TD COLSPAN="4"><IMG SRC="pictures/shim.gif" WIDTH="5" HEIGHT="5"></TD>
</TR>


<TR>
  <TD COLSPAN="4" align="CENTER"><CFIF IsDefined('url.message')>>>> <B>Check your email, then log-in</B> <<< </CFIF></TD>
</TR>

<TR>
<TD width="200" height="20" ALIGN="right" VALIGN="MIDDLE"  CLASS="style3" > <SPAN CLASS="style2">&gt;&gt;</SPAN> <STRONG>Email</STRONG></TD>
<CFIF IsDefined('client.ClientID')>
<CFSET e=this_client.PAYER_email>
<CFELSE>
<CFSET e=''>
</CFIF>
<TD COLSPAN="3" VALIGN="MIDDLE"  CLASS="style3" ><INPUT NAME="rl_email" TYPE="TEXT" VALUE="<CFOUTPUT>#e#</CFOUTPUT>" SIZE="26" CLASS="styleInput" ID="rl_email"></TD>
</TR>

<TR>
<TD ALIGN="RIGHT" height="100" VALIGN="MIDDLE" nowrap  CLASS="style3" ><CFIF NOT IsDefined('client.ClientID')>[Enter] or [Create]</CFIF> <SPAN CLASS="style2">&gt;&gt;</SPAN> <STRONG>Password</STRONG></TD>
<CFIF IsDefined('client.ClientID')>
<CFSET p=this_client.password>
<CFELSE>
<CFSET p=''>
</CFIF>
<TD COLSPAN="3" VALIGN="MIDDLE"  CLASS="style3" ><INPUT NAME="rl_password" TYPE="PASSWORD" VALUE="<CFOUTPUT>#p#</CFOUTPUT>" SIZE="26" CLASS="styleInput" ID="rl_password"></TD>
</TR>


<TR>
<TD ALIGN="CENTER" VALIGN="MIDDLE"  CLASS="style3" >&nbsp;</TD>
<CFPARAM NAME="y" DEFAULT="log-in">
<CFIF IsDefined('client.ClientID')>
<CFSET y='log-out'>
</CFIF>
<CFIF IsDefined('submit')>
<CFIF submit EQ 'edit profile'>
<CFSET y='delete'>
<!--- <SCRIPT TYPE="TEXT/JAVASCRIPT">MM_showHideLayers('HereA','','show');</SCRIPT>  --->
</CFIF>
</CFIF>
<TD ALIGN="LEFT" VALIGN="MIDDLE" ><INPUT NAME="submit" TYPE="submit" VALUE="<CFOUTPUT>#y#</CFOUTPUT>" CLASS="styleInput"></TD>
<TD ALIGN="CENTER" VALIGN="MIDDLE"  CLASS="style3"  width="20">or</TD>
<CFPARAM NAME="x" DEFAULT="register">
<CFIF IsDefined('client.ClientID')>
<CFSET x='edit profile'>
</CFIF>
<CFIF IsDefined('submit')>
<CFIF submit EQ 'edit profile'>
<CFSET x='save changes'>
<!--- <SCRIPT TYPE="TEXT/JAVASCRIPT">MM_showHideLayers('HereA','','show');</SCRIPT> --->
</CFIF>
</CFIF>
<TD ALIGN="LEFT" VALIGN="MIDDLE" ><INPUT NAME="submit" TYPE="submit" VALUE="<CFOUTPUT>#x#</CFOUTPUT>" CLASS="styleInput"></TD>
</TR>

<TR>
  <TD COLSPAN="4"><IMG SRC="pictures/shim.gif" WIDTH="20" HEIGHT="20"></TD>
</TR>


<!--- Conditional ADDRESS --->
<CFIF IsDefined('submit')>
<CFIF submit EQ 'edit profile'> 

<TR>
<CFIF IsDefined('client.ClientID')>
<TD ALIGN="RIGHT" VALIGN="MIDDLE"  CLASS="style3" ><EM> FirstName</EM></TD>
<CFSET f=this_client.First_Name>
<CFELSE>
<TD></TD>
<CFSET f=''>
</CFIF>
<TD COLSPAN="2" VALIGN="MIDDLE"  CLASS="style3" ><INPUT NAME="rl_FirstName" TYPE="TEXT" VALUE="<CFOUTPUT>#f#</CFOUTPUT>" SIZE="36" CLASS="style1c" ID="rl_FirstName"></TD>
</TR>
<TR>

<CFIF IsDefined('client.ClientID')>
<TD ALIGN="RIGHT" VALIGN="MIDDLE"  CLASS="style3" ><EM>LastName</EM></TD>
<CFSET l=this_client.Last_Name>
<CFELSE>
<TD></TD>
<CFSET l=''>
</CFIF>
<TD COLSPAN="2" VALIGN="MIDDLE"  CLASS="style3" ><INPUT NAME="rl_LastName" TYPE="TEXT" VALUE="<CFOUTPUT>#l#</CFOUTPUT>" SIZE="36" CLASS="style1c" ID="rl_LastName"></TD>
</TR>
<TR>

<CFIF IsDefined('client.ClientID')>
<TD ALIGN="RIGHT" VALIGN="MIDDLE"  CLASS="style3" ><EM>Street</EM></TD>
<CFSET a=this_client.address_street>
<CFELSE>
<TD></TD>
<CFSET a=''>
</CFIF>
<TD COLSPAN="2" VALIGN="MIDDLE"  CLASS="style3" ><INPUT NAME="rl_Street" TYPE="TEXT" VALUE="<CFOUTPUT>#a#</CFOUTPUT>" SIZE="36" CLASS="style1c" ID="rl_Street"></TD>
</TR>
<TR>

<CFIF IsDefined('client.ClientID')>
<TD ALIGN="RIGHT" VALIGN="MIDDLE"  CLASS="style3" ><EM>City</EM></TD>
<CFSET c=this_client.address_city>
<CFELSE>
<TD></TD>
<CFSET c=''>
</CFIF>
<TD COLSPAN="2" VALIGN="MIDDLE"  CLASS="style3" ><INPUT NAME="rl_City" TYPE="TEXT" VALUE="<CFOUTPUT>#c#</CFOUTPUT>" SIZE="36" CLASS="style1c" ID="rl_City"></TD>
</TR>
<TR>

<CFIF IsDefined('client.ClientID')>
<TD ALIGN="RIGHT" VALIGN="MIDDLE"  CLASS="style3" ><EM>State</EM></TD>
<CFSET s=this_client.address_state>
<CFELSE>
<TD></TD>
<CFSET s=''>
</CFIF>
<TD COLSPAN="2" VALIGN="MIDDLE"  CLASS="style3" ><INPUT NAME="rl_State" TYPE="TEXT" VALUE="<CFOUTPUT>#s#</CFOUTPUT>" SIZE="36" CLASS="style1c" ID="rl_state"></TD>
</TR>
<TR>

<CFIF IsDefined('client.ClientID')>
<TD ALIGN="RIGHT" VALIGN="MIDDLE"  CLASS="style3" ><EM>ZIP</EM></TD>
<CFSET z=this_client.address_ZIP>
<CFELSE>
<TD></TD>
<CFSET z=''>
</CFIF>
<TD COLSPAN="2" VALIGN="MIDDLE"  CLASS="style3" ><INPUT NAME="rl_ZIP" TYPE="TEXT" VALUE="<CFOUTPUT>#z#</CFOUTPUT>" SIZE="36" CLASS="style1c" ID="rl_ZIP"></TD>
</TR>
<TR>

<CFIF IsDefined('client.ClientID')>
<TD ALIGN="RIGHT" VALIGN="MIDDLE"  CLASS="style3" ><EM>Country</EM></TD>
<CFSET co=this_client.address_Country>
<CFELSE>
<TD></TD>
<CFSET co=''>
</CFIF>
<TD COLSPAN="2" VALIGN="MIDDLE"  CLASS="style3" ><INPUT NAME="rl_Country" TYPE="TEXT" VALUE="<CFOUTPUT>#co#</CFOUTPUT>" SIZE="36" CLASS="style1c" ID="rl_Country"></TD>
</TR>
<!--- Conditional ADDRESS --->
</CFIF>
</CFIF>
</TABLE>

<TABLE align="center">
<CFIF IsDefined('client.ClientID')>

 <CFIF NOT IsDefined('client.TXN_ID')><CFSET client.TXN_ID = ''></CFIF>


<CFQUERY NAME="GetOrder" DATASOURCE="#ds#">
SELECT  Orders.PAYMENT_DATE, Orders.PAYER_ID, Orders.PAYER_EMAIL, Orders.RECEIVER_EMAIL, Orders.PAYMENT_DATE, Orders.PAYMENT_GROSS, Items.ITEM_NAME, Items.ITEM_NUMBER
FROM    Orders INNER JOIN Items ON Orders.TXN_ID = Items.TXN_ID
WHERE   Orders.TXN_TYPE  <> 'reversal' 
        <CFIF client.TXN_ID NEQ 'ALL'> 
		AND Orders.TXN_ID = '#client.TXN_ID#' 
		</CFIF>
		AND Orders.PAYER_ID = '#client.ClientID#'
ORDER BY Orders.PAYMENT_DATE DESC        
</CFQUERY>

<CFIF NOT IsDefined('submit')><CFSET submit='null'></CFIF>
    
  <CFIF GetOrder.recordcount GT 0 AND NOT submit EQ 'edit profile'>

<TR><TD COLSPAN="4"><IMG SRC="pictures/shim.gif" WIDTH="20" HEIGHT="20"></TD></TR>

<TR>
<TD COLSPAN="3" ALIGN="center" BGCOLOR="FFFFFF" CLASS="style1c">CD/MP3 </TD>

<!--- <TD  ALIGN="left" VALIGN="TOP"  CLASS="subT" >$#NumberFormat(PAYMENT_GROSS,'.00')#</TD> --->
</TR>

<!--- <CFQUERY NAME="buys" DATASOURCE="#ds#">
SELECT * FROM ORDERS WHERE PAYER_ID = '#client.ClientID#'
</CFQUERY>
 --->

<CFOUTPUT QUERY="GetOrder">
<TR>
<TD  VALIGN="TOP"  CLASS="style2b" >#currentrow#<!--- #DateFormat(PAYMENT_DATE,'YYYY/MM/DD')# ---></TD>
<TD VALIGN="top" CLASS="style3Trans"><CFIF Find('CD',ITEM_NAME)><CFELSE><A HREF="#Server_URL#/download.cfm?ID=#ITEM_NUMBER#&#trim(client.ClientID)#&#Trim(ITEM_NAME)#"></CFIF>#ITEM_NAME#</A><!--- <br>#GetOrder.PAYMENT_DATE# --->
<!---<I>opus #WorkID#</I>  ---></TD>
<TD ALIGN="CENTER" VALIGN="top" CLASS="subT"><CFIF Find('CD',ITEM_NAME)>USPS delivery
    <CFELSE><A HREF="#Server_URL#/download.cfm?ID=#ITEM_NUMBER#&#trim(client.ClientID)#&#Trim(ITEM_NAME)#"><IMG SRC="pictures/download.gif" WIDTH="13" HEIGHT="13" BORDER="0"></A></CFIF></TD>
</TR>
<TR><TD COLSPAN="4"><IMG SRC="pictures/shimblack.gif" WIDTH="100%" HEIGHT="1"></TD></TR>
</CFOUTPUT>
<!--- <CFELSE>
<TR>
<TD colspan="4" ALIGN="center" VALIGN="MIDDLE"  CLASS="style3" ><IMG SRC="image/rothkamm_logo_tiny.gif" WIDTH="66" HEIGHT="8"> does not rent, sell, or share personal information about you with other people or companies.</TD>
</TR> --->
 </CFIF>
</CFIF>
<TR><TD COLSPAN="4"><IMG SRC="pictures/shim.gif" WIDTH="20" HEIGHT="20"></TD></TR>
</TABLE></FORM></TD>
</TR>
</TABLE></TD></TR></TABLE>
</BODY>
</HTML>
