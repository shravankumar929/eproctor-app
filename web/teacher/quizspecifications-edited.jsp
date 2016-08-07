<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

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
        <script type="text/javascript">
            function validate()
            {
                var x = document.forms["myForm"]["testName"].value;
                if (x == null || x == "") {
                    document.getElementById("nameerror").innerHTML = "Test Name is required!!!";
                    alert("Test Name is required!!!");
                   // return false;
                }
                var y = document.forms["myForm"]["exam_time"].value;
                if (y == null || y == "") {
                    document.getElementById("timeerror").innerHTML = "Test Time is required!!!";
                    alert("Test Time is required!!!");
                    //return false;
                }
                var z = document.forms["myForm"]["exam_duration"].value;
                if (z == null || z == "") {
                    document.getElementById("durationerror").innerHTML = "Test Duration is required!!!";
                    alert("Test Time is required!!!");
                    //return false;
                }
                var flag=0;
                var format=parseInt(z, 10);
                if (isNaN(format))
                {
                    alert(parseInt(z, 10));
                    //alert("data is not an integer");
                    flag=1;
                    document.getElementById("durationerror").innerHTML = "Enter Duration in minutes!";
                }
                else
                {
                   // alert(parseInt(z, 10));
                    //alert("data is not an integer");
                    flag=1;
                    document.getElementById("durationerror").innerHTML = "Enter Duration in minutes!";
                }
                var u = document.forms["myForm"]["description"].value;
                if (u == null || u == "") {
                    document.getElementById("descriptionerror").innerHTML = "Test Description is required!!!";
                    alert("Test Time is required!!!");
                    //return false;
                }
                if(x!="")
                    document.getElementById("nameerror").innerHTML = "";
                if(y!="")
                    document.getElementById("timeerror").innerHTML = "";
                if(z!="" && !isNaN(z))
                    document.getElementById("durationerror").innerHTML = "";
                if(u!="")
                    document.getElementById("descriptionerror").innerHTML = "";
                if(x==null || x=="" || y==null || y=="" || z==null || z=="" || u==null || u=="" || flag==1)
                    return false;
                else
                {
                    alert("true");
                    return true;
                }
            }
        </script>
        <script>
            $(document).ready(function () {
                localStorage.clear();

                $('.icon.button')
                        .popup({
                            on: 'click'
                        });
                $('.right.menu.open').on("click", function (e) {
                    e.preventDefault();
                    $('.ui.vertical.menu').toggle();
                });

                $('.ui.dropdown').dropdown();

                $(document).on('click', '#exam_time', function () {
                    $('#exam_time').datetimepicker({
                        formatTime: 'H:i',
                        formatDate: 'd.m.Y',
                        //defaultDate:'8.12.1986', // it's my birthday
                        defaultDate: '+03.01.1970', // it's my birthday
                        defaultTime: '10:00',
                        timepickerScrollbar: false
                    });
                });

                var iCnt = 0;
                var Que = 1;
                var question_num = 1;
                var opt_count = 1;
                var backup = "";

                var mainbody1 = "";
                $("#examCreate").click(function () {
                    iCnt = iCnt + 1;

                    var mainbody = '<div id="rem"><form id="myForm" method="post" action="makeJSON.jsp"><table id="table" class="ui table"><thead><tr><th style="width: 10%;"><div class="ui header"><h2>Add Test</h2></div></th><th style="width: 30%;"><div style="float:right;"><button id="examRemove" class="ui button">Cancel</button></div></th></tr></thead><tbody><tr><td><div class="ui ribbon label">Test Name:</div></td><td><div class="ui input focus"><input type="text" name="testName" id="test" placeholder="Name of the Test"><h4 id="nameerror" style="color:red;"></h4></div></td></tr><tr><td><div class="ui ribbon label">Time:</div></td><td><div class="ui input focus"><input type="text" name="exam_time" id="exam_time" placeholder="Year-Month-Date Hour:Min"><h4 id="timeerror" style="color:red;"></h4></div></td></tr><tr><td><div class="ui ribbon label">Duration:</div></td><td><div class="ui input focus"><input type="text" name="exam_duration" id="exam_duration" placeholder="Minutes"><h4 id="durationerror" style="color:red;"></h4></div></td></tr><tr><td><div class="ui ribbon label">Description:</div></td><td><textarea rows="5" cols="50" name="description" id="description" placeholder="Description about the Test"></textarea><h4 id="descriptionerror" style="color:red;"></h4></td></tr></tbody></table><br>&nbsp;<br>&nbsp;';
                    mainbody1 = '<div id="sub_que"><select class="ui dropdown" id="que"><option id="type" value="0">Choose type of question</option><option id="type" value="1">Multiple Choice Single Correct</option><option id="type" value="2">Multiple Choice Multiple Correct<option id="type" value="3">Numerical</option><option id="type" value="4">Matrix</option><option id="type" value="5">Match the Column</option></select><div id="savereset" class="ui grid"><br>&nbsp;<br><br>&nbsp;<br><br>&nbsp;<br><div class="sixteen wide column" align="center"><button class="ui primary button" id="save" onclick="return validate();">Save</button>&nbsp;&nbsp;&nbsp;&nbsp;<button class="ui button" id="reset" type="reset">Reset</button></div></div><input type="hidden" id="num_of_questions" name="num_of_questions" value="' + (question_num - 1) + '"/></form></div>';
                    backup = mainbody;
                    $("#main").append(mainbody + mainbody1);
                    //localStorage.setItem("previousData",mainbody);
                });
                $(document).on('click', '#save', function () {
                    backup = backup + mainbody1;
                    localStorage.setItem("previousData", backup);
                    $("#myForm").submit();
                });
                var htmlAppend = localStorage.getItem("previousData");
                if (htmlAppend)
                {
                    $("#main").append(htmlAppend);
                }

                $(document).on('click', '#examRemove', function () {
                    jQuery(this).closest("#rem").remove();
                    iCnt = iCnt - 1;
                });
                $(document).on('click', '#type', function () {
                    //alert($('#type').val());
                    //alert($(this).text());
                    //localStorage.setItem("previousData",backup);
                    var que = $("#que").val();
                    opt_count = 1;
                    if (que == 1)
                    {
                        //WE NEED TO GET NUMBER OF THIS QUESTION TO ASSIGN TO OPTIONS
                        var backup1 = '<div id="quesion_perticular"><hr><h3>Multiple Choice Single Correct</h3><br><h4 id="queLabel">Question No:'+question_num+'</h4><br><textarea rows="3" cols="80" name="' + question_num + '" id="question_num' + question_num + '" placeholder="Enter question Here:"></textarea><div class="ui icon button" id="erase1"><i class="erase icon"></i></div><br><div class="ui header"><h4>Options:</h4></div><br><div id="options' + question_num + '"><div id="option1" class="ui input focus"><h4 id="label">' + opt_count + '</h4>&nbsp;&nbsp;&nbsp;<input type="text" size="10" name="P' + question_num + '_' + opt_count + '"><div class="ui icon button" id="optremove1"><i class="minus icon"></i></div><div class="ui radio checkbox" id="check"><input id="ans" name="A' + question_num + '" value="1" type="radio"><label></label></div></div></div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<div class="ui icon button" id="opt1" data-content="Add more options"><i class="add square icon"></i></div><br><h4>Marks:&nbsp;&nbsp;<input type="text" name="marks' + question_num + '" size="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Negative Marks:&nbsp;&nbsp;<input type="text" size="2" name="marksNeg' + question_num + '"></h4><br>&nbsp;<br><input type="hidden" name="type' + question_num + '" value="1"/><input type="hidden" id="PtypeNum' + question_num + '" name="PtypeNum' + question_num + '" value="1"/></div>';
                        backup = backup + backup1;
                        $("#sub_que").before(backup1);
                        // $("#").attr('id',   this.id + '_' + new_id);
                        //alert(jQuery("#quesion_perticular1").closest("#question_num").html());
                        //jQuery("#quesion_perticular1").closest("#question_num").attr('name',question_num);
                        question_num = question_num + 1;
                        $("#num_of_questions").val(question_num);

                    } else if (que == 2)
                    {
                        var backup1 = '<div id="quesion_perticular"><hr><h3>Multiple Choice Multiple Correct</h3><br><h4 id="queLabel">Question No:'+question_num+'</h4><br><textarea rows="3" cols="80" name="' + question_num + '" id="question_num' + question_num + '" placeholder="Enter question Here:"></textarea><div class="ui icon button" id="erase2"><i class="erase icon"></i></div><br><div class="ui header"><h4>Options:</h4></div><br><div id="options' + question_num + '"><div id="option2" class="ui input focus"><h4 id="label">' + opt_count + '</h4>&nbsp;&nbsp;&nbsp;<input type="text" size="10" name="P' + question_num + '_' + opt_count + '"><div class="ui icon button" id="optremove2"><i class="minus icon"></i></div><div class="ui checkbox"><input name="A' + question_num + '" value="1" type="checkbox"><label></label></div></div></div><div class="ui icon button" id="opt2" data-content="Add more options"><i class="add square icon"></i></div><br><h4>Marks:&nbsp;&nbsp;<input type="text" size="2" name="marks' + question_num + '">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Negative Marks:&nbsp;&nbsp;<input type="text" size="2" name="marksNeg' + question_num + '"></h4><br>&nbsp;<br><input type="hidden" name="type' + question_num + '" value="2"/><input type="hidden" id="PtypeNum' + question_num + '" name="PtypeNum' + question_num + '" value="1"/></div>';
                        backup = backup + backup1;
                        $("#sub_que").before(backup1);
                        question_num = question_num + 1;
                        $("#num_of_questions").val(question_num);
                    } else if (que == 3)
                    {
                        var backup1 = '<div id="quesion_perticular"><hr><h3>Numerical Type</h3><br><h4 id="queLabel">Question No:'+question_num+'</h4><br><textarea rows="3" cols="80" name="' + question_num + '" id="question_num' + question_num + '" placeholder="Enter question Here:"></textarea><div class="ui icon button" id="erase3"><i class="erase icon"></i></div><br><div class="ui input focus"><br><h4>Answer:&nbsp;&nbsp;</h4><input name="NumericAns' + question_num + '" type="text" size="15"><h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Marks:&nbsp;&nbsp;</h4><input type="text" size="2"  name="marks' + question_num + '"><h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Negative Marks:&nbsp;&nbsp;</h4><input type="text" size="2" name="marksNeg' + question_num + '"></div></div><br>&nbsp;<br>&nbsp;<br><input type="hidden" name="type' + question_num + '" value="3"/></div>';
                        backup = backup + backup1;
                        $("#sub_que").before(backup1);
                        question_num = question_num + 1;
                        $("#num_of_questions").val(question_num);
                    } else if (que == 4)
                    {
                        var backup1 = '<div id="quesion_perticular"><hr><br><h3>Mtrix Type</h3><br><h4 id="queLabel">Question No:'+question_num+'</h4><div class="ui grid"><div class="one wide column"></div><div class="four wide column"><table class="ui celled table"><tr><td align="center"><h3>P</h3></td></tr><br><tr><td><input type="hidden" id="que_num" value="'+question_num+'"><div id="optionsP'+question_num+'"><div id="optionP4" class="ui input focus"><h4 id="label">' + opt_count + '</h4>&nbsp;&nbsp;<input type="text" size="10" name="P' + question_num + '_' + opt_count + '"><div class="ui icon button" id="optremoveP4"><i class="minus icon"></i></div></div></div><div class="ui icon button" id="optP4" data-content="Add more options"><i class="add square icon"></i></div></td></tr></table></div><div class="one wide column"></div><div class="four wide column"><table class="ui celled table"><tr><td><h3>Q</h3></td></tr><br><tr><td><input type="hidden" id="que_num" value="'+question_num+'"><div id="optionsQ'+question_num+'"><div id="optionQ4" class="ui input focus"><h4 id="label">' + String.fromCharCode(64 + opt_count) + '</h4>&nbsp;&nbsp;<input type="text" size="10" name="Q' + question_num + '_' + opt_count + '"><div class="ui icon button" id="optremoveQ4"><i class="minus icon"></i></div></div></div><div class="ui icon button" id="optQ4" data-content="Add more options"><i class="add square icon"></i></div></td></tr></table></div><div class="five wide column"><div class="ui icon button" id="erase4"><i class="erase icon"></i></div></div></div><br><h4>Answer:&nbsp;&nbsp;<input type="text" size="15" name="MatrixAns' + question_num + '">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Marks:&nbsp;&nbsp;<input type="text" size="2" name="marks' + question_num + '">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Negative Marks:&nbsp;&nbsp;<input type="text" size="2" name="marksNeg' + question_num + '"></h4><br>&nbsp;<br>&nbsp;<br><input type="hidden" name="type' + question_num + '" value="4"/><input type="hidden" id="PtypeNum' + question_num + '" name="PtypeNum' + question_num + '" value="1"/><input type="hidden" id="QtypeNum' + question_num + '" name="QtypeNum' + question_num + '" value="1"/></div>';
                        backup = backup + backup1;
                        $("#sub_que").before(backup1);
                        question_num = question_num + 1;
                        $("#num_of_questions").val(question_num);
                    } else if (que == 5)
                    {
                        var backup1 = '<div id="quesion_perticular"><hr><br><h3>Match The Column</h3><br><h4 id="queLabel">Question No:'+question_num+'</h4><div class="ui grid"><div class="one wide column"></div><div class="four wide column"><table class="ui celled table"><tr><td align="center"><h3>P</h3></td></tr><br><tr><td><input type="hidden" id="que_num" value="'+question_num+'"><div id="optionsP'+question_num+'"><div id="optionP5" class="ui input focus"><h4 id="label">' + opt_count + '</h4>&nbsp;&nbsp;<input type="text" size="10" name="P' + question_num + '_' + opt_count + '"><div class="ui icon button" id="optremoveP5"><i class="minus icon"></i></div></div></div><div class="ui icon button" id="optP5" data-content="Add more options"><i class="add square icon"></i></div></td></tr></table></div><div class="one wide column"></div><div class="four wide column"><table class="ui celled table"><tr><td><h3>Q</h3></td></tr><br><tr><td><input type="hidden" id="que_num" value="'+question_num+'"><div id="optionsQ'+question_num+'"><div id="optionQ4" class="ui input focus"><h4 id="label">' + String.fromCharCode(64 + opt_count) + '</h4>&nbsp;&nbsp;<input type="text" size="10" name="Q' + question_num + '_' + opt_count + '"><div class="ui icon button" id="optremoveQ4"><i class="minus icon"></i></div></div></div><div class="ui icon button" id="optQ4" data-content="Add more options"><i class="add square icon"></i></div></td></tr></table></div><div class="five wide column"><div class="ui icon button" id="erase4"><i class="erase icon"></i></div></div></div><br><h4>Answer:&nbsp;&nbsp;<input type="text" size="15" name="MatrixAns' + question_num + '">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Marks:&nbsp;&nbsp;<input type="text" size="2" name="marks' + question_num + '">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Negative Marks:&nbsp;&nbsp;<input type="text" size="2" name="marksNeg' + question_num + '"></h4><br>&nbsp;<br>&nbsp;<br><input type="hidden" name="type' + question_num + '" value="5"/><input type="hidden" id="PtypeNum' + question_num + '" name="PtypeNum' + question_num + '" value="1"/><input type="hidden" id="QtypeNum' + question_num + '" name="QtypeNum' + question_num + '" value="1"/></div>';
                        backup = backup + backup1;
                        $("#sub_que").before(backup1);
                        question_num = question_num + 1;
                        $("#num_of_questions").val(question_num);
                    }
                    //alert($('select option:selected').text());
                });
                $(document).on('click', '#opt1', function () {

                    var num = $(this).siblings('textarea').attr("name");//getting question number
                    var opt_name = "#options" + num;
                    var opt_c = $(this).siblings(opt_name).children().length + 1;

                    var name = "#PtypeNum" + num;
                    var val = $(name).val();
                    $(name).val(parseInt(val) + 1);
                    //alert(val);
                    $(this).siblings(opt_name).append('<div id="option1" class="ui input focus"><h4 id="label">' + opt_c + '</h4>&nbsp;&nbsp;&nbsp;<input type="text" size="10" name="P' + num + '_' + opt_c + '"><div class="ui icon button" id="optremove1"><i class="minus icon"></i></div><div id="check" class="ui radio checkbox"><input id="ans" name="A' + num + '" value="'+opt_c+'" type="radio"><label></label></div></div>');

                });
                $(document).on('click', '#opt2', function () {
                    var num = $(this).siblings('textarea').attr("name");//getting question number
                    var opt_name = "#options" + num;
                    var opt_c = $(this).siblings(opt_name).children().length + 1;

                    var name = "#PtypeNum" + num;
                    var val = $(name).val();
                    $(name).val(parseInt(val) + 1);
                    $(this).siblings(opt_name).append('<div id="option2" class="ui input focus"><h4 id="label">' + opt_c + '</h4>&nbsp;&nbsp;&nbsp;<input type="text" size="10" name="P' + num + '_' + opt_c + '"><div class="ui icon button" id="optremove2"><i class="minus icon"></i></div><div id="check" class="ui checkbox"><input id="ans" name="A' + num + '" value="'+opt_c+'" type="checkbox"><label></label></div></div>');
                });

                $(document).on('click', '#optP4', function () {
                    //var opt_c = $(this).siblings(opt_name).children().length + 1;
                    var num=$(this).siblings()[0].value;
                    var opt_name = "#optionsP" + num;
                    var name = "#PtypeNum" + num;
                    var val = $(name).val();
                    $(name).val(parseInt(val) + 1);
                    var opt_c=$(this).parent().children().children().length;//gives 1 more than the actual text fields
                    $(opt_name).append('<div id="optionP4" class="ui input focus"><h4 id="label">' + opt_c + '</h4>&nbsp;&nbsp;<input type="text" size="10" name="P' +num+ '_' + opt_c + '"><div class="ui icon button" id="optremoveP4"><i class="minus icon"></i></div></div>');
                });
                $(document).on('click', '#optQ4', function () {
                    var num=$(this).siblings()[0].value;
                    var opt_name = "#optionsQ" + num;
                    var name = "#QtypeNum" + num;
                    var val = $(name).val();
                    $(name).val(parseInt(val) + 1);
                    var opt_c=$(this).parent().children().children().length;
                    $(opt_name).append('<div id="optionQ4" class="ui input focus"><h4 id="label">' +String.fromCharCode(64 + opt_c) + '</h4>&nbsp;&nbsp;<input type="text" size="10" name="Q' + num + '_' + opt_c + '"><div class="ui icon button" id="optremoveQ4"><i class="minus icon"></i></div></div>');
                });

                $(document).on('click', '#optP5', function () {
                    var num=$(this).siblings()[0].value;
                    var opt_name = "#optionsP" + num;
                    var name = "#PtypeNum" + num;
                    var val = $(name).val();
                    $(name).val(parseInt(val) + 1);
                    var opt_c=$(this).parent().children().children().length;
                    $(opt_name).append('<div id="optionP5" class="ui input focus"><h4 id="label">' + opt_c + '</h4>&nbsp;&nbsp;<input type="text" size="10" name="P' +num+ '_' + opt_c + '"><div class="ui icon button" id="optremoveP5"><i class="minus icon"></i></div></div>');
                });
                $(document).on('click', '#optQ5', function () {
                    var num=$(this).siblings()[0].value;
                    var opt_name = "#optionsQ" + num;
                    var name = "#QtypeNum" + num;
                    var val = $(name).val();
                    $(name).val(parseInt(val) + 1);
                    var opt_c=$(this).parent().children().children().length;
                    $(opt_name).append('<div id="optionQ5" class="ui input focus"><h4 id="label">' + String.fromCharCode(64 + opt_c)+ '</h4>&nbsp;&nbsp;<input type="text" size="10" name="Q' + num + '_' + opt_c + '"><div class="ui icon button" id="optremoveQ5"><i class="minus icon"></i></div></div>');
                });
                $(document).on('click', '#optremove1', function () {

                    var id = 1;
                    var num = $(this).parent().parent().siblings('textarea').attr("name");//getting question number

                   // var div1 = $(this).parent().parent().closest('div').attr('id');
                    //alert(div1);
                    var name = "#PtypeNum" + num;
                    var val = $(name).val();
                    $(name).val(parseInt(val) - 1);
                    $(this).closest('div').parent().remove();
                    var opt_name = "#options" + num;
                    jQuery(opt_name).children('#option1').each(function () {
                        var e = $(this).children()[1];
                        jQuery(e).attr('name', "P" + num + "_" + id);
                        var l = $(this).children()[0];
                        jQuery(l).html(id);
                        var ele=$(this).children()[3];
                        e=jQuery(ele).children()[0];
                        jQuery(e).attr('value',id);
                       // var ele = $(this).children("#check").children("#ans");

                       // jQuery(ele).attr('name', "A" + num + "_" + id);
                        //jQuery(this).attr('id',id);
                        id = id + 1;
                        //alert(id); // "this" is the current element in the loop
                    });

                    // alert(num);
                    //jQuery(this).closest("#option1").remove();
                });
                $(document).on('click', '#erase1', function () {
                    //jQuery(this).closest("#rem").children('')
                    //$("#erase1").parent().parent().parent().attr('id') gives rem
                    var ele=jQuery(this).parent().parent().parent().attr('id');
                    alert("id="+ele);
                    var eleId="#"+ele;
                    var id=1;
                    $("#rem").children('textarea').each(function(){
                        var e=$(this).children()[0];
                        alert("children="+e);
                        jQuery(this).attr('name',id);
                        id=id+1;
                    }); 
                    id=1;
                    $(eleId).children('queLabel').each(function(){
                       // var e=$(this).children()[0];
                        jQuery(this).html("Question No:"+id);
                        id=id+1;
                    }); 
                    jQuery(this).closest("#quesion_perticular").remove();
                });

                $(document).on('click', '#optremove2', function () {
                    var id = 1;
                    var num = $(this).parent().parent().siblings('textarea').attr("name");//getting question number
                    $(this).closest('div').parent().remove();
                    //alert(num);
                    var opt_name = "#options" + num;
                    $(opt_name).children('#option2').each(function () {
                        var e = $(this).children()[1];
                        jQuery(e).attr('name', "P" + num + "_" + id);
                        var l = $(this).children()[0];
                        jQuery(l).html(id);
                        var ele=$(this).children()[3];
                        e=jQuery(ele).children()[0];
                        jQuery(e).attr('value',id);
                        //jQuery(this).attr('id',id);
                        id = id + 1;
                        //alert(id); // "this" is the current element in the loop
                    });

                });

                $(document).on('click', '#optremoveP4', function () {
                    var id=1;
                    var num=$(this).parent().parent().parent().children()[0].value;
                    jQuery(this).closest("#optionP4").remove();
                    var opt_name="#optionsP"+num;
                    
                    $(opt_name).children('#optionP4').each(function()
                    {
                        var ele=$(this).children()[0];//gives question heading
                        jQuery(ele).html(id);
                        ele=$(this).children()[1];
                        jQuery(ele).attr('name', "P" + num + "_" + id);
                        id=id+1;
                        //jQuery(ele).children()[0]//label
                        //jQuery(ele).children()[1]//text field
                    });

                    
                });
                $(document).on('click', '#optremoveQ4', function () {
                    var id=1;
                    var num=$(this).parent().parent().parent().children()[0].value;
                    jQuery(this).closest("#optionQ4").remove();
                    var opt_name="#optionsQ"+num;
                    $(opt_name).children('#optionQ4').each(function()
                    {
                        var ele=$(this).children()[0];//gives question heading
                        jQuery(ele).html(String.fromCharCode(64 + id));
                        ele=$(this).children()[1];
                        jQuery(ele).attr('name', "Q" + num + "_" + id);
                        id=id+1;
                        //jQuery(ele).children()[0]//label
                        //jQuery(ele).children()[1]//text field
                    });
                    
                });
                $(document).on('click', '#optremoveP5', function () {
                    var id=1;
                    var num=$(this).parent().parent().parent().children()[0].value;
                    jQuery(this).closest("#optionP5").remove();
                    var opt_name="#optionsP"+num;
                    $(opt_name).children('#optionP5').each(function()
                    {
                        var ele=$(this).children()[0];//gives question heading
                        jQuery(ele).html(id);
                        ele=$(this).children()[1];
                        jQuery(ele).attr('name', "P" + num + "_" + id);
                        id=id+1;
                        //jQuery(ele).children()[0]//label
                        //jQuery(ele).children()[1]//text field
                    });
                });
                $(document).on('click', '#optremoveQ5', function () {
                    var id=1;
                    var num=$(this).parent().parent().parent().children()[0].value;
                    jQuery(this).closest("#optionQ5").remove();
                    var opt_name="#optionsQ"+num;
                    $(opt_name).children('#optionQ4').each(function()
                    {
                        var ele=$(this).children()[0];//gives question heading
                        jQuery(ele).html(String.fromCharCode(64 + id));
                        ele=$(this).children()[1];
                        jQuery(ele).attr('name', "Q" + num + "_" + id);
                        id=id+1;
                        //jQuery(ele).children()[0]//label
                        //jQuery(ele).children()[1]//text field
                    });
                });
                $(document).on('click', '#erase2', function () {
                    jQuery(this).closest("#quesion_perticular").remove();
                });
                
                $(document).on('click', '#erase3', function () {
                    jQuery(this).closest("#quesion_perticular").remove();
                });

                $(document).on('click', '#erase4', function () {
                    jQuery(this).closest("#quesion_perticular").remove();
                });

                $(document).on('click', '#erase5', function () {
                    jQuery(this).closest("#quesion_perticular").remove();
                });
            });
        </script>
    </head>
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
                            <a class="item" href="editProfile.jsp"><i class="edit icon"></i> Edit Profile</a>
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
                        <a class="item" href="editProfile.jsp"><i class="edit icon"></i> Edit Profile</a>
                    <a class="item"><i class="settings icon"></i> Account Settings</a>
                    <a class="item" class="logout icon" href="/logout.jsp">Logout</a>
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
        </div>
        <p></p>
        <p></p>
        &nbsp;<br>&nbsp;<br>&nbsp;<br>

        <div class="ui stackable grid">
            <div class="one wide column"></div>
            <div class="twelve wide column">
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
                response.sendRedirect("/index.jsp");
            }
            %>
</html>
