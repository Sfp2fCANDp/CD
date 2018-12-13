package jflex;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java_cup.runtime.*;

public class Program {
	static HashMap<Integer, String> tokenClass = new HashMap<Integer, String> (); 
	
	public static void initHash()
	{
	
		tokenClass.put(sym.IF, "Keyword");
		tokenClass.put(sym.ELSE, "Keyword");
		tokenClass.put(sym.INT, "Keyword");
		tokenClass.put(sym.RETURN, "Keyword");
		tokenClass.put(sym.VOID, "Keyword");
		tokenClass.put(sym.WHILE, "Keyword");
		
		tokenClass.put(sym.ADD, "Operator");
		tokenClass.put(sym.SUB, "Operator");
		tokenClass.put(sym.MULT, "Operator");
		tokenClass.put(sym.DIV, "Operator");
		tokenClass.put(sym.LT, "Operator");
		tokenClass.put(sym.GT, "Operator");
		tokenClass.put(sym.LTOET, "Operator");
		tokenClass.put(sym.GTOET, "Operator");
		tokenClass.put(sym.DEQL, "Operator");
		tokenClass.put(sym.NOTEQL, "Operator");
		tokenClass.put(sym.EQL, "Operator");
		tokenClass.put(sym.SEMI, "Operator");
		tokenClass.put(sym.COMMA, "Operator");
		
		tokenClass.put(sym.LPAREN, "Operator");
		tokenClass.put(sym.RPAREN, "Operator");
		tokenClass.put(sym.LSQBKT, "Operator");
		tokenClass.put(sym.RSQBKT, "Operator");
		tokenClass.put(sym.LBRKT, "Operator");
		tokenClass.put(sym.RBRKT, "Operator");
		
		tokenClass.put(sym.ID, "Identifier");
		
		tokenClass.put(sym.NUMERIC_CONSTANT, "Numeric Constant");
		
		tokenClass.put(sym.WHITESPACE, "WhiteSpace");
		
		tokenClass.put(sym.STRING, "String");
	}
	public static void main(String[] args) {
		
			
			Program.initHash();
			FileReader inputFile;
			try {
				
				inputFile = new FileReader(new File("input.txt"));
				BufferedReader br = new BufferedReader(inputFile);
				LexerCMinus l = new LexerCMinus (br);
				
				try {
					Symbol sCrt;
					do 
					{
						sCrt = l.next_token();
											
						if (sCrt.sym != sym.EOF)
						{
							System.out.println("Symbol value: "+ l.yytext() + " Class: " + Program.tokenClass.get(sCrt.sym) +  " line: " + sCrt.left + " column: " + sCrt.right);
						}
					}while(sCrt.sym != sym.EOF);
					System.out.println("EOF");
				} catch (IOException e) {
					e.printStackTrace();
				}
				
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			}
			
		}

	}


