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
            .intro-heading {
                padding-top: 40px;
                padding-bottom: 580px;
                font-family: "Droid Serif","Helvetica Neue",Helvetica,Arial,sans-serif;
                font-size: 50px;
                font-style: italic;
                line-height: 200px;

                background-image: url(images/exam.jpg);
            }
            .btn 
            {
                padding: 20px 40px;
                padding-top: 20px;
                padding-right: 40px;
                padding-bottom: 20px;
                padding-left: 40px;
                border-color: #fed136;
                border-top-color: rgb(254, 209, 54);
                border-right-color: rgb(254, 209, 54);
                border-bottom-color: rgb(254, 209, 54);
                border-left-color: rgb(254, 209, 54);
                border-radius: 3px;
                border-top-left-radius: 3px;
                border-top-right-radius: 3px;
                border-bottom-right-radius: 3px;
                border-bottom-left-radius: 3px;
                text-transform: uppercase;
                font-family: Montserrat,"Helvetica Neue",Helvetica,Arial,sans-serif;
                font-size: 15px;
                font-weight: 700;
                color: #fff;
                background-color:#d2691e;
            }


            body {
                color: #222;
                font-family: "proxima-nova", 'Helvetica Neue', Helvetica, Arial, sans-serif;
                font-size: 20px;
                font-weight: 300;
                line-height: 1.625;
            }
            p
            {
                text-indent: 50px;
            }
            blockquote 
            {
                background: url(images/quote.png) no-repeat;
                color: #a5a4a4;
                font-style: italic;
                margin: 30px;
                padding: 30px 30px 30px 50px;
            }
            .img-with-text
            {
                text-align: justify;
                width: [width of img];
            }

            .img-with-text img 
            {
                display: block;
                margin: 0 auto;
            }
            .mutedText
            {
                font-size: 14px;
                color: #777;
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

                    <a class=" active item" href="index.jsp">Home</a>
                    <a class="item" href="registration.jsp">Registration</a>
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
                    <a class="active item" href="index.jsp">Home</a>
                    <a class="item" href="registration.jsp">Registration</a>
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
            <p></p>
            <p></p>
        </div>
        &nbsp;<br>&nbsp;<br>
        <p id="invalidLogin" style="float:right;color:red">
            <%
                if (request.getParameter("msg") != null) {
                    out.println(request.getParameter("msg"));
                }
            %>
        </p>
        <br>
        <div id="main-home" align="center">

            <div class="intro-heading">
                Welcome to eProctor<br>
                <a href="#about1" class="btn">What is eProctor</a>
                &nbsp;
                <a href="#working" class="btn">How it Works</a>
                &nbsp;
            </div>
        </div>
        <div class="ui stackable grid">
            <div id="about1">
                <h1 class="entry-title">
                    &nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;About eProctor
                </h1>
                <blockquote>
                    TAKE THE EXAM ANYWHERE ON ANY DEVICE
                </blockquote>
                <blockquote style="background: #fcfcfc;border-left: 2px dashed #ccc;font-style: italic;color:black ;margin: 30px;padding: 30px;">
                    EProctor is an application for taking an exam from any device without the need of an Invigilator. It is a replacement for the traditional way of writing exam. E-Proctor gives you an authenticated way of writing exam by face recognition. Student has to register a particular device befor the exam.
                </blockquote>
                &nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>

            </div>
            <br>
            <div id="working">
                <h1 class="entry-title">
                    &nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Working of E-Proctor
                </h1>
                <blockquote>
                    USE TECHNOLOGY
                </blockquote>
                <blockquote style="background: #fcfcfc;border-left: 2px dashed #ccc;font-style: italic;color:black ;margin: 30px;padding: 30px;">
                    Complete control over the device and Face Recognition are the main features of the e-Proctor application. It will suspend all other application while exam is going on so that student can not access any material. It captures the image of the student at various intervals of time and checks.
                    &nbsp;<br>&nbsp;<br>&nbsp;<br>

                </blockquote>
                
            </div>
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <div class="img-with-text">
                <img src="images/block1.png" width="200px" height="200px" alt="Image"/>
                <p>Block incoming & outgoing</p>
            </div>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <div class="img-with-text">
                <img src="images/block4.jpg" width="200px" height="200px" alt="Image"/>
                <p>Block all other Applications</p>
            </div>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <div class="img-with-text">
                <img src="images/block3.png" width="200px" height="200px" alt="Image"/>
                <p>Disable buttons</p>
            </div>
            <br>
        </div>
        <br>&nbsp;<br><br>&nbsp;<br><br>&nbsp;<br>
        <div align="center">
            <h1>Our Team</h1>
            <h3>IITB Summer Internship 2016</h3>
        </div>
        <br>&nbsp;<br>&nbsp;
        <div class="ui stackable grid">
            <div class="four wide column"></div>
            <div class="three wide column">
                <img class="ui medium circular image" src="/devlopers/Avinash.jpg">
                <div align="center"><h4>Avinash</h4></div>
                <div class="mutedText" align="center">Chief Mentor</div>
            </div>
            <div class="two wide column"></div>
            <div class="three wide column">
                <img class="ui medium circular image" src="/devlopers/Rajanikant.jpg">
                <div align="center"><h4>Rajanikant</h4></div>
                <div class="mutedText" align="center">Mentor</div>
                <div align="center">
                    <a href="https://www.facebook.com/jangir.raj?fref=ts" target="_blank">
                    <button class="ui circular facebook icon button">
                        <i class="facebook icon"></i>
                    </button>
                    </a>
                    <a href="https://twitter.com/rkjangir85" target="_blank">
                    <button class="ui circular twitter icon button">
                        <i class="twitter icon"></i>
                    </button>
                    </a>
                    <a href="https://www.linkedin.com/in/rajanikant" target="_blank">
                    <button class="ui circular linkedin icon button">
                        <i class="linkedin icon"></i>
                    </button>
                    </a>
                </div>
            </div>
            <div class="four wide column"></div>
            <br>&nbsp;<br>&nbsp;<br>&nbsp;
            <div class="two wide column"></div>
            <div class="two wide column">
                <img class="ui medium circular image" src="/devlopers/shravan.jpg">
                <div align="center"><h4>Shravan</h4></div>
                <div class="mutedText" align="center">Intern</div>
                <div class="mutedText" align="center">(Computer Science And Engineering)<br>RGUKT Basar</div>
                <div align="center">
                    <a href="https://www.facebook.com/Shravank929">
                    <button class="ui circular facebook icon button">
                        <i class="facebook icon"></i>
                    </button>
                    </a>
                    <a href="https://plus.google.com/+ShravanKumarSunkari">
                    <button class="ui circular google plus icon button">
                        <i class="google plus icon"></i>
                    </button>
                    </a>
                    <a href="https://www.linkedin.com/in/shravan-kumar-5b6a10104">
                    <button class="ui circular linkedin icon button">
                        <i class="linkedin icon"></i>
                    </button>
                    </a>
                </div>
            </div>
            <div class="one wide column"></div>
            <div class="two wide column">
                <img class="ui medium circular image" src="/devlopers/sarreddy.jpg">
                <div align="center"><h4>Sarreddy</h4></div>
                <div class="mutedText" align="center">Intern</div>  
                <div class="mutedText" align="center">(Computer Science And Engineering)<br>College</div>
                <div align="center">
                    <a href="">
                    <button class="ui circular facebook icon button">
                        <i class="facebook icon"></i>
                    </button>
                    </a>
                    <a href="">
                    <button class="ui circular google plus icon button">
                        <i class="google plus icon"></i>
                    </button>
                    </a>
                    <a href="">
                    <button class="ui circular linkedin icon button">
                        <i class="linkedin icon"></i>
                    </button>
                    </a>
                </div>                          
            </div>
            <div class="one wide column"></div>
            <div class="two wide column">
                <img class="ui medium circular image" src="/devlopers/aneesh.jpg">
                <div align="center"><h4>Aneesh</h4></div>
                <div class="mutedText" align="center">Intern</div>
                <div class="mutedText" align="center">(Computer Science And Engineering)<br>College</div>
                <div align="center">
                    <a href="">
                    <button class="ui circular facebook icon button">
                        <i class="facebook icon"></i>
                    </button>
                    </a>
                    <a href="">
                    <button class="ui circular google plus icon button">
                        <i class="google plus icon"></i>
                    </button>
                    </a>
                    <a href="">
                    <button class="ui circular linkedin icon button">
                        <i class="linkedin icon"></i>
                    </button>
                    </a>
                </div> 
            </div>
            <div class="one wide column"></div>
            <div class="two wide column">
                <img class="ui medium circular image" src="/devlopers/shubhamsharma.jpg">
                <div align="center"><h4>Shubham</h4></div>
                <div class="mutedText" align="center">Intern</div> 
                <div class="mutedText" align="center">(Computer Science And Engineering)<br>College</div>
                <div align="center">
                    <a href="">
                    <button class="ui circular facebook icon button">
                        <i class="facebook icon"></i>
                    </button>
                    </a>
                    <a href="">
                    <button class="ui circular google plus icon button">
                        <i class="google plus icon"></i>
                    </button>
                    </a>
                    <a href="">
                    <button class="ui circular linkedin icon button">
                        <i class="linkedin icon"></i>
                    </button>
                    </a>
                </div>
            </div>
            <div class="two wide column"></div>
            <div class="one wide column"></div>
            <div class="two wide column">
                <img class="ui medium circular image" src="/devlopers/deepanshu.jpg">
                <div align="center"><h4>Deepanshu</h4></div>
                <div class="mutedText" align="center">Intern</div>
                <div class="mutedText" align="center">(Computer Science And Engineering)<br>College</div>
                <div align="center">
                    <a href="">
                    <button class="ui circular facebook icon button">
                        <i class="facebook icon"></i>
                    </button>
                    </a>
                    <a href="">
                    <button class="ui circular google plus icon button">
                        <i class="google plus icon"></i>
                    </button>
                    </a>
                    <a href="">
                    <button class="ui circular linkedin icon button">
                        <i class="linkedin icon"></i>
                    </button>
                    </a>
                </div> 
            </div>
            <div class="one wide column"></div>
            <div class="two wide column">
                <img class="ui medium circular image" src="/devlopers/anmol.jpg">
                <div align="center"><h4>Anmol</h4></div>
                <div class="mutedText" align="center">Intern</div>
                <div class="mutedText" align="center">(Computer Science And Engineering)<br>College</div>
                <div align="center">
                    <a href="">
                    <button class="ui circular facebook icon button">
                        <i class="facebook icon"></i>
                    </button>
                    </a>
                    <a href="">
                    <button class="ui circular google plus icon button">
                        <i class="google plus icon"></i>
                    </button>
                    </a>
                    <a href="">
                    <button class="ui circular linkedin icon button">
                        <i class="linkedin icon"></i>
                    </button>
                    </a>
                </div> 
            </div>
            <div class="one wide column"></div>
            <div class="two wide column">
                <img class="ui medium circular image" src="/devlopers/yashwanth.jpg">
                <div align="center"><h4>Yashwanth</h4></div>
                <div class="mutedText" align="center">Intern</div> 
                <div class="mutedText" align="center">(Computer Science And Engineering)<br>College</div>
                <div align="center">
                    <a href="">
                    <button class="ui circular facebook icon button">
                        <i class="facebook icon"></i>
                    </button>
                    </a>
                    <a href="">
                    <button class="ui circular google plus icon button">
                        <i class="google plus icon"></i>
                    </button>
                    </a>
                    <a href="">
                    <button class="ui circular linkedin icon button">
                        <i class="linkedin icon"></i>
                    </button>
                    </a>
                </div>
            </div>
            <div class="one wide column"></div>
            <div class="two wide column">
                <img class="ui medium circular image" src="/devlopers/kalyani.jpg">
                <div align="center"><h4>Kalyani</h4></div>
                <div class="mutedText" align="center">Intern</div>
                <div class="mutedText" align="center">(Computer Science And Engineering)<br>College</div>
                <div align="center">
                    <a href="">
                    <button class="ui circular facebook icon button">
                        <i class="facebook icon"></i>
                    </button>
                    </a>
                    <a href="">
                    <button class="ui circular google plus icon button">
                        <i class="google plus icon"></i>
                    </button>
                    </a>
                    <a href="">
                    <button class="ui circular linkedin icon button">
                        <i class="linkedin icon"></i>
                    </button>
                    </a>
                </div> 
            </div>
            <div class="one wide column"></div>
            <div class="two wide column">
                <img class="ui medium circular image" src="/devlopers/rathi.jpg">
                <div align="center"><h4>Hardik</h4></div>
                <div class="mutedText" align="center">Intern</div> 
                <div class="mutedText" align="center">(Computer Science And Engineering)<br>College</div>
                <div align="center">
                    <a href="">
                    <button class="ui circular facebook icon button">
                        <i class="facebook icon"></i>
                    </button>
                    </a>
                    <a href="">
                    <button class="ui circular google plus icon button">
                        <i class="google plus icon"></i>
                    </button>
                    </a>
                    <a href="">
                    <button class="ui circular linkedin icon button">
                        <i class="linkedin icon"></i>
                    </button>
                    </a>
                </div>
            </div>
        </div>
        <br>&nbsp;<br>&nbsp;<br>&nbsp;
        <div align="center">
            <h3>Developed under Ekalavya Summer Internship 2016 IIT Bombay</h3>
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
    </nav>
</body>
</html>

