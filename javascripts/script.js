// JavaScript Document

(function(){
	//--------------------------------------------------------
	// Delete Alerts 
	//--------------------------------------------------------
	var deleteUserSubmit = document.querySelector(".delete-user-form");
	var deleteImageSubmit = document.querySelectorAll(".delete-form");	
	
	// Alert for User deletion
	if(deleteUserSubmit){
		
		deleteUserSubmit.onclick = function(e){
			
			var answer = confirm("Are you sure you want to delete this user?");
			
			if(answer){
				
			}else{
				e.preventDefault();
				return false;
			};	
		};
	};
	
	// Alert for Image deletion
	if(deleteImageSubmit){
		
		for(i=0, max=deleteImageSubmit.length; i<max; i++){
			
			deleteImageSubmit[i].onclick = function(e){
				
				var answer = confirm("Are you sure you want to delete this Panorama?");
				
				if(answer){
					
				}else{
					e.preventDefault();
					return false;
				};			
			};		
		};
	};
	
	//--------------------------------------------------------
	// Client-side Validation
	//--------------------------------------------------------
	var inputs = {
		"user-first_name": [/^([a-zA-Z '.-]+){2,30}$/, false],
		"user-last_name": [/^([a-zA-Z '.-]){2,30}$/, false],
		"user-eMail": [/^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/, false],
		"user-passWord": [/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{5,30}$/, false],
		"user-passwordConfirmation": [/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{5,30}$/, false],
		"user-url_id": [/^(?!^[0-9]*$)(?!^[a-zA-Z]*$)^([a-zA-Z0-9]{5,30})$/, false]
	};
	
	var validateField = function(e){
				
		var regEx = inputs[e.currentTarget.id][0];
   		var pass = regEx.test(e.currentTarget.value);
		
		if(document.getElementById(e.currentTarget.id).parentNode.parentNode.nextSibling.nextSibling){
			var errorMsg = document.getElementById(e.currentTarget.id).parentNode.parentNode.nextSibling.nextSibling;
		}else{
			var errorMsg = document.getElementById(e.currentTarget.id).parentNode.nextSibling.nextSibling.nextSibling;
		}
		
		if(e.currentTarget.id != "user-passwordConfirmation"){
			if(!pass){
				errorMsg.style.display = "block";
				inputs[e.currentTarget.id][1] = true;
			}else{
				errorMsg.style.display = "none";
				inputs[e.currentTarget.id][1] = false;
			};
		}else{
			for(var item in inputs){
				if(item == "user-passwordConfirmation"){
				
 	    		    if(document.getElementById(item).value != document.getElementById("user-passWord").value){
	        			inputs[item][1] = true;
	        			errorMsg.style.display = "block";
	       			}else{
	     				inputs[item][1] = false;
	     				errorMsg.style.display = "none";
   			   		};
   		   		};
   		   	};
    	};
    	
    	return pass;
		
	};
	
	for(var input in inputs){
    	var theInput = document.getElementById(input);
		if(theInput){
			theInput.onchange = function(e){
				validateField(e);
			};
		}
  	};
	
	//--------------------------------------------------------
	// Empty password and Email fields
	//--------------------------------------------------------
	
	var passwordField = document.getElementById("user-password");
	var emailField = document.querySelector(".loginEmail");
	
	if(passwordField){
		passwordField.value = "";
	}
	
	if(emailField){
		emailField.value = "";
	}
	
})();