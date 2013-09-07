<cfcomponent extends="Controller" output="no">
    
    <!--- Updates the user's information --->
    <cffunction name="update">
        <cfset user = model("person").findOne(where="password=MD5('#params.user.password#') AND url_id='#session.user.url_id#'")>
        
        <!--- If the password and url_id matches, do the update --->
        <cfif IsObject(user)>
            <cfif user.hasErrors()>
            	<cfdump var="user" abort>
        		<cfset renderPage(action="info")>
        	<cfelse>
            	<cfset params.user.password = hash(params.user.password, "MD5")>
    			<cfset user.update(params.user)>
				<cfset session.user.url_id = params.user.url_id>
                <cfset redirectTo(controller="info", action=session.user.url_id)>
            </cfif>
        <!--- If not send an error message and take the user back to the info page --->
        <cfelse>
        	<cfset flashInsert(error="Make sure you type the correct Password")>
            <cfset redirectTo(controller="info", action=session.user.url_id)>
        </cfif>
    </cffunction>
    
    <!--- Function that opens the Profile page --->
    <cffunction name="profile">
		<cfset user = model("person").findOneByUrl_Id(params.url_id)>
        <cfset image = user.photos(include="person", order="uploaded_at DESC")>
    </cffunction>
    
    <!--- Function that opens the Info page --->
    <cffunction name="info">
    	<cfset user = model("person").findOneByUrl_Id(params.url_id)>
    </cffunction>
    
    <!--- Function that uploads the image to the database and images folder --->
    <cffunction name="upload">
    	<cfif params.user.file eq "">
        	<cfset flashInsert(error="Please select a file to upload")>
        <cfelse>
			<cfset image = model("photo").resize(params.user.file)>
            <cfif image eq false>
            	<cfset flashInsert(error="Please select an image")>
            <cfelse>
				<cfset params.user.file = "#session.user.url_id##image#">
                <cfset image = model("photo").new(params.user)>
                <cfset image.save(where="personid='#params.user.personid#'")>
            </cfif>
        </cfif>      
        <cfset redirectTo(controller="profile", action=session.user.url_id)>
    </cffunction>
    
    <!--- Function that deletes an image from the Profile page --->
    <cffunction name="delete">
    	<cfset deleteImage = model("photo").deleteFile(params.image.file)>
    	<cfset image = model("photo").findOneByPhoto_Id(params.image.photo_id)>
        <cfset image.delete()>
        <cfif session.user.admin neq 1>
        	<cfset redirectTo(controller="profile", action=session.user.url_id)>
        <cfelse>
        	<cfset redirectTo(controller="profile", action=image.url_id)>
        </cfif>
    </cffunction>
    
    <!--- Function that deletes a user (used by the admin) --->
    <cffunction name="deleteUser">
    	<cfset user = model("person").findOneById(params.user.id)>
        <cfset user.delete()>
        <cfset redirectTo(controller="home", action=session.user.url_id)>
    </cffunction>
</cfcomponent>