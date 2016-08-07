<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
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
                $.fn.form.settings.rules.myCustomRule = function(param) {
    // Your validation condition goes here
                   // alert(param);
                   var str=param;
                   var len=str.toString().length;
                    if(len==0 || len>=6)
                        return true;
                    else if(len<6)
                        return false;
                }

                $('.ui.form')
                        .form({
                            fields: {
                                username: {
                                    identifier: 'username',
                                    rules: [
                                        {
                                            type: 'empty',
                                            prompt: 'Please enter Username'
                                        }
                                    ]
                                },
                                password: {
                                    identifier: 'password',
                                    rules: [
                                        {
                                            type: 'empty',
                                            prompt: 'Please enter Password'
                                        }
                                    ]
                                }
                            }
                        });



            });
            function validate()
            {
                $('.ui.form')
                        .form({
                            fields: {
                                role: {
                                    identifier: 'role',
                                    rules:
                                            [
                                                {
                                                    type: 'checked',
                                                    prompt: 'Please select your role'
                                                }
                                            ]
                                },
                                fname: {
                                    identifier: 'fname',
                                    rules:
                                            [
                                                {
                                                    type: 'empty',
                                                    prompt: 'Please enter your first name'
                                                }
                                            ]
                                },
                                lname: {
                                    identifier: 'lname',
                                    rules: [
                                        {
                                            type: 'empty',
                                            prompt: 'Please enter your last name'
                                        }
                                    ]
                                },
                                passwd: {
                                    identifier: 'passwd',
                                    rules: [
                                        {
                                            
                                            type: 'myCustomRule[passwd]',
                                            prompt: 'Password should have minimum 6 characters'
                                        }
                                    ]
                                },
                                passwd1: {
                                    identifier: 'passwd1',
                                    rules: [
                                        {
                                            type: 'match[passwd]',
                                            prompt: 'Passwords cannot be matched',
                                        }
                                    ]
                                }

                            },
                            inline: true,
                            on: 'blur',
                        });


            }

        </script>
       

    </head>
    <body>
        <div class="ui stackable grid">
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
                            <a class="item" href="editProfile.jsp"><i class="edit icon"></i> Edit Profile</a>
                            
                            <a class="item" href="/logout.jsp">Logout</a>
                        </div>
                    </div>
                    <div class="item">
                        <form method="get" action="https://www.google.co.in/#q"/>
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
                    <a class="item" href="editProfile.jsp"><i class="edit icon"></i> Edit Profile</a>
                    
                    <a class="item" class="logout icon" href="/logout.jsp">Logout</a>
                    <div class="item">
                        <form method="get" action="https://www.google.co.in/#q"/>
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
        <div class="twelve wide column">
           <%
        try
        {
            Connection con = null;
                con=DB_Connect.getDBConnection();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("select Fname,Mname,Lname,Photo from Details where Email='" + (session.getAttribute("name")) + "'");
            if(rs.next()) 
            {
    %>
    <form class="ui form" method="post" action="FileUpdateServlet" enctype="multipart/form-data">
    <br>&nbsp;<br>
    <div class="ui stackable grid">
        
        <div class="one wide column"></div>

        <div class="four wide column">

            
            <h4 class="ui dividing header"> Edit Profile </h4>
            <div class="required field">
                <label>First name</label>
                <input placeholder="First Name" id="fname"  value="<%=rs.getString(1)%>" name="fname" type="text">
            </div>
            &nbsp;<br>
            <div class="field">
                <label>Middle name</label>
                <input placeholder="Middle Name" id="mname"  value="<%=rs.getString(2)%>" name="mname" type="text">
            </div>
            &nbsp;<br>
            <div class="required field">
                <label>Last name</label>
                <input placeholder="Last Name" id="lname"  value="<%=rs.getString(3)%>" name="lname" type="text">
            </div>
            <div class="required field">
                <label>Password</label>
                <input placeholder="Password" id="passwd" name="passwd" type="password" style="width:290px">
            </div>
            <div class="required field">
                <label>Re-enter Password</label>
                <input placeholder="Password" id="passwd1" type="password" style="width:290px">
            </div>
            <div class="ui blue submit button" onclick="validate()">Update</div>
            <button class="ui button" type="reset" value="Reset">Reset</button>
            <div class="ui error message"></div>
             <%
                String str = request.getParameter("msg");

                if (str != null) {
                    int err = Integer.parseInt(str);
                    if (err == 0)//sucess
                    {
                        out.println("<h3>Updation sucessful!</h3>");
                    } else if (err == 1)//1 for email already exists
                    {
                        out.println("<h3 style='color:red'>Updation failed!</h3>");
                    } else {
                        out.println("<h3 style='color:red'>unknown error occured!</h3>");
                    }

                }
        %>
        
        </div>


        <div class="two wide column">
            <%
                out.println("<img src='" + rs.getString(4) + "' width='300px' hight='500px'>");
            %>
            <br>
            <div>
                <input id="image" name="uploadFile" type="file"  accept="image/*">
            </div>
        </div>
       

    </div>
    </form>
    <%  
            }
            else
            {
            }

            }
            catch(SQLException e)
            {
                out.println("Error");
            }
    %> 

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
