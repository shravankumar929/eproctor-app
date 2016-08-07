package home;
import dbConnection.DB_Connect;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class registerStudent extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
           
            String email = request.getParameter("email");
            String passwd = request.getParameter("password");
            String mac=request.getParameter("mac");
           
            MessageDigest alg = MessageDigest.getInstance("MD5");
                alg.reset();
                alg.update(passwd.getBytes());
                byte[] digest = alg.digest();
                StringBuffer hashedpasswd = new StringBuffer();
                    String hx;
                    for (int i = 0; i < digest.length; i++) {
                        hx = Integer.toHexString(0xFF & digest[i]);
                        //0x03 is equal to 0x3, but we need 0x03 for our md5sum
                        if (hx.length() == 1) {
                            hx = "0" + hx;
                        }
                        hashedpasswd.append(hx);
                    }
            String pass=hashedpasswd.toString();
             Connection con = null;
                con=DB_Connect.getDBConnection();
             Statement s1=con.createStatement();
             String que="select Test.StudentId from Test,Details where Details.Email='"+email+"' and Details.Password='"+pass+"' and Test.StudentId=Details.UserId";
             
             ResultSet rs1=s1.executeQuery(que);
             // dislpay the details of all invigilators in the form of a table so that admin can allot centres according to the invigilator's city and locality
             if (rs1.next() )
             {
             	que="select * from Test where MacId='"+mac+"'";
             	ResultSet rs2=s1.executeQuery(que);
             	if(!rs2.next())
             	{
             	que="update Test set MacId='"+mac+"' where StudentId='"+rs1.getInt(1)+"'";
                int rs=s1.executeUpdate(que);
                out.println(1);
                }
                else
                	out.println(0);//sends 0 if mac is already registered
             }
             else
             {
                 out.println(0);
             }
             
            
        } catch (Exception ex) {
                out.println(ex.getMessage());
        }
    }
}
