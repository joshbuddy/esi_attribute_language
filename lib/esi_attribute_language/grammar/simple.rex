class EsiAttributeLanguage::SimpleGrammarParser

rule
  \{                                                { [:LBRACE,    text] }
  \}                                                { [:RBRACE,    text] }
  \$                                                { [:DOLLAR,    text] }
  \|                                                { [:PIPE,      text] }
  \(                                                { [:LPAREN,    text] }
  \)                                                { [:RPAREN,    text] }
  [0-9]+                                            { [:NUMBER,    text] }
  '(\\'|[^'])*'	                                    { [:OTHER,     text] }
  (\\\|\\\$|\\\[|\\\]|\\\)|[^\|\(\)\$\{\}]{1})*     { [:OTHER,     text] }
end