<cfparam name="user">

<cfoutput>
<div id="info">

<div class="logout-profile">

#linkTo(text="#user.first_name# #user.last_name#", route="userProfile", url_id=user.url_id)#

<cfif (user.url_id neq session.user.url_id)>
	#linkTo(text="#session.user.first_name# #session.user.last_name#", controller="profile", action="#session.user.url_id#")#
</cfif>

#linkTo(text="Logout", controller="main", action="logout")#

</div>

<cfif flashKeyExists("success")>
	<p class="success">#flash("success")#</p>
</cfif>

<div class="user">
<h2>#user.first_name# #user.last_name#</h2>

<cfif(#user.birthdate# != '')>
<p>Birth Date: #DateFormat(user.birthdate, "mmmm d, yyyy")#</p>
</cfif>

<p>Email: #user.email#</p>

<p>Gender: #user.gender#</p>

<p>Profile Address: http://#cgi.server_name#/profile/#user.url_id#</p>

<cfif(#user.about# != '')>
<p>About Me: #user.about#</p>
</cfif>
</div>

</div>
<div id="update-form">

<cfif flashKeyExists("error")>
	<p class="errors">#flash("error")#</p>
</cfif>

<cfif(session.user.id == #user.id#)>
#startFormTag(action="update", class="info-form")#

#errorMessagesFor("user")#

<div class="errors">
#errorMessagesFor("user")#
</div>

<fieldset>

#textField(label="First Name :", objectName="user", property="first_name")#
<p class="error">2-30 characters and no spaces</p>

#textField(label="Last Name :", objectName="user", property="last_name")#
<p class="error">2-30 characters and no spaces</p>

#textField(label="Email :", objectName="user", property="email")#
<p class="error">Enter a valid email</p>

<label for="user[birthdate]">Birth date :</label>
#dateSelect(objectName="user", property="birthdate", startYear=1913, endYear="2013", combine=true, includeBlank=true)#

<fieldset>
<legend>Gender</legend>
#radioButton(label="Male", objectName="user", property="gender", tagValue="M")#

#radioButton(label="Female", objectName="user", property="gender", tagValue="F")#
</fieldset>

<fieldset>
<legend>Profile Address</legend>

#textField(label="http://#cgi.server_name#/profile/", objectName="user", property="url_id")#
<p class="error">6-30 characters and no spaces</p>
</fieldset>

#textArea(objectName="user", property="about", rows="5", cols="40")#
<p class="error"></p>

#passwordField(label="Password :", objectName="user", property="password")#
<p class="error"></p>
    
<div id="submit_update">
	#submitTag(value="Update")#
</div>

</fieldset>
#endFormTag()#
</cfif>

</div>

</cfoutput>