/* UserCode section */

/* Imported packages */
import java.util.*;
import java_cup.runtime.*;

%%

/* Options and declarations section */ 

/* Makes the generated class public witch the name "CSharpLexer" and 
 * to write the generated code to a file "CSharpLexer.java"
 */  
%public
%class CSharpLexer

/* Make the generated class implement "sym" interface */
%implements sym

/* Cause the generated scanner to use the full 16 bit Unicode
 * input character set (character codes 0-65535)
 */
%unicode

/* Turns line and column counting on */
%line
%column

/* Enable the CUP compatibility mode to interface with a CUP generated class */
%cup

%{
	
	int nComments = 0;
	Stack stackBCC = new Stack();
  StringBuffer string = new StringBuffer();
  
  public int getComments() {
	  return nComments;
  }
  
  public int getFirstCommentClass() {
		return ((Integer)stackBCC.pop()).intValue();
  }
  
  private Symbol symbol(int type) {
	  return new Symbol(type, yyline + 1, yycolumn + 1);
  }

  private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline + 1, yycolumn + 1, value);
  }
  
%}

/* Main character classes */
/* line and paragraph separator (\u2028, \u2029) */
LineTerminator 			= \r | \n | \r\n | \u2028 | \u2029
WhiteSpace 		 			= {LineTerminator} | [ \t\v\f]
InputCharacter 			= [^\r\n\u2028\u2029]

/* Comments */
EndOfLineComment 	 	= "//" {InputCharacter}* {LineTerminator}

/* Identifiers */
Identifier = ("@" | [:jletter:]) [:jletterdigit:]*

/* Decimal literals */
DecimalIntegerLiteral	= {DecimalDigit}+ {IntegerSuffix}
DecimalDigit 					= [0-9]
IntegerSuffix 				= {USuffix}? {LSuffix}?
USuffix 							= [Uu]
LSuffix 							= [Ll]

/* Hexadecimal literals */
HexadecimalIntegerLiteral = 0 [xX] {HexaDigit}+
HexaDigit          				= [0-9a-fA-F]

/* Floating point literals */        
FloatLiteral  = {FloatLiteral1} | {FloatLiteral2} | {FloatLiteral3} | {FloatLiteral4}
FloatLiteral1 = {DecimalDigit}+ \. {DecimalDigit}+ {Exponent}? {FloatSuffix}?
FloatLiteral2 = \. {DecimalDigit}+ {Exponent}? {FloatSuffix}?
FloatLiteral3 = {DecimalDigit}+ {Exponent} {FloatSuffix}?
FloatLiteral4 = {DecimalDigit}+ {FloatSuffix}
Exponent 			= [eE] [+-]? {DecimalDigit}+
FloatSuffix 	= [FfDdMm] 

/* String and character literals */
StringCharacter = [^\r\n\u2028\u2029\"\\]
SingleCharacter = [^\r\n\u2028\u2029\'\\]

/* Unicode escape sequence */
UnicodeSequence  = {UnicodeSequence1} | {UnicodeSequence2}
UnicodeSequence1 = "\\u" {HexaDigit}{4}
UnicodeSequence2 = "\\U" {HexaDigit}{8}

%state STATE_STRING, STATE_CHAR, COMMENT

%%

/* Lexical rules */

<YYINITIAL> {
  /* Whitespace */
  {WhiteSpace} 										{ /* ignore */ }

  /* Comments */
  {EndOfLineComment}             	{ nComments++; }
  "/*"														{ nComments++; yybegin(COMMENT); }

  /* Keywords */
  "abstract"                     	{ return symbol(T_ABSTRACT); }
  "add"		                       	{ return symbol(T_ADD); }
  "as"			                    	{ return symbol(T_AS); }
  "assembly"			            		{ return symbol(T_ASSEMBLY); }
  "base"  		                   	{ return symbol(T_BASE); }
  "bool"	    	                	{ return symbol(T_BOOL); }
  "break"                        	{ return symbol(T_BREAK); }
  "byte"                         	{ return symbol(T_BYTE); }
  "case"                         	{ return symbol(T_CASE); }
  "catch"                        	{ return symbol(T_CATCH); }
  "char"                         	{ return symbol(T_CHAR); }
  "checked"                      	{ return symbol(T_CHECKED); }
  "class"                        	{ stackBCC.push(new Integer(nComments)); return symbol(T_CLASS); }
  "const"                        	{ return symbol(T_CONST); }
  "continue"                     	{ return symbol(T_CONTINUE); }
  "decimal"                      	{ return symbol(T_DECIMAL); }
  "default"                      	{ return symbol(T_DEFAULT); }
  "delegate"                     	{ return symbol(T_DELEGATE); }
  "do"                           	{ return symbol(T_DO); }
  "double"                       	{ return symbol(T_DOUBLE); }
  "else"                         	{ return symbol(T_ELSE); }
  "enum"                         	{ return symbol(T_ENUM); }
  "event"                        	{ return symbol(T_EVENT); }
  "explicit"                     	{ return symbol(T_EXPLICIT); }
  "extern"                       	{ return symbol(T_EXTERN); }
  "false"                        	{ return symbol(T_FALSE); }
  "field" 	                     	{ return symbol(T_FIELD); }
  "finally"                      	{ return symbol(T_FINALLY); }
  "fixed"                        	{ return symbol(T_FIXED); }
  "float"                        	{ return symbol(T_FLOAT); }
  "for"                          	{ return symbol(T_FOR); }
  "foreach"                      	{ return symbol(T_FOREACH); }
  "get"		                       	{ return symbol(T_GET); }
  "goto"                         	{ return symbol(T_GOTO); }
  "if"                           	{ return symbol(T_IF); }
  "implicit"                     	{ return symbol(T_IMPLICIT); }
  "in"                           	{ return symbol(T_IN); }
  "int"                          	{ return symbol(T_INT); }
  "interface"                    	{ return symbol(T_INTERFACE); }
  "internal"                     	{ return symbol(T_INTERNAL); }
  "is"                           	{ return symbol(T_IS); }
  "lock"                         	{ return symbol(T_LOCK); }
  "long"                         	{ return symbol(T_LONG); }
  "method"                      	{ return symbol(T_METHOD); }
  "module"	                     	{ return symbol(T_MODULE); }
  "namespace"                    	{ return symbol(T_NAMESPACE); }
  "new"                          	{ return symbol(T_NEW); }
  "null"                         	{ return symbol(T_NULL); }
  "object"                       	{ return symbol(T_OBJECT); }
  "operator"                     	{ return symbol(T_OPERATOR); }
  "out"                          	{ return symbol(T_OUT); }
  "override"                     	{ return symbol(T_OVERRIDE); }
  "param"                       	{ return symbol(T_PARAM); }
  "params"                       	{ return symbol(T_PARAMS); }
  "private"                      	{ return symbol(T_PRIVATE); }
  "property"                     	{ return symbol(T_PROPERTY); }
  "protected"                    	{ return symbol(T_PROTECTED); }
  "public"                       	{ return symbol(T_PUBLIC); }
  "readonly"                     	{ return symbol(T_READONLY); }
  "ref"                          	{ return symbol(T_REF); }
  "remove"                       	{ return symbol(T_REMOVE); }
  "return"                       	{ return symbol(T_RETURN); }
  "sbyte"                        	{ return symbol(T_SBYTE); }
  "sealed"                       	{ return symbol(T_SEALED); }
  "set"		                       	{ return symbol(T_SET); }
  "short"                        	{ return symbol(T_SHORT); }
  "sizeof"                       	{ return symbol(T_SIZEOF); }
  "stackalloc"                   	{ return symbol(T_STACKALLOC); }
  "static"                       	{ return symbol(T_STATIC); }
  "string"                       	{ return symbol(T_STRING); }
  "struct"                       	{ return symbol(T_STRUCT); }
  "switch"                       	{ return symbol(T_SWITCH); }
  "this"                         	{ return symbol(T_THIS); }
  "throw"                        	{ return symbol(T_THROW); }
  "true"                         	{ return symbol(T_TRUE); }
  "try"                          	{ return symbol(T_TRY); }
  "type"	                       	{ return symbol(T_TYPE); }
  "typeof"                       	{ return symbol(T_TYPEOF); }
  "uint"                         	{ return symbol(T_UINT); }
  "ulong"                        	{ return symbol(T_ULONG); }
  "unchecked"                    	{ return symbol(T_UNCHECKED); }
  "unsafe"                       	{ return symbol(T_UNSAFE); }
  "ushort"                       	{ return symbol(T_USHORT); }
  "using"                        	{ return symbol(T_USING); }
  "virtual"                      	{ return symbol(T_VIRTUAL); }
  "void"                         	{ return symbol(T_VOID); }
  "volatile"                     	{ return symbol(T_VOLATILE); }
  "while"                        	{ return symbol(T_WHILE); }
  
  /* Separators */
  "{"                            	{ return symbol(T_LBRACE); }
  "}"                            	{ return symbol(T_RBRACE); }
  "["                            	{ return symbol(T_LBRACK); }
  "]"                            	{ return symbol(T_RBRACK); }
  "("                            	{ return symbol(T_LPAREN); }
  ")"                            	{ return symbol(T_RPAREN); }
  "."                            	{ return symbol(T_DOT); }
  ","                            	{ return symbol(T_COMMA); }
  ":"                            	{ return symbol(T_COLON); }
  ";"                            	{ return symbol(T_SEMICOLON); }
  
  /* Operators */
  "+"                            	{ return symbol(T_PLUS); }
  "-"                            	{ return symbol(T_MINUS); }
  "*"                            	{ return symbol(T_MULT); }
  "/"                            	{ return symbol(T_DIV); }
  "%"                            	{ return symbol(T_MOD); }
  "&"                            	{ return symbol(T_AND); }
  "|"                            	{ return symbol(T_OR); }
  "^"                            	{ return symbol(T_XOR); }
  "!"                            	{ return symbol(T_NOT); }
  "?"                            	{ return symbol(T_QUESTION); }
  "~"                            	{ return symbol(T_COMP); }
  "="                            	{ return symbol(T_EQ); }
  "<"                            	{ return symbol(T_LT); }
  ">"                            	{ return symbol(T_GT); }
  "++"                           	{ return symbol(T_PLUSPLUS); }
  "--"                           	{ return symbol(T_MINUSMINUS); }
  "&&"                           	{ return symbol(T_ANDAND); }
  "||"                           	{ return symbol(T_OROR); }
  "<<"                           	{ return symbol(T_LSHIFT); }
  ">>"                           	{ return symbol(T_RSHIFT); }
  "=="                           	{ return symbol(T_EQEQ); }
  "!="                           	{ return symbol(T_NOTEQ); }
  "<="                           	{ return symbol(T_LTEQ); }
  ">="                           	{ return symbol(T_GTEQ); }
  "+="                           	{ return symbol(T_PLUSEQ); }
  "-="                           	{ return symbol(T_MINUSEQ); }
  "*="                           	{ return symbol(T_MULTEQ); }
  "/="                           	{ return symbol(T_DIVEQ); }
  "%="                           	{ return symbol(T_MODEQ); }
  "&="                           	{ return symbol(T_ANDEQ); }
  "|="                           	{ return symbol(T_OREQ); }
  "^="                           	{ return symbol(T_XOREQ); }
  "<<="                          	{ return symbol(T_LSHIFTEQ); }
  ">>="                          	{ return symbol(T_RSHIFTEQ); }
  "->"                           	{ return symbol(T_ARROW); }
  
  /* String literal */
  \"                             	{ yybegin(STATE_STRING); string.setLength(0); }

  /* Character literal */
  \'                             	{ yybegin(STATE_CHAR); }

  /* Numeric literals */
  {DecimalIntegerLiteral}        	{	int pos = yylength();
																		if (Character.isLetter(yytext().charAt(pos - 1)))	{	
																		  pos--;
  																	  if (Character.isLetter(yytext().charAt(pos - 1)))
  																		  pos --;
  																	}
  																	return symbol(T_INTEGER_LITERAL, new Integer(yytext().substring(0, pos))); }
  
  {HexadecimalIntegerLiteral}    	{ return symbol(T_INTEGER_LITERAL, new Integer(Integer.parseInt(yytext().substring(2),16))); }
 
  {FloatLiteral}                 	{ int pos = yylength();
									                  if (Character.isLetter(yytext().charAt(pos - 1)))
										                  pos--;
  									                return symbol(T_FLOAT_LITERAL, new Float(yytext().substring(0, pos))); }
	  								   
  /* Identifiers */ 
  {Identifier}                   	{ return symbol(T_IDENTIFIER, yytext()); }  
}

<COMMENT> {
  "*/" 														{ yybegin(YYINITIAL); }
  [^*] 														{ /* ignore */ }
  "*"+														{ /* ignore */ }
  {LineTerminator}								{ nComments++; }
} 

<STATE_STRING> {
  \"                             	{ yybegin(YYINITIAL); return symbol(T_STRING_LITERAL, string.toString()); }
  
  {StringCharacter}+             	{ string.append( yytext() ); }
  
  /* Escape sequences */
  "\\'"                          	{ string.append( '\'' ); }
  "\\\""                         	{ string.append( '\"' ); }
  "\\\\"                         	{ string.append( '\\' ); }
  "\\0"                          	{ string.append( '\0' ); }
  "\\a"                          	{ string.append( '\u0007' ); } /* Alert */
  "\\b"                          	{ string.append( '\b' ); }
  "\\f"                          	{ string.append( '\f' ); }
  "\\n"                          	{ string.append( '\n' ); }
  "\\r"                          	{ string.append( '\r' ); }
  "\\t"                          	{ string.append( '\t' ); }
  "\\v"                          	{ string.append( '\u000b' ); } /* Vertical tab */
  
  "\\x" {HexaDigit} {HexaDigit}{0,3}  { char val = (char) Short.parseShort(yytext().substring(2),16);
                        				   	    string.append( val ); }                      				   	
                        				   	
  {UnicodeSequence}                   { char val = (char) Short.parseShort(yytext().substring(2), 16); 
  										                  string.append( val ); }       				  
  
  /* Error cases */
  \\.                            	{ throw new RuntimeException("Illegal escape sequence \"" + yytext() + "\""); } 
  {LineTerminator}               	{ throw new RuntimeException("Unterminated string at end of line"); }
}

<STATE_CHAR> {
  {SingleCharacter}\' 	          { yybegin(YYINITIAL); return symbol(T_CHARACTER_LITERAL, new Character(yytext().charAt(0))); }
  
  /* Escape sequences */
  "\\'"\'                         { yybegin(YYINITIAL); return symbol(T_CHARACTER_LITERAL, new Character('\'')); }
  "\\\""\'                        { yybegin(YYINITIAL); return symbol(T_CHARACTER_LITERAL, new Character('\"')); }
  "\\\\"\'                        { yybegin(YYINITIAL); return symbol(T_CHARACTER_LITERAL, new Character('\\')); }
  "\\0"\'                         { yybegin(YYINITIAL); return symbol(T_CHARACTER_LITERAL, new Character('\0')); }
  "\\a"\'                         { yybegin(YYINITIAL); return symbol(T_CHARACTER_LITERAL, new Character('\u0007')); }
  "\\b"\'                         { yybegin(YYINITIAL); return symbol(T_CHARACTER_LITERAL, new Character('\b')); }
  "\\f"\'                         { yybegin(YYINITIAL); return symbol(T_CHARACTER_LITERAL, new Character('\f')); }
  "\\n"\'                         { yybegin(YYINITIAL); return symbol(T_CHARACTER_LITERAL, new Character('\n')); }
  "\\r"\'                         { yybegin(YYINITIAL); return symbol(T_CHARACTER_LITERAL, new Character('\r')); }
  "\\t"\'                         { yybegin(YYINITIAL); return symbol(T_CHARACTER_LITERAL, new Character('\t')); }
  "\\v"\'                         { yybegin(YYINITIAL); return symbol(T_CHARACTER_LITERAL, new Character('\u000b')); }
  
  "\\x" {HexaDigit} {HexaDigit}{0,3}\' { yybegin(YYINITIAL); 
			                                   char val = (char) Short.parseShort(yytext().substring(2, yylength() - 1),16);
			                                   return symbol(T_CHARACTER_LITERAL, new Character(val)); }
                        				   	  
	{UnicodeSequence}\'                  { yybegin(YYINITIAL); 
  												               char val = (char) Short.parseShort(yytext().substring(2, yylength() - 1), 16);
  												               return symbol(T_CHARACTER_LITERAL, new Character(val)); }
  /* Error cases */
  \\.           			            { throw new RuntimeException("Illegal escape sequence \"" + yytext() + "\""); }
  {LineTerminator}    			      { throw new RuntimeException("Unterminated character literal at end of line"); }
}

/* Error fallback */
.|\n                        			{ throw new RuntimeException("Illegal character \"" + yytext() +
                                                              "\" at line " + yyline + ", column " + yycolumn); }
                                                              