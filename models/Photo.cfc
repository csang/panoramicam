<cfcomponent extends="Model" output="no">
	<cffunction name="init">
    
    	<!--- Associations --->
    	<cfset belongsTo("person")>
               
    </cffunction>
    
    <!--- Deletes the file from the images folder --->
    <cffunction name="deleteFile" access="public" returntype="void">
    	<cfargument name="image" type="any">
        <cffile action="delete" file="../images/panoramas/#image#">
    </cffunction>
    
    <!--- Resizes the image being uploaded to 1440x381 --->
    <cffunction name="resize" access="public" returntype="string">
		<cfargument name="upfile" type="any">
                        
        <cfif isImageFile("#upfile#")>
        	<cfset myimf = ImageNew("#upfile#")>
        <cfelse>
        	<cfreturn false>
        </cfif>
                
        <cfset random = randRange(1,1000)>
        
        <cfset file = "#DateFormat(now(),'mmmmdyyyy')##TimeFormat(now(), 'hhmm')##random#.jpg">
        
        <cfset ImageResize(myimf,"1440","381")>
        
        <cfimage source="#myimf#" action="write" destination="../images/panoramas/1.jpg" overwrite="yes">
        
        <cffile action="rename" source="../images/panoramas/1.jpg" destination="../images/panoramas/#session.user.url_id##file#">
        <cfset filename = "#file#">
        <cfreturn filename>
	</cffunction>
</cfcomponent>