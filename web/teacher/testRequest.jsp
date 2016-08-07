<%@page import="dbConnection.DB_Connect"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*,java.io.*,java.util.*"%>
<html>
    <%
        if ((session.getAttribute("name")) != null && (session.getAttribute("password") != null) && (session.getAttribute("role").equals("Teacher"))) 
        {
        %>
    <head>

        <meta name="viewport" content="width=device-width, initial-scale=1.0,maximum-scale=1, minimum-scale=1">
        <title>EProctor</title>
        <script type="text/javascript" src="styles/js/jquery.min.js"></script>
        <script type="text/javascript" src="styles/semantic/dist/semantic.min.js"></script>
        <link rel="stylesheet" type="text/css" href="styles/semantic/dist/semantic.min.css">
    </head>
    <body>
<%
    String name="";
    String description="";
    int duration=0;
    String time="";
    int jumble=0;
    int anyTime=0;
    try
    {
	name=request.getParameter("testName");
	description=request.getParameter("description");
        duration=Integer.parseInt(request.getParameter("exam_duration"));
        time=request.getParameter("exam_time");
        jumble=Integer.parseInt(request.getParameter("jumble"));
        anyTime=Integer.parseInt(request.getParameter("anyTime"));
        out.println("jumble="+jumble);
        out.println("anyTime="+anyTime);
        
    }
    catch(Exception e)
    {
        out.println(e.getMessage());
    }
	Connection con = null;
        con=DB_Connect.getDBConnection();
    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery("select UserId from Details where Details.Email='"+session.getAttribute("name")+"'");
    if(rs.next())
    {
        PreparedStatement ps = con.prepareStatement("insert into requests(UserId,Name,Description,req_status,Duration,Time,jumble,anyTime)values(?,?,?,?,?,?,?,?)");
        ps.setInt(1,Integer.parseInt(rs.getString(1)));
        ps.setString(2,name);
        ps.setString(3,description);
        ps.setInt(4,0);
        ps.setInt(5,duration);
        ps.setString(6,time);
        ps.setInt(7,jumble);
        ps.setInt(8,anyTime);
        ps.executeUpdate();
	   	//int que=st.executeUpdate("insert into requests(UserId,Name,Description,req_status)values('"+Integer.parseInt(rs.getString(1))+"','"+name+"',\'"+description+"\',"+0+")");
		response.setStatus(response.SC_MOVED_TEMPORARILY);
        response.setHeader("Location", "createExam.jsp");
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