<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.File"%>
<%@page import="java.util.ArrayList"%>
<%@page import="home.QuestionPaper"%>
<%@page import="java.util.*"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%!
    String test_name=null;
    int num_of_questions=0;
    int total_duration=0;
    int total_marks=0;
    String testTime=null;
    String testId=null;
    String testDesc=null;
    QuestionPaper obj = null;
    String question_options = null;
    Boolean errOccured=false;
%>
<!DOCTYPE html>
<html>
    <head>
    </head>
    <%
        /*
        encoding = config.getInitParameter("requestEncoding");
                if( encoding==null ) 
                        encoding="UTF-8";
                if(null == request.getCharacterEncoding())
                request.setCharacterEncoding(encoding);
        */
        StringBuffer text=null;
        try
        {
        testTime = request.getParameter("exam_time");
        testTime=testTime+":00";
        test_name = request.getParameter("testName");
        total_duration=Integer.parseInt(request.getParameter("exam_duration"));
        num_of_questions = Integer.parseInt(request.getParameter("num_of_questions"));
        text = new StringBuffer(request.getParameter("description"));
        }
        catch(NullPointerException e)
        {
            out.println("Cannot create test without all the required details!!!<br>Go back and Enter all details <a href='quizspecifications.jsp'>Click here</a>");
            errOccured=true;
        }
        catch(NumberFormatException ex)
        {
            if(errOccured==false)
            {
            out.println("Cannot create test without all the required details!!!<br>Go back and Enter all details <a href='quizspecifications.jsp'>Click here</a>");
             errOccured=true;
            }
        }
        
        //int loc = (new String(text)).indexOf('\n');
        /*
        while (loc > 0) {
            text.replace(loc, loc + 1, "<BR>");
            loc = (new String(text)).indexOf('\n');
        }
        */
        

        //total_duration = Double.parseDouble(request.getParameter("total_duration"));
        //total_marks = Integer.parseInt(request.getParameter("total_marks"));
        //start_time = request.getParameter("start_time");
        int total = 0;
        int total_que = num_of_questions - 1;
        for (int i = 1; i < num_of_questions; i++) {
            String m = request.getParameter("marks" + i);
            if (m != null) {
                total += Integer.parseInt(m);
                //out.println("Marks="+m);
            } else {
                total_que -= 1;//stores number of questions
            }
        }
        /*
                INSERT INTO EXAM TABLE
        */
        try
        {
        obj = new QuestionPaper(test_name,text.toString() ,total, total_duration, testTime, total_que);
        }
        catch(NullPointerException e)
        {
            if(errOccured==false)
            {
            out.println("Cannot create test without all the required details!!!<br>Go back and Enter all details <a href='quizspecifications.jsp'>Click here</a>");
             errOccured=true;
            }
        }
        try
        {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con=DriverManager.getConnection("jdbc:mysql://localhost/eproctor","eproctor","shraonessk");
        Statement s1=con.createStatement();
        String que="insert into Exam(Name,Time,Marks,Duration,NoOfQuestions,Description)values('"+test_name+"','"+testTime+"','"+total+"','"+total_duration+"','"+total_que+"','"+text.toString()+"')";
        int rs1=s1.executeUpdate(que);
        }
        catch(SQLException e)
        {
           if(errOccured==false)
            {
            out.println("Cannot create test without all the required details!!!<br>Go back and Enter all details <a href='quizspecifications.jsp'>Click here</a>");
             errOccured=true;
            }
        }
        catch(NullPointerException ex)
        {
           if(errOccured==false)
            {
            out.println("Cannot create test without all the required details!!!<br>Go back and Enter all details <a href='quizspecifications.jsp'>Click here</a>");
             errOccured=true;
            }
        }
        //question_options = request.getParameter("question_options");

        //Add question one by one
        ArrayList<String> p = new ArrayList<>();
        ArrayList<String> q = new ArrayList<>();
        for (int i = 1; i <= total_que; i++) {
            int type=-1;
            int marks=0;
            int marksNeg=0;
            try
            {
            type = Integer.parseInt(request.getParameter("type" + i));
            marks = Integer.parseInt(request.getParameter("marks" + i));
            marksNeg = Integer.parseInt(request.getParameter("marksNeg" + i));
            }
            catch(NullPointerException e)
            {
                if(errOccured==false)
            {
            out.println("Cannot create test without all the required details!!!<br>Go back and Enter all details <a href='quizspecifications.jsp'>Click here</a>");
             errOccured=true;
            }
            }
            
            if (type == 1) 
            {
                StringBuffer que_text =new StringBuffer("");
                
                try 
                {
                    int num_p = Integer.parseInt(request.getParameter("PtypeNum" + i));

                    for (int j = 1; j <= num_p; j++) 
                    {
                        p.add(request.getParameter("P" + i + "_" + j));
                        //out.println("Adding =" + request.getParameter("P" + i + "_" + j));
                    }
                    
                    que_text = new StringBuffer(request.getParameter(Integer.toString(i)));
                    /*
                    loc = (new String(que_text)).indexOf('\n');
                    while (loc > 0) 
                    {
                        que_text.replace(loc, loc + 1, "<BR>");
                        loc = (new String(que_text)).indexOf('\n');
                    }
                    */
                    
                    
                } 
                catch (NullPointerException e) 
                {
                    if(errOccured==false)
            {
            out.println("Cannot create test without all the required details!!!<br>Go back and Enter all details <a href='quizspecifications.jsp'>Click here</a>");
             errOccured=true;
            }
                }
                try
                {
                    obj.addQue(type,i,que_text.toString(), marks, marksNeg, new ArrayList<>(p), new ArrayList<>(q));
                    try
                    {
                        int ans=Integer.parseInt(request.getParameter("A"+i));
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con=DriverManager.getConnection("jdbc:mysql://localhost/eproctor","eproctor","shraonessk");
                        Statement s1=con.createStatement();
                        String que="select ExamId from Exam where Name='"+test_name+"' and Time='"+testTime+"' and Marks='"+total+"'";
                        ResultSet rs=s1.executeQuery(que);
                        
                        if(rs.next())
                        {
                            int ExamId=Integer.parseInt(rs.getString(1));
                        
                        s1=con.createStatement();
                        que="insert into Question(ExamId,Description,Marks,NegativeMarks,Answer,TypeId)values('"+ExamId+"','"+que_text.toString()+"','"+marks+"','"+marksNeg+"','"+p.get(ans-1)+"','"+1+"')";
                        int rs1=s1.executeUpdate(que);
                        out.println("Successfully inserted record");
                        }
                        else
                        	out.println("Cannot insert quesion!!!");
                    }
                    catch(Exception e)
                    {
                        if(errOccured==false)
            {
            out.println("Cannot create test without all the required details!!!<br>Go back and Enter all details <a href='quizspecifications.jsp'>Click here</a>");
             errOccured=true;
            }
                    }
                    
                }
                catch(NullPointerException e) 
                {
                    if(errOccured==false)
            {
            out.println("Cannot create test without all the required details!!!<br>Go back and Enter all details <a href='quizspecifications.jsp'>Click here</a>");
             errOccured=true;
            }
                }
            }
            else if(type==2)
            {
                /*
                                String[] checkboxes= request.getParameterValues("checkbox");
String[] textareas= request.getParameterValues("textarea");
 
   for (int j = 0; j < checkboxes.length; j++) {
                id = checkboxes[j]; 
                variable = observacion[j];
                boolean i = userdao.modificaSolicitud(id,  variable); // this is a update sql method
                 
            }

                        java.net.URLDecoder.decode(request.getParameter("content"), "utf-8");


                */
                StringBuffer que_text =new StringBuffer("");
                try 
                {
                    int num_p = Integer.parseInt(request.getParameter("PtypeNum" + i));

                    for (int j = 1; j <= num_p; j++) 
                    {
                        p.add(request.getParameter("P" + i + "_" + j));
                        //out.println("Adding =" + request.getParameter("P" + i + "_" + j));
                    }
                    
                    que_text = new StringBuffer(request.getParameter(Integer.toString(i)));
                    /*
                    loc = (new String(que_text)).indexOf('\n');
                    while (loc > 0) 
                    {
                        que_text.replace(loc, loc + 1, "<BR>");
                        loc = (new String(que_text)).indexOf('\n');
                    }
                    */
                    
                    
                } 
                catch (NullPointerException e) 
                {
                    if(errOccured==false)
            {
            out.println("Cannot create test without all the required details!!!<br>Go back and Enter all details <a href='quizspecifications.jsp'>Click here</a>");
             errOccured=true;
            }
                }
                try
                {
                    obj.addQue(type,i,que_text.toString(), marks, marksNeg, new ArrayList<>(p), new ArrayList<>(q));
                    String[] checkboxes=null;
                    String ans=null;
                    try
                    {
                        checkboxes= request.getParameterValues("A"+i);
                        
                        for(int l=0;l<checkboxes.length;l++)
                        {
                            int val=Integer.parseInt(checkboxes[l]);
                            if(ans==null)
                                ans=p.get(val-1);
                            else
                                ans=ans+"|"+p.get(val-1);
                        }
                    }
                    catch(NullPointerException ex)
                    {
                        if(errOccured==false)
            {
            out.println("Cannot create test without all the required details!!!<br>Go back and Enter all details <a href='quizspecifications.jsp'>Click here</a>");
             errOccured=true;
            }
                    }
                    try
                    {
                        
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con=DriverManager.getConnection("jdbc:mysql://localhost/eproctor","eproctor","shraonessk");
                        Statement s1=con.createStatement();
                        String que="select ExamId from Exam where Name='"+test_name+"' and Time='"+testTime+"' and Marks='"+total+"'";
                        ResultSet rs=s1.executeQuery(que);
                 
                        if(rs.next())
                        {
                            int ExamId=Integer.parseInt(rs.getString(1));
                        
                        s1=con.createStatement();
                        que="insert into Question(ExamId,Description,Marks,NegativeMarks,Answer,TypeId)values('"+ExamId+"','"+que_text.toString()+"','"+marks+"','"+marksNeg+"','"+ans+"','"+2+"')";
                        int rs1=s1.executeUpdate(que);
                        }
                        else
                        	out.println("Cannot insert into database!");
                    }
                    catch(SQLException e)
                    {
                       if(errOccured==false)
            {
            out.println("Cannot create test without all the required details!!!<br>Go back and Enter all details <a href='quizspecifications.jsp'>Click here</a>");
             errOccured=true;
            }
                    }
                }
                catch(NullPointerException e) 
                {
                    if(errOccured==false)
            {
            out.println("Cannot create test without all the required details!!!<br>Go back and Enter all details <a href='quizspecifications.jsp'>Click here</a>");
             errOccured=true;
            }
                }
            }
            else if(type==3)
            {
                StringBuffer que_text =new StringBuffer("");
                try 
                {
                    que_text = new StringBuffer(request.getParameter(Integer.toString(i)));
                    /*
                    loc = (new String(que_text)).indexOf('\n');
                    while (loc > 0) 
                    {
                        que_text.replace(loc, loc + 1, "<BR>");
                        loc = (new String(que_text)).indexOf('\n');
                    }
*/
                    String ans=request.getParameter("NumericAns"+i);
                    for(int c=0;c<ans.length();c++)
                        p.add(Character.toString(ans.charAt(c)));
                    
                } 
                catch (NullPointerException e) 
                {
                    if(errOccured==false)
            {
            out.println("Cannot create test without all the required details!!!<br>Go back and Enter all details <a href='quizspecifications.jsp'>Click here</a>");
             errOccured=true;
            }
                }
                try
                {
                    obj.addQue(type,i,que_text.toString(), marks, marksNeg, new ArrayList<>(p), new ArrayList<>(q));
                    try
                    {
                        
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con=DriverManager.getConnection("jdbc:mysql://localhost/eproctor","eproctor","shraonessk");
                        Statement s1=con.createStatement();
                        String que="select ExamId from Exam where Name='"+test_name+"' and Time='"+testTime+"' and Marks='"+total+"'";
                        ResultSet rs=s1.executeQuery(que);
                       
                        if(rs.next())
                        {
                            int ExamId=Integer.parseInt(rs.getString(1));
                        
                        s1=con.createStatement();
                        String ans="";
                        for(int l=0;l<p.size();l++)
                            ans=ans+p.get(l);
                        que="insert into Question(ExamId,Description,Marks,NegativeMarks,Answer,TypeId)values('"+ExamId+"','"+que_text.toString()+"','"+marks+"','"+marksNeg+"','"+ans+"','"+3+"')";
                        int rs1=s1.executeUpdate(que);
                        }
                        else
                        	out.println("Cannot insert into database!");
                    }
                    catch(SQLException e)
                    {
                        if(errOccured==false)
            {
            out.println("Cannot create test without all the required details!!!<br>Go back and Enter all details <a href='quizspecifications.jsp'>Click here</a>");
             errOccured=true;
            }
                    }
                }
                catch(NullPointerException e) 
                {
                    if(errOccured==false)
            {
            out.println("Cannot create test without all the required details!!!<br>Go back and Enter all details <a href='quizspecifications.jsp'>Click here</a>");
             errOccured=true;
            }
                }
            }
            else if(type==4)
            {
                try 
                {
                    int num_p = Integer.parseInt(request.getParameter("PtypeNum" + i));
                    int num_q = Integer.parseInt(request.getParameter("QtypeNum" + i));
                    for (int j = 1; j <= num_p; j++) 
                    {
                        p.add(request.getParameter("P" + i + "_" + j));
                        out.println("Adding =" + request.getParameter("P" + i + "_" + j));
                    }
                    for (int j = 1; j <= num_q; j++) 
                    {
                        q.add(request.getParameter("Q" + i + "_" + j));
                        out.println("Adding =" + request.getParameter("Q" + i + "_" + j));
                    }
                    
                } 
                catch (NullPointerException e) 
                {
                    if(errOccured==false)
            {
            out.println("Cannot create test without all the required details!!!<br>Go back and Enter all details <a href='quizspecifications.jsp'>Click here</a>");
             errOccured=true;
            }
                }
                try
                {
                    obj.addQue(type,i,"", marks, marksNeg, new ArrayList<>(p), new ArrayList<>(q));
                    try
                    {
                        
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con=DriverManager.getConnection("jdbc:mysql://localhost/eproctor","eproctor","shraonessk");
                        Statement s1=con.createStatement();
                        String que="select ExamId from Exam where Name='"+test_name+"' and Time='"+testTime+"' and Marks='"+total+"'";
                        ResultSet rs=s1.executeQuery(que);
                        
                        if(rs.next())
                        {
                            int ExamId=Integer.parseInt(rs.getString(1));
                   
                        s1=con.createStatement();
                        String ans="";//Fix a method to store ans
                        
                        que="insert into Question(ExamId,Description,Marks,NegativeMarks,Answer,TypeId)values('"+ExamId+"','"+""+"','"+marks+"','"+marksNeg+"','"+ans+"','"+4+"')";
                        int rs1=s1.executeUpdate(que);
                        }
                        else
                        	out.println("Cannot insert into database!");
                    }
                    catch(SQLException e)
                    {
                        if(errOccured==false)
            {
            out.println("Cannot create test without all the required details!!!<br>Go back and Enter all details <a href='quizspecifications.jsp'>Click here</a>");
             errOccured=true;
            }
                    }
                }
                catch(NullPointerException e) 
                {
                    if(errOccured==false)
            {
            out.println("Cannot create test without all the required details!!!<br>Go back and Enter all details <a href='quizspecifications.jsp'>Click here</a>");
             errOccured=true;
            }
                }
            }
            else if(type==5)
            {
                try 
                {
                    int num_p = Integer.parseInt(request.getParameter("PtypeNum" + i));
                    int num_q = Integer.parseInt(request.getParameter("QtypeNum" + i));
                    for (int j = 1; j <= num_p; j++) 
                    {
                        p.add(request.getParameter("P" + i + "_" + j));
                        out.println("Adding =" + request.getParameter("P" + i + "_" + j));
                    }
                    for (int j = 1; j <= num_q; j++) 
                    {
                        q.add(request.getParameter("Q" + i + "_" + j));
                        out.println("Adding =" + request.getParameter("Q" + i + "_" + j));
                    }
                    
                } 
                catch (NullPointerException e) 
                {
                    if(errOccured==false)
            {
            out.println("Cannot create test without all the required details!!!<br>Go back and Enter all details <a href='quizspecifications.jsp'>Click here</a>");
             errOccured=true;
            }
                }
                try
                {
                    obj.addQue(type,i,"", marks, marksNeg, new ArrayList<>(p), new ArrayList<>(q));
                    try
                    {
                        
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con=DriverManager.getConnection("jdbc:mysql://localhost/eproctor","eproctor","shraonessk");
                        Statement s1=con.createStatement();
                        String que="select ExamId from Exam where Name='"+test_name+"' and Time='"+testTime+"' and Marks='"+total+"'";
                        ResultSet rs=s1.executeQuery(que);
                       
                        if(rs.next())
                        {
                            int ExamId=Integer.parseInt(rs.getString(1));
                   
                        s1=con.createStatement();
                        String ans="";//Fix a method to store ans
                        
                        que="insert into Question(ExamId,Description,Marks,NegativeMarks,Answer,TypeId)values('"+ExamId+"','"+""+"','"+marks+"','"+marksNeg+"','"+ans+"','"+5+"')";
                        int rs1=s1.executeUpdate(que);
                        }
                        else
                        	out.println("Cannot insert into database!");
                        
                    }
                    catch(SQLException e)
                    {
                        if(errOccured==false)
            {
            out.println("Cannot create test without all the required details!!!<br>Go back and Enter all details <a href='quizspecifications.jsp'>Click here</a>");
             errOccured=true;
            }
                    }
                }
                catch(NullPointerException e) 
                {
                    if(errOccured==false)
            {
            out.println("Cannot create test without all the required details!!!<br>Go back and Enter all details <a href='quizspecifications.jsp'>Click here</a>");
             errOccured=true;
            }
                }
            }
            //out.println("Printing p<br>");
            for(int k=0;k<p.size();k++)
                out.println(p.get(k)+"<br>");
            p.clear();
            q.clear();
        }
        if(errOccured==false)
            {
        //CREATE JSON FILE HERE
        Gson gson = new Gson();
        String jsonString = gson.toJson(obj);
        System.out.println("JSON string=" + jsonString);
        out.println("<br>" + jsonString);
        try {
            String paperName = test_name + ".json";
            File questionPaper = new File("exam/" + paperName);
            if (!questionPaper.exists()) {
                out.println("File does not exist! creating new file");
                questionPaper.createNewFile();

                }
            out.println("FIle exists!!!");
            FileWriter fw = new FileWriter(questionPaper);
            fw.write(jsonString);
            fw.close();
            response.setStatus(response.SC_MOVED_TEMPORARILY);
            response.setHeader("Location", "encrypt.jsp?paperName=" + paperName + "&exam_name=" + test_name);
        } catch (Exception e) {
            out.println(e.getMessage());
        }
    }

    %>
</html>

