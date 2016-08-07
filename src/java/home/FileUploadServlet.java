package home;

import dbConnection.DB_Connect;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author shravan
 */
public class FileUploadServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // location to store file uploaded
    private static final String UPLOAD_DIRECTORY = "/eproctor/upload";

    // upload settings
    private static final int MEMORY_THRESHOLD = 1024 * 1024 * 3; 	// 3MB
    private static final int MAX_FILE_SIZE = (1024 * 1024)/2; // 500KB
    private static final int MAX_REQUEST_SIZE = 1024 * 1024; // 1MB

    /**
     * Upon receiving file upload submission, parses the request to read upload
     * data and saves the file on disk.
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, FileUploadException {
        response.setContentType("text/html;charset=UTF-8");
        String fileStore=null;
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            if (!ServletFileUpload.isMultipartContent(request)) {
                // if not, we stop here
                PrintWriter writer = response.getWriter();
                writer.println("Error: Form must has enctype=multipart/form-data.");
                writer.flush();
                return;
            }
            //out.println("Name===" + request.getParameter("fname"));

            // configures upload settings
            DiskFileItemFactory factory = new DiskFileItemFactory();
            // sets memory threshold - beyond which files are stored in disk 
            factory.setSizeThreshold(MEMORY_THRESHOLD);
            // sets temporary location to store files
            factory.setRepository(new File(System.getProperty("java.io.tmpdir")));

            ServletFileUpload upload = new ServletFileUpload(factory);
            
           // List<FileItem> uploadItems = upload.parseRequest(request);
            /*
            for (FileItem uploadItem : uploadItems) {
                if (uploadItem.isFormField()) {
                    String fieldName = uploadItem.getFieldName();
                    String value = uploadItem.getString();
                   // out.println(fieldName + "=" + value);
                }
            }
            */
            //String email = uploadItems.get(4).getString(); 
            // sets maximum size of upload file
            upload.setFileSizeMax(MAX_FILE_SIZE);

            // sets maximum size of request (include file + form data)
            upload.setSizeMax(MAX_REQUEST_SIZE);

            // constructs the directory path to store upload file
            // this path is relative to application's directory
            String uploadPath = getServletContext().getRealPath("")+"/upload";

            // creates the directory if it does not exist
            
            List<FileItem> formItems=null;
            try
            {
           
            formItems = upload.parseRequest(request);
            }
            catch(Exception e)
            {
                response.setStatus(response.SC_MOVED_TEMPORARILY);
                response.setHeader("Location", "registration.jsp?msg=2");
            }
            String email = formItems.get(4).getString(); 
            File uploadDir = new File(uploadPath+File.separator+formItems.get(4).getString());
            if (!uploadDir.exists()) {
                out.println("File does not exist!");
                uploadDir.mkdir();
                out.println("Created dir");
            }
           
            try {
                // parses the request's content to extract file data
                
                
                
                if (formItems != null && formItems.size() > 0) {
                    // iterates over form's fields
                    for (FileItem item : formItems) {
                        // processes only fields that are not form fields
                        if (!item.isFormField()) {
                            String fileName = new File(item.getName()).getName();
                            int index=fileName.lastIndexOf(".");
                            String fileUser=email+fileName.substring(index);
                            String filePath = uploadPath + File.separator +formItems.get(4).getString()+File.separator+fileUser;
                            fileStore=UPLOAD_DIRECTORY+ File.separator +formItems.get(4).getString()+File.separator+fileUser;
                            File storeFile = new File(filePath);
                            out.println("File path="+filePath);
                            out.println("fileStore="+fileStore);
                            // saves the file on disk
                            item.write(storeFile);
                            //request.setAttribute("message","Upload has been done successfully!");
                            

                        }
                    }
                }
                //Store in database
                try {

//Establishing connection with back end database
                Connection con = null;
                con=DB_Connect.getDBConnection();
                //Statement s = con.createStatement();
                //Getting the various parameters which have been given by the user.
                String role= formItems.get(0).getString(); 
                String fname = formItems.get(1).getString(); 
                String mname = formItems.get(2).getString(); 
                String lname = formItems.get(3).getString(); 
                
                String passwd = formItems.get(5).getString(); 
                String sql = "select * from Details where Email=?";
                PreparedStatement ps = con.prepareStatement(sql);

                ps.setString(1,email);
                ResultSet rs = ps.executeQuery();
               // ResultSet rs = s.executeQuery("select * from Details where Email='" + email + "'");
                //out.println(rs.next());
                if (rs.next()) {
                    response.setStatus(response.SC_MOVED_TEMPORARILY);
                    response.setHeader("Location", "registration.jsp?msg=1");

                } 
                else {

                    MessageDigest alg = MessageDigest.getInstance("MD5");

                    // Reset the digest, in case it's been used already during this section of code
                    // This probably isn't needed for pages of 210 simplicity
                    alg.reset();

                    // Calculate the md5 hash for the password. md5 operates on bytes, so give
                    // MessageDigest the byte verison of the string
                    alg.update(passwd.getBytes());

                    // Create a byte array from the string digest
                    byte[] digest = alg.digest();

                    // Convert the hash from whatever format it's in, to hex format
                    // which is the normal way to display and report md5 sums
                    // This is done byte by byte, and put into a StringBuffer
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

                    // Print out the string hex version of the md5 hash
                    //out.println("MD5 version is: " + hashedpasswd.toString() + "<br>");
                    if (role != null) {
                        
                        //String qry1 = "insert into Details(Email,Role,Fname,Lname,Password,Status,mname,photo) values('" + email + "','" + role + "','" + fname + "','" + lname + "','" + hashedpasswd.toString() + "','" + 0 + "','" + mname + "','/"+fileStore+"')";//Inserting into the table resgistration.
                        String qry = "insert into Details(Email,Role,Fname,Lname,Password,Status,mname,photo) values(?,?,?,?,?,?,?,?)";
                        ps = con.prepareStatement(qry);
                        
                        ps.setString(1,email);
                        ps.setString(2,role);
                        ps.setString(3,fname);
                        ps.setString(4,lname);
                        ps.setString(5,hashedpasswd.toString());
                        ps.setInt(6,0);
                        ps.setString(7,mname);
                        ps.setString(8,fileStore);
                        ps.executeUpdate();
                        //s.executeUpdate(qry);
                        response.setStatus(response.SC_MOVED_TEMPORARILY);
                        response.setHeader("Location", "registration.jsp?msg=0");
                    }
                    con.close();
                }

            } catch (Exception e) {
                e.printStackTrace();
                out.println(e.getMessage());
            }
                
                
                
            } 
            catch (Exception ex) 
            {
                out.println(ex.getMessage());
                //request.setAttribute("message","There was an error: " + ex.getMessage());
               // response.setStatus(response.SC_MOVED_TEMPORARILY);
               // response.setHeader("Location", "registration.jsp?msg=3");//denotes image upload error
            }
            // redirects client to message page
            // getServletContext().getRequestDispatcher("/message.jsp").forward(request, response);
            
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
        } catch (FileUploadException ex) {
            Logger.getLogger(FileUploadServlet.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (FileUploadException ex) {
            Logger.getLogger(FileUploadServlet.class.getName()).log(Level.SEVERE, null, ex);
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
