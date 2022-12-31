open Ast
open Ast.IR
open Baselib

exception Error of string * Lexing.position

let rec analyze_expr expr env =
  match expr with
  | Syntax.Int n -> Int n.value
  | Syntax.Bool b -> Bool b.value
  | Syntax.Var v -> 
    if not (Env.mem v.name env ) then 
      raise (Error ("unbound variable: " ^ v.name, v.pos));
    Var v.name
  | Syntax.Add x -> Add ((analyze_expr x.left env), (analyze_expr x.right env))
  | Syntax.Sub x -> Sub ((analyze_expr x.left env), (analyze_expr x.right env))
  | Syntax.Mul x -> Mul ((analyze_expr x.left env), (analyze_expr x.right env))
  | Syntax.Div x -> Div ((analyze_expr x.left env), (analyze_expr x.right env))


  
  let rec analyze_instr instr env =
    match instr with
    | Syntax.DeclVar dv -> 
      DeclVar dv.name, Env.add dv.name true env
    | Syntax.Assign a -> 
      if not (Env.mem a.var env ) then 
        raise (Error ("variable does not exist: " ^a.var, a.pos));
      let ae = analyze_expr a.expr env in
      Assign (a.var, ae) , env

let rec analyze_block block env =
  match block with
  | i :: b -> 
    let ai, new_env = analyze_instr i env in 
    ai :: (analyze_block b new_env)
  | [] -> []

let analyze parsed =
  analyze_block parsed Baselib._types_


