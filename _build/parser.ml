
module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
  type token = 
    | Lvar
    | Ltrue of (
# 7 "parser.mly"
       (bool)
# 16 "parser.ml"
  )
    | Lsc
    | Lint of (
# 6 "parser.mly"
       (int)
# 22 "parser.ml"
  )
    | Lident of (
# 9 "parser.mly"
       (string)
# 27 "parser.ml"
  )
    | Lfalse of (
# 8 "parser.mly"
       (bool)
# 32 "parser.ml"
  )
    | Leq
    | Lend
  
end

include MenhirBasics

# 1 "parser.mly"
  
  open Ast
  open Ast.Syntax

# 46 "parser.ml"

type ('s, 'r) _menhir_state = 
  | MenhirState00 : ('s, _menhir_box_prog) _menhir_state
    (** State 00.
        Stack shape : .
        Start symbol: prog. *)

  | MenhirState03 : (('s, _menhir_box_prog) _menhir_cell1_Lvar _menhir_cell0_Lident _menhir_cell0_Leq, _menhir_box_prog) _menhir_state
    (** State 03.
        Stack shape : Lvar Lident Leq.
        Start symbol: prog. *)

  | MenhirState10 : (('s, _menhir_box_prog) _menhir_cell1_Lident _menhir_cell0_Leq, _menhir_box_prog) _menhir_state
    (** State 10.
        Stack shape : Lident Leq.
        Start symbol: prog. *)

  | MenhirState14 : (('s, _menhir_box_prog) _menhir_cell1_instr, _menhir_box_prog) _menhir_state
    (** State 14.
        Stack shape : instr.
        Start symbol: prog. *)


and ('s, 'r) _menhir_cell1_instr = 
  | MenhirCell1_instr of 's * ('s, 'r) _menhir_state * (Ast.Syntax.block)

and 's _menhir_cell0_Leq = 
  | MenhirCell0_Leq of 's * Lexing.position

and ('s, 'r) _menhir_cell1_Lident = 
  | MenhirCell1_Lident of 's * ('s, 'r) _menhir_state * (
# 9 "parser.mly"
       (string)
# 80 "parser.ml"
) * Lexing.position

and 's _menhir_cell0_Lident = 
  | MenhirCell0_Lident of 's * (
# 9 "parser.mly"
       (string)
# 87 "parser.ml"
) * Lexing.position

and ('s, 'r) _menhir_cell1_Lvar = 
  | MenhirCell1_Lvar of 's * ('s, 'r) _menhir_state

and _menhir_box_prog = 
  | MenhirBox_prog of (Ast.Syntax.block) [@@unboxed]

let _menhir_action_01 =
  fun _startpos_n_ n ->
    (
# 48 "parser.mly"
           (
  Int { value = n ; pos = _startpos_n_ }
)
# 103 "parser.ml"
     : (Ast.Syntax.expr))

let _menhir_action_02 =
  fun _startpos_b_ b ->
    (
# 51 "parser.mly"
             ( Bool { value = b ; pos = _startpos_b_} )
# 111 "parser.ml"
     : (Ast.Syntax.expr))

let _menhir_action_03 =
  fun _startpos_b_ b ->
    (
# 52 "parser.mly"
             ( Bool { value = b ; pos = _startpos_b_} )
# 119 "parser.ml"
     : (Ast.Syntax.expr))

let _menhir_action_04 =
  fun _startpos_v_ v ->
    (
# 53 "parser.mly"
             ( Var { name = v ; pos = _startpos_v_} )
# 127 "parser.ml"
     : (Ast.Syntax.expr))

let _menhir_action_05 =
  fun _startpos_id_ id ->
    (
# 27 "parser.mly"
  (
   [ DeclVar { name = id ; pos = _startpos_id_}]
  )
# 137 "parser.ml"
     : (Ast.Syntax.block))

let _menhir_action_06 =
  fun _startpos__3_ _startpos_id_ e id ->
    (
# 32 "parser.mly"
  (
    [ DeclVar { name = id ; pos = _startpos_id_}
      ; Assign { var = id ; expr = e ; pos = _startpos__3_ }
    ]
  )
# 149 "parser.ml"
     : (Ast.Syntax.block))

let _menhir_action_07 =
  fun _startpos__2_ e id ->
    (
# 38 "parser.mly"
  (
	[ Assign { var = id
     		 ; expr = e 
    		 ; pos = _startpos__2_ 
    		 }
    ]
  )
# 163 "parser.ml"
     : (Ast.Syntax.block))

let _menhir_action_08 =
  fun b i ->
    (
# 20 "parser.mly"
                              ( i @ b )
# 171 "parser.ml"
     : (Ast.Syntax.block))

let _menhir_action_09 =
  fun i ->
    (
# 21 "parser.mly"
                          ( i )
# 179 "parser.ml"
     : (Ast.Syntax.block))

let _menhir_print_token : token -> string =
  fun _tok ->
    match _tok with
    | Lend ->
        "Lend"
    | Leq ->
        "Leq"
    | Lfalse _ ->
        "Lfalse"
    | Lident _ ->
        "Lident"
    | Lint _ ->
        "Lint"
    | Lsc ->
        "Lsc"
    | Ltrue _ ->
        "Ltrue"
    | Lvar ->
        "Lvar"

let _menhir_fail : unit -> 'a =
  fun () ->
    Printf.eprintf "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

include struct
  
  [@@@ocaml.warning "-4-37-39"]
  
  let rec _menhir_run_12_spec_00 : type  ttv_stack. ttv_stack -> _ -> _menhir_box_prog =
    fun _menhir_stack _v ->
      MenhirBox_prog _v
  
  let rec _menhir_goto_prog : type  ttv_stack. ttv_stack -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _v _menhir_s ->
      match _menhir_s with
      | MenhirState14 ->
          _menhir_run_16 _menhir_stack _v
      | MenhirState00 ->
          _menhir_run_12_spec_00 _menhir_stack _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_16 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_instr -> _ -> _menhir_box_prog =
    fun _menhir_stack _v ->
      let MenhirCell1_instr (_menhir_stack, _menhir_s, i) = _menhir_stack in
      let b = _v in
      let _v = _menhir_action_08 b i in
      _menhir_goto_prog _menhir_stack _v _menhir_s
  
  let rec _menhir_run_01 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | Lident _v ->
          let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | Leq ->
              let _menhir_stack = MenhirCell1_Lvar (_menhir_stack, _menhir_s) in
              let _menhir_stack = MenhirCell0_Lident (_menhir_stack, _v, _startpos) in
              let _startpos_0 = _menhir_lexbuf.Lexing.lex_start_p in
              let _menhir_stack = MenhirCell0_Leq (_menhir_stack, _startpos_0) in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | Ltrue _v_1 ->
                  let _startpos_2 = _menhir_lexbuf.Lexing.lex_start_p in
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let (_startpos_b_, b) = (_startpos_2, _v_1) in
                  let _v = _menhir_action_02 _startpos_b_ b in
                  _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
              | Lint _v_4 ->
                  let _startpos_5 = _menhir_lexbuf.Lexing.lex_start_p in
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let (_startpos_n_, n) = (_startpos_5, _v_4) in
                  let _v = _menhir_action_01 _startpos_n_ n in
                  _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
              | Lident _v_7 ->
                  let _startpos_8 = _menhir_lexbuf.Lexing.lex_start_p in
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let (_startpos_v_, v) = (_startpos_8, _v_7) in
                  let _v = _menhir_action_04 _startpos_v_ v in
                  _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
              | Lfalse _v_10 ->
                  let _startpos_11 = _menhir_lexbuf.Lexing.lex_start_p in
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let (_startpos_b_, b) = (_startpos_11, _v_10) in
                  let _v = _menhir_action_03 _startpos_b_ b in
                  _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
              | _ ->
                  _eRR ())
          | Lsc ->
              let (_startpos_id_, id) = (_startpos, _v) in
              let _v = _menhir_action_05 _startpos_id_ id in
              _menhir_goto_instr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_08 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_Lvar _menhir_cell0_Lident _menhir_cell0_Leq -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell0_Leq (_menhir_stack, _startpos__3_) = _menhir_stack in
      let MenhirCell0_Lident (_menhir_stack, id, _startpos_id_) = _menhir_stack in
      let MenhirCell1_Lvar (_menhir_stack, _menhir_s) = _menhir_stack in
      let e = _v in
      let _v = _menhir_action_06 _startpos__3_ _startpos_id_ e id in
      _menhir_goto_instr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_instr : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | Lsc ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | Lvar ->
              let _menhir_stack = MenhirCell1_instr (_menhir_stack, _menhir_s, _v) in
              _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState14
          | Lident _v_0 ->
              let _menhir_stack = MenhirCell1_instr (_menhir_stack, _menhir_s, _v) in
              _menhir_run_09 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState14
          | Lend ->
              let i = _v in
              let _v = _menhir_action_09 i in
              _menhir_goto_prog _menhir_stack _v _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_09 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _menhir_stack = MenhirCell1_Lident (_menhir_stack, _menhir_s, _v, _startpos) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | Leq ->
          let _startpos_0 = _menhir_lexbuf.Lexing.lex_start_p in
          let _menhir_stack = MenhirCell0_Leq (_menhir_stack, _startpos_0) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | Ltrue _v_1 ->
              let _startpos_2 = _menhir_lexbuf.Lexing.lex_start_p in
              let _tok = _menhir_lexer _menhir_lexbuf in
              let (_startpos_b_, b) = (_startpos_2, _v_1) in
              let _v = _menhir_action_02 _startpos_b_ b in
              _menhir_run_11 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | Lint _v_4 ->
              let _startpos_5 = _menhir_lexbuf.Lexing.lex_start_p in
              let _tok = _menhir_lexer _menhir_lexbuf in
              let (_startpos_n_, n) = (_startpos_5, _v_4) in
              let _v = _menhir_action_01 _startpos_n_ n in
              _menhir_run_11 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | Lident _v_7 ->
              let _startpos_8 = _menhir_lexbuf.Lexing.lex_start_p in
              let _tok = _menhir_lexer _menhir_lexbuf in
              let (_startpos_v_, v) = (_startpos_8, _v_7) in
              let _v = _menhir_action_04 _startpos_v_ v in
              _menhir_run_11 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | Lfalse _v_10 ->
              let _startpos_11 = _menhir_lexbuf.Lexing.lex_start_p in
              let _tok = _menhir_lexer _menhir_lexbuf in
              let (_startpos_b_, b) = (_startpos_11, _v_10) in
              let _v = _menhir_action_03 _startpos_b_ b in
              _menhir_run_11 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_11 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_Lident _menhir_cell0_Leq -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell0_Leq (_menhir_stack, _startpos__2_) = _menhir_stack in
      let MenhirCell1_Lident (_menhir_stack, _menhir_s, id, _) = _menhir_stack in
      let e = _v in
      let _v = _menhir_action_07 _startpos__2_ e id in
      _menhir_goto_instr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  let rec _menhir_run_00 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | Lvar ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | Lident _v ->
          _menhir_run_09 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState00
      | _ ->
          _eRR ()
  
end

let prog =
  fun _menhir_lexer _menhir_lexbuf ->
    let _menhir_stack = () in
    let MenhirBox_prog v = _menhir_run_00 _menhir_stack _menhir_lexbuf _menhir_lexer in
    v
