%{
  open Ast
  open Ast.Syntax
%}


%token <int> Lint
%token <bool> Ltrue
%token <bool> Lfalse
%token <string> Lident
%token Lsc Lend Lvar Leq Ladd Lsub Lmul Ldiv


%start prog

(* %type <Ast.Syntax.expr> prog *)
%type <Ast.Syntax.block> prog

%%

prog:
	| i = instr ; Lsc ; b = prog { i @ b }
	| i = instr ; Lsc ; Lend { i }
	(*| Lend { [] }*)
;

instr:
  | Lvar; id = Lident 
  {
   [ DeclVar { name = id ; pos = $startpos(id)}]
  }
  (* On renvoi des listes  *)
  | Lvar; id = Lident; Leq; e = expr
  {
    [ DeclVar { name = id ; pos = $startpos(id)}
      ; Assign { var = id ; expr = e ; pos = $startpos($3) }
    ]
  }
  | id = Lident; Leq; e = expr
  {
	[ Assign { var = id
     		 ; expr = e 
    		 ; pos = $startpos($2) 
    		 }
    ]
  }
;

expr:
| n = Lint {
  Int { value = n ; pos = $startpos(n) }
}
| b = Ltrue  { Bool { value = b ; pos = $startpos(b)} }
| b = Lfalse { Bool { value = b ; pos = $startpos(b)} }
| v = Lident { Var { name = v ; pos = $startpos(v)} }
| expr; Ladd; expr { Add { left = $1; right = $3; pos = $startpos($2) } }
| expr; Lsub; expr { Sub { left = $1; right = $3; pos = $startpos($2) } }
| expr; Lmul; expr { Mul { left = $1; right = $3; pos = $startpos($2) } }
| expr; Ldiv; expr { Div { left = $1; right = $3; pos = $startpos($2) } }

// | left=expr; Ladd; right=expr { Add { left=left; right=right; pos = $startpos() } }


;
