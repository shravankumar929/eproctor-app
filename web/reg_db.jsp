<%-- 
    This jsp page is used to store data into the the database table when the new user is registering for the quiz module.
--%>
<%@page import="dbConnection.DB_Connect"%>
<%@page contentType="text/html; charset=iso-8859-1" pageEncoding="UTF-8" language="java" import="java.sql.*,java.io.*,java.security.MessageDigest"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">



<%

    try {

//Establishing connection with back end database
        Connection con = null;
        con=DB_Connect.getDBConnection();
        Statement s = con.createStatement();
        //Getting the various parameters which have been given by the user.
        String role = request.getParameter("role");
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String mname = request.getParameter("mname");
        String email = request.getParameter("email");
        String passwd = request.getParameter("password");


        ResultSet rs=s.executeQuery("select * from Details where Email='"+email+"'");
        out.println(rs.next());
        if(rs.next())
        {
            response.setStatus(response.SC_MOVED_TEMPORARILY);
            response.setHeader("Location", "registration.jsp?msg=Email Already exists!");

        }
        else
        {

        MessageDigest alg = MessageDigest.getInstance("MD5");
 
        // Reset the digest, in case it's been used already during this section of code
        // This probably isn't needed for pages of 210 simplicity
        alg.reset(); 
     
        // Calculate the md5 hash for the password. md5 operates on bytes, so give
        // MessageDigest the byte verison of the string
        alg.update(passwd.getBytes());
     
        // Create a byte array from the string digest
        byte[] digest = alg.digest();
     
        // Convert the hash from whatever format it's in, to hex format
        // which is the normal way to display and report md5 sums
        // This is done byte by byte, and put into a StringBuffer
        StringBuffer hashedpasswd = new StringBuffer();
        String hx;
        for (int i=0;i<digest.length;i++){
            hx =  Integer.toHexString(0xFF & digest[i]);
            //0x03 is equal to 0x3, but we need 0x03 for our md5sum
            if(hx.length() == 1){hx = "0" + hx;}
            hashedpasswd.append(hx);
        }
 
        // Print out the string hex version of the md5 hash
        //out.println("MD5 version is: " + hashedpasswd.toString() + "<br>");
        if (role != null) {
            String qry = "insert into Details(Email,Role,Fname,Lname,Password,Status,mname) values('" + email + "','" + role + "','" + fname + "','" + lname +"','"+hashedpasswd.toString()+"','" + 0 + "','"+mname+"')";//Inserting into the table resgistration.

            s.executeUpdate(qry);
            response.setStatus(response.SC_MOVED_TEMPORARILY);
            response.setHeader("Location", "index.jsp");
        }
        con.close();
    }
        

    } catch (Exception e) {
        e.printStackTrace();
        out.println(e.getMessage());
    }

%>
