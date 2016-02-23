/*
 * This sample shows how to list all the names from the EMPLOYEE table
 */

// You need to import the java.sql package to use JDBC
import java.sql.*;

public class Employee3
{
  public static void main (String args []) throws Exception
  {

     String url = "jdbc:mysql://localhost:3306/";
     String dbName = "companyDB";
     String userName = "cs377";
     String password = "abc123";
     String sslVer = "?useSSL=false";

     // Load the Oracle JDBC driver
     Class.forName("com.mysql.jdbc.Driver");

     // Connect to the database
     Connection conn = null;
     conn = DriverManager.getConnection(url+dbName + sslVer,userName,password);


     // Create a Statement
     Statement stmt = conn.createStatement ();

     // Select the ENAME column from the EMP table
     ResultSet rset = stmt.executeQuery ("select * from employee");

     // Iterate through the result and print the employee names
     while (rset.next ())
     {
          System.out.println (rset.getString (1) + " " 
			       + rset.getString (2) + " "
			       + rset.getString (3) + " "
			       + rset.getString(4)
			     );
     }

     /* =================================== */
     System.out.println("============================");
     System.out.println("Goto last row and get number of rows ===");

     rset.last();
     int nRows = rset.getRow();

     System.out.println("\nNumber of rows = " + nRows + "\n");

     System.out.println("============================");
     System.out.println("Read in reverse order ===");

     rset.afterLast(); //Moves the curser to the end of the ResultSet object
     while(rset.previous())
     {
          System.out.println (rset.getString (1) + " " 
                      + rset.getString (2) + " "
                      + rset.getString (3) + " "
                      + rset.getString(4)
                    );
     }

     // Close the ResultSet
     rset.close();

     // Close the Statement
     stmt.close();

     // Close the connection
     conn.close();   
  }
}
