package com.fbtwitter.app;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;

@SuppressWarnings("serial")
public class Project1TwitterAppServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException, ServletException {
		resp.setContentType("text/plain");
		
		String username = req.getParameter("username");
		
		HttpSession session = req.getSession();
		session.setAttribute("username", username);
		
		RequestDispatcher rd  = req.getRequestDispatcher("index.jsp");
		rd.forward(req, resp);
		
		
	}
	
	
}
