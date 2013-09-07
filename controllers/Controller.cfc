<!---
	This is the parent controller file that all your controllers should extend.
	You can add functions to this file to make them globally available in all your controllers.
	Do not delete this file.
--->
<cfcomponent extends="Wheels">

	<cffunction name="init">
    
        <cfset filters(through="checkSession", except="login,signin,create,logout")>
    
    </cffunction>
	
    <cffunction name="checkSession">
    
    	<cfif not StructKeyExists(session, "user")>
        	<cfset redirectTo(controller="main", action="login")>
        </cfif>
    
    </cffunction>

</cfcomponent>