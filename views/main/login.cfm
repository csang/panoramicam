<cfparam name="user">

<cfoutput>

<div id="welcome">
#startFormTag(action="signin", class="login")#

<fieldset class="loginFieldset">

<div class="errors">
#flash("error")#
</div>

#textField(label="Email :", objectName="user", property="email", append="", prepend="", class="loginEmail")#

#passwordField(label="Password :", objectName="user", property="password", append="", prependToLabel="")#
    
#submitTag(value="Log in", id="submit_login")#

</fieldset>
#endFormTag()#

#startFormTag(action="create", class="register")#

<div class="errors">
#errorMessagesFor("user")#
#flash("passError")#
</div>

<fieldset class="registerFieldset">

#textField(label="First Name :", objectName="user", property="first_name")#
<p class="error">2-30 characters</p>

#textField(label="Last Name :", objectName="user", property="last_name")#
<p class="error">2-30 characters</p>

#textField(label="Email :", objectName="user", property="eMail")#
<p class="error">Enter a valid email</p>

#passwordField(label="Password :", objectName="user", property="passWord")#
<p class="error">6-30 characters, 1 digit and 1 uppercase letter</p>

#passwordField(label="Confirm Password :", objectName="user", property="passwordConfirmation")#
<p class="error">Password must match</p>

<fieldset>
<legend>Profile Address</legend>

#textField(label="http://#cgi.server_name#/profile/", objectName="user", property="url_id")#

</fieldset>
<p class="error url_id">6-30 characters</p>    
<div id="submit_register">
	#submitTag(value="Register Now")#
</div>

</fieldset>
#endFormTag()#
</div>

</cfoutput>