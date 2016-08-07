<%@page contentType="text/html" pageEncoding="UTF-8" import="java.io.*,java.sql.*,java.lang.String"%>
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
                $(document).ready(function(){
                    $('.right.menu.open').on("click",function(e){
                        e.preventDefault();
                        $('.ui.vertical.menu').toggle();
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
        </script>
    </head>
    <body>
        <div class="ui grid">
        <div class="computer tablet only row">
            <div class="ui top fixed inverted menu">
                <img src="images/eProctor2.png" " width="150px" height="50px" >
 
                <a class="item" href="index.jsp">Home</a>
                <a class="item" href="registration.jsp">Registration</a>
                <a class="item" href="announcements.jsp">Announcements</a>
                <a class="item" href="downloadApp.jsp">Download</a>
                <a class="active item" href="contact.jsp">Contact Us</a>
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
                <a class="item" href="home.jsp">Home</a>
                <a class="item" href="registration.jsp">Registration</a>
                <a class="item" href="announcements.jsp">Announcements</a>
                <a class="item" href="downloadApp.jsp">Download</a>
                <a class="active item" href="contact.jsp">Contact Us</a>
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
        &nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>
        <div class="ui stackable grid">
        <div class="one wide column"></div>
        <div class="fourteen wide column">
        <div class="ui header">
            <h1>Contact Details :</h1>
            <p>eProctor Team</p>
            <p>Indian Institute of Technology</p>
            <p>Powai</p>
            <p>Mumbai-400076</p>
            <p>India</p>
            <p><br />
            </p>
        </div>
        </div>
        </div>
        &nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>
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