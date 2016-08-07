<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*,java.io.*,java.util.*"%>

<html>
    <%
        if ((session.getAttribute("name")) != null && (session.getAttribute("password") != null) && (session.getAttribute("role").equals("Teacher"))) 
        {
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
                    var c=2;
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


                    
                $(document).on('click', '#add' ,function() {
                    var temp ='<div class="ui input focus">'+
                '<input placeholder="Enter e-mail.." type="text" name="emailId">'+
                '<div class="ui blue icon button" id="remove"><i class="minus icon"></i></div>'+
                '</div><div id="padding">&nbsp;<br></div>';
                    $( temp ).insertBefore( "#add" );
                    jQuery("#count").attr('value',c);
                    c=c+1;
                });
                $(document).on('click', '#remove' ,function() {
                    $(this).parent().next().remove("#padding");
                    $(this).parent().remove();
                });
                });
                function validate()
                {
                    $('.ui.form')
                    .form({
                        fields: {
                            exam_name: {
                                identifier: 'exam_name',
                                rules: 
                                [
                                {
                                    type   : 'empty',
                                    prompt : 'Please enter exam name'
                                }
                                ]
                            },
                            exam_id: {
                                identifier: 'exam_id',
                                rules: 
                                [
                                {
                                    type   : 'empty',
                                    prompt : 'Please enter exam id from Current exams list'
                                }
                                ]
                            },

                            emailId: {
                                identifier: 'emailId',
                                rules: [
                                {
                                    type   : 'email',
                                    prompt : 'Please enter email of the student'
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
        <a class="item" href="createExam.jsp">Create Exam</a>
        <a class="active item" href="addStudents.jsp">Add Students</a>
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
            <br>&nbsp;<br>
            <div class="ui center aligned basic segment">
            
             <div class="ui header">
                <h4>Add students who are eligible for an exam
                </h4>
             </div>
             <div class="ui horizontal divider">
             </div>

             <form class="ui form segment" action="InsertData.jsp" method="post" > 
             	<div class="ui stackable grid">
             	<div class="three wide column">
             	<div class="required field">
             	<label>Exam Name:</label>
             	<input type="text" name="exam_name" placeholder="Exam Name">
            	</div>
            	<div class="required field">
            	<label>Exam Id:</label>
            	<input type="text" name="exam_id" placeholder="Exam Id">
            	</div>
            	</div>
            	<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>
            	<div class="ten wide column">
               <div class="ui input focus">
                <input placeholder="Enter e-mail.." type="text" name="emailId">
                <div class="ui blue icon button" id="remove"><i class="minus icon"></i></div>
              </div>
              <div id="padding">
                &nbsp;<br>
              </div>
               <div id = "add" class="ui labeled icon button">
                  Add new e-mail
                  <i class="add icon"></i>
               </div>
               <input type="hidden" id="count" name="count" value="1">
               &nbsp;<br>&nbsp;<br>
               <button class="ui blue button" onclick="validate()">Submit</button>
               <div class="ui error message"></div>
               </div>
             </form>
             <div align="center">
             <%
                String msg=request.getParameter("msg");
                if(msg!=null)
                {
                    out.println("<br><div align='center' style='color:red;'>"+msg+"</div>");
                }

             %>
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
