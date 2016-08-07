<%@page import="dbConnection.DB_Connect"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*,java.io.*,java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>LTI Tool</title>
            <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <script src="styles/js/jquery.min.js"></script>
                    <script src="styles/semantic/dist/semantic.min.js"></script>
                    <link rel="stylesheet" type="text/css" href="styles/semantic/dist/semantic.min.css">  

                        </head>
                        <body>

                            <div class="ui header">
                                <h1>Centre Allotment</h1>
                            </div>

                            <%
                                try {

                                    String fname = null, fpassword = null;
                                    fname = (String) session.getAttribute("name");
                                    /*getting email id of the invigilator  currently logged in*/
                                    fpassword = (String) session.getAttribute("password");
                                    /*establishing connection with the back-end Ms-Access database named "one"*/
                                    Connection con = null;
                                    con=DB_Connect.getDBConnection();
                                    Statement st = con.createStatement();
                                    ResultSet rs = st.executeQuery("select Role,Email,CentreAllotted from registration where Email='" + fname + "' and Password='" + fpassword + "' and Role='Invigilator'");
                                    if (rs.next()) {
                                        String s1 = rs.getString(3);/* getting the  entry from the  column named 'centre alloted' into a string named s1*/

                                        if (s1.equals("NA")) /*if centre is not alloted to the invigiltor yet*/ {

                            %>
                            <h1>Not Allotted Yet...!!</h1>
                            <%  } else /*if centre has been alloted to the invigilator */ {
                            %>
                            <h1><%= s1%></h1>
                            <%
                                        }
                                    } else {

                                    }

                                } catch (Exception e) {
                                    System.out.println("errror" + e);
                                }
                            %>
                        </body>
                        </html>