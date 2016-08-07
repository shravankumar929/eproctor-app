<%-- 
    This destroys the user session created on login when he presses the logout button.
--%>

<%
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>e-Abhyaas </title>

    </head>
    <body>
        <%
            //destroying the session
            session.removeAttribute("name");
            session.removeAttribute("password");
            session.removeAttribute("role");
            //session.removeAttribute("firstName");
            session.invalidate();
        %>
        <jsp:forward page="index.jsp"/>
    </body>
</html>
