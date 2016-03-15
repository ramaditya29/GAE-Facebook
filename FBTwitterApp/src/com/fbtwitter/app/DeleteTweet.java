package com.fbtwitter.app;

import java.io.IOException;




import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;

@SuppressWarnings("serial")
public class DeleteTweet extends HttpServlet{
	public void doPost(HttpServletRequest req, HttpServletResponse  res) throws ServletException, IOException{
		res.setContentType("text/html");
		PrintWriter out = res.getWriter();
		String myKey = req.getParameter("key");
		DatastoreService service = DatastoreServiceFactory.getDatastoreService();
		Key key = KeyFactory.stringToKey(myKey);
		service.delete(key);
		out.write("Deleted Successfully");
	}

}
