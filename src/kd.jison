%lex
%%

','                     return ',';
':'                     return ':';
'='                     return '=';
'('                     return '(';
')'                     return ')';
'['                     return '[';
']'                     return ']';
'<<'                    return '<<';
'>>'                    return '>>';
'|'                     return 'DECL';
'+'                     return 'PUBLIC';
'-'                     return 'PRIVATE';
'#'                     return 'PROTECTED';
'~'                     return 'PACKAGE';
'/'                     return 'DERIVED';
'_'                     return 'CLASSIFIER';

([0-9]+|\*)(\.\.([0-9]+|\*))?   return 'MULTIPLICITY';
'{'(.|\n)*?'}'                  { yytext = yytext.substring(1, yytext.length - 1); return 'CONSTRAINT'; } /* remove the braces with substring */
'"'(.|\n)*?'"'                  { yytext = yytext.substring(1, yytext.length - 1); return 'COMMENT'; } /* remove the quotes with substring */
[a-zA-Z][a-zA-Z0-9_]*           return 'IDENT';

\s+                     /* skip whitespace */
<<EOF>>                 return 'EOF';

/lex

%start class_diagram
%%

class_diagram
	: classes 'EOF'
	;

classes
	: class_sequence
	| /* epsilon */
	;

class_sequence
	: class_sequence class
	| class
	;

class
	: 'DECL' class_continuation
	;

class_continuation
	: stereotype class_continuation_continuation
	| class_continuation_continuation
	;

class_continuation_continuation
	: IDENT template constraint members
	;

members
	: member_sequence
	| /* epsilon */
	;

member_sequence
	: member_sequence member
	| member
	;

member
	: stereotype member_continuation
	| member_continuation
	;

member_continuation
	: visibility derivation classifier IDENT member_attribute_operation
	;

member_attribute_operation
	: '(' params ')' member_type /* operation */
	| member_type /* attribute */
	;

member_type
	: ':' IDENT multiplicity constraint
	;

params
	: param_sequence
	| /* epsilon */
	;

param_sequence
	: param_sequence ',' param
	| param
	;

param
	: IDENT ':' IDENT multiplicity
	;

comment
	: COMMENT
	| /* epsilon */
	;

stereotype
	: '<<' IDENT '>>'
	;

template
	: '[' params ']'
	| /* epsilon */
	;

constraint
	: CONSTRAINT
	| /* epsilon */
	;

multiplicity
	: '[' MULTIPLICITY ']'
	| /* epsilon */
	;

default_value
	: '='
	| /* epsilon */
	;

visibility
	: 'PUBLIC'
	| 'PRIVATE'
	| 'PROTECTED'
	| 'PACKAGE'
	;

derivation
	: 'DERIVED'
	| /* epsilon */
	;

classifier
	: 'CLASSIFIER'
	| /* epsilon */
	;

%%
