
import java.lang.reflect.*;

public class DynamicLoader
{
   public static void main(String[] args) throws Exception
   {
      /* ============================================
	 Load the class (name is given in argv[0])
         ============================================ */
      Class toRun = Class.forName(args[0]);

      String[] param = { "1", "2" } ;
      Object[] Args = { param };      // This is the type of args for main

      /* ============================================
	 Find the main method in the loaded class...
         ============================================ */
      Method mainMethod = findMain(toRun);

      /* ============================================
         Execute it...
         ============================================ */
      mainMethod.invoke( null, Args  );
   }
   private static Method findMain(Class clazz) throws Exception
   {
      Method[] methods = clazz.getMethods();
      for (int i=0; i<methods.length; i++)
      {
         if (methods[i].getName().equals("main"))
            return methods[i];
      }
      return null;
   }
}


