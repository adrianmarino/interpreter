grammar ruml;
//
//
// ----------------------------------------------------------------------------
// Lexical rules
// ----------------------------------------------------------------------------
fragment DIGIT  : [0-9];
fragment LETTER : [a-zA-Z] | '_';

IDENTIFIER
  : LETTER (LETTER | DIGIT)*
  ;
NEWLINE
  : '\r'?'\n'
  ;
WS: [ \t]+ -> skip
  ;
LINE_COMMENT
  : '#' .*? NEWLINE -> skip
  ;
COMMENT
  : '=begin' (COMMENT|.)*? '=end' NEWLINE? -> skip
  ;
//
//
// ----------------------------------------------------------------------------
// Grammar rules
// ----------------------------------------------------------------------------
program
  : (class_def NEWLINE+)*
  ;
class_def
  : 'class' class_name ('<' super_class_name)? NEWLINE+ class_body 'end'
  ;
class_name
  : IDENTIFIER
  ;
super_class_name
  : IDENTIFIER
  ;
class_body
  : (attribute NEWLINE+| method_def NEWLINE+)*
  ;
method_def
  : 'def' method_name method_params NEWLINE+ 'end'
  ;
method_name
  : (class_name '.' | 'self.' )? IDENTIFIER
  ;
method_par
  : IDENTIFIER
  ;
method_params
  : ((method_par)* | ( '(' method_par (',' method_par )* ')' )* )
  ;
attribute
  : ('attr_reader' | 'attr_writer' | 'attr_accessor') variable (',' variable)*
  ;
variable
  : ':' IDENTIFIER
  ;
