package home;

import dbConnection.DB_Connect;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class downloadPaperKey extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        FileInputStream fis=null;
        String email=request.getParameter("email");
        String mac = request.getParameter("mac");
        String exam_name=request.getParameter("exam_name");
        int exam_id=Integer.parseInt(request.getParameter("exam_id"));
        Connection con = null;
        con=DB_Connect.getDBConnection();
        Statement s = con.createStatement();
        ResultSet rs = s.executeQuery("select * from Test where MacId=\"" + mac + "\" and exam_start='0' and ExamId='"+exam_id+"'");
        if (rs.next()) {
            try {
                
                //isr = new InputStreamReader(this.getClass().getClassLoader().getResourceAsStream("QuestionPaper.json"));
                fis = new FileInputStream(new File("exam/"+exam_name+"_Ans"+ ".json.txt"));
                int i;
                char c;
                while ((i = fis.read()) != -1) {
                    c = (char) i;
                    out.write(c);
                }
                rs = s.executeQuery("select UserId from Details where Email=\"" + email + "\"");
                if (rs.next())
                {
                    int userId=rs.getInt(1);
                    int r=s.executeUpdate("update Test set exam_start='0' where Test.StudentId='"+userId+"' and Test.ExamId='"+exam_id+"'");
                }
            } catch (Exception e) {
                out.println(e.getMessage());
            }
        } else {
            out.println("0");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            //Logger.getLogger(verify.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            //Logger.getLogger(verify.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
