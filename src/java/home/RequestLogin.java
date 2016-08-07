package home;

import dbConnection.DB_Connect;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author shravan
 */
public class RequestLogin extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, NoSuchAlgorithmException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        Connection con = null;
        con=DB_Connect.getDBConnection();
        Statement s = con.createStatement();
        MessageDigest alg = MessageDigest.getInstance("MD5");
        alg.reset();
        alg.update(password.getBytes());
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
        ResultSet rs = s.executeQuery("select Details.UserId,Test.ExamId from Test,Details where Details.Email=\"" + email + "\" and Details.Password=\"" + pass + "\" and Details.UserId=Test.StudentId and Details.Status=\""+1+"\"");
        if (rs.next()) {
            int userId=rs.getInt(1);
            
            out.println(userId);
        } else {
            out.println(0);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
           // Logger.getLogger(verify.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NoSuchAlgorithmException ex) {
          //  Logger.getLogger(RequestLogin.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
           //Logger.getLogger(verify.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NoSuchAlgorithmException ex) {
            //Logger.getLogger(RequestLogin.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
