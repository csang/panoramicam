<cfcomponent extends="Model" output="no">
	<cffunction name="init">
    	
        <!--- Associations --->
        <cfset hasMany("photos")>
        
        <!--- Validations --->
    	<cfset validatesPresenceOf("first_name,last_name,email,url_id,password")>
        
        <cfset validatesFormatOf(property="email", type="email")>
        <cfset validatesLengthOf(property="first_name", maximum=30, minimum=2)>
        <cfset validatesLengthOf(property="last_name", maximum=30, minimum=2)>
        <cfset validatesLengthOf(property="url_id", maximum=30, minimum=6)>
        <cfset validatesLengthOf(property="password", within="5,255")>
        <cfset validatesUniquenessOf("url_id")>
        <cfset validatesUniquenessOf("email")>
        <cfset validatesConfirmationOf("password")>
    
	</cffunction>
</cfcomponent>