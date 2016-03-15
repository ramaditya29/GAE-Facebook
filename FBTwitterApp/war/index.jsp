<%@page import="com.google.appengine.api.datastore.Query.FilterOperator"%>
<%@page import="com.google.appengine.api.datastore.FetchOptions"%>
<%@page import="com.google.appengine.api.datastore.Entity"%>
<%@page import="java.util.List"%>
<%@page import="com.google.appengine.api.datastore.Query"%>
<%@page import="com.google.appengine.api.datastore.Query.FilterPredicate"%>
<%@page import="com.google.appengine.api.datastore.DatastoreServiceFactory"%>
<%@page import="com.google.appengine.api.datastore.DatastoreService"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en" >
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">

    <title>Create Tweets</title>


  	<style>
	body {
	  padding-top: 20px;
	  padding-bottom: 20px;
	}
	
	.navbar {
	  margin-bottom: 20px;
	}
	</style>
	 <link rel="stylesheet" href="bootstrap.css"></link>
	  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
	  <link rel="stylesheet" href="jquery.dataTables.min.css">
	  <script src="jquery-1.11.3.js"></script>	
	  <script src="angular.min.js"></script>
	  <script src="bootstrap.min.js"></script>
	  <script src="jquery.dataTables.js"></script>
	  <script src="fbApp.js"></script>
  	  <script>
  	  var username = "<%= (String)session.getAttribute("username")%>";
  	var tweetsTable = '';
  	 $("document").ready(function(){
  		tweetsTable = $("#tweetsTable").dataTable({});
  	  	 	$("#formInfo").hide();
  	  		$.ajax({
      				type: 'POST',
      				data: {
      					username : username
      				},
      				url: '/retrieveTweet',
      				dataType: 'json',
      				success: function(output){
      					console.log(output.data);
      					tweetsTable.fnClearTable();
      					$.each(output.data, function(inx,val){
      						var deleteFn = 'deleteFn("' + val.key + '")';
      						//var deleteFn = 'deleteFn("Aditya")';
                  var data = [
      							val.username,
      							val.tweet,
      							"<button class='btn btn-lg btn-danger' id='deleteRow' onclick='"+ deleteFn + "'><i class='fa fa-minus'></i></button>"
      						];
      						tweetsTable.fnAddData(data);
      					});
      				},
      				error: function(output){
      					console.log(output);
      				}
  	  	  	});
  	  		//alert(username);
			$("#createTweet").click(function(){
				$("#formInfo").toggle();
				getUserData();
			});
			
			$("#postTweet").click(function(){
				var username = $("#username").val();
				var userid = $("#userid").val();
				var picture = $("#picture").val();
				var content = $("#tweet").val();
				//alert(username + userid + picture + content);
				$.ajax({
					type: 'POST',
					data:{
						username : username,
						userid : userid,
						picture: picture,
						tweet: content
					},
					url: '/saveTweet',
					success: function(output){
						$("#tweet").val('');
						//alert(output);
						$("#modalContent").html(output);
						$("#myModal").modal('show');
						retrieveData();
					},
					error: function(output){
						alert(output);
					}
				});
			});
  	 });
  	 function retrieveData(){
  	  	
  		tweetsTable = $("#tweetsTable").dataTable({});
  		$.ajax({
				type: 'POST',
				data: {
					username : username
				},
				url: '/retrieveTweet',
				dataType: 'json',
				success: function(output){
					console.log(output.data);
					tweetsTable.fnClearTable();
					$.each(output.data, function(inx,val){
						var deleteFn = 'deleteFn("' + val.key + '")';
						//var deleteFn = 'deleteFn("Aditya")';
          var data = [
							val.username,
							val.tweet,
							"<button class='btn btn-lg btn-danger' id='deleteRow' onclick='"+ deleteFn + "'><i class='fa fa-minus'></i></button>"
						];
						tweetsTable.fnAddData(data);
					});
				},
				error: function(output){
					console.log(output);
				}
	  	});
  	 }
  	function statusChangeCallback(response) {
  		console.log('statusChangeCallback');
  		console.log(response);
  		// The response object is returned with a status field that lets the
  		// app know the current login status of the person.
  		// Full docs on the response object can be found in the documentation
  		// for FB.getLoginStatus().
  		if (response.status === 'connected') {
  		// Logged into your app and Facebook.
  			testAPI();
  			
  		} else if (response.status === 'not_authorized') {
  		// The person is logged into Facebook, but not your app.
  			document.getElementById('status').innerHTML = 'Please log ' +
  		'into this app.';
  		} else {
  		// The person is not logged into Facebook, so we're not sure if
  		// they are logged into this app or not.
  		document.getElementById('status').innerHTML = 'Please log ' +
  		'into Facebook.';
  		}
  	}

  	// This function is called when someone finishes with the Login
  	// Button. See the onlogin handler attached to it in the sample
  	// code below.
  	function checkLoginState() {
  		FB.getLoginStatus(function(response) {
  			statusChangeCallback(response);
  		});
  	}



  	// Now that we've initialized the JavaScript SDK, we call 
  	// FB.getLoginStatus(). This function gets the state of the
  	// person visiting this page and can return one of three states to
  	// the callback you provide. They can be:
  	//
  	// 1. Logged into your app ('connected')
  	// 2. Logged into Facebook, but not your app ('not_authorized')
  	// 3. Not logged into Facebook and can't tell if they are logged into
  	// your app or not.
  	//
  	// These three cases are handled in the callback function.





  	// Load the SDK asynchronously
  	 window.fbAsyncInit = function() {
  	    FB.init({
  	      appId      : '844651422347967',
  	      xfbml      : true,
  	      version    : 'v2.5'
  	    });
  	  function checkLoginState() {
    		FB.getLoginStatus(function(response) {
    			statusChangeCallback(response);
    		});
    	}
  	FB.getLoginStatus(function(response) {

        statusChangeCallback(response);

        },{scope:'user_friends,user_birthday,email,publish_actions'});
  	
  	    // ADD ADDITIONAL FACEBOOK CODE HERE
  	  };
		
  	  (function(d, s, id){
  	     var js, fjs = d.getElementsByTagName(s)[0];
  	     if (d.getElementById(id)) {return;}
  	     js = d.createElement(s); js.id = id;
  	     js.src = "//connect.facebook.net/en_US/sdk.js";
  	     fjs.parentNode.insertBefore(js, fjs);
  	   }(document, 'script', 'facebook-jssdk'));

  	
 
	  

  	// Here we run a very simple test of the Graph API after login is
  	// successful. See statusChangeCallback() for when this call is made.
  	function testAPI() {
  		console.log('Welcome! Fetching your information.... ');
  		FB.api('/me?fields=name,id,picture', function(response) {
  			console.log('Successful login for: ' + response.name);
  			//document.getElementById('status').innerHTML =
  		//	'Thanks for logging in, ' + response.name + '!' ;
  			document.getElementById('username').value = response.name;
  			username = response.name;
  			//document.getElementById('userid').value = response.id;
  			//document.getElementById('url').value = response.picture.data.url;
  		});
  	}
  	function getUserData(){
  		FB.api('/me?fields=name,id,picture',function(response){
  	  		console.log( response);
     			//alert(response.name);
    			username = response.name;
     			$("#username").val(response.name);
     			$("#userid").val(response.id);
     			$("#picture").val(response.picture.data.url);
     	});
  	}
  	function execute(operation){
		if(operation == "post"){
			var post = $("#tweet").val();
			if(post == "")
				alert("Please enter some tweet");
			else{
				FB.login(function(response){
				       //var typed_text = document.getElementById("message_text").value;
				        FB.api('/me/feed', 'post', {message: post});
				        //document.getElementById('theText').innerHTML = 'Thanks for posting the message' + typed_text;
				   }, {scope: 'publish_actions,user_birthday,user_about_me,email'});
				//alert("I am in post");
				$("#tweet").val('');
				document.getElementById('post').checked = false; 
				
				alert("Posted Succesfully on your timeline");
			}
			
		}
		else if(operation == "send"){
			document.getElementById('send').checked = false;
			FB.ui({
		 		method: 'share',
		 		href:'https://apps.facebook.com/TwitterApp/index.jsp'
		 		});	
		}
		else{
		}
  	}
  	function deleteFn(key){
		alert(key);
		$.ajax({
			type: 'POST',
			data: {
				key : key
			},
			url: '/deleteTweet',
			success: function(output){
				alert(output);	
				retrieveData();
			},
			error: function(output){
			}
			});
  	}
  	  </script>	
  	</head>

  <body>

    <div class="container" >

      <!-- Static navbar -->
      <!--  nav class="navbar navbar-default">
        <div class="container-fluid">
          <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#"><i class="fa fa-facebook-official"> Twitter App</i></a>
          </div>
          <div id="navbar" >
            <ul class="nav navbar-nav">
              <li class="active"><a href="index.jsp"><i class="fa fa-plus"></i> Create Tweets</a></li>
              <li><a href="friends.jsp"><i class="fa fa-users"></i> Friends</i></a></li>
              <li><a href="toptweets.jsp"><i class="fa fa-twitter"></i> Top Tweets</a></li>
              
            </ul>
            
          </div>
        </div>
      </nav-->
      <h3 class="text-primary text-center"><i class="fa fa-facebook-official"></i> Twitter Application</h3>
      <hr/>
      	<ul class="nav nav-pills">
  			  <li class="active"><a href="index.jsp"><i class="fa fa-plus"></i> Create Tweets</a></li>
              <li><a href="friends.jsp"><i class="fa fa-users"></i> Friends</i></a></li>
              <li><a href="toptweets.jsp"><i class="fa fa-twitter"></i> Top Tweets</a></li>
		</ul>
		<hr/>
     
      <div>
    	  <button type="button" class="btn btn-danger" id="createTweet" ><i class="fa fa-twitter"></i> Create Tweet</button>	
    	  <br/><br/>
    	 	<div id="formInfo">
    		  <form role="form" class="form-horizontal" method="POST" >
    		      <div class="form-group">
    				  <label for="comment">Tweet Name:</label>
    				  <textarea class="form-control" rows="5"  cols="8" id="tweet" name="tweet"></textarea>
    				  <input type="hidden" value="username" id="username" name="username" />
    				  <input type="hidden" value="userid" id="userid" name="userid" />
    				  <input type="hidden" value="picture" id="picture" name="picture" />
    			  </div>
    			  <div class="form-group">
    			  	<button class="btn btn-success" type="button" id="postTweet"><i class="fa fa-comment"></i> Post Tweet</button>
    			  </div>
    			  <div class="form-group">
    			 	 <label class="checkbox-inline"><input type="checkbox" value="post" onchange="execute('post')" id="post">Post Message To Time Line</label>
    			  	 <label class="checkbox-inline"><input type="checkbox" value="send" onchange="execute('send')" id="send">Send Message to Friends</label>
    			  </div>
    		  </form>	
    		  </div>
    		  <hr/>
    		  <h3 class="text-primary text-center"><i class="fa fa-list-alt"></i> List of Tweets</h3>
    		  <table class="table table-bordered table-striped" id="tweetsTable">
    		  	<thead>
    		  		<tr>
    		  			<th>Username</th>
    		  			<th>Tweet</th>
    		  			<th></th>
    		  		</tr>
    		  	</thead>
    		  </table>
    		  </div>
    	 </div>	  
    </div> 
	<div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog modal-sm">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Status</h4>
        </div>
        <div class="modal-body" >
          <p id="modalContent">This is a small modal.</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>

  
  </body>
</html>
