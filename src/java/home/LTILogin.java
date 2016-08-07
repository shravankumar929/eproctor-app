package home;

import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
public class LTILogin extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, NoSuchAlgorithmException {
        response.setContentType("text/html;charset=UTF-8");
        
        try (PrintWriter out = response.getWriter()) {
           String userId=request.getParameter("user_id");
           
           String role=request.getParameter("roles");
           String emailId=request.getParameter("lis_person_contact_email_primary");
           String oauth_consumer_key=request.getParameter("oauth_consumer_key");
           
           String lis_result_sourcedid=request.getParameter("lis_result_sourcedid");
           out.println("1="+lis_result_sourcedid);
           String lis_outcome_service_url=request.getParameter("lis_outcome_service_url");
            out.println("2="+lis_outcome_service_url);
          // int custom_test_id=Integer.parseInt(request.getParameter("custom_test_id"));
           //out.println("3="+custom_test_id);
           String back_url =request.getParameter("back_url");
           
          
           out.println("userid="+userId);
           String UserId=request.getParameter("id");
           Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost/eproctor", "eproctor", "shraonessk");
            
            Statement s = con.createStatement();
            int r;
            try
            {
                r=s.executeUpdate("insert into LTI(oauth_consumer_key,lis_result_sourcedid,lis_outcome_service_url,back_url,LTI_UserId)values('"+oauth_consumer_key+"','"+lis_result_sourcedid+"','"+lis_outcome_service_url+"','"+back_url+"','"+userId+"')");
            }
            catch(Exception e)
            {
                out.println(e.getMessage());
            }
            ResultSet rs=s.executeQuery("select LTI_UserId from Details where LTI_UserId='"+userId+"'");
            if(!rs.next())
            {   out.println(role);
                r=s.executeUpdate("update Details set LTI_UserId='"+userId+"' where Email='"+emailId+"'");
            }
            rs=s.executeQuery("select LTI_UserId from Details where LTI_UserId='"+userId+"'");
            if(true)
            {
                HttpSession session=request.getSession();
                if(role.equals("Administrator"))
                {
                    /*
                    MessageDigest alg = MessageDigest.getInstance("MD5");
                alg.reset();
                alg.update(fpassword.getBytes());
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
                String pass = hashedpasswd.toString();
                    
                    
                    */
                    session.setAttribute("role","Admin");
                    session.setAttribute("firstName",emailId);
                    session.setAttribute("name",emailId);
                    session.setAttribute("password","z");
                   
                    response.sendRedirect("admin/adminIndex.jsp");
                }
                else if(role.equals("Teacher"))
                {
                    session.setAttribute("role","Teacher");
                    session.setAttribute("firstName",emailId);
                    session.setAttribute("name",emailId);
                    session.setAttribute("password","z");
                    response.sendRedirect("teacher/teacherIndex.jsp");
                }
                else if(role.equals("Student"))
                {
                    session.setAttribute("role","Student");
                    session.setAttribute("firstName",emailId);
                    session.setAttribute("name",emailId);
                    session.setAttribute("password","z");
                    response.sendRedirect("student/studentResults.jsp");
                }
                
            }
           
               // response.sendRedirect("registration.jsp");
          
            

        } catch (ClassNotFoundException ex) {
            out.println("Exception ="+ex.getMessage());

        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(LTILogin.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(LTILogin.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(LTILogin.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(LTILogin.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
