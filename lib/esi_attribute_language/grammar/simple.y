class EsiAttributeLanguage::SimpleGrammarParser

token DOLLAR LPAREN RPAREN STRING VARIABLE OTHER PIPE LBRACE RBRACE QUOTE

rule
  expression:
      DOLLAR LPAREN variable RPAREN                   { result = val[2] } # $(...)
    | OTHER                                           { result = val[0] }
    | DOLLAR LPAREN variable RPAREN expression        { result = ConcatNode.new(val[2], val[4]) } # $(...)
    | OTHER expression                                { result = ConcatNode.new(val[0], val[1]) }
    ;
  
  variable:
       variable PIPE variable                         { result = OrNode.new(val[0], val[2]) }
    |  variable LBRACE OTHER RBRACE              { result = HashLookupNode.new(val[0], Node.cleanse_string(val[2])) }
    |  OTHER                                          { result = VariableLookup.new(val[0]) }
    ;

end