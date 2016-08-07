<%@page contentType="text/html" pageEncoding="UTF-8" import="java.io.*,java.sql.*,java.lang.String"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0,maximum-scale=1, minimum-scale=1">
        <title>EProctor</title>
        <script src="styles/js/jquery.min.js"></script>
        <script src="styles/semantic/dist/semantic.min.js"></script>
        <link rel="stylesheet" type="text/css" href="styles/semantic/dist/semantic.min.css">
        <link rel="stylesheet" type="text/css" href="styles/custom.css">
        <style type="text/css">
            

  body {
    background-size: cover;
    padding: 0;
    margin: 0;
  }

  .form-holder {
    background: rgba(255,255,255,0.2);
    margin-top: 10%;
    border-radius: 3px;
  }

  .form-head {
    font-size: 30px;
    letter-spacing: 2px;
    text-transform: uppercase;
    color: #fff;
    text-shadow: 0 0 30px #000;
    margin: 15px auto 30px auto;
  }

  .remember-me {
    text-align: left;
  }
  


        </style>
        <script>
            $(document).ready(function () {
                $('.right.menu.open').on("click", function (e) {
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
                                            type: 'empty',
                                            prompt: 'Please enter Email'
                                        }
                                    ]
                                }
                            }
                        });
            });
        </script>
        <script type="text/javascript">

            function doSearch(s) {
                var regExp1 = /\bfield\b/;
                var regExp2 = /[(,),<,>,\[,\]]/;
                var str = s.value;
                if (str == "") {
                    alert("Please be sure to enter something to search for.");
                    s.focus();
                } else {
                    if (typeof regExp1.source != 'undefined') //supports regular expression testing
                        if (regExp1.test(str) || regExp2.test(str)) {
                            var alrt = "Please note that you can not include:";
                            alrt += "\n\nThe reserved word 'field'\nthe characters [, ], (, ), < or >";
                            alrt += "\n\nin your search query!\n\nIf you are confident that you know";
                            alrt += "\nwhat you are doing, then you can\nmanually produce the URL required."
                            s.focus();
                            return alert(alrt);
                        }
                    openDbRelativeURL("All?SearchView&Query=" + escape(str) + "&start=1&count=10");
                }
            }
            function openDbRelativeURL(url, target) {
                //Check we have a target window;
                target = (target == null) ? window : target;
                //Work out the path of the database;
                path = location.pathname.split('.nsf')[0] + '.nsf/';
                target.location.href = path + url;
            }


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
                    <a class="item" href="contact.jsp">Contact Us</a>
                    <div class="right menu">
                        <a class="active item" id="login" href="loginPage.jsp">Login</a>
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
                    <a class="item" href="registration.jsp">Registration</a>
                    <a class="item" href="announcements.jsp">Announcements</a>
                    <a class="item" href="downloadApp.jsp">Download</a>
                    <a class="item" href="contact.jsp">Contact Us</a>
                    
                    <div class="right menu">
                        <div class="active item">
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
            <p></p>
            <p></p>

        </div>
        &nbsp;<br>&nbsp;<br>
        
        <div class="ui stackable grid">
        <div class="ui one column center aligned grid">
            <div class="column six wide form-holder">
                <h2 class="center aligned header form-head">Recover my account</h2>
             
                <form class="ui form" method="post" action="recoverAccount.jsp">
                    <div class="field">
                        <label style="float:left;">Email</label>
                        <div class="ui left icon input">
                        <i class="user icon"></i>
                        <input type = "text" id="username" placeholder="EMail" name="username">
                        </div>
                    </div>
                    <div class="field">
                        <input type="submit" value="Mail Me Password" class="ui button large fluid green">
                        <br>
                        <div class="ui button">
                            <a href="loginPage.jsp" style="float:right;"><h3>Cancel</h3></a>
                        </div>
                       
                    </div>
                    <div class="ui error message"></div>
                    <%
                    String msg=request.getParameter("msg");
                    if(msg!=null)
                    {
                        out.println(msg);
                    }
                %>
                </form>

            </div>
        </div>
        </div>
</body>
</html>
