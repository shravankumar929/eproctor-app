<%--
Whenever the teacher chooses the option "Results",he/she is redirected to this page
Here, he is asked to select a test from the ones he had uploaded, of which he whishes to view the results
As soon as he selects a test and presses the showResults button, he is redirected to displayResults.jsp where he can view the results
--%>

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
                <a class="item" href="quizspecifications.jsp" id="specifications">Assessment</a>
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
        
        </div>
        <%
/*
    
                    <form method="post" action="displayResults.jsp" >

                        <h1 align="left">Select test to view results-</h1>
                        <br />
                        <%
                            
                                  File directory = new File("uploads");//reading all files of this folder
                                   String[] readfile;
                                   File[] myarray; // contains the path of all files in the folder
                                   String[] testName; // testname stores the name of the teacher who uploaded the test and name of test given by him,the values being seperated by ';'
                                   String[] final_testName; // stores the name of test without .pdf extension
                                   myarray=directory.listFiles();
                                   out.println("<select name=\"sel\" align=\"left\" style=\"font-size:medium;font-family:Calibri;border-color:#1AACF0;background-color:#E4E1E1\">");
                                   for (int k = 0; k < myarray.length; k++)
                                   {       
                                       String name1=myarray[k].getName();
                                       final_testName=new String[myarray.length];
                                       if(name1.contains(filename)==true && name1.contains(".pdf")==true)
                                       {
                                           testName= name1.split(";");
                                           final_testName[k]= testName[1].replace(".pdf","");
                  
                                           out.println("<option value=\""+final_testName[k]+"\">"+final_testName[k] +"</option>");// allowing user to select a test from the drop down menu

                                       }
                                   }
                                   out.println("</select>");
                               // <input type="submit" name="submit" value="Results" class="button"  style="font-family: Calibri;font-size: medium;"align="left" size="10"/>
                            
                        
                        
                    </form>
                    
*/                                                                
   
%> 
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
