package com.fbtwitter.app;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.PreparedQuery;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Query.Filter;
import com.google.appengine.api.datastore.Query.FilterOperator;
import com.google.appengine.api.datastore.Query.FilterPredicate;

@SuppressWarnings("serial")
public class UpdateCounter extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		resp.setContentType("application/json");
		PrintWriter out = resp.getWriter();
		//UpdateTweetBean update = null;
		//ArrayList<UpdateTweetBean> results = new ArrayList<UpdateTweetBean>();
		JSONObject object = new JSONObject();
		String myKey = req.getParameter("key");
		Key key = KeyFactory.stringToKey(myKey);
		DatastoreService service = DatastoreServiceFactory.getDatastoreService();
		Query updateQuery = new Query("Tweet");
		Filter filter = new FilterPredicate(Entity.KEY_RESERVED_PROPERTY, FilterOperator.EQUAL, key);
		updateQuery.setFilter(filter);
		PreparedQuery query = service.prepare(updateQuery);
		Entity tweets = query.asSingleEntity();
		tweets.setProperty("visited_counter", ((Long)tweets.getProperty("visited_counter")).intValue() + 1);
		service.put(tweets);
		try {
			object.put("username", tweets.getProperty("username"));
			object.put("tweet", tweets.getProperty("tweet") );
			object.put("count", tweets.getProperty("visited_counter"));
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		out.write(object.toString());
		
	}

}
