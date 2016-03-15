<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">

    <title>Friends</title>


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
  	  <script>
  	  	var username = "<%= (String) session.getAttribute("username") %>";
  	  	var friendsTable = "";
  	  	var friendsTweetsTable = "";
		$(document).ready(function(){
			retrieveData();		
		});
		function retrieveData()
		{
			friendsTweetsTable = $("#friendsTweets").dataTable({});
			$.ajax({
				type: 'POST',
				data: {
					username : username
				},
				url: '/friendTweets',
				dataType: 'json',
				success: function(output){
					console.log(output.data);
  					friendsTweetsTable.fnClearTable();
  					$.each(output.data, function(inx,val){
  						//var deleteFn = 'deleteFn("' + val.key + '")';
  						var tweetUpdateFn = 'updateFn("' + val.key + '")';
  						//var deleteFn = 'deleteFn("Aditya")';
              			var data = [
  							val.username,
  							"<u><span style='cursor:pointer;' onclick='" + tweetUpdateFn + "'>" + val.tweet + "</span></u>",
  							val.visited_counter
  						];
  						friendsTweetsTable.fnAddData(data);
  					});
				},
				error: function(output){
					console.log(output);
				}
				
			});
		}
		function updateFn(key){
			//alert(key);
			$.ajax({
				type: 'POST',
				data: {
					key : key
				},
				url: '/updateCounter',
				dataType: 'json',
				success: function(output){
					$("#modalContent").html("Username: " + output.username + "<br/>" + "Tweet:" + output.tweet + "<br/>" +  "Visits:" + output.count);
					$("#myModal").modal('show');	
					//console.log(output.username);
					retrieveData();
				},
				error: function(output){}
				
			});
		}

		function friendsData(response){
			console.log("Printing");
			console.log(response.data);
			friendsTable = $("#friendsTable").dataTable({});
			friendsTable.fnClearTable();
			$.each(response.data, function(inx,val){
				var data = [
					val.name,
					"<img src='" + val.picture.data.url + "'></img>"
				];
				console.log(val.picture.data.url)
				friendsTable.fnAddData(data);
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
	  			FB.api('/me/friends?fields=name,id,picture',function(response){
	            	console.log(response);
	            	friendsData(response);
	            })
	  			
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
		        FB.login(function (response){
		        			//onlogin(response);
		        		},{scope:'user_friends,email,user_birthday'});

		        });
	  	
	  	    // ADD ADDITIONAL FACEBOOK CODE HERE
	  	  };
			
	  	  (function(d, s, id){
	  	     var js, fjs = d.getElementsByTagName(s)[0];
	  	     if (d.getElementById(id)) {return;}
	  	     js = d.createElement(s); js.id = id;
	  	     js.src = "//connect.facebook.net/en_US/sdk.js";
	  	     fjs.parentNode.insertBefore(js, fjs);
	  	   }(document, 'script', 'facebook-jssdk'));
  	  </script>
  </head>

  <body>

    <div class="container">

      <!-- Static navbar -->
      <!--nav class="navbar navbar-default">
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
          <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
              <li><a href="index.jsp"><i class="fa fa-plus"></i> Create Tweets</a></li>
              <li class="active"><a href="friends.jsp"><i class="fa fa-users"></i> Friends</i></a></li>
              <li><a href="toptweets.jsp"><i class="fa fa-twitter"></i> Top Tweets</a></li>
              
            </ul>
            
          </div><!--/.nav-collapse -->
        </div><!--/.container-fluid -->
      </nav-->
      <h3 class="text-primary text-center" ><i class="fa fa-facebook-official"></i> Twitter Application</h3>
      <hr/>
		<ul class="nav nav-pills">
  			  <li><a href="index.jsp"><i class="fa fa-plus"></i> Create Tweets</a></li>
              <li class="active"><a href="friends.jsp"><i class="fa fa-users"></i> Friends</i></a></li>
              <li><a href="toptweets.jsp"><i class="fa fa-twitter"></i> Top Tweets</a></li>
		</ul>
	  <hr/>
	  <h3 class="text-primary text-center"><i class="fa fa-users"></i> Friends</h3>
	  <table class="table table-bordered table-striped table-hover" id="friendsTable">
	  	<thead>
	  		<tr>
	  			<th>Username</th>
	  			<th>Picture</th>
	  		</tr>
	  	</thead>
	  	<tbody>
	  	</tbody>
	  </table>
	  <hr/>
      <h3 class="text-primary text-center"><i class="fa fa-list-alt"></i> Friends Tweets</h3>
	  <table class="table table-striped table-bordered" id="friendsTweets">
	  	<thead>
	  		<tr>
	  			<th>Username</th>
	  			<th>Tweets</th>
	  			<th>Views</th>
	  		</tr>
	  	</thead>
	  	<tbody>
	  	</tbody>
	  </table>	
    </div> <!-- /container -->

	<div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog modal-sm">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Tweet Details</h4>
        </div>
        <div class="modal-body" >
          <p id="modalContent"></p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>
  
  </body>
</html>
