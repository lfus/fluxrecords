<DIV ID="HereA" STYLE="position:absolute; top: 76px; width: 300px; left:131px; z-index: 10; visibility: hidden; border: 1px none #000000;" ><!--- <CFINCLUDE TEMPLATE="js/emailcheck.js"> ---><FORM NAME="form1" ID="form1" METHOD="POST" ACTION="<CFOUTPUT>#script_name#?#CGI.QUERY_STRING#</CFOUTPUT>"><TABLE WIDTH="300" HEIGHT="300" BORDER="0" ALIGN="center" CELLPADDING="0" CELLSPACING="10" BGCOLOR="#ffffff" CLASS="style2b">

	
	<TR>
	  <TD ALIGN="RIGHT" VALIGN="MIDDLE" CLASS="style3" >Date</TD>
	  <TD ALIGN="CENTER" VALIGN="MIDDLE" CLASS="style2b" ><CFOUTPUT>#DateFormat(Now(),'m/d/yy')#</CFOUTPUT></TD>
	  <TD ALIGN="RIGHT" VALIGN="MIDDLE" CLASS="style3" >P.S.T.</TD>
	  <TD ALIGN="CENTER" VALIGN="MIDDLE" CLASS="style2b" ><CFOUTPUT>#TimeFormat(Now(),'h:mm tt')#</CFOUTPUT></TD>
	</TR>
	
	<TR>
	  <TD ALIGN="RIGHT" VALIGN="MIDDLE" CLASS="style3" >IP</TD>
	  <TD ALIGN="CENTER" VALIGN="MIDDLE" CLASS="style2b"><CFOUTPUT>#CGI.REMOTE_ADDR#</CFOUTPUT></TD>
	  <TD ALIGN="RIGHT" VALIGN="MIDDLE" CLASS="style3" >OS</TD>
	  <TD ALIGN="CENTER" VALIGN="MIDDLE" CLASS="style2b" ><CFIF Find('Mac',HTTP_USER_AGENT)>Mac<CFELSEIF Find('Windows',HTTP_USER_AGENT)>Windows
	  </CFIF></TD>
	</TR>
	
	
		<CFOUTPUT>
	<TR>
	  <TD ALIGN="RIGHT" VALIGN="TOP"  CLASS="style3" >&nbsp;</TD>
    <TD COLSPAN="3" VALIGN="MIDDLE"  CLASS="style3" ><IMG SRC="image/rothkamm_logo_tiny.gif" WIDTH="66" HEIGHT="8"> does not rent, sell, or share personal information about you with other people or companies.</TD>
  </TR>
 <TR>
	  <TD ALIGN="RIGHT" VALIGN="MIDDLE"  CLASS="style3" >FirstName</TD>
       <CFIF IsDefined('client.ClientID')><CFSET f=this_client.FirstName><CFELSE><CFSET f=''></CFIF>
	  <TD COLSPAN="3" ALIGN="RIGHT" VALIGN="MIDDLE"  CLASS="style3" ><INPUT NAME="rl_FirstName" TYPE="TEXT" VALUE="<CFOUTPUT>#f#</CFOUTPUT>" SIZE="31" CLASS="style1c" ID="rl_FirstName"></TD>
  </TR>
  <TR>
	  <TD ALIGN="RIGHT" VALIGN="MIDDLE"  CLASS="style3" >LastName</TD>
       <CFIF IsDefined('client.ClientID')><CFSET l=this_client.LastName><CFELSE><CFSET l=''></CFIF>
	  <TD COLSPAN="3" ALIGN="RIGHT" VALIGN="MIDDLE"  CLASS="style3" ><INPUT NAME="rl_LastName" TYPE="TEXT" VALUE="<CFOUTPUT>#l#</CFOUTPUT>" SIZE="31" CLASS="style1c" ID="rl_LastName"></TD>
  </TR>
  
	<TR>
	  <TD ALIGN="RIGHT" VALIGN="MIDDLE"  CLASS="style3" >*Email</TD>
       <CFIF IsDefined('client.ClientID')><CFSET e=this_client.email><CFELSE><CFSET e=''></CFIF>
	  <TD COLSPAN="3" ALIGN="RIGHT" VALIGN="MIDDLE"  CLASS="style3" ><INPUT NAME="rl_email" TYPE="TEXT" VALUE="<CFOUTPUT>#e#</CFOUTPUT>" SIZE="31" CLASS="style1c" ID="rl_email"></TD>
  </TR>
	<TR>
	  <TD ALIGN="RIGHT" VALIGN="MIDDLE"  CLASS="style3" >*Password</TD>
       <CFIF IsDefined('client.ClientID')><CFSET p=this_client.password><CFELSE><CFSET p=''></CFIF>
	  <TD COLSPAN="3" ALIGN="RIGHT" VALIGN="MIDDLE"  CLASS="style3" ><INPUT NAME="rl_password" TYPE="PASSWORD" VALUE="<CFOUTPUT>#p#</CFOUTPUT>" SIZE="31" CLASS="style1c" ID="rl_password"></TD>
  </TR>

	
	<TR>
	  <TD ALIGN="CENTER" VALIGN="MIDDLE"  CLASS="style3" >&nbsp;</TD>
	
	<CFPARAM NAME="y" DEFAULT="log-in">
	   <CFIF IsDefined('client.ClientID')><CFSET y='log-out'></CFIF>
	   <CFIF IsDefined('submit')>
	    <CFIF submit EQ 'edit profile'>
	    <CFSET y='delete'>
		<!--- <SCRIPT TYPE="TEXT/JAVASCRIPT">MM_showHideLayers('HereA','','show');</SCRIPT>  --->
	   </CFIF>
	  </CFIF>	  
	  <TD ALIGN="RIGHT" VALIGN="MIDDLE" ><INPUT NAME="submit" TYPE="submit" VALUE="<CFOUTPUT>#y#</CFOUTPUT>" CLASS="style2"></TD>
	  
	  <TD ALIGN="CENTER" VALIGN="MIDDLE"  CLASS="style3" >or</TD>
	  
	   <CFPARAM NAME="x" DEFAULT="register">
	   <CFIF IsDefined('client.ClientID')><CFSET x='edit profile'></CFIF>
	   <CFIF IsDefined('submit')>
	    <CFIF submit EQ 'edit profile'>
	    <CFSET x='save changes'>
		<!--- <SCRIPT TYPE="TEXT/JAVASCRIPT">MM_showHideLayers('HereA','','show');</SCRIPT>  --->
	   </CFIF>
	  </CFIF>
	  <TD ALIGN="LEFT" VALIGN="MIDDLE" ><INPUT NAME="submit" TYPE="submit" VALUE="<CFOUTPUT>#x#</CFOUTPUT>" CLASS="style2"></TD>
   
    </TR>
   </CFOUTPUT> 
  <TR>
	  <TD COLSPAN="4" ALIGN="RIGHT" HEIGHT="9" VALIGN="TOP" CLASS="style2"><A HREF="javascript:MM_showHideLayers('HereA','','hide');" ><IMG SRC="pictures/remove.gif" TITLE="Cancel" WIDTH="9" HEIGHT="9" BORDER="0"></A></TD>
  </TR>
</TABLE></FORM></DIV>