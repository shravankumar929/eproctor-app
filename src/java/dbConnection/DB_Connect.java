package dbConnection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author shravan
 */
public class DB_Connect 
{
   
   
    // JDBC driver name
    static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    
    public DB_Connect(){ }
    
    public synchronized static Connection getDBConnection()
    {
         Connection con = null;
        
        try 
        {
            Class.forName("com.mysql.jdbc.Driver");
        } catch(ClassNotFoundException e) 
        {
            System.out.println("Could not load driver class "+e);
        }
        try {
          
             con = DriverManager.getConnection("jdbc:mysql://localhost:3306/eproctor","eproctor","");
        } catch (SQLException e) {
            System.out.println("Could not get connection "+e);
        }
        return con;
    }
    
    public synchronized static void closeDBConnection(Connection con)
    { 
        if(con != null)
        {
            try{
                con.close();
                con = null;
            } catch(SQLException e){
                System.out.println("Couldn't close connection "+e);
            }
        }
    }
    
    public synchronized static void closeStatement(Statement stmt){
        if(stmt != null)
        {
            try{
                stmt.close();
                stmt = null;
                
            } catch(SQLException e){
                System.out.println("Couldn't close statement" +e);
            }
        }
    }
    
    public synchronized static void closePStatement(PreparedStatement pstmt){
        if(pstmt != null)
        {
            try{
                pstmt.close();
                pstmt = null;
                
            } catch(SQLException e){
                System.out.println("Couldn't close Prepared Statement "+ e);
                
            }
        }
    }
    
    public synchronized static void closeResultSet(ResultSet res){
        if(res != null)
        {
            try{
                res.close();
                res = null;
            } catch(SQLException e){
                System.out.println("Couldn't close Result Set" + e);
            }
        }
    }
    public synchronized static boolean isClosed(Connection con){
        boolean isClosed = false;
        try{
            if(con == null || con.isClosed())
            {
                isClosed = true;
            }
        } catch(Exception e){
            e.printStackTrace();
        }
        return isClosed;
    }
}
