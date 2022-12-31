type reg =
  | V0
  | FP
  | SP
  | V1

type label = string

type loc = 
| Mem of reg * int

type instr =
  | Li of reg * int
  | Sw of reg * loc
  | Lw of reg * loc 
  | Move of reg * reg 
  | Addi of reg * reg * int
  | Add of reg * reg * reg
  | Sub of reg * reg * reg
  | Mul of reg * reg * reg
  | Div of reg * reg * reg

type directive =
  | Asciiz of string

type decl = label * directive

type asm = { text: instr list ; data: decl list }

let ps = Printf.sprintf (* alias raccourci *)

let fmt_reg = function
  | V0   -> "$v0"
  | FP  -> "$fp"
  | SP -> "$sp"
  | V1 -> "$v1"

  let fmt_loc = function
  | Mem ( r,o ) -> ps "%d(%s)" o (fmt_reg r)

let fmt_instr = function
  | Li (r, i) -> ps "  li %s, %d" (fmt_reg r) i
  | Sw (r, l) -> ps "  sw %s, %s" (fmt_reg r) (fmt_loc l)
  | Lw (r, l) -> ps "  lw %s, %s" (fmt_reg r) (fmt_loc l)
  | Move (d,s) -> ps " move %s, %s" (fmt_reg d) (fmt_reg s)
  | Addi (d, r, i) -> ps " addi %s, %s, %d" (fmt_reg d) (fmt_reg r) i
  | Add (d, s, t) -> ps "add %s, %s, %s" (fmt_reg d) (fmt_reg s) (fmt_reg t)
  | Sub (d, s, t) -> ps "sub %s, %s, %s" (fmt_reg d) (fmt_reg s) (fmt_reg t)
  | Mul (d, s, t) -> ps "Mul %s, %s, %s" (fmt_reg d) (fmt_reg s) (fmt_reg t)
  | Div (d, s, t) -> ps "div %s, %s, %s" (fmt_reg d) (fmt_reg s) (fmt_reg t)

let fmt_dir = function
  | Asciiz (s) -> ps ".asciiz \"%s\"" s

let emit oc asm =
  Printf.fprintf oc ".text\n.globl main\nmain:\n" ;
  List.iter (fun i -> Printf.fprintf oc "%s\n" (fmt_instr i)) asm.text ;
  Printf.fprintf oc "  move $a0, $v0\n  li $v0, 1\n  syscall\n  jr $ra\n" ;
  Printf.fprintf oc "\n.data\n" ;
  List.iter (fun (l, d) -> Printf.fprintf oc "%s: %s\n" l (fmt_dir d)) asm.data
