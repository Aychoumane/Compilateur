%{
  open Ast
  open Ast.Syntax
%}

%token <int> Lint
%token <bool> Lbool
%token <string> Lident

%token Ladd Lsub Lmul Ldiv Lopar Lcpar Lequal 
%token Lreturn Lassign Lsc Lend Lvar 

%left Ladd Lsub
%left Lmul Ldiv

%start prog

%type <Ast.Syntax.block> prog

%%

prog:
| i = instr ; Lsc ; b = prog { i @ b }
| i = instr ; Lsc ; Lend {i}
;

instr: 
| Lvar ; id = Lident {                       (*Declaration de variable : var "nom" *)
  [DeclVar{ name = id 
          ; pos = $startpos(id)
          }] 
}
| Lvar ; id = Lident ; Lequal ; e = expr {   (*Déclaration et Assignation de valeur : var "nom" = val *)
  [DeclVar{name = id 
          ;pos = $startpos(id)
          }
  ; Assign {var = id 
           ;expr = e 
           ;pos = $startpos(id)
  }]
  }
| id = Lident ; Lequal ; e = expr {           (*Variable existante : "nom" = val *)
  [Assign { var = id 
          ; expr = e 
          ; pos = $startpos($2) 
    }]
}


expr:
| n = Lint {                                 (*Définitions des types int , bool , variable*)
  Int { value = n 
      ; pos = $startpos(n) 
      }
}
| b = Lbool {
  Bool { value = b 
       ; pos = $startpos(b) 
       }
}
| variable = Lident{
  Var{ value = variable 
     ; pos = $startpos(variable)
  }
}
|a = expr  ; Ladd ; b = expr{                 (*Appel des fonctions intégrés*)
   Call{func = "_add" 
        ;args = [a ; b]
        ;pos = $startpos($2)
    }
  }
|a = expr  ; Lsub ; b = expr{         
   Call{func = "_sub" 
        ;args = [a ; b]
        ;pos = $startpos($2)
    }
  }
|a = expr  ; Lmul ; b = expr{
   Call{func = "_mul" 
        ;args = [a ; b]
        ;pos = $startpos($2)
    }
  }
|a = expr  ; Ldiv ; b = expr{
   Call{func = "_div" 
        ;args = [a ; b]
        ;pos = $startpos($2)
    }
  }
| Lopar ; e = expr ; Lcpar{               (*Gestion des parenthèses*)
  e
}
;
