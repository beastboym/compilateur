
(* The type of tokens. *)

type token = 
  | Lvar
  | Ltrue of (bool)
  | Lsc
  | Lint of (int)
  | Lident of (string)
  | Lfalse of (bool)
  | Leq
  | Lend

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val prog: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Ast.Syntax.block)
