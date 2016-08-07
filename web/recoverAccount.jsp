<%@page import="dbConnection.DB_Connect"%>
<%@page import="home.MailClass"%>
<%
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<%@ page import="javax.mail.*"%>
<%@ page import="javax.mail.internet.*,javax.activation.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.sql.*,java.io.*,java.util.*,java.security.*"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Recover Password</title>
    </head>
    <body>

        <%
            String email = null;
            MailClass mail = new MailClass();
            try {

                email = request.getParameter("username");
                
                out.println(email);

                Connection con = null;
                con=DB_Connect.getDBConnection();
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery("select Email,Status from Details where Email='" + email + "'");
                if (rs.next()) {
                    String Email = rs.getString(1);
                    int status = Integer.parseInt(rs.getString(2));
                    if (status == 1) {

                        //Generate a random password
                        String AB = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
                        SecureRandom rnd = new SecureRandom();

                        StringBuilder sb = new StringBuilder(10);
                        for (int i = 0; i < 10; i++) {
                            sb.append(AB.charAt(rnd.nextInt(AB.length())));
                        }
                        String passwd = sb.toString();
                        // Send the actual HTML message, as big as you like

                        mail.sendEmail("smtp.gmail.com", "25", "codealive687@gmail.com", "shraonessk123", Email, "eProctor Password Recovery", "<div align='center'><h3>Your New Password:" + passwd + "<br>Login with above password and change Password!!!<br></h3></div>");

                        MessageDigest alg = MessageDigest.getInstance("MD5");

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
                        for (int i = 0; i < digest.length; i++) {
                            hx = Integer.toHexString(0xFF & digest[i]);
                            //0x03 is equal to 0x3, but we need 0x03 for our md5sum
                            if (hx.length() == 1) {
                                hx = "0" + hx;
                            }
                            hashedpasswd.append(hx);
                        }
                        int res = st.executeUpdate("update Details set Password='" + hashedpasswd.toString() + "' where Email='" + email + "'");
                        response.sendRedirect("forgotPass.jsp?msg=A new password has been sent to " + email);
                    } else {
                        response.sendRedirect("forgotPass.jsp?msg=Your account is not activated yet!<br>It is under verification!!!");
                    }

                } else {
                    response.sendRedirect("forgotPass.jsp?msg=Invalid Email!");
                    System.out.println("Invalid email");
                }

            } catch (Exception e) {

                out.println("Error1=" + e.getMessage());
            }

        %>

    </body>
</html>


<%        /*
            String email = null;
            try 
            {

                email = request.getParameter("username");
                Class.forName("com.mysql.jdbc.Driver");
                out.println(email);

                Connection con = DriverManager.getConnection("jdbc:mysql://localhost/eproctor", "eproctor", "shraonessk");
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery("select Email,Status from Details where Email='" + email + "'");
                if (rs.next()) 
                {
                    String Email = rs.getString(1);
                    int status = Integer.parseInt(rs.getString(2));
                    if (status == 1) 
                    {
                        String to = rs.getString(1);

                        String result;

                        Properties props = new Properties();
                        props.put("mail.smtp.host", "smtp.gmail.com");
                        props.put("mail.smtp.socketFactory.port", "25");
                        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
                        props.put("mail.smtp.auth", "true");
                            props.put("mail.smtp.port", "25");

                        Session mailSession = Session.getDefaultInstance(props);
                            mailSession.setPasswordAuthentication(new URLName("smtp","localhost",25,"INBOX","codealive687@gmail.com","shraonessk123"), new PasswordAuthentication("codealive687@gmail.com","shraonessk123"));
                        /*
                        Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
                            protected PasswordAuthentication getPasswordAuthentication() {
                                return new PasswordAuthentication("", "password");//change accordingly  
                            }
                        });
     */
    //compose message 
    /*
                        try {
                            MimeMessage message = new MimeMessage(mailSession);
                            //MimeMessage message = new MimeMessage(session);
                            message.setFrom(new InternetAddress("shravank929@gmail.com"));//change accordingly  
                            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
                            message.setSubject("eProctor Password Recovery");

                            //Generate a random password
                            String AB = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
                            SecureRandom rnd = new SecureRandom();

                            StringBuilder sb = new StringBuilder(10);
                            for (int i = 0; i < 10; i++) {
                                sb.append(AB.charAt(rnd.nextInt(AB.length())));
                            }
                            String passwd = sb.toString();
                            // Send the actual HTML message, as big as you like
                            message.setContent("<div align='center'><h3>Your New Password:" + passwd + "<br>Login with above password and change Password!!!<br></h3></div>",
                                    "text/html");
                            // Send message
                            Transport.send(message);
                            result = "Sent message successfully....";
                            MessageDigest alg = MessageDigest.getInstance("MD5");

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
                            for (int i = 0; i < digest.length; i++) {
                                hx = Integer.toHexString(0xFF & digest[i]);
                                //0x03 is equal to 0x3, but we need 0x03 for our md5sum
                                if (hx.length() == 1) {
                                    hx = "0" + hx;
                                }
                                hashedpasswd.append(hx);
                            }
                            int res = st.executeUpdate("update Details set Password='" + hashedpasswd.toString() + "' where Email='" + email + "'");
                            response.sendRedirect("forgotPass.jsp?msg=A new password has been sent to " + email);
                        } catch (MessagingException e) {
                            out.println("Error0=" + e.getMessage());
                           // response.sendRedirect("forgotPass.jsp?msg=Sorry, unable send now!!!");
                            throw new RuntimeException(e);
                                
                        }

                    }
                    else 
                    {
                        response.sendRedirect("forgotPass.jsp?msg=Your account is not activated yet!<br>It is under verification!!!");
                    }

                } 
                else 
                {
                    response.sendRedirect("forgotPass.jsp?msg=Invalid Email!");
                    System.out.println("Invalid email");
                }

                    
            }
            catch(Exception e)
            {
                    
                out.println("Error1="+e.getMessage());
            }
     */
%>


