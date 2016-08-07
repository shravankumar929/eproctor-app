package home;

import dbConnection.DB_Connect;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author shravan
 */
public class RegisteredExams extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
           try {
            /*Establishing connection with the back end Ms-Access database named 'one'*/
            //String email = request.getParameter("email");
            String userId=request.getParameter("userId");
            //out.println("Email="+email);
            //out.println("<br>Password=" + passwd);
            
             Connection con = null;
                con=DB_Connect.getDBConnection();
             Statement s1=con.createStatement();
             
             String query2="select Test.ExamId,Exam.Name,Test.Time from Test,Exam where Test.ExamId=Exam.ExamId and StudentId=\'"+userId+"\'";
             ResultSet rs2 = s1.executeQuery(query2);
             boolean found=false;
             String examList=null;
            while(rs2.next())
            {
                found=true;
                if(examList==null)
                    examList=rs2.getString(1)+"|"+rs2.getString(2)+"|"+rs2.getString(3);
                else
                    examList="~"+rs2.getString(1)+"|"+rs2.getString(2)+"|"+rs2.getString(3);
               // out.println(rs2.getString(1)+"|"+rs2.getString(2)+"|"+rs2.getString(3));//Examid:ExamName:ExamTime
            }
             out.println(examList);
             if(!found)
             {
                 out.println("0");
             }
             
            
        } catch (Exception ex) {
                out.println(ex.getMessage());
        }
        }
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
