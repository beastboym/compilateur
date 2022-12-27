%{
  open Ast
  open Ast.Syntax
%}

%token <int> Lint
%token TRUE FALSE
%token Lend

%start prog

%type <Ast.Syntax.expr> prog

%%

prog:
| e = expr; Lend { e }
;

expr:
| n = Lint {
  Int { value = n ; pos = $startpos(n) }
}
| TRUE {Bool { value = true ; pos = $startpos()}}
| FALSE {Bool { value = false ; pos = $startpos()}}
;
