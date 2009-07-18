class EsiAttributeLanguage::GrammarParser

rule
  '(\\'|[^'])*'	      { [:STRING,   text] }
  ==                  { [:EQ,       text] }
  !=                  { [:NE,       text] }
  <=                  { [:LTE,      text] }
  >=                  { [:GTE,      text] }
  <                   { [:LT,       text] }
  >                   { [:GT,       text] }
  \$                  { [:DOLLAR,   text] }
  \|                  { [:PIPE,     text] }
  \[                  { [:LSQUARE,  text] }
  \]                  { [:RSQUARE,  text] }
  \{                  { [:LBRACE,   text] }
  \}                  { [:RBRACE,   text] }
  \(                  { [:LPAREN,   text] }
  \)                  { [:RPAREN,   text] }
  \\                  { [:BSLASH,   text] }
  \+                  { [:PLUS,     text] }
  \*                  { [:STAR,     text] }
  \/                  { [:SLASH,    text] }
  \'                  { [:QUOTE,    text] }
  \?                  { [:QMARK,    text] }
  \.                  { [:DOT,      text] }
  \^                  { [:CARROT,   text] }
  \-                  { [:MINUS,    text] }
  &                   { [:AMP,      text] }
  !                   { [:BANG,     text] }
  [0-9]+              { [:NUMBER,   text] }
  [A-Za-z_-]+         { [:VARIABLE, text] }
  .                   nil
end