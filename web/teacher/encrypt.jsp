<%@page import="home.AES"%>
<%@page import="javax.crypto.spec.SecretKeySpec"%>
<%
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>

<%@ page import="java.io.*,java.util.*, javax.servlet.*,java.sql.*,java.io.*,java.lang.*,javax.crypto.*,java.math.*,java.security.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<HTML>
     <%
        if ((session.getAttribute("name")) != null && (session.getAttribute("password") != null) && (session.getAttribute("role").equals("Teacher"))) {
    %>
    <HEAD>

        <title>eProctor</title>

    </HEAD>
    
    <BODY>

        <%
            String fileName = request.getParameter("paperName");
            String exam_name = request.getParameter("exam_name");
            String ansPaperName=request.getParameter("ansPaperName");
            String text=null,text1=null;
            try {

                int read;
                FileInputStream fis = new FileInputStream(new File("exam/" + fileName));
                File outfile = new File("exam/" + fileName + ".txt");// initialises the output file which is a .o file
                if (!outfile.exists()) {
                    outfile.createNewFile(); // create a new object file with name same as the invigilator's id
                }
                String key = "Bar12345Bar12345";
                // Create key and cipher
                Key aesKey = new SecretKeySpec(key.getBytes(), "AES");
                Cipher cipher = Cipher.getInstance("AES");
                // encrypt the text
                cipher.init(Cipher.ENCRYPT_MODE, aesKey);
                BufferedReader br = new BufferedReader(new FileReader("exam/" + fileName));
                try {
                    StringBuilder sb = new StringBuilder();
                    String line = br.readLine();

                    while (line != null) {
                        sb.append(line);
                        sb.append(System.lineSeparator());
                        line = br.readLine();
                    }
                    text = sb.toString();
                } finally {
                    br.close();
                }
                //AES encrypt=new AES();
               // final String strToEncrypt = "My text to encrypt";
                final String strPssword = "Bar12345Bar12345";
                AES.setKey(strPssword);

                AES.encrypt(text.trim());

                System.out.println("String to Encrypt: " + text);
                System.out.println("Encrypted: " + AES.getEncryptedString());

                final String strToDecrypt =  AES.getEncryptedString();
                AES.decrypt(strToDecrypt.trim());
                System.out.println("Enctrypted====>"+strToDecrypt);
                FileOutputStream fos = new FileOutputStream(outfile);
                fos.write(strToDecrypt.getBytes());
                
                
                
                
                
                
                
                //Encrypt answer paper also
                fis.close();
                fis = new FileInputStream(new File("exam/" + ansPaperName));
                outfile = new File("exam/" + ansPaperName + ".txt");// initialises the output file which is a .o file
                if (!outfile.exists()) {
                    outfile.createNewFile(); // create a new object file with name same as the invigilator's id
                }
                br = new BufferedReader(new FileReader("exam/" + ansPaperName));
                try {
                    StringBuilder sb = new StringBuilder();
                    String line = br.readLine();

                    while (line != null) {
                        sb.append(line);
                        sb.append(System.lineSeparator());
                        line = br.readLine();
                    }
                    text1 = sb.toString();
                } finally {
                    br.close();
                }
                //AES encrypt=new AES();
               // final String strToEncrypt = "My text to encrypt";
                //strPssword = "Bar12345Bar12345";
                AES.setKey(strPssword);

                AES.encrypt(text1.trim());

                System.out.println("String to Encrypt(Ans Paper): " + text1);
                System.out.println("Encrypted: " + AES.getEncryptedString());

                final String strToDecrypt1 =  AES.getEncryptedString();
                AES.decrypt(strToDecrypt1.trim());
                System.out.println("Enctrypted====>"+strToDecrypt1);
                fos = new FileOutputStream(outfile);
                fos.write(strToDecrypt1.getBytes());
                /*
                byte[] encrypted = cipher.doFinal(strToDecrypt.getBytes());
                System.err.println(new String(encrypted));
                FileOutputStream fos = new FileOutputStream(outfile);
                fos.write(encrypted);
                */
                
                System.out.println(AES.getDecryptedString());
                /*
                
                Cipher encipher = Cipher.getInstance("AES");
                KeyGenerator kgen = KeyGenerator.getInstance("AES");
                kgen.init(128);
                SecretKey skey = kgen.generateKey();

                byte[] encoded = skey.getEncoded();
                String data = new BigInteger(1, encoded).toString(16);//the variable 'data' contains the encryption/decryption key
                
                //creating a CSV file and writing the encryption key in it
                FileWriter fw = new FileWriter("exam/" + "k$" + fileName + ".csv");
                fw.append(data);
                fw.append(",");

                fw.flush();
                fw.close();
                //creation of CSV file complete encryption process continues
                encipher.init(Cipher.ENCRYPT_MODE, skey);
                CipherInputStream cis = new CipherInputStream(fis, encipher);
                String paper = "";
                while ((read = cis.read()) != -1) 
                {
                    System.out.println("123");
                    fos.write((char) read);
                    paper += (char) read;
                    fos.flush();
                }
                fos.close();
                 */
                
                //WRITE PAPER INTO DATABASE
                /*
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost/eproctor", "eproctor", "shraonessk");
                Statement s1 = con.createStatement();
                String query1 = "insert into Exam_Paper values(\"" + exam_name + "\",\"" + paper + "\"";
                out.println(query1);
                int rs1 = s1.executeUpdate(query1);
                //encryption ends, the .o file is successfully created and saved at desired location
                */
                response.sendRedirect("createExam.jsp");
               
        } 
        catch (Exception ex) 
        {
            System.out.println(ex);
            response.sendRedirect("createExam.jsp");
        }


        %>
    </BODY>

    <% 
    } else 
    {
        response.sendRedirect("/index.jsp");
    }
    %>

</HTML>
