<!--- Place HTML here that should be used as the default layout of your application --->
<cfoutput>
<html>
<head>
#stylesheetLinkTag("style")#
</head>
<body>
	<header>
    	<cfif StructKeyExists(session,"user") and session.user.admin eq 0>
        	<a href="../home/#session.user.url_id#"><img id="logo" src="../../images/assets/panoramicam_logo.png"/></a>
        <cfelse>
            <img id="logo" src="../../../images/assets/panoramicam_logo.png"/>
        </cfif>
    </header>
    <div id="wrapper">
	#includeContent()#
    </div>
    <footer>
    	<p>&copy;2013, Carlos Sang</p>
    </footer>
    <script type="text/javascript" src="../../javascripts/script.js"></script>
</body>
</html>
</cfoutput>