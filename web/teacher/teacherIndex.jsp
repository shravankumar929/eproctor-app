<%@page import="dbConnection.DB_Connect"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*,java.io.*,java.util.*"%>

<html>
    <%
        if ((session.getAttribute("name")) != null && (session.getAttribute("password") != null) && (session.getAttribute("role").equals("Teacher"))) {
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
                    $("#sendRequest").hide();
                    $("#sentRequests").hide();
                    $("#sentReq").click(function()
                        {
                            $("#sentRequests").show();
                        });
                    $("#sendReq").click(function()
                        {
                            $("#sendRequest").show();
                        });
                    $("#examRemove").click(function()
                        {
                            $("#sendRequest").hide();
                            return false;
                        });
                    $('.ui.dropdown').dropdown();
                    $('.demo.sidebar').first().sidebar('attach events', '.toggle.button');
                    $('.toggle.button').removeClass('disabled');
                });
        </script>
       

    </head>
    
    <body>
        <div class="ui grid">
        <div class="computer tablet only row">
            <div class="ui top fixed inverted menu">
                <img src="/images/eProctor2.png" " width="150px" height="50px" >
 
                <a class="item" href="teacherIndex.jsp">Home</a>
            
                <a class="item" href="quizResults.jsp" id="results">Quiz Results</a>
                <div class="right menu">
                    <div class="item">
                   <h3>
                    Welcome <%= session.getAttribute("firstName")%>
                    </h3>
                    </div>
                    <div class="ui dropdown item">
                        More <i class="icon dropdown"></i>
                        <div class="menu">
                            <a class="item" href="editProfile.jsp"><i class="edit icon"></i> Edit Profile</a>
                            
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
                <a class="item" href="teacherIndex.jsp">Home</a>
                
                <a class="item" href="quizResults.jsp" id="results">Quiz Results</a>
                <div class="right menu">
                    <div class="item">
                    <h3>
                    Welcome <%= session.getAttribute("firstName")%>
                    </h3>
                    </div>
                   <a class="item" href="editProfile.jsp"><i class="edit icon"></i> Edit Profile</a>
                    
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
        <h3>Exams & Results</h3>
        <a class="active item" href="teacherIndex.jsp">Current Exams</a>
        <a class="item" href="createExam.jsp">Create Exam</a>
        <a class="item" href="addStudents.jsp">Add Students</a>
        </div>
        
        </div>

        
        <div class="two wide column">
        <br>
        <div class="ui right attached icon toggle button">
            <i class="icon list layout"></i>
            Menu
        </div>
        </div>
        <div class="twelve wide column">

        <%
            Connection con = null;
            con=DB_Connect.getDBConnection();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("select ExamId,Name,Time,Description from Exam where Time >= CURDATE()");
            /*
            select * from table where logdate = CURDATE() 
            Calendar c = Calendar.getInstance();
            java.util.Date u_day = c.getTime();

            DateFormat df = new DateFormat();
            df.getDateInstance(DateFormat.MEDIUM);
            java.util.Date date = getItSomehow();
            Timestamp timestamp = new Timestamp(date.getTime());
            preparedStatement = connection.prepareStatement("SELECT * FROM tbl WHERE ts > ?");
            preparedStatement.setTimestamp(1, timestamp);
            */
        %>
        
            <br>&nbsp;<br>
            <div class="ui header">
        	<h3>Current Exams</h3>
        	</div>
            <table class="ui celled table">
                <thead>
                    <tr>
                    <th style="width:20%">Exam ID</th>
                    <th style="width:20%">Name</th>
                    <th style="width:30%">Date & Time</th>
                    <th style="width:30%">Description</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        while(rs.next())
                        {
                            out.println("<form action='viewTest.jsp' action='post'><tr><td>"+rs.getString(1)+"</td><td>"+rs.getString(2)+"</td><td>"+rs.getString(3)+"</td><td>"+rs.getString(4)+"</td><tr></form>");
                        }
                    %>
                </tbody>
            </table>

            <%
            	rs = st.executeQuery("select ExamId,Name,Time,Description from Exam where Time < CURDATE()");
            %>
            <div class="ui header">
        	<h3>Past Exams</h3>
        	</div>
            <table class="ui celled table">
                <thead>
                   <tr>
                    <th style="width:20%">Exam ID</th>
                    <th style="width:20%">Name</th>
                    <th style="width:30%">Date & Time</th>
                    <th style="width:30%">Description</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    	boolean found=false;
                        while(rs.next())
                        {
                        	found=true;
                            out.println("<form action='viewTest.jsp' action='post'><tr><td>"+rs.getString(1)+"</td><td>"+rs.getString(2)+"</td><td>"+rs.getString(3)+"</td><td>"+rs.getString(4)+"</td><tr></form>");
                        }
                        if(!found)
                        	out.println("No exams found!!!");
                    %>
                </tbody>
            </table>
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
