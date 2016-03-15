package com.fbtwitter.app;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.Query;

@SuppressWarnings("serial")
public class TopTweets extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		resp.setContentType("application/json");
		PrintWriter out = resp.getWriter();
		DatastoreService service = DatastoreServiceFactory.getDatastoreService();
		Query topTweetsQuery = new Query("Tweet").addSort("visited_counter",Query.SortDirection.DESCENDING);
		List<Entity> tweets = service.prepare(topTweetsQuery).asList(FetchOptions.Builder.withLimit(5));
		MyTweets myTweet = null;
		JSONObject object = new JSONObject();
		ArrayList<MyTweets> results = new ArrayList<MyTweets>();
		for(Entity tweet : tweets){
			myTweet = new MyTweets();
			myTweet.setTweet((String)tweet.getProperty("tweet"));
			myTweet.setUsername((String)tweet.getProperty("username"));
			myTweet.setUserid((String) tweet.getProperty("userid"));
			myTweet.setUrl((String)tweet.getProperty("url"));
			myTweet.setVisited_counter((Long) tweet.getProperty("visited_counter"));
			myTweet.setKey(KeyFactory.keyToString(tweet.getKey()));
			results.add(myTweet);
		}
		try {
			object.put("data", results);
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		out.write(object.toString());
	}

}
