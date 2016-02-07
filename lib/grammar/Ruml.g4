grammar Ruml;
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
ruml
  : (module_def NEWLINE* | class_def NEWLINE*)*
  ;
//
// Module
//
module_def
  : 'module' IDENTIFIER NEWLINE* body 'end'
  ;
module_name
  : IDENTIFIER
  ;
//
// Class
//
class_def
  : 'class' class_name ('<' super_class_name)? NEWLINE* body 'end'
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
  : (
      ( include_def
      | extend_def
      | attributes_def
      | class_method_def
      | instance_method_def
      )
      NEWLINE+
    )*
  ;
include_def
  : 'include' IDENTIFIER
  ;
extend_def
  : 'extend' IDENTIFIER
  ;
attributes_def
  : 'attr_reader'   SYMBOL (',' SYMBOL)*  #attr_reader
  | 'attr_writer'   SYMBOL (',' SYMBOL)*  #attr_writter
  | 'attr_accessor' SYMBOL (',' SYMBOL)*  #attr_accessor
  ;
//
// Method
//
class_method_def
  : 'def' class_method_name params NEWLINE+ 'end'
  ;
class_method_name
  : (class_name '.' | 'self.' ) IDENTIFIER
  ;
instance_method_def
  : 'def' instance_method_name params NEWLINE+ 'end'
  ;
instance_method_name
  : IDENTIFIER
  ;
//
// Method params
//
params
  : ( '(' param (',' param )* ')' )*
  ;
param
  : normal_param
  | keyword_param
  | default_param
  ;
normal_param
  : IDENTIFIER
  ;
keyword_param
  : KEYWORD_PARAM_NAME value?
  ;
default_param
  : IDENTIFIER '=' value
  ;
value
  : STRING  #stringValue
  | SYMBOL  #symbolValue
  | NUMBER  #numberValue
  ;
