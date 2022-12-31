open Ast.IR
open Mips

module Env = Map.Make(String)

type cinfo = {
  asm: Mips.instr list
; env: Mips.loc Env.t
; fpo: int
}

let rec compile_expr e env =
  match e with
  | Int n  -> [ Li (V0, n) ]
  | Bool b -> [Li (V0, if b then 1 else 0)] 
  | Var v -> [Lw (V0,Env.find v env)] 
  | Add (left, right) ->
    let left_instrs = compile_expr left env in
    let right_instrs = compile_expr right env in
    left_instrs @ right_instrs @ [ Add (V0, V0, V1) ]
  | Sub (left, right) ->
    let left_instrs = compile_expr left env in
    let right_instrs = compile_expr right env in
    left_instrs @ right_instrs @ [ Sub (V0, V0, V1) ]
  | Mul (left, right) ->
    let left_instrs = compile_expr left env in
    let right_instrs = compile_expr right env in
    left_instrs @ right_instrs @ [ Mul (V0, V0, V1) ]
| Div (left, right) ->
    let left_instrs = compile_expr left env in
    let right_instrs = compile_expr right env in
    left_instrs @ right_instrs @ [ Div (V0, V0, V1) ]


let compile_instr instr info = 
  match instr with 
  | DeclVar v -> 
    {
      info with 
      fpo = info.fpo -4
      ; env = Env.add v (Mem (FP, info.fpo)) info.env
    }
  | Assign (v,e) -> 
    { info with 
    asm = info.asm 
     @ compile_expr e info.env
     @ [ Sw (V0, Env.find v info.env)]
    }


let rec compile_block block info = 
  match block with
  | i :: b -> 
 (* let new_info = compile_instr i info in new_info :: (compile_block b new_info)*)
    let new_info = compile_instr i info in compile_block b new_info
  | [] -> info


let compile ir =
  let info = compile_block ir 
      {
        asm = Baselib.builtins
      ; env = Env.empty
      ; fpo = 0
      }
  in
  { text =[ 
        Move (FP, SP) 
      ;Addi (SP, SP, info.fpo )] 
      @ info.asm
  ; data = [] }
