<html>
    <head>
        <script src="styles/js/jquery.min.js"></script>
        <script src="styles/semantic/dist/semantic.min.js"></script>
        <link rel="stylesheet" type="text/css" href="styles/semantic/dist/semantic.min.css">
        <script  type="text/javascript">
            var str = "";
            var i = 1; //counter to add rows
            function addRow(tableID)
            {
                /* this function is used to create a new row for the table when the user presses add button */
                var table = document.getElementById(tableID);

                var rowCount = table.rows.length; /*get the number of rows currently in the table*/
                var row = table.insertRow(rowCount); /*insert a new row*/


                var cell1 = row.insertCell(0);
                cell1.innerHTML = rowCount + 1;/*display question numbe rin first cell*/


                var cell2 = row.insertCell(1); /*create a select element from which the user can select the type of questions*/

                var element1 = document.createElement('select');
                element1.setAttribute('name', 'type' + i);
                element1.setAttribute('id', 'type' + i);
                element1.add(new Option("Multiple Choice Single Correct", "1"));
                element1.add(new Option("Multiple Choice Multiple Correct", "2"));
                element1.add(new Option("Numerical Answer", "3"));
                element1.add(new Option("Match the Column", "4"));
                element1.add(new Option("Matrix Match", "5"));

                cell2.appendChild(element1);

                var cell3 = row.insertCell(2);/*create a select element from which the user can select the qualifier*/
                var element2 = document.createElement('select');
                element2.setAttribute('name', 'qualifier' + i);
                element2.setAttribute('id', 'qualifier' + i);
                element2.add(new Option("1", "0"));
                element2.add(new Option("2", "1"));
                element2.add(new Option("3", "2"));
                element2.add(new Option("4", "3"));
                element2.add(new Option("5", "4"));
                element2.add(new Option("6", "5"));
                element2.add(new Option("7", "6"));
                element2.add(new Option("8", "7"));
                element2.add(new Option("9", "8"));
                element2.add(new Option("10", "9"));

                cell3.appendChild(element2);
                var cell4 = row.insertCell(3);  /*create a select element from which the user can select the sub qualifier*/
                var element3 = document.createElement('select');
                element3.setAttribute('name', 'subqualifier' + i);
                element3.setAttribute('id', 'subqualifier' + i);
                element3.add(new Option("0", "0"));
                element3.add(new Option("1", "1"));
                element3.add(new Option("2", "2"));
                element3.add(new Option("3", "3"));
                element3.add(new Option("4", "4"));
                element3.add(new Option("5", "5"));
                element3.add(new Option("6", "6"));
                element3.add(new Option("7", "7"));
                element3.add(new Option("8", "8"));
                element3.add(new Option("9", "9"));
                element3.add(new Option("10", "10"));
                cell4.appendChild(element3);
                var cell5 = row.insertCell(4);
                cell5.innerHTML = table.rows[0].cells[4].innerHTML;
                var cell6 = row.insertCell(5);
                cell6.innerHTML = table.rows[0].cells[5].innerHTML;
                var cell7 = row.insertCell(6);
                var element4 = document.createElement('input');/*create a text field in which the user can enter the marks for correct answer*/
                element4.setAttribute('name', 'right' + i);
                element4.setAttribute('id', 'right' + i);

                cell7.appendChild(element4);
                var cell8 = row.insertCell(7);
                cell8.innerHTML = table.rows[0].cells[7].innerHTML;
                var cell9 = row.insertCell(8);
                var element5 = document.createElement('input');/*create a text field in which the user can enter the marks deducted for wrong answer*/
                element5.setAttribute('name', 'wrong' + i);
                element5.setAttribute('id', 'wrong' + i);

                cell9.appendChild(element5);

                var qType1 = document.getElementById("type" + (i - 1));
                var qTypevalue1 = qType1.options[qType1.selectedIndex].value;
                var q1 = document.getElementById("qualifier" + (i - 1));
                var qvalue1 = q1.options[q1.selectedIndex].text;
                var sq1 = document.getElementById("subqualifier" + (i - 1));
                var sqvalue1 = sq1.options[sq1.selectedIndex].text;
                var right1 = document.getElementById("right" + (i - 1)).value;
                var right2 = parseInt(right1);
                var wrong1 = document.getElementById("wrong" + (i - 1)).value;
                var wrong2 = parseInt(wrong1);
                if (qTypevalue1 == 1)
                {
                    document.getElementById("subqualifier" + (i - 1)).disabled = true;/*no sub-qualifier for type1 i.e single correct*/
                }
                if (qTypevalue1 == 2)
                {
                    document.getElementById("subqualifier" + (i - 1)).disabled = true; /*no sub-qualifier for type2 i.e multiple correct*/
                }
                if (wrong2 > right2)
                {
                    alert("Marks deducted for wrong answer cannot be more than those alloted for correct answer");
                }



                i++;
                // alert(document.getElementById(type1).name);    



            }



            function getValues() {
                /*This function is used to make a comma seperated string of the question specifications*/
                /*The first line in this string has the total number of questions, the total marks and the total time seperated by commas*/
                str = "";

                var test = document.getElementById("test").value;
                var total = document.getElementById("total").value;
                var total1 = 0;
                var time = document.getElementById("time").value;
                if (time == '')
                {
                    //alert("You Forgot to Enter Total time !!");
                    time = 10;
                }
                for (var m = 0; m < i; m++)
                {
                    var right_t = document.getElementById("right" + m).value;
                    if (right_t == '')
                        var right1_t = 0;
                    else
                        var right1_t = parseInt(right_t);
                    total1 += right1_t;
                }
                str += test + "_" + i + "," + total1 + "," + time + ";";
                for (var j = 0; j < i; j++) {


                    var qType = document.getElementById("type" + j);
                    var qTypevalue = qType.options[qType.selectedIndex].value;
                    if (qTypevalue == 1)
                    {
                        var q = document.getElementById("qualifier" + j);
                        var qvalue = q.options[q.selectedIndex].text;
                        var sq = document.getElementById("subqualifier" + j);
                        sq.disabled = true;
                        var sqvalue = "0";
                        var right = document.getElementById("right" + j).value;
                        var right1 = parseInt(right);
                        var wrong = document.getElementById("wrong" + j).value;
                        var wrong1 = parseInt(wrong);
                        if (right == '' || wrong == '')
                        {
                            if (right == '')
                                right1 = 0;
                            if (wrong == '')
                                wrong1 = 0;
                        }
                        if (parseInt(right) < parseInt(wrong))
                        {
                            wrong1 = right1 - 1;
                        }
                        if (parseInt(wrong) < 0)
                        {
                            alert("Dont enter - sign");
                            wrong1 = 0;
                        }
                    } else if (qTypevalue == 2)
                    {
                        var q = document.getElementById("qualifier" + j);
                        var qvalue = q.options[q.selectedIndex].text;
                        var sq = document.getElementById("subqualifier" + j);
                        sq.disabled = true;
                        var sqvalue = "0";
                        var right = document.getElementById("right" + j).value;
                        var right1 = parseInt(right);
                        var wrong = document.getElementById("wrong" + j).value;
                        var wrong1 = parseInt(wrong);
                        if (right == '' || wrong == '')
                        {
                            if (right == '')
                                right1 = 0;
                            if (wrong == '')
                                wrong1 = 0;
                        }
                        if (parseInt(right) < parseInt(wrong))
                        {
                            wrong1 = right1 - 1;
                        }
                        if (parseInt(wrong) < 0)
                        {
                            alert("Dont enter - sign");
                            wrong1 = 0;
                        }
                    } else
                    {
                        var q = document.getElementById("qualifier" + j);
                        var qvalue = q.options[q.selectedIndex].text;
                        var sq = document.getElementById("subqualifier" + j);
                        var sqvalue = sq.options[sq.selectedIndex].text;
                        var right = document.getElementById("right" + j).value;
                        var right1 = parseInt(right);

                        var wrong = document.getElementById("wrong" + j).value;
                        var wrong1 = parseInt(wrong);
                        if (right == '' || wrong == '')
                        {
                            if (right == '')
                                right1 = 0;
                            if (wrong == '')
                                wrong1 = 0;
                        }

                        if (parseInt(right) < parseInt(wrong))
                        {
                            wrong1 = right1 - 1;
                        }
                        if (parseInt(wrong) < 0)
                        {
                            alert("Dont enter - sign");
                            wrong1 = 0;
                        }
                    }
                    str += (j + 1) + "," + qTypevalue + "," + qvalue + "," + sqvalue + "," + right1 + "," + wrong1 + ";";


                }
                //  alert(str);
                window.location.replace("newjsp.jsp?str=" + str);
            }


        </script>
    </head>
    <body>
        <div class="ui grid">
            <div class="sixteen wide column">
                <form class="ui form" id="form1" name="form1" method="post"  action="fileUpload.jsp">
                    <p>Test Name-<input type="text" class="form_row" name="test" id="test"></p>
                    <p>Total Marks-<input type="text" class="form_row" name="time" id="time">Total Time-<input type="text" class="form_row" name="total" id="total">
                        <br />
                    </p>
                    <table class="ui fixed table">
                        <tr>
                            <td>
                                <select name="type" id="type0">
                                    <option value="1">Multiple Choice Single Correct</option>
                                    <option value="2">Multiple Choice Multiple Correct</option>
                                    <option value="3">Numerical Answer</option>
                                    <option value="5">Matrix Match</option>
                                    <option value="4">Match The Column</option>
                                </select>
                            </td>
                            <td>
                                <select name="qualifier" id="qualifier0">
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="6">6</option>
                                    <option value="7">7</option>
                                    <option value="8">8</option>
                                    <option value="9">9</option>
                                    <option value="10">10</option>
                                </select>
                            </td>
                            <td>
                                <select name="subqualifier" id="subqualifier0">
                                    <option value="0 ">0 </option>
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="6">6</option>
                                    <option value="7">7</option>
                                    <option value="8">8</option>
                                    <option value="9">9</option>
                                    <option value="10">10</option>
                                </select>
                            </td>
                            <td> Marks Alloted-
                            </td>
                            <td>
                                <img src="images/right1.gif" alt="" width="39" height="34">
                            </td>
                            <td>
                                <input name="right" type="text" class="form_row" id="right0" width="1">
                            </td>
                            <td>
                                <img src="images/wrong.gif" width="42" height="32" alt="">
                            </td>
                            <td>
                                <p><input name="wrong" type="text" class="form_row" id="wrong0" width="1">
                                </p>
                            </td>
                        </tr>
                    </table>
                    <table class="ui table">
                        <tr>
                            <td>
                                <input name="add" type="button" class="button" value="Add " onclick="addRow('form_table')" align="left">
                            </td>
                            <td>
                                <input name="done" type="button" class="button" id="done" value="Done" onClick="getValues()" align="centre">
                            </td>
                            <td>
                                <input name="reset" type="reset" class="button" id="reset" value="Reset" align="centre">
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
    </body>
</html>