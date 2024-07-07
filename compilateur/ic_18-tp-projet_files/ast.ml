module Syntax = struct
  type ident = string
  type expr =
    | Int of  { value: int
              ; pos: Lexing.position }
    | Bool of { value: bool
              ; pos: Lexing.position }
    | Var of  { value : string 
              ; pos: Lexing.position }
    | Call of { func: ident
              ; args: expr list
              ; pos: Lexing.position }

  type instr =
    | DeclVar of { name : string 
                 ; pos: Lexing.position}
    | Assign  of { var: ident
                 ; expr: expr
                 ; pos: Lexing.position }
    | Return  of { expr: expr
                 ; pos: Lexing.position }
  and block = instr list
end

type type_t =
  | Int_t
  | Bool_t
  | Func_t of type_t * type_t list

module IR = struct
  type ident = string
  type expr =
    | Int  of int
    | Bool of bool
    | Var  of ident 
    | Call of ident * expr list 

  type instr = 
    | DeclVar of ident 
    | Assign of ident * expr 
    | Return of expr 
  and block = instr list 
end
