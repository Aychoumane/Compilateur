open Ast
open Mips 
module Env = Map.Make(String)

let _types_ = 
   Env.of_seq
    (List.to_seq
      [ 
         ("_add", Func_t (Int_t, [ Int_t ; Int_t ]));
         ("_sub", Func_t (Int_t, [ Int_t ; Int_t ]));
         ("_mul", Func_t (Int_t, [ Int_t ; Int_t ]));
         ("_div", Func_t (Int_t, [ Int_t ; Int_t ]));
      ])

let builtins = 
   [
      Label "_add";
      Lw (T0, Mem (SP, 0));
      Lw (T1, Mem (SP, 4));
      Add (V0, T0, T1);
      Jr RA;

      Label "_sub";
      Lw (T0, Mem (SP, 0));
      Lw (T1, Mem (SP, 4));
      Sub (V0, T0, T1);
      Jr RA;

      Label "_mul";
      Lw (T0, Mem (SP, 0));
      Lw (T1, Mem (SP, 4));
      Mul (V0, T0, T1);
      Jr RA;

      Label "_div";
      Lw (T0, Mem (SP, 0));
      Lw (T1, Mem (SP, 4));
      Div (V0, T0, T1);
      Jr RA;

      Label "main";
      Move (FP, SP); 
      Addi (FP, SP, -4) ; 
   ]
