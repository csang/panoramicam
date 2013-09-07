<cfcomponent extends="Controller" output="no">
	
    <!--- Function that opens the home page --->
    <cffunction name="home">
    	<cfset user = model("person").findAll()>
    	<cfset image = model("photo").new()>
    	<cfset image = model("photo").findAll(include="person", order="uploaded_at DESC")>
    </cffunction>
    
    <!--- Function that opens the login/register page --->
	<cffunction name="login">
		<cfset user = model("person").new()>
	</cffunction>
    
    <!--- Function that logs out the user --->
    <cffunction name="logout">
		<cfset StructDelete(session, "user")>
        <cfset redirectTo(controller="main", action="login")>
	</cffunction>
    
    <!--- Function that signs in the user if it exists in the database --->
    <cffunction name="signin">
    	<cfif (params.user.email == "" || params.user.password == "")>
        	<cfset user = model("person").new(email=params.user.email)>
            <cfset flashInsert(error="The email and password that you entered is not valid")>
			<cfset renderPage(action="login")>
        <cfelse>
        	<cfset user = model("person").findOne(where="email='#params.user.email#' AND password=MD5('#params.user.password#')")>
            
            <cfif IsObject(user)>
				<cfset session.user = user>
                <cfset redirectTo(controller="home", action="#session.user.url_id#")>
            <cfelse>
                <cfset user = model("person").new(email=params.user.email)>
                <cfset flashInsert(error="The email and password that you entered is not valid")>
                <cfset renderPage(action="login")>
            </cfif>
        </cfif>
	</cffunction>
    
    <!--- Function that creates the user when registering --->
    <cffunction name="create">
    
    	<cfif params.user.password eq "">
        	<cfset user = model("person").new(params.user)>
            <cfset flashInsert(passError="Please fill in all the fields")>
            <cfset renderPage(action="login")>
        <cfelse>
			<cfset params.user.password = hash(params.user.password, "MD5")>
            <cfset params.user.passwordConfirmation = hash(params.user.passwordConfirmation, "MD5")>
            <cfset user = model("person").new(params.user)>
            <cfset user.save()>
                
			<cfif user.hasErrors()>
            	<cfset user.password = "">
                <cfset user.passwordConfirmation = "">
                <cfset renderPage(action="login")>
            <cfelse>
                <cfset user = model("person").findOne(where="email='#params.user.email#' AND password='#params.user.password#'")>
                <cfset session.user = user>
                <cfset flashInsert(success="You've registered successfully. Welcome to PANORAMICAM!")>
                <cfset redirectTo(controller="info", action="#session.user.url_id#")>
            </cfif>
        </cfif>
    </cffunction>
    
    <!--- Function that deletes an image from the home page (used by the admin) --->
    <cffunction name="delete">
    	<cfset deleteImage = model("photo").deleteFile(params.image.file)>
    	<cfset image = model("photo").findOneByPhoto_Id(params.image.photo_id)>
        <cfset image.delete()>
        <cfset redirectTo(controller="home", action=session.user.url_id)>
    </cffunction>
    
</cfcomponent>