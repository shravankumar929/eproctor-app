<%@page import="dbConnection.DB_Connect"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*,java.io.*,java.util.*"%>

<html>
 <%
        if ((session.getAttribute("name")) != null && (session.getAttribute("password") != null) && (session.getAttribute("role").equals("Admin"))) {
    %>
    <head>

        <meta name="viewport" content="width=device-width, initial-scale=1.0,maximum-scale=1, minimum-scale=1">
        <title>EProctor</title>
        <script type="text/javascript" src="/styles/js/jquery.min.js"></script>
        <script type="text/javascript" src="/styles/semantic/dist/semantic.min.js"></script>
        <link rel="stylesheet" type="text/css" href="/styles/semantic/dist/semantic.min.css">
        <style type="text/css">
        .ui-datepicker th { background-color: #CCCCFF; }
        </style>
        <script>    
                $(document).ready(function(){
                    $('.icon.button')
                        .popup({
                             on: 'click'
                        });
                    $('.right.menu.open').on("click",function(e){
                        e.preventDefault();
                        $('.ui.vertical.menu').toggle();
                    });
                    
                    $('.demo.sidebar').first().sidebar('attach events', '.toggle.button');
                    $('.toggle.button').removeClass('disabled');
                    $('.ui.dropdown').dropdown();
                });

        </script>
       

    </head>
    <body>
        <div class="ui grid">
        <div class="computer tablet only row">
            <div class="ui top fixed inverted menu">
                <img src="/images/eProctor2.png" " width="150px" height="50px" >
 
                <a class="item" href="adminHome.jsp">Home</a>
                <a class="item" href="announcements.jsp">Announcements</a>
                <div class="right menu">
                    <div class="item">
                   <h3>
                    Welcome <%= session.getAttribute("firstName")%>
                    </h3>
                    </div>
                    <div class="ui dropdown item">
                        More <i class="icon dropdown"></i>
                        <div class="menu">
                            <a class="item" href="/editProfile.jsp"><i class="edit icon"></i> Edit Profile</a>
                            
                            <a class="item" class="logout icon" href="/logout.jsp">Logout</a>
                        </div>
                    </div>
                    <div class="item">
                        <form method="get" action="http://www.google.com/search"/>
                            <div class="ui search">
                                <div class="ui icon input">
                                    <input class="prompt" placeholder="Search..." type="text">
                                            <i class="search icon"></i>
                                </div>
                                <div class="results"></div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="mobile only row">
            <div class="ui fixed inverted navbar menu">
                <a href="" class="brand item">eProctor</a>
                <div class="right menu open">
                    <a href="" class="menu item">
                        <i class="content icon"></i>
                    </a>
                </div>
            </div>
            <div class="ui vertical navbar menu">
                <a class="item" href="adminHome.jsp">Home</a>
                <a class="item" href="announcements.jsp">Announcements</a>
                <div class="right menu">
                    <div class="item">
                    <h3>
                    Welcome <%= session.getAttribute("firstName")%>
                    </h3>
                    </div>
                    <a class="item" href="/editProfile.jsp"><i class="edit icon"></i> Edit Profile</a>
                    
                    <a class="item" class="logout icon" href="/logout.jsp">Logout</a>
                    <div class="item">
                        <form method="get" action="http://www.google.com/search"/>
                            <div class="ui search">
                                <div class="ui icon input">
                                    <input class="prompt" placeholder="Search..." type="text">
                                            <i class="search icon"></i>
                                </div>
                                <div class="results"></div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <p></p>
    <p></p>
        &nbsp;<br>&nbsp;<br>
    
    <div class="ui stackable grid">
        <div class="ui demo sidebar vertical menu">
        <div class="item">
            <h3>Requests</h3>
                <a class="item" href="RegistrationRequests.jsp">Registration Requests</a>
                <a class="item" href="ExamRequests.jsp">Exam Requests</a>
        </div>
        <div class="item">
            <h3>Accounts</h3>
           
                <a class="item" href="DisplayUsers.jsp">View Accounts</a>
            
        </div>
        <div class="item">
            <h3>Monitor Exams</h3>
                <a class="active item" href="MalpractiseRequests.jsp">View Log</a>
                
        </div>
        </div>

        
        <div class="two wide column">
        <br>
        <div class="ui right attached icon toggle button">
            <i class="icon list layout"></i>
            Menu
        </div>
        </div>
    </div> 
    <div class="ui header">
            
            <h3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;User Images</h3>
        </div>   
   	<div class="ui stackable grid">
   		<div class="one wide column"></div>
        <div class="three wide column">
        
        <%
            String email=request.getParameter("useremail");
            Connection con = null;
                con=DB_Connect.getDBConnection();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("select Photo from Details where Email='"+email+"'");
            if(rs.next())
            {
            out.println("<img src='"+rs.getString(1)+"' width='200px' height='200px'><br><h4>User Original Image</h4>");
            }
            
        %>
        </div>

        <div class="ten wide column">

        <div class="ui small images">
            <%
            try
            {

            File folder = new File("/verify/"+email);
                File[] listOfFiles = folder.listFiles();

                for (int i = 0; i < listOfFiles.length; i++) 
                {
                    if (listOfFiles[i].isFile()) 
                    {
                        //String path=listOfFiles[i].getAbsolutePath();
                        out.println(listOfFiles[i].getAbsolutePath());
                        out.println("<img src='/verify/"+email+"/"+listOfFiles[i].getName()+"'>");
                        //out.println("<img src='/home/shravan/apache-tomcat-8.0.27/webapps/ROOT/verify/"+email+"/"+listOfFiles[i].getName()+"'>");
                       // out.println("<img src=\"/home/shravan/apache-tomcat-8.0.27/webapps/ROOT/verify/"+"abc@gmail.com"+"/"+listOfFiles[i].getName()+"\">");
                    }
                }  
            }
            catch(Exception e)
            {

            }
            %>
        </div>

        <br>&nbsp;<br>
        	<a href="MalpractiseRequests.jsp"><button style='margin: 0 auto;height:40px;width:100px' class='fluid ui blue button'>Go Back</button></a>
        </div> 
    </div>
        &nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>
    </body>

	<%
    } 
     else
    {
   	response.sendRedirect("/index.jsp");
    }
    %>
</html>
