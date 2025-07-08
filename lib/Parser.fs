//! parser combinators from scratch
//! - tabbed syntax parsing
//! - more informative errors
//! - able to parse context-sensitive subgrammars
//!
//! https://fsharpforfunandprofit.com/posts/understanding-parser-combinators/

/// parser result
type PResult<'T> =
    /// successfully parsed
    | Succ of 'T
    /// syntax error
    | Fail of string

/// generic parser
type Parser<'T> = Parser of (string -> PResult<'T * string>)

/// helper function to run typed combinators
let run (Parser p) (input: string) = p input

/// parse single char
let pchar (c: char) =
    Parser(fun (input: string) ->
        match input with
        | "" -> Fail input
        | input when input.[0] = c -> Succ(c, input.[1..])
        | _ -> Fail input)

let A = pchar 'A'

run A "" // Fail ""
run A "A" // Succ ('A', "")
run A "B" // Fail "B"
run A "ABC" // Succ ('A', "BC")

let B = pchar 'B'

run B "" // Fail ""
run B "A" // Fail "A"
run B "BC" // Succ ('B', "C")

/// parse string
let pstr (s: string) =
    Parser(fun (input: string) ->
        match input with
        | "" -> Fail input
        | input when input.StartsWith(s) -> Succ(s, input.[s.Length ..])
        | _ -> Fail input)

let LineCommentPfx = pstr "//"

run LineCommentPfx "" // Fail ""
run LineCommentPfx "//" // Succ ("//", "")
run LineCommentPfx "// A\n//" // Succ ("//", " A\n//")
