<%-- 
   This jsp page provides the form to be filled in by the new user who is interested in registering with the quiz module.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*,java.io.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>eProctor</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="styles/js/jquery.min.js"></script>
        <script src="styles/semantic/dist/semantic.min.js"></script>
        <link rel="stylesheet" type="text/css" href="styles/semantic/dist/semantic.min.css">
        <link rel="stylesheet" type="text/css" href="styles/custom.css">
        <script>    
                $(document).ready(function()
                {
                    $('.right.menu.open').on("click",function(e)
                    {
                        e.preventDefault();
                        $('.ui.vertical.menu').toggle();
                    });
                    $("#showReq").click(function () {
                    $('.ui.small.modal')
                            .modal('show');
                    return false;
                    });
                    $('.ui.dropdown').dropdown();
                   
                    $('.ui.form')
                        .form({
                        fields: {
                            username: {
                            identifier: 'username',
                            rules: [
                            {
                                type   : 'empty',
                                prompt : 'Please enter Username'
                            }
                            ]
                            },
                            password: {
                            identifier: 'password',
                            rules: [
                            {
                                type   : 'empty',
                                prompt : 'Please enter Password'
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
                                    type   : 'checked',
                                    prompt : 'Please select your role'
                                }
                                ]
                            },
                            fname: {
                                identifier: 'fname',
                                rules: 
                                [
                                {
                                    type   : 'empty',
                                    prompt : 'Please enter your first name'
                                }
                                ]
                            },

                            lname: {
                                identifier: 'lname',
                                rules: [
                                {
                                    type   : 'empty',
                                    prompt : 'Please enter your last name'
                                }
                                ]
                            },
      
                            email: {
                                identifier: 'email',
                                rules: [
                                {
                                    type   : 'email',
                                    prompt : 'Please enter a valid e-mail'
                                }
                            ]
                            },
                            passwd: {
                                identifier: 'passwd',
                                rules: [
                                {
                                    type   : 'empty',
                                    prompt : 'Please enter a password'
                                },
                                {
                                    type   : 'minLength[6]',
                                    prompt : 'Your password must be at least {ruleValue} characters'
                                }
                                ]
                            },
                            passwd1: {
                                identifier: 'passwd1',
                                rules: [
                                {
                                    type   : 'match[passwd]',
                                    prompt : 'Passwords cannot be matched',
                                }
                                ]
                            },
                            image: {
                                identifier: 'image',
                                rules: [
                                {
                                    type   : 'empty',
                                    prompt : 'Select image to upload',
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
        
        &nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>
        <div class="ui stackable grid">
        <div class="computer tablet only row">
            <div class="ui top fixed inverted menu">
                <img src="images/eProctor2.png" " width="150px" height="50px" >
 
                <a class="item" href="index.jsp">Home</a>
                <a class="active item" href="registration.jsp">Registration</a>
                <a class="item" href="announcements.jsp">Announcements</a>
                <a class="item" href="downloadApp.jsp">Download</a>
                <a class="item" href="contact.jsp">Contact Us</a>
                <div class="right menu">
                        <a class="item" href="loginPage.jsp">Login</a>
                        <div class="item">
                            <form method="get" action="http:/www.google.com/search"/>
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
                <a class="item" href="index.jsp">Home</a>
                <a class="active item" href="registration.jsp">Registration</a>
                <a class="item" href="announcements.jsp">Announcements</a>
                <a class="item" href="downloadApp.jsp">Download</a>
                <a class="item" href="contact.jsp">Contact Us</a>
                
                <div class="right menu">
                        <div class="item">
                            <a href="loginPage.jsp">Login</a>
                        </div>
                        <div class="item">
                            <form method="get" action="http:/www.google.com/search"/>
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
    </div>
    </div>
        <div class="ui stackable grid">
            <div class="one wide column"></div>
            <div class="eight wide column">
                <form class="ui form segment" method="post" action="FileUploadServlet" enctype="multipart/form-data">
                     <h4 class="ui dividing header">Registration</h4>
                     <div class="fields">
                        <div class="field">
                            <label style="text-align:left;float:left;">Role<h5 style="text-align:right;float:right;color:red;">*&nbsp;&nbsp;&nbsp;&nbsp;</h5></label>
                        
                        
                        <div class="ui radio checkbox">
                            <input name="role" value="Teacher" type="radio">
                            <label>Teacher</label>
                        </div>
                        &nbsp;
                        <div class="ui radio checkbox">
                            <input name="role" value="Student" type="radio">
                            <label>Student</label>
                        </div>
                        </div>
                    </div>
                    <div class="fields">
                        <div class="required field">
                            <label>First name</label>
                                <input placeholder="First Name" id="fname" name="fname" type="text">
                        </div>
                        <div class="field">
                                <label>Middle name</label>
                                <input placeholder="Middle Name" id="mname" name="mname" type="text">
                        </div>
                        <div class="required field">
                                <label>Last name</label>
                                <input placeholder="Last Name" id="lname" name="lname" type="text">
                        </div>
                    </div>
                    <div class="fields">
                        <div class="required field">
                                <label>Email</label>
                                <input placeholder="Email" id="email" name="email" type="text">
                        </div>
                    </div>
                    <div class="fields">
                        <div class="required field">
                                <label>Password</label>
                                <input placeholder="Password" id="passwd" name="passwd" type="password">
                                
                        </div>

                        <div class="required field">
                                <label>Re-enter Password</label>
                                <input placeholder="Password" id="passwd1" type="password">
                        </div>
                    </div>
                    Minimum Length is 6
                    <div class="fields">
                        <div class="required field">
                                <label>Photo</label>
                                <input id="image" name="uploadFile" type="file" accept="image/*">
                                Max size 500KB&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="" id="showReq">Show Requirements</a>
                        </div>
                    </div>
                    
                    <div class="ui blue small submit button" onclick="validate()">Create Account</div>
                    <button class="ui button" type="reset" value="Reset">Reset</button>
                    <div class="ui error message"></div>
                </form>
                
                <%
                    String str=request.getParameter("msg");
                    
                    if(str!=null)
                    {
                        int err=Integer.parseInt(str);
                        if(err==0)//sucess
                            out.println("<h3>Registration sucessful!<br>Your account is under verification!</h3>");
                        else if(err==1)//1 for email already exists
                            out.println("<h3 style='color:red'>Email already exists!</h3>");
                        else if(err==2)
                            out.println("<h3 style='color:red'>Error while uploading image!</h3>");
                        else
                            out.println("<h3 style='color:red'>Unknown error occured!</h3>");
                            
                    }
                %>
                
                <br>
                
            </div>
        </div>
        <div class="ui small modal">
                <i class="close icon"></i>
                <div class="header">
                    <h3>Requirements for the Photo</h3>
                </div>
                <div class="ui grid">
                    <div class="one wide column"></div>
                    <div class="twelve wide column">
                        <ul>
                            <li>Photo must be less than 500KB in size.</li>
                            <br>
                            <li>Photo should be clear and should be with clear background</li>
                            <br>
                            <li>If you fail to upload a clear image your account cannot be verified</li>
                            <br>&nbsp;<br>&nbsp;
                        </ul>
                    </div>
                </div>
            </div>
        &nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>
        <div class="ui inverted vertical footer segment">
        <div class="center aligned container">
            <div align="center">
            <h4>
                Copyright © Quiz Module| Designed by e-Proctor Team
            </h4>
            </div>
        </div>
    </div>
    </body>

</html>
