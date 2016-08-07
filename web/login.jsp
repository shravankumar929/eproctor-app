<%-- 
    This page takes the  input as entered by the user on index.jsp and validates it against the back-end database 'one'
--%>



<%
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*,java.io.*,java.util.*,java.security.*,dbConnection.DB_Connect"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">




<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>eProctor</title>
    </head>
    <body>
        <%
            
            /*Here we verify the information entered by the user in the e-mail id text field and password field */
 /*This page is called when the user clicks on the 'Login' button as the action of the corresponding form on index.jsp is the current page 'login,jsp' */
            String fname = null, fpassword = null;
            try {

                fname = request.getParameter("username");
                fpassword = request.getParameter("password");

                MessageDigest alg = MessageDigest.getInstance("MD5");
                alg.reset();
                alg.update(fpassword.getBytes());
                byte[] digest = alg.digest();
                StringBuffer hashedpasswd = new StringBuffer();
                String hx;
                for (int i = 0; i < digest.length; i++) {
                    hx = Integer.toHexString(0xFF & digest[i]);
                    //0x03 is equal to 0x3, but we need 0x03 for our md5sum
                    if (hx.length() == 1) {
                        hx = "0" + hx;
                    }
                    hashedpasswd.append(hx);
                }
                String pass = hashedpasswd.toString();
                /*Establishing connection with the back end Ms-Access database named 'one'*/
               // Class.forName("com.mysql.jdbc.Driver");
                Connection con = null;
                con=DB_Connect.getDBConnection();
                String sql = "select Role,Fname,Status from Details where Email=? and Password=?";
                PreparedStatement ps = con.prepareStatement(sql);

                ps.setString(1,fname);
                ps.setString(2,pass);
                ResultSet rs = ps.executeQuery();

                String s1;
                String s2;
                int status;
                if (rs.next()) 
                {

                    s1 = rs.getString(1); // Role of the user
                    s2 = rs.getString(2); // First name of the user
                    status=rs.getInt(3);
                    // s3 = rs.getString(5); // Test Alloted to the user, this entry is set as 'NA' by default if the centre is not alloted
                    if(status==0)
                    {
                    	response.sendRedirect("loginPage.jsp?msg=Your account is under verification!!!");
                    }
                    else if (s1.equals("Teacher")) // if the user who is trying to log in is a teacher
                    {
                        //set user's session

                        session.setAttribute("role", s1);
                        session.setAttribute("firstName", s2);
                        session.setAttribute("name", fname);
                        session.setAttribute("password", fpassword);
                        response.sendRedirect("teacher/teacherIndex.jsp");
                       // response.setStatus(response.SC_MOVED_TEMPORARILY);
                       // response.setHeader("Location", "teacher/teacherIndex.jsp");//redirect <track kind="" src=""> o the teacher's page
                    } else if (s1.equals("Admin")) // if the user who is trying to log in is the admin
                    {
                        //set user's session
                        session.setAttribute("role", s1);
                        session.setAttribute("firstName", s2);
                        session.setAttribute("name", fname);
                        session.setAttribute("password", fpassword);
                        response.sendRedirect("admin/adminIndex.jsp");
                       // response.setStatus(response.SC_MOVED_TEMPORARILY);
                       // response.setHeader("Location", "admin/adminIndex.jsp");//redirect to the admin's page
                    } else if (s1.equals("Student")) {
                    
                        session.setAttribute("role", s1);
                        session.setAttribute("firstName", s2);
                        session.setAttribute("name", fname);
                        session.setAttribute("password", fpassword);
                        response.sendRedirect("student/studentResults.jsp");
                    	//response.sendRedirect("loginPage.jsp?msg=Students are not allowed to login!!!");
                       // response.setStatus(response.SC_MOVED_TEMPORARILY);
                        //response.setHeader("Location", "student/studentIndex.jsp");
                    } 
                    else 
                    {
                        response.sendRedirect("loginPage.jsp?msg=Invalid Username/Password!");
                    }

                } 
                else 
                {
                    /*
                    out.println("<script type=\"text/javascript\">");
                                        out.println("alert('User or password incorrect');");
                                        out.println("location='index.jsp';");
                                        out.println("</script>");
                     */
                    response.sendRedirect("loginPage.jsp?msg=Invalid Username/Password!");// redirect to index page, give error message and ask the user to enter the details again
                }

            } catch (Exception e) {
                out.println(e.getMessage());
            }
        %>

    </body>
</html>
