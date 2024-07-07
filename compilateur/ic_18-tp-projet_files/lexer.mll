{
  open Lexing
  open Parser

  exception Error of char
}

let num = ['0'-'9']
let bool = "true"|"false"
let alpha = ['a' - 'z' 'A'-'Z']
let identifier = alpha (alpha | num | '_') * 

rule token = parse
| eof             { Lend }
| [ ' ' '\t' ]    { token lexbuf }
| '\n'            { Lexing.new_line lexbuf; token lexbuf }
| "var"           { Lvar }
| "return"        { Lreturn }
| num+ as n       { Lint (int_of_string n) }
| bool as b       { Lbool (bool_of_string b) }
| identifier as v { Lident(v) }
| '#'             { comment lexbuf }
| ';'             { Lsc }
| '='             { Lequal }
| '('             { Lopar }           
| ')'             { Lcpar } 
| '+'             { Ladd }
| '-'             { Lsub }
| '*'             { Lmul }
| '/'             { Ldiv }
| _ as c          { raise (Error c) }

and comment = parse
| eof  { Lend }
| '\n' { Lexing.new_line lexbuf; token lexbuf }
| _    { comment lexbuf }
