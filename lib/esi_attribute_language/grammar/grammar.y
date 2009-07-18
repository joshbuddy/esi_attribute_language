class EsiAttributeLanguage::GrammarParser

token DOLLAR LSQUARE RSQUARE LPAREN RPAREN LBRACE RBRACE BSLASH PIPE
token PLUS NUMBER MINUS STAR SLASH VARIABLE STRING EQ NE LTE GTE LT GT BANG AMP

rule
  expression:
      NUMBER                             { result = Integer(val[0]) }
    | STRING                             { result = Node.cleanse_string(val[0]) }
    | expression EQ expression           { result = MethodNode.new(val[0], :'==', val[2]) }
    | expression NE expression           { result = MethodNode.new(MethodNode.new(val[0], :'==', val[2]), :'^', true) }
    | expression LTE expression          { result = MethodNode.new(val[0], :'<=', val[2]) }
    | expression GTE expression          { result = MethodNode.new(val[0], :'>=', val[2]) }
    | expression LT expression           { result = MethodNode.new(val[0], :'<' , val[2]) }
    | expression GT expression           { result = MethodNode.new(val[0], :'>' , val[2]) }
    | expression AMP expression          { result = MethodNode.new(val[0], :'&' , val[2]) }
    | expression PIPE expression         { result = MethodNode.new(val[0], :'|' , val[2]) }
    | expression PLUS expression         { result = MethodNode.new(val[0], :+   , val[2]) }
    | expression MINUS expression        { result = MethodNode.new(val[0], :-   , val[2]) }
    | expression STAR expression         { result = MethodNode.new(val[0], :'*' , val[2]) }
    | expression SLASH expression        { result = MethodNode.new(val[0], :'/' , val[2]) }
    | BANG expression                    { result = MethodNode.new(val[1], :'^', true) }
    | LPAREN expression RPAREN           { result = val[1] }
    | DOLLAR LPAREN variable RPAREN      { result = val[2] } # $(...)
    ;
  
  variable:
      STRING                             { result = Node.cleanse_string(val[0]) }
    | variable PIPE variable             { result = OrNode.new(val[0], val[2]) }
    | variable LBRACE hash_lookup RBRACE { result = HashLookupNode.new(val[0], val[2]) }
    | VARIABLE                           { result = VariableLookup.new(val[0]) }
    ;
  
  hash_lookup:
      STRING                             { result = Node.cleanse_string(val[0]) }
    | VARIABLE                           { result = val[0] }
    ;

end