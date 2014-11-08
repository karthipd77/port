package controller;
import java.io.DataInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;




import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.UserBean;

import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Date;




public class login extends HttpServlet implements connection {
	private static final long serialVersionUID = 1L;

	Connection myconn;
	static final String oraDriver="oracle.jdbc.driver.OracleDriver";
	static final String conURL="jdbc:oracle:thin:";
	static final String host="";
	static final String port="1521";
	static final String instance="INATP02";
	static final String uid="shobana";
	static final String pwd="shobana";
	static final String oraURL=conURL+"@"+host+":"+port+":"+instance;
	 RequestDispatcher rd = null;
    public void doPost(HttpServletRequest request, HttpServletResponse response)
    throws IOException{
        response.setContentType("text/html");
    	PrintWriter out = response.getWriter();
    	out.println("<html><head>");
    try
    {
    	
    	Connection myconn;
          Class.forName("oracle.jdbc.driver.OracleDriver");
          myconn=DriverManager.getConnection(oraURL,uid,pwd);
          Statement stmt = myconn.createStatement();
   
          Statement stmt1 = myconn.createStatement();
          int id =0;
          
          String username = request.getParameter("username");
          String password = request.getParameter("password");
         
       
          String query = "Select * from user_table where username='"+username+"' and password='"+password+"' ";
          
          Statement  st = myconn.createStatement();
          ResultSet  rs = st.executeQuery(query);

          if(rs.next())  
          {
          
        	  
        	  String query1 = "Select * from user_table where username='"+username+"' and password='"+password+"' ";
  			stmt1 = myconn.createStatement();
  			ResultSet rs1 = stmt1.executeQuery(query1);
  			 
  			 
  			while(rs1.next())
  			{
  				id = Integer.parseInt(rs.getString(8));
  				
  				System.out.println("append"+id);
  			}

  			if(id==1)
  			{
  				response.sendRedirect("adminpage.jsp");
  			}
  			else
  			
  			{
  				 rd = request.getRequestDispatcher("/WEB-INF/views/user_home.jsp");
  	            UserBean user = new UserBean(username, password);
  	            request.setAttribute("user", user);
  	            rd.forward(request, response);
  			}
        	  
          	 
 
          }
          else
          {
        	  response.sendRedirect("login.jsp");
          }
          
    }
    
    
    catch(Exception e)
    {
          	  
          System.out.println(e);
    }
    
    
    }
    
    public void doGet(HttpServletRequest request, HttpServletResponse response)
    	    throws IOException, ServletException{
    	 rd = request.getRequestDispatcher("/WEB-INF/views/register.jsp");
    	 rd.forward(request, response);
    }

}
