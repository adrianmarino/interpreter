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
SYMBOL
  : ':' IDENTIFIER
  ;
NUMBER
  : DIGIT+('.'DIGIT)*
  | '.'DIGIT+
  | DIGIT+
  ;
STRING
  : '\'' .*? '\''
  | '"' .*? '"'
  ;
KEYWORD_PARAM_NAME
  : IDENTIFIER ':'
  ;
//
//
// ----------------------------------------------------------------------------
// Grammar rules
// ----------------------------------------------------------------------------
program
  : (module_def NEWLINE+ | class_def NEWLINE+)*
  ;
//
// Module
//
module_def
  : 'module' module_name NEWLINE+ body 'end'
  ;
module_name
  : IDENTIFIER
  ;
//
// Class
//
class_def
  : 'class' class_name ('<' super_class_name)? NEWLINE+ body 'end'
  ;
class_name
  : IDENTIFIER
  ;
super_class_name
  : IDENTIFIER
  ;
//
// Body
//
body
  : ( (include_def | extend_def | attributes_def | class_method_def | instance_method_def ) NEWLINE+ )*
  ;
include_def
  : 'include' module_name
  ;
extend_def
  : 'extend' module_name
  ;
attributes_def
  : ('attr_reader' | 'attr_writer' | 'attr_accessor') SYMBOL (',' SYMBOL)*
  ;
class_method_def
  : 'def' class_method_name params NEWLINE+ 'end'
  ;
class_method_name
  : (class_name '.' | 'self.' )? IDENTIFIER
  ;
instance_method_def
  : 'def' instance_method_name params NEWLINE+ 'end'
  ;
instance_method_name
  : IDENTIFIER
  ;
params
  : param*
  | ( '(' param (',' param )* ')' )*
  ;
param
  : param_value
  | keyword_param
  | default_param
  ;
param_value
  : IDENTIFIER
  ;
keyword_param
  : keyword_param_name value?
  ;
keyword_param_name
  : KEYWORD_PARAM_NAME
  ;
default_param
  : default_param_name '=' value
  ;
default_param_name
  : IDENTIFIER
  ;
value
  : STRING
  | SYMBOL
  | NUMBER
  ;
