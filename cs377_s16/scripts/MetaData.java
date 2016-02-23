import java.sql.*;

public class MetaData 
{
   public static void main (String args[]) 
   {
      String url = "jdbc:mysql://localhost:3306/";
      String dbName = "companyDB";
      String userName = "cs377";
      String password = "abc123";
      String sslVer = "?useSSL=false";

      try 
      {
         // Load the MySQL JDBC driver
	     Class.forName("com.mysql.jdbc.Driver");
      } 
      catch (Exception e) 
      {
         System.out.println("Failed to load JDBC driver.");
         return;
      }

      // Connect to the database
      Connection conn = null;
      Statement stmt = null;

      try 
      {
         conn = DriverManager.getConnection(url + dbName + sslVer,userName,password);
         stmt = conn.createStatement ();
      } 
      catch (Exception e) 
      {
         System.err.println("problems connecting to " + url+dbName);
      }

      try 
      {
         ResultSet result = stmt.executeQuery("select * from employee");

         ResultSetMetaData meta = result.getMetaData();

         int NCols = meta.getColumnCount();

         System.out.println ("Types codes: ");
         System.out.println ("    String: " + Types.CHAR);
         System.out.println ("    INT: " + Types.INTEGER);
         System.out.println ("    DECIMAL: " + Types.DECIMAL + "\n");

         System.out.println ("Name    TypeCode   TypeName  DispSz  Scale  Precis   ClassName");
         System.out.println ("-----------------------------------------------");
         for (int i = 1; i <= NCols; i++) 
	 {
            System.out.println (meta.getColumnLabel(i) + "\t"
				+ meta.getColumnType(i) + "\t" + "   "
				+ meta.getColumnTypeName(i) + "\t"
				+ meta.getColumnDisplaySize(i) + "\t"
				+ meta.getScale(i) + "\t"
				+ meta.getPrecision(i) + "\t"
				+ meta.getColumnClassName(i) + "\t"
				);
         }

         conn.close();
      }
      catch (Exception e) 
      {
         System.out.println(e.getMessage()); // Print the error message
//       e.printStackTrace();                // Print the stack
      }
   }
}
