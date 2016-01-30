grammar ruby;
//
//
// ----------------------------------------------------------------------------
// Lexical rules
// ----------------------------------------------------------------------------
fragment DIGIT  : [0-9];
fragment LETTER : [a-zA-Z] | '_';

NUMBER
  : DIGIT+('.'DIGIT)*
  | '.'DIGIT+
  | DIGIT+
  ;
IDENTIFIER: LETTER (LETTER | DIGIT)*;
AT: '@';
DAT: '@@';
NEWLINE: '\r'?'\n';
WS: [ \t]+ -> skip;
LINE_COMMENT: '#' .*? NEWLINE -> skip;
COMMENT: '=begin' (COMMENT|.)*? '=end' NEWLINE? -> skip;
//
//
// ----------------------------------------------------------------------------
// Grammar rules
// ----------------------------------------------------------------------------
program: ( class_def NEWLINE+ | statement NEWLINE+ )*;

class_def
  : 'class' class_name (NEWLINE | '<' class_parent NEWLINE )
      class_body
    'end'
  ;

class_name: IDENTIFIER;
class_parent: IDENTIFIER;
class_body
  : (statement NEWLINE)*
  | (method_def NEWLINE)*
  ;
method_def
  : 'def' (class_name '.' | 'self' '.')? method_name ((method_par)* | ( '(' method_par (',' method_par )* ')' )* ) NEWLINE+
      method_body
    'end'
  ;

method_name: IDENTIFIER;
method_par: IDENTIFIER;
method_body: (statement NEWLINE)*;

// Instruction in the program body
statement
  : 'if' '(' condition ')' NEWLINE block 'end'
	| 'elsif' '(' condition ')'
	| 'loop' 'do' NEWLINE block 'end'
	| 'yield' '(' operando ')'
  | 'return' (operando  | '('operando ')' )
  | 'return' (booleani | '(' booleani ')' )
  | 'puts' statement
	| /* @@id = (number | id | string) */
    (DAT IDENTIFIER) '=' (operando | '(' operando_par ')' )
  | /* @@id = id (id, id, ...) */
    (DAT IDENTIFIER) '=' (class_name '.' method_name)
      ( ('(' ')') | ( '(' opAsClassMet=operando (',' op1AsClassMet=operando )* ')' ) )?
  | // @@id = id (id, id, ...)
    (DAT IDENTIFIER) '=' method_name ( ('(' ')') | ( '(' operando (',' operando )* ')' ) )?
  | // @@id = (number | id | string)
    (AT IDENTIFIER) '=' (operando | '(' operando ')' )
  | // @id = id (id, id, ...)
    (AT IDENTIFIER) '=' (class_name '.' method_name) ( ('(' ')') | ( '(' operando (',' operando )* ')' ) )?
  | // @id = id (id, id, ...)
    (AT IDENTIFIER) '=' method_name ( ('(' ')') | ( '(' operando (',' operando )* ')' ) )?
  | // id = (number | id | string)
    IDENTIFIER '=' (operando  | '(' operando ')' )
  | // id = id (id, id, ...)
    IDENTIFIER '=' (class_name '.' method_name)
    ( ('(' ')')| ( '(' opAsClassMet=operando (',' op1AsClassMet=operando)* ')' ) )?
  | // id = id (id, id, ...)
    IDENTIFIER '=' method_name ( ('(' ')')  | ( '(' operando (',' operando )* ')' ) )?
  | operando
  ;

block: (statement NEWLINE)+;

// condition or operation
condition
  : // condition operator (IDENTIFIER | NUMBER)
    booleani
  | booleani ('&' | '|') booleani
  | '(' condition ')'
  | booleani '|' condition
  | booleani '&' booleani ('&' | '|') condition
  ;

// math instruction
instruction
  : '(' operando_par ')' ( '/' operando | '*'  operando | '+'  operando | '-' operando  )?
  | '(' instruction_par ')' ( '/'  operando | '*' operando | '+' operando | '-' operando )?
  | (DAT IDENTIFIER) ( '/' operando | '*' operando | '+' operando | '-' operando  )
  | (AT IDENTIFIER) ( '/' operando | '*' operando | '+' operando | '-' operando )
  | IDENTIFIER ( '/' operando | '*' operando | '+' operando | '-' operando  )
  | //NUMBER operator NUMBER
    NUMBER ( '/' operando | '*' operando | '+' operando | '-' operando)
  ;

instruction_par: instruction;

operando_par: operando;

// 'return'
operando
  : NUMBER
  | (DAT IDENTIFIER)
  | (AT IDENTIFIER)
  | IDENTIFIER
  | class_name '.' 'new' ( '.' method_name  ('.' method_name)* )? ( '(' operando (',' operando )* ')' )?
  | // id((id | number),(id|number)*) do |id|
    (class_name '.' method_name) ( ('(' ')')  | ( '(' operando (',' operando  )* ')' ) )?
    ( 'do' '|' IDENTIFIER '|' NEWLINE block 'end')?
  | // id((id | number),(id|number)*) do |id|
    method_name ( ('(' ')')  | ( '(' operando (',' operando )* ')' ) )?
	   ( 'do' '|' IDENTIFIER '|' NEWLINE block 'end')? | instruction | '(' instruction_par ')'
  ;

booleani
  : 'true'
  | 'false'
  | operando ( '<' operando | '<=' operando | '>=' operando | '>'  operando | '==' operando  )
  ;
