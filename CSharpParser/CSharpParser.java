import java.io.*;
import java.util.*;
import java.lang.ClassCastException;
import java_cup.runtime.*;
import Cls.Unit.*;
import Cls.Decl.Mod.*;

/**
 * Simple test driver for the java parser. Just runs it on some
 * input files, gives no useful output.
 */
public class CSharpParser {
  public static void main(String argv[]) {
     try {
            CSharpLexer s = new CSharpLexer(new FileReader(argv[0]));
            parser p = new parser(s);
            Unit u = null;
            u = (Unit)p.parse().value;
            CSharpFile f = new CSharpFile();
            f.parse_tree = u;
            f.Test();
            
            System.out.println("--- End ---");
    }
      catch (Exception e) {
        e.printStackTrace(System.out);
      }
  }
}
