package home;

import dbConnection.DB_Connect;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Enumeration;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author shravan
 */
public class verifyImage extends HttpServlet {
   static final String SAVE_DIR = "verify/";
    static final int BUFFER_SIZE = 4096;
     
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
         System.out.println("Got a request from====");
       try {
           // Gets file name for HTTP header
          // String exam_name=request.getParameter("exam_name");
          String fileName = request.getHeader("fileName");//here fileName is email of the student
          String Filenames[]=new String[2];
          Filenames=fileName.split("~");
          fileName=Filenames[0];
          String exam_name=Filenames[1];
          String file=fileName;
          //String file=fileName;
         // File("C:\\Directory1").mkdir();
          //File("C:\\Directory2\\Sub2\\Sub-Sub2").mkdirs()
           boolean tmp=new File(SAVE_DIR+file).mkdir();
          // if(!tmp.exists())
              // tmp.createNewFile();
           File saveFile = new File(SAVE_DIR+file+"/"+fileName);
           if(!saveFile.exists())
               saveFile.createNewFile();
           // prints out all header values
           System.out.println("===== Begin headers =====");
           Enumeration<String> names = request.getHeaderNames();
           while (names.hasMoreElements()) {
           String headerName = names.nextElement();
           System.out.println(headerName + " = " + request.getHeader(headerName));
           }
           System.out.println("===== End headers =====\n");
           
           // opens input stream of the request for reading data
           InputStream inputStream = request.getInputStream();
           
           // opens an output stream for writing file
           FileOutputStream outputStream = new FileOutputStream(saveFile);
           
           byte[] buffer = new byte[BUFFER_SIZE];
           int bytesRead = -1;
           System.out.println("Receiving data...");
           
           while ((bytesRead = inputStream.read(buffer)) != -1) {
               outputStream.write(buffer, 0, bytesRead);
               
           }
           
           System.out.println("Data received.");
           outputStream.close();
           inputStream.close();
           response.getOutputStream().write(1);
           System.out.println("File written to: " + saveFile.getAbsolutePath());
           
           // sends response to client
           //response.getWriter().print("UPLOAD DONE");
           
           
          /*
           Code for extracting zip file and save in the folder
          */
          
          
          String zipFilePath=SAVE_DIR+file+"/"+fileName;
         // String destDirectory=SAVE_DIR+file+"/"+file;
          //String destDirectory=SAVE_DIR+file;//add full path 
          String destDirectory=SAVE_DIR+file;
          File destDir = new File(destDirectory);
        if (!destDir.exists()) {
            destDir.mkdir();
        }
        ZipInputStream zipIn = new ZipInputStream(new FileInputStream(zipFilePath));
        ZipEntry entry = zipIn.getNextEntry();
        // iterates over entries in the zip file
        while (entry != null) {
            String filePath = destDirectory + File.separator + entry.getName();
            System.out.println("FilePath=>"+filePath);
            if (!entry.isDirectory()) {
                // if the entry is a file, extracts it
                extractFile(zipIn, filePath);
            } else {
                // if the entry is a directory, make the directory
                File dir = new File(filePath);
                dir.mkdir();
            }
            zipIn.closeEntry();
            entry = zipIn.getNextEntry();
        }
        zipIn.close();
          /// Class.forName("com.mysql.jdbc.Driver");
          // Connection con=DriverManager.getConnection("jdbc:mysql://localhost/eproctor","eproctor","shraonessk");
          // Statement s1=con.createStatement();
          /// String query1="update log set Image=\""+fileName+"\" where email=\""+fileName+"\"";
          // ResultSet rs1=s1.executeQuery(query1);
          
          //insert into database
          
          try
          {
          Connection con = null;
                con=DB_Connect.getDBConnection();
            Statement s = con.createStatement();
            System.out.println(file);
            System.out.println(exam_name);
            String examName=exam_name.substring(0,exam_name.lastIndexOf("."));
            ResultSet rs=s.executeQuery("select ExamId from Exam where Name='"+examName+"'");
            if(rs.next())
            {
                int exam_id=rs.getInt(1);
                int r=s.executeUpdate("insert into Log(Email,Description,ExamId) values('"+file+"','Suspicious Activity Found!','"+exam_id+"')");
                //int r=s.executeUpdate("update Log set Email='"+email+"' and ExamId='"+exam_id+"' and Description='Cheated!'");
            }
          }
          catch(Exception ee)
          {
              System.out.println(ee.getMessage());
          }

       } 
      // catch (ClassNotFoundException ex) 
       //{
          // Logger.getLogger(verifyImage.class.getName()).log(Level.SEVERE, null, ex);
       //} 
       catch (Exception ex) 
       {
       	   //response.getOutputStream().write(0);
           System.out.println(ex.getMessage());
          // Logger.getLogger(verifyImage.class.getName()).log(Level.SEVERE, null, ex);
       }
    }
    private void extractFile(ZipInputStream zipIn, String filePath) throws IOException {
        BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(filePath));
        byte[] bytesIn = new byte[BUFFER_SIZE];
        int read = 0;
        while ((read = zipIn.read(bytesIn)) != -1) {
            bos.write(bytesIn, 0, read);
        }
        bos.close();
    }
}
