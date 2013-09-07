<!---
	Here you can add routes to your application and edit the default one.
	The default route is the one that will be called on your application's "home" page.
--->
<cfset addRoute(name="userProfile", pattern="profile/[url_id]", controller="user", action="profile")>

<cfset addRoute(name="userInfo", pattern="info/[url_id]", controller="user", action="info")>

<cfset addRoute(name="userHome", pattern="home/[url_id]", controller="main", action="home")>

<cfset addRoute(name="home", pattern="", controller="main", action="login")>