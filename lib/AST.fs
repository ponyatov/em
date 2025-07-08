//! E language syntax tree types

type Comment =
    /// #!/usr/bin/env Evento
    | SheBang of string
    /// // line comment
    | LineComment of string
    /// /* block comment */
    | BlockComment of string

/// primitive
type Prim =
    /// integer
    | Int of int
    /// floating-point
    | Float of float
    /// wide character
    | Char of string
    /// boolean
    | Bool of bool

let A = Int 123 // Int 123
let B = Int 456 // Int 456

/// operator
type Op =
    /// `+A`
    | Pos of Expr
    /// `-A`
    | Neg of Expr
    /// `A++`
    | Inc of Expr
    /// `A--`
    | Dec of Expr
    /// `A+B`
    | Add of Expr * Expr
    /// `A-B`
    | Sub of Expr * Expr
    /// `A*B`
    | Mul of Expr * Expr
    /// `A/B`
    | Div of Expr * Expr
    /// `A%B`
    | Mod of Expr * Expr

/// expression
and Expr =
    | Prim of Prim
    | Op of Op

/// Abstract Syntax Tree
type AST =
    | Comment of Comment
    | Expr of Expr
