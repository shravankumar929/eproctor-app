<%
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html>

<html>
    <%
        if ((session.getAttribute("name")) != null && (session.getAttribute("password") != null) && (session.getAttribute("role").equals("Teacher"))) {
    %>
    <head>

        <meta name="viewport" content="width=device-width, initial-scale=1.0,maximum-scale=1, minimum-scale=1">
        <title>EProctor</title>
        <script src="/styles/js/jquery.min.js"></script>
        <script src="/styles/semantic/dist/semantic.min.js"></script>
        <link rel="stylesheet" type="text/css" href="/styles/semantic/dist/semantic.min.css">
        <link rel="stylesheet" type="text/css" href="/styles/datetime/jquery.datetimepicker.css">
        <script src="/styles/datetime/jquery.datetimepicker.js"></script>
        <script src="/styles/datetime/jquery.datetimepicker.min.js"></script>
        <style type="text/css">
        .clickable-div 
    	{
         	cursor: pointer;
    	}
        </style>
        <script>    
                $(document).ready(function(){
                    localStorage.clear();
                    $('.icon.button')
                        .popup({
                             on: 'click'
                        });
                    $('.right.menu.open').on("click",function(e){
                        e.preventDefault();
                        $('.ui.vertical.menu').toggle();
                    });
    				
                    $('.ui.dropdown').dropdown();

                    $(document).on('click', '#exam_time' ,function() {
                    $('#exam_time').datetimepicker({
						formatTime:'H:i',
						formatDate:'d.m.Y',
						//defaultDate:'8.12.1986', // it's my birthday
						defaultDate:'+03.01.1970', // it's my birthday
						defaultTime:'10:00',
						timepickerScrollbar:false
					});
                });

                    var iCnt = 0;
                    var Que=1;
                    var question_num=1;
                    var opt_count=1;
                    var backup="";
                    
                    var mainbody1="";
                    $("#examCreate").click(function(){
                        iCnt = iCnt + 1;

                        var mainbody='<div id="rem"><form id="myForm" method="post" action="makeJSON.jsp"><table id="table" class="ui table"><thead><tr><th style="width: 50%;"><div class="ui header"><h2>Add Test</h2></div></th><th style="width: 50%;"><div style="float:right;"><button id="examRemove" class="ui button">Cancel</button></div></th></tr></thead><tbody><tr><td><div class="ui ribbon label">Test Name:</div></td><td><div class="ui input focus"><input type="text" name="testName" id="test"></div><br></td></tr><tr><td><div class="ui ribbon label">Time:</div></td><td><div class="ui input focus"><input type="text" name="exam_time" id="exam_time"></div><br></td></tr><tr><td><div class="ui ribbon label">Description:</div></td><td><textarea rows="5" cols="50" name="description" id="description"></textarea></td></tr></tbody></table><br>&nbsp;<br>&nbsp;';
                        	mainbody1='<div id="sub_que"><select class="ui dropdown" id="que"><option id="type" value="0">Choose type of question</option><option id="type" value="1">Multiple Choice Single Correct</option><option id="type" value="2">Multiple Choice Multiple Correct<option id="type" value="3">Numerical</option><option id="type" value="4">Matrix</option><option id="type" value="5">Match the Column</option></select><div id="savereset" class="ui grid"><br>&nbsp;<br><br>&nbsp;<br><br>&nbsp;<br><div class="sixteen wide column" align="center"><button class="ui primary button" id="save">Save</button>&nbsp;&nbsp;&nbsp;&nbsp;<button class="ui button" id="reset" type="reset">Reset</button></div></div><input type="hidden" id="num_of_questions" name="num_of_questions" value="'+(question_num-1)+'"/></form></div>';
                        backup=mainbody;
                        $("#main").append(mainbody+mainbody1);
                        //localStorage.setItem("previousData",mainbody);
                    });
                    $(document).on('click', '#save' ,function() {
                        backup=backup+mainbody1;
                    	localStorage.setItem("previousData",backup);
                    	$("#myForm").submit();
                    });
                    var htmlAppend=localStorage.getItem("previousData");
                    if(htmlAppend)
                    {
                    	$("#main").append(htmlAppend);
                    }
                    
                    $(document).on('click', '#examRemove' ,function() {
                        jQuery(this).closest("#rem").remove();
                        iCnt=iCnt-1;
                    });
                    $(document).on('click', '#type' ,function() {
                        //alert($('#type').val());
                        //alert($(this).text());
                        //localStorage.setItem("previousData",backup);
                        var que=$("#que").val();
                        opt_count=1;
                        if(que==1)
                        {
                            //WE NEED TO GET NUMBER OF THIS QUESTION TO ASSIGN TO OPTIONS
                            var backup1='<div id="quesion_perticular1"><hr><br><h3>Multiple Choice Single Correct</h3><br><textarea rows="3" cols="80" name="'+question_num+'" id="question_num'+question_num+'" placeholder="Enter question Here:"></textarea><div class="ui icon button" id="erase1"><i class="erase icon"></i></div><br><div class="ui header"><h3>Options:</h3></div><br><div id="options'+question_num+'"><div id="option1" class="ui input focus"><h3 id="label">'+opt_count+'</h3>&nbsp;&nbsp;&nbsp;<input type="text" size="10" name="P'+question_num+'_'+opt_count+'"><div class="ui icon button" id="optremove1"><i class="minus icon"></i></div><div class="ui radio checkbox" id="check"><input id="ans" name="A'+question_num+'" type="radio"><label></label></div></div></div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<div class="ui icon button" id="opt1" data-content="Add more options"><i class="add square icon"></i></div><br><div class="ui input focus"><br><h4>Marks:&nbsp;&nbsp;</h4><input type="text" name="marks'+question_num+'" size="2"><h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Negative Marks:&nbsp;&nbsp;</h4><input type="text" size="2" name="marksNeg'+question_num+'"></div><br>&nbsp;<br>&nbsp;<br><input type="hidden" name="type'+question_num+'" value="1"/><input type="hidden" id="PtypeNum'+question_num+'" name="PtypeNum'+question_num+'" value="1"/></div>';
                            backup=backup+backup1;
                            $("#sub_que").before(backup1);
                           // $("#").attr('id',   this.id + '_' + new_id);
                           //alert(jQuery("#quesion_perticular1").closest("#question_num").html());
                            //jQuery("#quesion_perticular1").closest("#question_num").attr('name',question_num);
                            question_num=question_num+1;
                            $("#num_of_questions").val(question_num);

                        }
                        else if(que==2)
                        {
                        	var backup1='<div id="quesion_perticular2"><hr><br><h3>Multiple Choice Multiple Correct</h3><br><textarea rows="3" cols="80" name="'+question_num+'" id="question_num'+question_num+'" placeholder="Enter question Here:"></textarea><div class="ui icon button" id="erase2"><i class="erase icon"></i></div><br><div class="ui header"><h3>Options:</h3></div><br><div id="options'+question_num+'"><div id="option2" class="ui input focus"><h3 id="label">'+opt_count+'</h3>&nbsp;&nbsp;&nbsp;<input type="text" size="10" name="P'+question_num+'_'+opt_count+'"><div class="ui icon button" id="optremove2"><i class="minus icon"></i></div><div class="ui radio checkbox"><input name="A'+question_num+'_'+opt_count+'" type="radio"><label></label></div></div></div><div class="ui icon button" id="opt2" data-content="Add more options"><i class="add square icon"></i></div><br><div class="ui input focus"><br><h4>Answer:&nbsp;&nbsp;</h4><input type="text" size="15"><h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Marks:&nbsp;&nbsp;</h4><input type="text" size="2"><h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Negative Marks:&nbsp;&nbsp;</h4><input type="text" size="2"></div><br>&nbsp;<br>&nbsp;<br><input type="hidden" name="type'+question_num+'" value="2"/></div>';
                        	backup=backup+backup1;
                            $("#sub_que").before(backup1);
                            question_num=question_num+1;
                            $("#num_of_questions").val(question_num);
                        }
                        else if(que==3)
                        {
                        	var backup1='<div id="quesion_perticular3"><hr><br><h3>Numerical type</h3><br><textarea rows="3" cols="80" name="question_num'+question_num+'" id="question_num'+question_num+'" placeholder="Enter question Here:"></textarea><div class="ui icon button" id="erase3"><i class="erase icon"></i></div><br><div class="ui input focus"><br><h4>Answer:&nbsp;&nbsp;</h4><input type="text" size="15"><h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Marks:&nbsp;&nbsp;</h4><input type="text" size="2"><h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Negative Marks:&nbsp;&nbsp;</h4><input type="text" size="2"></div></div><br>&nbsp;<br>&nbsp;<br><input type="hidden" name="type'+question_num+'" value="3"/></div>';
                        	backup=backup+backup1;
                            $("#sub_que").before(backup1);
                            question_num=question_num+1;
                            $("#num_of_questions").val(question_num);
                        }
                        else if(que==4)
                        {
                        	var backup1='<div id="quesion_perticular4"><hr><br><h3>Mtrix Type</h3><br><div class="ui grid"><div class="one wide column"></div><div class="four wide column"><table class="ui celled table"><tr><td align="center"><h1>P</h1></td></tr><br><tr><td><div id="optionsP4"><div id="optionP4" class="ui input focus"><input type="text" size="10" name="opt"><div class="ui icon button" id="optremoveP4"><i class="minus icon"></i></div></div></div><div class="ui icon button" id="optP4" data-content="Add more options"><i class="add square icon"></i></div></td></tr></table></div><div class="two wide column"></div><div class="four wide column"><table class="ui celled table"><tr><td><h1>Q</h1></td></tr><br><tr><td><div id="optionsQ4"><div id="optionQ4" class="ui input focus"><input type="text" size="10" name="opt"><div class="ui icon button" id="optremoveQ4"><i class="minus icon"></i></div></div></div><div class="ui icon button" id="optQ4" data-content="Add more options"><i class="add square icon"></i></div></td></tr></table></div><div class="five wide column"><div class="ui icon button" id="erase4"><i class="erase icon"></i></div></div></div><br><div class="ui input focus"><br><h4>Answer:&nbsp;&nbsp;</h4><input type="text" size="15"><h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Marks:&nbsp;&nbsp;</h4><input type="text" size="2"><h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Negative Marks:&nbsp;&nbsp;</h4><input type="text" size="2"></div><br>&nbsp;<br>&nbsp;<br><input type="hidden" name="type'+question_num+'" value="4"/></div>';
                        	backup=backup+backup1;
                        	$("#sub_que").before(backup1);
                        	question_num=question_num+1;
                        	$("#num_of_questions").val(question_num);
                        }
                        else if(que==5)
                        {
                        	var backup1='<div id="quesion_perticular5"><hr><br><h3>Match The Column</h3><br><div class="ui grid"><div class="one wide column"></div><div class="four wide column"><table class="ui celled table"><tr><td align="center"><h1>P</h1></td></tr><br><tr><td><div id="optionsP5"><div id="optionP5" class="ui input focus"><input type="text" size="10" name="opt"><div class="ui icon button" id="optremoveP5"><i class="minus icon"></i></div></div></div><div class="ui icon button" id="optP5" data-content="Add more options"><i class="add square icon"></i></div></td></tr></table></div><div class="two wide column"></div><div class="four wide column"><table class="ui celled table"><tr><td><h1>Q</h1></td></tr><br><tr><td><div id="optionsQ5"><div id="optionQ5" class="ui input focus"><input type="text" size="10" name="opt"><div class="ui icon button" id="optremoveQ5"><i class="minus icon"></i></div></div></div><div class="ui icon button" id="optQ5" data-content="Add more options"><i class="add square icon"></i></div></td></tr></table></div><div class="five wide column"><div class="ui icon button" id="erase5"><i class="erase icon"></i></div></div></div><br><div class="ui input focus"><br><h4>Answer:&nbsp;&nbsp;</h4><input type="text" size="15"><h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Marks:&nbsp;&nbsp;</h4><input type="text" size="2"><h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Negative Marks:&nbsp;&nbsp;</h4><input type="text" size="2"></div><br>&nbsp;<br>&nbsp;<br><input type="hidden" name="type'+question_num+'" value="5"/></div>';
                        	backup=backup+backup1;
                        	$("#sub_que").before(backup1);
                        	question_num=question_num+1;
                        	$("#num_of_questions").val(question_num);
                        }
                        //alert($('select option:selected').text());
                    });
                    $(document).on('click', '#opt1' ,function() {
                     
                       var num=$(this).siblings('textarea').attr("name");//getting question number
                       var opt_name="#options"+num;
                       var opt_c=$(this).siblings(opt_name).children().length+1;
             
                       var name="#PtypeNum"+num;
                       var val=$(name).val();
                       $(name).val(parseInt(val)+1);
                       //alert(val);
                        $(this).siblings(opt_name).append('<div id="option1" class="ui input focus"><h3 id="label">'+opt_c+'</h3>&nbsp;&nbsp;&nbsp;<input type="text" size="10" name="P'+num+'_'+opt_c+'"><div class="ui icon button" id="optremove1"><i class="minus icon"></i></div><div id="check" class="ui radio checkbox"><input id="ans" name="A'+num+'" type="radio"><label></label></div></div>');
               
                    });
                    $(document).on('click', '#optremove1' ,function() {
                        
                        var id=1;
                        var num=$(this).parent().parent().siblings('textarea').attr("name");//getting question number
                        
                        var div1=$(this).parent().parent().closest('div').attr('id');
                        //alert(div1);
                        var name="#PtypeNum"+num;
                       	var val=$(name).val();
                       	$(name).val(parseInt(val)-1);
                        $(this).closest('div').parent().remove();
                        var opt_name="#options"+num;
                        jQuery(opt_name).children('#option1').each(function () {
                        	var e=$(this).children()[1];
                        	jQuery(e).attr('name',"P"+num+"_"+id);
                        	var l=$(this).children()[0];
                        	jQuery(l).html(id);
                        	
                        	ele=$(this).children("#check").children("#ans");
                       
                        	jQuery(ele).attr('name',"A"+num+"_"+id);
                        	//jQuery(this).attr('id',id);
                        	id=id+1;
    						//alert(id); // "this" is the current element in the loop
						});
						
                       // alert(num);
						    //jQuery(this).closest("#option1").remove();
                    });
                    $(document).on('click', '#erase1' ,function() {
                        jQuery(this).closest("#quesion_perticular1").remove();
                    });

                    $(document).on('click', '#optremove2' ,function() {
                    	var id=1;
                        var num=$(this).parent().parent().siblings('textarea').attr("name");//getting question number
                        $(this).closest('div').parent().remove();
                        alert(num);
                        var opt_name="#options"+num;
                        $(opt_name).children('#option2').each(function () {
                        	var e=$(this).children()[1];
                        	jQuery(e).attr('name',"P"+num+"_"+id);
                        	var l=$(this).children()[0];
                        	jQuery(l).html(id);
                        	//jQuery(this).attr('id',id);
                        	id=id+1;
    						//alert(id); // "this" is the current element in the loop
						});
                       
                    });
                     $(document).on('click', '#erase2' ,function() {
                        jQuery(this).closest("#quesion_perticular2").remove();
                    });
                    $(document).on('click', '#opt2' ,function() {
                    	var num=$(this).siblings('textarea').attr("name");//getting question number
                        var opt_name="#options"+num;
                       var opt_c=$(this).siblings(opt_name).children().length+1;
                       
                        $(this).siblings(opt_name).append('<div id="option2" class="ui input focus"><h3 id="label">'+opt_c+'</h3>&nbsp;&nbsp;&nbsp;<input type="text" size="10" name="P'+num+'_'+opt_c+'"><div class="ui icon button" id="optremove2"><i class="minus icon"></i></div><div class="ui radio checkbox"><input name="A'+question_num+'_'+opt_c+'" type="radio"><label></label></div></div>');
                    });

                    $(document).on('click', '#erase3' ,function() {
                        jQuery(this).closest("#quesion_perticular3").remove();
                    });

                    $(document).on('click', '#optP4' ,function() {
                        $("#optionsP4").append('<div id="optionP4" class="ui input focus"><input type="text" size="10" name="opt2"><div class="ui icon button" id="optremoveP4"><i class="minus icon"></i></div></div>');
                    });
                    $(document).on('click', '#optQ4' ,function() {
                        $("#optionsQ4").append('<div id="optionQ4" class="ui input focus"><input type="text" size="10" name="opt2"><div class="ui icon button" id="optremoveQ4"><i class="minus icon"></i></div></div>');
                    });
                    
                     $(document).on('click', '#optremoveP4' ,function() {
                        jQuery(this).closest("#optionP4").remove();
                    });
                      $(document).on('click', '#optremoveQ4' ,function() {
                        jQuery(this).closest("#optionQ4").remove();
                    });
                   
                    $(document).on('click', '#erase4' ,function() {
                        jQuery(this).closest("#quesion_perticular4").remove();
                    });

                    $(document).on('click', '#optP5' ,function() {
                        $("#optionsP5").append('<div id="optionP5" class="ui input focus"><input type="text" size="10" name="opt2"><div class="ui icon button" id="optremoveP5"><i class="minus icon"></i></div></div>');
                    });
                    $(document).on('click', '#optQ5' ,function() {
                        $("#optionsQ5").append('<div id="optionQ5" class="ui input focus"><input type="text" size="10" name="opt2"><div class="ui icon button" id="optremoveQ5"><i class="minus icon"></i></div></div>');
                    });
                    
                     $(document).on('click', '#optremoveP5' ,function() {
                        jQuery(this).closest("#optionP5").remove();
                    });
                      $(document).on('click', '#optremoveQ5' ,function() {
                        jQuery(this).closest("#optionQ5").remove();
                    });
                   
                    $(document).on('click', '#erase5' ,function() {
                        jQuery(this).closest("#quesion_perticular5").remove();
                    });
        });
        </script>
    </head>
    <%
        if ((session.getAttribute("name")) != null && (session.getAttribute("password") != null)) 
        {
            
    %>
    <body>
        <div class="ui grid">
        <div class="computer tablet only row">
            <div class="ui top fixed inverted menu">
                <img src="/images/eProctor2.png" " width="150px" height="50px" >
 
                <a class="item" href="teacherIndex.jsp">Home</a>
                <a class="active item" href="quizspecifications.jsp" id="specifications">Assessment</a>
                <a class="item" href="selectTest.jsp" id="results">Quiz Results</a>
                <div class="right menu">
                    <div class="item">
                   <h3>
                    Welcome <%= session.getAttribute("firstName")%>
                    </h3>
                    </div>
                    <div class="ui dropdown item">
                        More <i class="icon dropdown"></i>
                        <div class="menu">
                            <a class="item"><i class="edit icon"></i> Edit Profile</a>
                            <a class="item"><i class="settings icon"></i> Account Settings</a>
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
                <a class="active item" href="quizspecifications.jsp" id="specifications">Specifications</a>
                <a class="item" href="selectTest.jsp" id="results">Quiz Results</a>
                <div class="right menu">
                    <div class="item">
                    <h3>
                    Welcome <%= session.getAttribute("firstName")%>
                    </h3>
                    </div>
                   
                            <a class="item"><i class="edit icon"></i> Edit Profile</a>
                            <a class="item"><i class="settings icon"></i> Account Settings</a>
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
        &nbsp;<br>&nbsp;<br>&nbsp;<br>
    
    <div class="ui stackable grid">
    	<div class="one wide column"></div>
    	<div class="twelve wide column">
            <table class="ui table">
                <tr>
                    <td>
                        Exam Name:
                    </td>
                    <td>
                        
                    </td>
                </tr>
            </table>
    		<button id="examCreate" class="ui right labeled icon button">
  				<i class="right arrow icon"></i>
  					Create Test
			</button>&nbsp;<br>&nbsp;<br>&nbsp;<br>
    		
    		<div id="main">

            </div>
    	</div>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    
        &nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>
    </body>
    <%
    } 
    else
    {
    out.println("hai");
    response.setStatus(response.SC_MOVED_TEMPORARILY);
    response.setHeader("Location", "/index.jsp");
    
    }
    %>

</html>