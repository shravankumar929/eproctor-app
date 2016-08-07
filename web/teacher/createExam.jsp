<%@page import="dbConnection.DB_Connect"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*,java.io.*,java.util.*"%>

<html>
    <head>
        <%
        if ((session.getAttribute("name")) != null && (session.getAttribute("password") != null) && (session.getAttribute("role").equals("Teacher"))) 
        {
        %>
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
                    $('.demo.sidebar').first().sidebar('attach events', '.toggle.button');
                    $('.toggle.button').removeClass('disabled');
                    $('.ui.dropdown').dropdown();


                });
                function validate()
                {
                    $('.ui.form')
                    .form({
                        fields: {
                            testName: {
                                identifier: 'testName',
                                rules: 
                                [
                                {
                                    type   : 'empty',
                                    prompt : 'Please enter test name'
                                }
                                ]
                            },
                            exam_time: {
                                identifier: 'exam_time',
                                rules: 
                                [
                                {
                                    type   : 'empty',
                                    prompt : 'Please Enter Time of the Exam'
                                }
                                ]
                            },

                            exam_duration: {
                                identifier: 'exam_duration',
                                rules: [
                                {
                                    type   : 'empty',
                                    prompt : 'Please Enter Exam Duration'
                                },

                                {
            						type   : 'number',
            						prompt : 'Please Enter Exam Duration in Minutes'
          						}
                                ]
                            },
      
                            description: {
                                identifier: 'description',
                                rules: [
                                {
                                    type   : 'empty',
                                    prompt : 'Please enter test description'
                                }
                            ]
                            },
      
                            jumble: {
                                identifier: 'jumble',
                                rules: [
                                {
                                    type   : 'checked',
                                    prompt : 'Please select jumble yes/no'
                                }
                            ]
                            },
      
                            anyTime: {
                                identifier: 'anyTime',
                                rules: [
                                {
                                    type   : 'checked',
                                    prompt : 'Please select test time'
                                }
                            ]
                            }
                        },
                        inline:true,
                        on:'blur',

                    });
                }
                
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
        <a class="item" href="teacherIndex.jsp">Current Exams</a>
        <a class="active item" href="createExam.jsp">Create Exam</a>
        <a class="item" href="addStudents.jsp">Add Students</a>
        </div>
        
        </div>

        
        <div class="two wide column">
        <br>
        <div class="ui right attached small icon toggle button">
            <i class="icon list layout"></i>
            Menu
        </div>
        </div>
        <div class="thirteen wide column">
        <%
            Connection con = null;
                con=DB_Connect.getDBConnection();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("select Name,Time,Duration,Description,req_status from requests,Details where Details.UserId=requests.UserId and Details.Email='"+session.getAttribute("name")+"'");
        %>
    	
            <br>
            <button id="sentReq" class="ui right labeled small icon button">
                <i class="right arrow icon"></i>
                    Requests sent
            </button>
            <br>
            <div id="sentRequests">
            <br>
            <table class="ui celled table">
            <%
                if(rs.next())
                {
                	out.println("<thead>");
                    out.println("<tr>");
                    out.println("<th style='width:10%'>Exam Name</th>");
                    out.println("<th style='width:20%'>Exam Time</th>");
                    out.println("<th style='width:10%'>Duration</th>");
                    out.println("<th style='width:20%'>Description</th>");
                    out.println("<th style='width:10%'>Status</th>");
                    out.println("<th style='width:20%'>Action</th>");
                    out.println("</tr>");
                	out.println("</thead>");
                }
                rs = st.executeQuery("select Name,Time,Duration,Description,req_status,requestId,jumble,anyTime from requests,Details where Details.UserId=requests.UserId and Details.Email='"+session.getAttribute("name")+"'");
            %>
                <tbody>
                    <%
                        boolean flag=false;
                        while(rs.next())
                        {
                            flag=true;
                            out.println("<form action='continueExam.jsp' method='post'>");
                           	out.println("<tr>");
                            out.println("<td>"+rs.getString(1)+"</td>");
							out.println("<td>"+rs.getString(2)+"</td>");
                           	out.println("<td>"+rs.getString(3)+"</td>");
                            out.println("<td>"+rs.getString(4)+"</td>");
                            String desc=rs.getString(4);
                            out.println("<input type='hidden' name='exam_name' value='"+rs.getString(1)+"'>");
                            out.println("<input type='hidden' name='exam_time' value='"+rs.getString(2)+"'>");
                            out.println("<input type='hidden' name='exam_duration' value='"+rs.getString(3)+"'>");
                            out.println("<input type='hidden' name='description' value=\""+desc+"\">");
                            out.println("<input type='hidden' name='requestId' value='"+rs.getString(6)+"'>");
                            out.println("<input type='hidden' name='jumble' value='"+rs.getString(7)+"'>");
                            out.println("<input type='hidden' name='anyTime' value='"+rs.getString(8)+"'>");
                            if(Integer.parseInt(rs.getString(5))==1)
                            {
                                out.println("<td>Accepted</td><td><a href='quizspecifications1.jsp'><button class='ui button' type='submit'>Create Test</button></a></td>");
                            }
                            else
                                out.println("<td>Under Review</td><td></td>");
                            out.println("<tr>");
                           
                            out.println("</form>");
                        }
                        
                        if(flag==false)
                            out.println("<br>No awaiting requests!!!");
                    %>
                </tbody>
            </table>
            </div>
            <br>
            <button id="sendReq" class="ui right labeled small icon button">
                <i class="right arrow icon"></i>
                    Send a new Request
            </button>
            <br>&nbsp;<br>
  			<div id="sendRequest">
                <br>
                <div class="ui stackable grid">
                <div class="ten wide column">
                <form class="ui form segment" action="testRequest.jsp" method="post">
                <h4 class="ui dividing header">Create Test </h4>
                <div style="float:right;"><button id="examRemove" class="ui blue button">Cancel</button></div>
                		<div class="five wide column">
                		<div class="required field">
                            <label>Test Name:</label>
                                <input placeholder="First Name" type="text" name="testName" id="test">
                        </div>
                        <div class="required field">
                                <label>Test Time:</label>
                                <input type="text" name="exam_time" id="exam_time" placeholder="Year-Month-Date Hour:Min">
                        </div>
                        <div class="required field">
                                <label>Test Duration:</label>
                                <input type="text" name="exam_duration" id="exam_duration" placeholder="Minutes">
                        </div>
                        <div class="required field">
                                <label>Description:</label>
                                <textarea rows="5" cols="50" name="description" id="description"></textarea>
                        </div>
                        <div class="field">
                        		<label style="text-align:left;float:left;">Question Paper need to be Jumbled?<h5 style="text-align:right;float:right;color:red;">*&nbsp;&nbsp;&nbsp;&nbsp;</h5></label>
                               
                                <div class="ui radio checkbox">
                                    <input name="jumble" value="1" type="radio">
                                    <label>Yes</label>
                                </div>
                                &nbsp;
                                <div class="ui radio checkbox">
                                    <input name="jumble" value="0" type="radio">
                                    <label>No</label>
                                </div>
                                &nbsp;
                                
                        </div>
                        <div class="field">
                        		<label style="text-align:left;float:left;">Test can be given at any time?<h5 style="text-align:right;float:right;color:red;">*&nbsp;&nbsp;&nbsp;&nbsp;</h5></label>
                                
                                <div class="ui radio checkbox">
                                    <input name="anyTime" value="1" type="radio">
                                    <label>Yes</label>
                                </div>
                                &nbsp;
                                <div class="ui radio checkbox">
                                    <input name="anyTime" value="0" type="radio">
                                    <label>No</label>
                                </div>
                                &nbsp;
                                
                        </div>
                        <div class="ui blue small submit button" onclick="validate()"> Send Request </div>
                		<div class="ui error message"></div>
                		</div>
                        
                </form>
                </div>
                </div>
                </div>
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
