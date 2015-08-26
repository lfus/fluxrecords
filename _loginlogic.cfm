<CFIF IsDefined('TID')>
<CFSET client.ClientID = TID>
</CFIF>

<CFSCRIPT>
/**
 * This function deletes all client variables for a user.
 * Version 2 mods by Tony Petruzzi
 * 
 * @param safeList 	 A list of client vars to NOT delete. 
 * @return Returns true. 
 * @author Bernd VanSkiver (bernd@shadowdesign.net) 
 * @version 2, January 29, 2002 
 */
function DeleteClientVariables() {
	var ClientVarList = GetClientVariablesList();
	var safeList = "";
	var i = 1;

	if(ArrayLen(Arguments) gte 1) safeList = Arguments[1];

	for(i=1; i lte listLen(ClientVarList); i=i+1) {
		if(NOT ListFindNoCase(safeList, ListGetAt(ClientVarList, i )))  DeleteClientVariable(ListGetAt(ClientVarList, i));
	}
	return true;
}

</CFSCRIPT>


<CFIF IsDefined('client.ClientID')>
 <CFIF client.ClientID EQ "0121BDA5-E147-7A54-F31C6D9989F9BDC6">   
  <CFSET StructClear(Session)>
  <CFSCRIPT>DeleteClientVariables();</CFSCRIPT>    
 </CFIF> 
</CFIF>


<!--- <CFIF IsDefined("Cookie.rothkammInternational")>

<CFSET client.ClientID = Cookie.rothkammInternational>
</CFIF> --->

<CFIF  IsDefined('confirm')>
 <CFIF  ListGetAt(confirm,1) EQ '12345'>

 <CFQUERY NAME="temp_user" DATASOURCE="#ds#">
      SELECT * FROM CUSTOMERS_TEMP
      WHERE PAYER_TEMP_ID = '#ListGetAt(confirm,2)#'
 </CFQUERY>

   <CFIF temp_user.recordcount GT 0> 
    
   <!--- dups ---> 
   <CFQUERY NAME="dupConfirm" DATASOURCE="#ds#">
    SELECT PAYER_EMAIL FROM CUSTOMERS WHERE PAYER_EMAIL = '#temp_user.PAYER_EMAIL#'
   </CFQUERY>  
      <CFIF dupConfirm.recordcount GT 0> 
      <SCRIPT TYPE="TEXT/JAVASCRIPT">alert('*** Welcome back  *** :: <CFOUTPUT>#temp_user.PAYER_EMAIL#</CFOUTPUT> is already confirmed. Please log-in');
       location.href = '/register.cfm';
      </SCRIPT> 
      </CFIF>

   <CFSET client.ClientID = CreateUUID()>  
   <CFQUERY NAME="new_user" DATASOURCE="#ds#">
        INSERT INTO CUSTOMERS 
      (First_Name,Last_Name,PAYER_email,password,PAYER_ID,status)
       VALUES   
      (
'#trim(temp_user.First_Name)#',
'#trim(temp_user.Last_Name)#',
'#trim(temp_user.PAYER_email)#',
'#trim(temp_user.password)#',	 
'#trim(client.ClientID)#', 
3
)
   </CFQUERY>
   
     <CFMAIL FROM="info@fluxrecords.com" TO="#trim(temp_user.PAYER_email)#" SUBJECT="FluxRecords Registration"> 
Your Account:

username: #trim(temp_user.PAYER_email)# 
password: #trim(temp_user.password)#

http://FLUXRECORDS.COM

_____________________________ 
Flux Records Management Group

      </CFMAIL> 
   
   	<SCRIPT TYPE="TEXT/JAVASCRIPT">alert('*** Success  *** :: You are CONFIRMED and logged-in');
    <CFIF temp_user.sURL NEQ "/register.cfm">location.href = '<CFOUTPUT>#temp_user.sURL#</CFOUTPUT>';</CFIF>
    </SCRIPT> 
 
   </CFIF>
 
 <CFELSE>404<CFABORT>
 </CFIF>
</CFIF>


<CFIF IsDefined('submit')> 

<CFIF NOT IsDefined('rl_email') OR NOT IsDefined('rl_password')><!--- sys  --->
<SCRIPT TYPE="TEXT/JAVASCRIPT">
	 alert('*** Error *** :: Email or Password can not be empty');
</SCRIPT>

<CFELSEIF len(rl_email) LT 7 OR len(rl_password) LT 1 OR NOT find('@',rl_email) OR NOT find('.',rl_email)><!--- string--->

<SCRIPT TYPE="TEXT/JAVASCRIPT">
	 alert('*** Welcome *** :: Please enter your Email and create a Password to [register] OR enter your Email and Password to [log-in]');</SCRIPT>

<CFELSE><!--- MAIN --->

<CFSWITCH EXPRESSION='#submit#'>
 
 <CFCASE VALUE='Log-out'>
 <CFSET StructClear(Session)>
 <CFSCRIPT>
  DeleteClientVariables();
</CFSCRIPT>
 
 <!--- <SCRIPT TYPE="TEXT/JAVASCRIPT">alert('*** Success *** :: You are logged-out');</SCRIPT> --->
 </CFCASE>
  
 <CFCASE VALUE='Register'> 
   <CFQUERY NAME="dup" DATASOURCE="#ds#">
   SELECT PAYER_EMAIL FROM CUSTOMERS WHERE PAYER_EMAIL = '#trim(rl_email)#'
   </CFQUERY>
    <CFIF dup.recordcount GT 0>
	<SCRIPT TYPE="TEXT/JAVASCRIPT">
	 alert('*** Error *** :: <CFOUTPUT>#Trim(rl_email)#</CFOUTPUT> is already registered :: Please Log-in');
	</SCRIPT>
	 <CFELSE>  
<!--- 	 <CFSET client.ClientID = CreateUUID()>   --->
     <CFSET client.TXN_ID = ''>
	 <!--- <CFSET client.ClientID = client.CFToken> --->    	 		 
	
     <CFIF IsDefined('sURL')><CFSET sURL = '#sURL#'><CFELSE><CFSET sURL='/register.cfm'></CFIF>   
<!---      <CFSET ConfirmString1 = '12345,#client.ClientID#'> 
     <CFSET ConfirmString =  Encrypt(ConfirmString1,'12345')> --->
     <CFSET ConfirmString =  RandRange(10000000,99999999,"SHA1PRNG")> 
                                       
      <CFQUERY NAME="new_temp_user" DATASOURCE="#ds#">
      INSERT INTO CUSTOMERS_TEMP
      (<!--- First_Name,Last_Name, --->PAYER_email,password,PAYER_TEMP_ID,sURL,status)
       VALUES   
      (
<!--- '#left(trim(rl_FirstName),50)#',
'#left(trim(rl_LastName),100)#', --->
'#left(trim(rl_email),100)#',
'#left(trim(rl_password),50)#',
'#ConfirmString#', 
'#sURL#',
101
)
       </CFQUERY>
     
     
      <CFIF Trim(rl_email) NEQ ''><CFMAIL FROM="info@fluxrecords.com" TO="#Trim(rl_email)#" SUBJECT="Confirm Your Registration">
Welcome

Please click on link below or paste it in your browser to confirm your registration:
http://fluxrecords.com/register.cfm?confirm=12345,#ConfirmString#

_____________________________ 
Flux Records Management Group

      </CFMAIL></CFIF>       
      <CFOUTPUT>
      
       <CFFILE ACTION="append"
        FILE="#GetDirectoryFromPath(GetCurrentTemplatePath())#\logins.txt"
        OUTPUT="#Now()# IP:#REMOTE_ADDR# EMAIL:#Trim(rl_email)#">
		
		<SCRIPT TYPE="TEXT/JAVASCRIPT">alert('*** IMPORTANT *** :: Please check your #Trim(rl_email)# email account and CONFIRM you registration');
        <!--- <CFIF IsDefined('sURL')>location.href = '<CFOUTPUT>#sURL#</CFOUTPUT>';</CFIF> --->
        </SCRIPT>
      
	  </CFOUTPUT>
     </CFIF> 
  </CFCASE>
  
  
  
  
<!---  
<CFCASE VALUE='Edit Profile'>
</CFCASE> 
--->
 
 <CFCASE VALUE='Delete'>
<!---  <CFQUERY NAME="copy_user" DATASOURCE="#ds#">  
  INSERT INTO users_dead 
  (email,password,register_date,remote_host,http_user_agent,ClientID) 
  VALUES
  ('#left(rl_email,50)#','#left(rl_password,50)#',#CreateODBCDateTime(now())#,
   '#left(CGI.remote_addr,300)#','#left(cgi.HTTP_USER_AGENT,1000)#','#client.ClientID#')
 </CFQUERY> --->
 <CFQUERY NAME="kill" DATASOURCE="#ds#">
<!---   DELETE from users WHERE ClientID = '#client.ClientID#' --->
  DELETE from CUSTOMERS WHERE PAYER_ID = '#client.ClientID#'
 </CFQUERY> 
 <CFSET StructClear(Session)>
 <CFSCRIPT>
  DeleteClientVariables();
  </CFSCRIPT>
 <SCRIPT TYPE="TEXT/JAVASCRIPT">alert('*** Success *** :: Your profile has been deleted');</SCRIPT>
 </CFCASE>
 
 <CFCASE VALUE='Save Changes'>
 <CFQUERY NAME="changed_user" DATASOURCE="#ds#">  
   UPDATE CUSTOMERS SET 
          First_Name='#left(trim(rl_FirstName),100)#',
		  Last_Name='#left(trim(rl_LastName),100)#',
		  Address_Street='#left(trim(rl_Street),200)#',
		  Address_City='#left(trim(rl_City),100)#',
		  Address_State='#left(trim(rl_State),50)#',
		  Address_ZIP='#left(trim(rl_ZIP),200)#',
		  Address_Country='#left(trim(rl_country),100)#',
		  PAYER_email='#left(trim(rl_email),100)#',
          password='#left(trim(rl_password),50)#'
    WHERE PAYER_ID = '#client.ClientID#'
 </CFQUERY>
 <SCRIPT TYPE="TEXT/JAVASCRIPT">alert('*** Success *** :: Your changes have been saved');</SCRIPT>
 </CFCASE>

 <CFCASE VALUE='Log-in'>
 <CFQUERY NAME="log_user" DATASOURCE="#ds#">  
   SELECT * FROM CUSTOMERS WHERE PAYER_EMAIL = '#trim(rl_email)#'
  </CFQUERY>
   <CFIF log_user.recordcount GT 0>
	<CFQUERY NAME="pass_user" DATASOURCE="#ds#">  
     SELECT password FROM CUSTOMERS
     WHERE PAYER_ID = '#log_user.PAYER_ID#'
    </CFQUERY>
   <!--- <CFOUTPUT>|#log_user.PAYER_ID#|=|#pass_user.password#|#trim(rl_password)#|</CFOUTPUT><cfabort> --->
	  <CFIF trim(pass_user.password) EQ trim(rl_password)>
	 
	   <CFSET client.ClientID = log_user.PAYER_ID>
       <CFSET client.TXN_ID       = 'ALL'>
	   <!--- <CFMAIL FROM="#ds#@#ds#.com" TO="#ds#@#ds#.com" SUBJECT="#log_user.PAYER_email# - #log_user.First_Name# #log_user.Last_Name#">Login</CFMAIL> --->
	   <!--- <CFCOOKIE NAME="rothkammInternational" VALUE="#log_user.clientID#"> --->
	   <!--- log logins --->
       <CFFILE ACTION="append"
        FILE="#GetDirectoryFromPath(GetCurrentTemplatePath())#\logins.txt"
        OUTPUT="#Now()# IP:#REMOTE_ADDR# EMAIL:#Trim(rl_email)#">
        
	   <SCRIPT TYPE="TEXT/JAVASCRIPT">
	    alert('*** Welcome <cfoutput>#log_user.First_Name#</cfoutput> *** :: You are logged-in');
	   <CFIF IsDefined('sURL')>location.href = '<CFOUTPUT>#sURL#</CFOUTPUT>';</CFIF>
       </SCRIPT>
	  <CFELSE>
	   
       <SCRIPT TYPE="TEXT/JAVASCRIPT">alert('*** Error *** :: Password incorrect :: Your correct password has been emailed to <CFOUTPUT>#Trim(rl_email)# <!--- - #log_user.recordcount# - #log_user.PAYER_ID# |#pass_user.password#|#trim(rl_password)#| ---></CFOUTPUT>');</SCRIPT>
       
	 <CFMAIL FROM="info@fluxrecords.com" TO="#Trim(rl_email)#" SUBJECT="[a reminder]">
	 #pass_user.password#

http://FLUXRECORDS.COM

_____________________________ 
Flux Records Management Group
	   </CFMAIL>
      </CFIF>
	<CFELSE>   
    <SCRIPT TYPE="TEXT/JAVASCRIPT">
	 alert('*** Error *** :: <CFOUTPUT>#Trim(rl_email)#</CFOUTPUT> is not registered.');
    </SCRIPT>
    
    </CFIF>
  </CFCASE> 
 

 </CFSWITCH>
</CFIF><!--- MAIN --->
</CFIF>


<CFIF IsDefined('TID')><CFSET client.ClientID=TID></CFIF>

<CFIF IsDefined('client.ClientID')>
<CFSET logo="">
<CFQUERY NAME="this_client" DATASOURCE="#ds#">
SELECT * FROM CUSTOMERS
WHERE PAYER_ID = '#client.ClientID#'
</CFQUERY>
<CFELSE>
<!--- <CFSET logo="_off"> --->
<CFSET logo="">
<CFSET StructClear(Session)>
</CFIF>
