<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>eProctor</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="/styles/js/jquery.min.js"></script>
	    <script src="/styles/semantic/dist/semantic.min.js"></script>
	    <script src="/styles/jquery.address.js"></script>
	    <link rel="stylesheet" type="text/css" href="/styles/semantic/dist/semantic.min.css">
		<link rel="stylesheet" type="text/css" href="/styles/custom.css">
    <script type="text/javascript">// <![CDATA[
      $( document ).ready(function() 
      {
        $('.demo.menu .item').tab();
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
                <img src="/images/eProctor2.png" " width="150px" height="50px" >
 
                <a class="item" href="index.jsp">Home</a>
                <a class="item" href="registration.jsp">Registration</a>
                <a class="item" href="announcements.jsp">Announcements</a>
                <a class="active item" href="DeviceDownload.html">Download</a>
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
                <a class="item" href="registration.jsp">Registration</a>
                <a class="item" href="announcements.jsp">Announcements</a>
                <a class="active item" href="downloadApp.jsp">Download</a>
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
        &nbsp;<br>&nbsp;
        <div class="ui stackable grid">
            <div class="one wide column">
            </div>
            <div class="twelve wide column">
                <p>&nbsp;</p>
                <p>&nbsp;</p>
                 <div class="ui header">
                    <h1>eProctor Application Download</h1>
                </div>
                
              
				<div class="ui pointing secondary demo menu">
					<a class="active red item" data-tab="first">Android</a>
					<a class="blue item" data-tab="second">Windows</a>
					<a class="green item" data-tab="third">Ubuntu</a>
				
				</div>
        <div class="ui active tab segment" data-tab="first">
          <h3><a href="">Download eProctor apk file Here(Not avialable)</a></h3>
          <div class="ui header">
            <h3>Installation steps:(For apk file)</h3>
          </div>
            <ul>
              <li>
                Download the application from the above link
              </li>
              <li>
                In settings, go to security option and enable the unknown source option.<br>
                <img src="/images/permissions.png">
              </li>
              <li>
                After the download has completed go to the downloaded folder of your device and click the downloaded apk file
              </li>
              <li>
                Agree to the app permissions requirement and click on next
              </li>
              <li>
                Done. Launch the application
              </li>
            </ul>
          
        </div>
        <div class="ui tab segment" data-tab="second">
            <h3><a href="/app/windows.zip">Download eProctor File Here</a></h3>
            
          
            <div class="ui header">
            <h3>Installation steps:(For Zip file)</h3>
          	</div>
<pre>
Requrements - 
  Windows 7,8,10
  Oracle Java 8 JDK


 1. Download the Eproctor.zip file.
 2. Extract the zip file.
 3. Go into the folder and run the "run.bat" file.
 4. For any query, ask the Eproctor face-recognition team.

Testing Process
    
 1. You need to create your own dataset first for training the recogniser.
 	You need to store your 10 images in different angles-
		Straight
		15 degrees left
		15 degrees right
		30 degrees left
		30 degrees right
		45 degrees left
		45 degree right
		Straight image with serious expression
		10 degree down as in the exam posture
		10 degree up.
	For storing image , click the image button in which direction you want to give the image and then click snap button only when your face is detected
	(The green square which appears on the screen appeals that your face is detected ).

	After processing your dataset, the software will either accept or reject your dataset.
	If your dataset is rejected, then you have not given your images in the right manner 
	and try again from the start as none of your images are saved.After the acceptance, Submit button will be enabled to proceed further. 


 2. After creating your own dataset, give the exam and test all the functionalities.
</pre>
        </div>
        <div class="ui tab segment" data-tab="third">
            <h3><a href="/app/Eproctor_linux.zip">Download Jar File Here</a></h3>
          <div class="ui header">
            <h3>Installation steps:(For Jar file)</h3>
          </div>
<pre>
Requrements - 
  Ubuntu
  Oracle Java 8 JDK


 1. Download the Eproctor.zip file.
 2. Extract the zip file.
 3. Go into the folder and run the "run.sh" file.You need to change the permissions to executable if it does not run.
 4. For any query, ask the Eproctor face-recognition team.

Testing Process
    
 1. You need to create your own dataset first for training the recogniser.
 	You need to store your 10 images in different angles-
		Straight
		15 degrees left
		15 degrees right
		30 degrees left
		30 degrees right
		45 degrees left
		45 degree right
		Straight image with serious expression
		10 degree down as in the exam posture
		10 degree up.
	For storing image , click the image button in which direction you want to give the image and then click snap 
  button only when your face is detected (The green square which appears on the screen appeals that 
  your face is detected).

	After processing your dataset, the software will either accept or reject your dataset.If your dataset is 
  rejected, then you have not given your images in the right manner and try again from the start as none of your
  images are saved.After the acceptance,Submit button will be enabled to proceed further. 


 2. After creating your own dataset, give the exam and test all the functionalities.
</pre>
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