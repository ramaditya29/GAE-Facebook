package com.fbtwitter.app;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;

@SuppressWarnings("serial")
public class CreateTweet extends HttpServlet{
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
	{
		resp.setContentType("text/html");
		PrintWriter out = resp.getWriter();
		String userName = req.getParameter("username");
		String userId = req.getParameter("userid");
		String url = req.getParameter("picture");
		String content = req.getParameter("tweet");
		//out.println(userName + userId + url + content);
		
		DatastoreService service = DatastoreServiceFactory.getDatastoreService();
		Entity entity = new Entity("Tweet");
		
		entity.setProperty("username", userName );
		entity.setProperty("userid", userId);
		entity.setProperty("url", url);
		entity.setProperty("tweet", content);
		entity.setProperty("visited_counter", 0);
		service.put(entity);
		out.println("Data Successfully Inserted");
		
	}

}
