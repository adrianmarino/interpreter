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
  : (attribute NEWLINE+| (class_method | instance_method) NEWLINE+)*
  ;
class_method
  : 'def' class_method_name params NEWLINE+ 'end'
  ;
class_method_name
  : (class_name '.' | 'self.' )? IDENTIFIER
  ;
instance_method
  : 'def' instance_method_name params NEWLINE+ 'end'
  ;
instance_method_name
  : IDENTIFIER
  ;
params
  : ((param)* | ( '(' param (',' param )* ')' )* )
  ;
param
  : IDENTIFIER
  ;
attribute
  : ('attr_reader' | 'attr_writer' | 'attr_accessor') variable (',' variable)*
  ;
variable
  : ':' IDENTIFIER
  ;
