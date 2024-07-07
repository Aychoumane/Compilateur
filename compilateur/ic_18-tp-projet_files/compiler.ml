open Ast.IR
open Mips

module Env = Map.Make(String)
type cinfo = {
              asm : Mips.instr list ; 
              env : Mips.loc Env.t ; 
              fpo : int 
             }

let rec compile_expr expr env =
  match expr with
  | Int n          -> [ Li (V0, n) ]
  | Bool b         -> if (b) 
                      then [ Li (V0, 1) ]
                      else [ Li (V0, 0) ] 
  | Var v          -> [Lw ( V0, Env.find v env)] 
  | Call(f , args) -> let ca = List.rev_map (fun a ->
                  compile_expr a env 
                  @ [ Addi (SP, SP, -4)
                    ; Sw (V0, Mem (SP, 0)) ])
                args in
     List.flatten ca
     @ [ Jal f
       ; Addi (SP, SP, 4 * (List.length args)) ]

let rec compile_instr instr info =
  match instr with
  | DeclVar v        ->
                       {
                         info with
                         fpo = info.fpo - 4;
                         env = Env.add v (Mem (FP, info.fpo)) info.env;
                       }
  | Assign (v, expr) ->
                       {
                        info with
                        asm = info.asm @ compile_expr expr info.env @ [ Sw (V0, Env.find v info.env) ];
                       }
  | Return expr      ->
      let compiled_expr = compile_expr expr info.env in
      { info with asm = info.asm @ compiled_expr @ [ Move (SP, FP); Jr RA ] }


and compile_block block info =
  match block with
  | i :: b ->
      let new_info = compile_instr i info in
      compile_block b new_info
  | [] -> info

let compile ast =
  let info =
    compile_block ast { asm = Baselib.builtins; env = Env.empty; fpo = 0 }
  in
  { text = info.asm @ [ Move (FP, SP) ; Addi (FP, SP, -4)] ; data = [] }


