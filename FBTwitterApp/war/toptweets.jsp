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

    <title>Top Tweets</title>


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
  	  	var topTweetsTable = "";
  	  	$(document).ready(function(){
			topTweetsTable = $("#topTweetsTable").dataTable({
				"order": [[ 2, "desc" ]]
			});
			$.ajax({
				type: 'POST',
				url: '/topTweets',
				dataType: 'json',
				success: function(output){
					topTweetsTable.fnClearTable();
					$.each(output.data, function(inx,val){
						var data = [
							val.username,
							val.tweet,
							val.visited_counter
						];
						topTweetsTable.fnAddData(data);
					});
				},
				error: function(output){
					console.log(output);
				}
			});
  	  	});
  	  </script>
  </head>

  <body>

    <div class="container">

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
          <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
              <li ><a href="index.jsp"><i class="fa fa-plus"></i> Create Tweets</a></li>
              <li ><a href="friends.jsp"><i class="fa fa-users"></i> Friends</i></a></li>
              <li class="active"><a href="toptweets.jsp"><i class="fa fa-twitter"></i> Top Tweets</a></li>
              
            </ul>
            
          </div><!--/.nav-collapse -->
        </div><!--/.container-fluid -->
      </nav-->
      <h3 class="text-primary text-center"><i class="fa fa-facebook-official"></i> Twitter Application</h3>
      <hr/>
	  <ul class="nav nav-pills">
  			  <li ><a href="index.jsp"><i class="fa fa-plus"></i> Create Tweets</a></li>
              <li ><a href="friends.jsp"><i class="fa fa-users"></i> Friends</i></a></li>
              <li class="active"><a href="toptweets.jsp"><i class="fa fa-twitter"></i> Top Tweets</a></li>
	  </ul>
	  <hr/>
	  <h3 class="text-primary text-center"><i class="fa fa-twitter"></i> Top Tweets</h3>		      
	  <table class="table table-bordered table-striped" id="topTweetsTable">
	  	<thead>
	  		<tr>
	  			<th>Username</th>
	  			<th>Tweet</th>
	  			<th>No of Views</th>
	  		</tr>
	  	</thead>
	  	<tbody>
	  	</tbody>
	  </table>
    </div> <!-- /container -->


  
  </body>
</html>
