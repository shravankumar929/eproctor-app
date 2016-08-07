<%-- 
    Document   : InsertData
    Created on : 13 Jun, 2016, 4:38:51 PM
    Author     : sarreddy
--%>
<%@page import="java.util.HashSet"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Enumeration"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<%
        if ((session.getAttribute("name")) != null && (session.getAttribute("password") != null) && (session.getAttribute("role").equals("Admin"))) {
    %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            try
            {
                Enumeration paramNames = request.getParameterNames();
                Connection con = null;
                con=DB_Connect.getDBConnection();
                while (paramNames.hasMoreElements()) {
                    String paramName = (String) paramNames.nextElement();
                    out.println(paramName);
                    String[] paramValues = request.getParameterValues(paramName);
                    
                    for (int i = 0; i < paramValues.length; i++) {
                        out.println(paramValues[i]);
                        String[] s = paramValues[i].split(":");
                        Statement s1=con.createStatement();
                        String query ="update Details set Status=\'"+s[1]+"\' where Email=\'"+s[0]+"\'";
                        out.println(query);
                        s1.executeUpdate(query);
                        
                    }
                }
                Statement s1=con.createStatement();
                String query ="delete from Details where Status=\'"+2+"\'";
                out.println(query);
                s1.executeUpdate(query);
                response.setStatus(response.SC_MOVED_TEMPORARILY);
                response.setHeader("Location", "RegistrationRequests.jsp");
            }
            catch(Exception e)
            {
                    out.println(e.getMessage());
            }
        %>
    </body>
     <%
    } 
     else
    {
   	response.sendRedirect("/index.jsp");
    }
    %>
</html>
