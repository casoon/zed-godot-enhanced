; Made using highlights done for nvim-treesitter as a base
; https://github.com/nvim-treesitter/nvim-treesitter/blob/42fc28ba918343ebfd5565147a42a26580579482/queries/gdshader/highlights.scm

; Keywords
[
  "render_mode"
  "shader_type"
  "group_uniforms"
  "global"
  "instance"
  "const"
  "varying"
  "uniform"
  ; type
  "struct"
  ; modifiers
  "in"
  "out"
  "inout"
  (precision_qualifier)
  (interpolation_qualifier)
  ; repeat
  "while"
  "for"
  ; return
  "continue"
  "break"
  "return"
  ; conditional
  "if"
  "else"
  "switch"
  "case"
  "default"
  ; directive
  "#"
  "include"
] @keyword

[
  "="
  "+="
  "-="
  "!"
  "~"
  "+"
  "-"
  "*"
  "/"
  "%"
  "||"
  "&&"
  "|"
  "^"
  "&"
  "=="
  "!="
  ">"
  ">="
  "<="
  "<"
  "<<"
  ">>"
  "++"
  "--"
] @operator

; Types
(boolean) @boolean
[
  (integer)
  (float)
] @number
(string) @string

; Delimiters
[
  "."
  ","
  ";"
] @punctuation.delimiter

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

[
  (builtin_type)
  (ident_type)
] @type

[
  (shader_type)
  (render_mode)
  (hint_name)
] @attribute

(builtin_variable) @constant

(builtin_function) @function

(group_uniforms_declaration
  group_name: (ident) @property
  subgroup_name: (ident) @property)

(struct_declaration
  name: (ident) @type)

(struct_member
  name: (ident) @property)

(function_declaration
  name: (ident) @function)

(parameter
  name: (ident) @variable.special)

(member_expr
  member: (ident) @property)

(call_expr
  function: [
    (ident)
    (builtin_type)
  ] @function)

(call_expr
  function: (builtin_type) @function)

(comment) @comment
