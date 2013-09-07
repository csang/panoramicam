<cfparam name="image" type="query">
<cfparam name="user">

<cfoutput>

<div class="logout-info">

<cfif (session.user.admin neq 1)>
	<cfif (user.url_id eq session.user.url_id)>
   		#linkTo(text="My Info", controller="info", action="#user.url_id#")#
    <cfelse>
		#linkTo(text="#user.first_name# #user.last_name#'s Info", controller="info", action="#user.url_id#")#
    </cfif>
<cfelse>
	#linkTo(text="All", controller="home", action="#session.user.url_id#")#
</cfif>

<cfif (user.url_id neq session.user.url_id and session.user.admin neq 1)>
	#linkTo(text="#session.user.first_name# #session.user.last_name#", controller="profile", action="#session.user.url_id#")#
</cfif>

#linkTo(text="Logout", controller="main", action="logout")#

</div>

<h2>#user.first_name# #user.last_name#</h2>

<cfif (session.user.admin eq 1)>
    #startFormTag(action="deleteUser", class="delete-user-form")#
    <input id="user-id" name="user[id]" type="hidden" value="#user.id#">
    <div class="submit-delete">
        #submitTag(value="Delete User")#
    </div>
    #endFormTag()#
</cfif>

<cfif (session.user.admin neq 1)>
    <p>
        <strong>Member Since:</strong><br />
        #DateFormat(user.created_at, "mmmm d, yyyy")#
    </p>
</cfif>

<cfif (session.user.id == #user.id# && session.user.admin neq 1)>
    
    #startFormTag(action="upload", multipart="true", class="upload-form")#
        <fieldset>
        	<div class="errors">
	            #flash("error")#
            </div>
            <input id="user-id" name="user[personid]" type="hidden" value="#user.id#">
            #hiddenField(objectName="user", property="url_id")#
            #fileField(label="Photo :", objectName="user", property="file")#
            <div id="submit_upload">
                #submitTag(value="Upload")#
            </div>
        </fieldset>
    #endFormTag()#
</cfif>


<cfloop query="image">
	<div class="image">
		<cfif (session.user.id eq #image.personid# || session.user.admin eq 1)>
        #startFormTag(action="delete", class="delete-form")#
        <input id="image-photo_id" name="image[photo_id]" type="hidden" value="#image.photo_id#">
        <input id="image-url" name="image[file]" type="hidden" value="#image.file#">
        <div class="submit-delete">
            #submitTag(value="Delete")#
        </div>
        #endFormTag()#
        </cfif>
        <img src="../../images/panoramas/#image.file#"/>
    </div>
</cfloop>

</cfoutput>