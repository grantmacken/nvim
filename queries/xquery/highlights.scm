; declared namespace indentifiers
(module_import
  [
   name: (identifier) @namespace
   "import"  @include
   ]
  )
(schema_import
  [
   name: (identifier) @namespace
   "element" @keyword
   "import"  @include
   ]
  )
; highlight top level namespace
[
 (module_declaration )
 (namespace_declaration)
 ] @namespace
(function_declaration "function" @keyword.function)
(inline_function_expr "function" @keyword.function)
(default_namespace_declaration [ "function"  "element"] @keyword)
(context_item_declaration [ "context"  "item"] @keyword)
(variable_declaration "variable" @keyword)
; keywords in declarations
[
 "NaN"
 "base-uri"
 "boundary-space"
 "collation"
 "construction"
 "copy-namespaces"
 "decimal-format"
 "decimal-separator"
 "declare"
 "default"
 "digit"
 "encoding"
 "exponent-separator"
 "external"
 "grouping-separator"
 "infinity"
 "inherit"
 "minus-sign"
 "module"
 "namespace"
 "no-inherit" 
 "no-preserve"
 "option"
 "ordering" 
 "pattern-separator"
 "per-mille"
 "percent"
 "preserve"
 "schema" 
 "strip"
 "strip"
 "version"  
 "xquery" 
 "zero-digit"
 ] @keyword
;TSConditional
[
 "case"
 "catch"
 "default"
 "else"
 "every"
 "if"
 "in"
 "satisfies"
 "some"
 "switch"
 "then" 
 "try"
 ] @conditional
[ "catch" ] @exeption
[ 
  "for" 
  "typeswitch" 
  ] @repeat
; disambiguation
(wildcard) @conditional
(sequence_type
  (occurrence_indicator) @attribute
  )
; 3.12 FLWOR Expressions
[ 
  "at" 
  "in" 
  "where"
  ] @conditional
[ 
  "allowing"
  "as"
  "ascending"
  "by"
  "collation" 
  "count"
  "descending"
  "empty"
  "greatest"
  "group"
  "least"
  "let"
  "order"
  "ordered" 
  "stable"
  "unordered"
  ] @keyword
["return"] @keyword.return
[axis_movement: (_)]  @keyword.operator
[":=" "="] @operator
; PATH 
(abbrev_reverse) @operator
(abbrev_foward) @operator
; lhs rhs binary statements
(range_expr [ "to" ] @keyword.operator)
(additive_expr [ "-" "+"] @operator)
(multiplicative_expr [ "*" ] @operator)
(multiplicative_expr [ "div" "idiv" "mod" ] @keyword.operator)
(comparison_expr [ "eq" "ne" "lt" "le" "gt" "ge" "is" ] @keyword.operator)
(comparison_expr [ "=" "!=" "<" "<=" ">" ">="  "<<" ">>" ] @operator)
(unary_expr [ "-" "+"] @operator)
(and_expr [ "and" ] @keyword.operator)
(or_expr [ "or" ] @keyword.operator)
; other lhs rhs expr operators that are words  
(instance_of_expr ["instance" "of"] @keyword.operator ) 
(cast_expr [ "cast"] @keyword.operator ) 
(castable_expr [ "castable"] @keyword.operator ) 
(treat_expr [ "treat"] @keyword.operator ) 
(intersect_except_expr [ "intersect" "except"] @keyword.operator )
(union_expr [ "union" ] @keyword.operator )
(string_concat_expr ["||"] @operator )
(bang_expr [ "!" ] @operator )
(arrow_expr [ "=>" ]  @operator)
(context_item_expr [ "." ] @operator)
(postfix_lookup "?" @operator ) 
(unary_lookup "?" @operator )
; constructors 
(square_array_constructor ["[" "]"] @constructor )
(curly_array_constructor ["array" ] @constructor )
(map_constructor ["map" ] @constructor )
(string_constructor ["``[" "]``"] @constructor )
(comp_elem_constructor ["element"] @constructor )
(comp_attr_constructor ["attribute"] @constructor )
(comp_doc_constructor ["document"] @yconstructor )
(comp_text_constructor ["text" ] @constructor )
(comp_comment_constructor ["comment" ] @constructor )
(comp_pi_constructor ["processing-instruction" ] @constructor )
(comp_namespace_constructor ["namespace" ] @constructor )
; also say these are constuctors
(parenthesized_expr ["(" ")"] @constructor)
(predicate ["[" "]"] @constructor) 
; literals
[(string_literal) (char_data) (char_ref) (char_group) ] @string
[ (integer_literal) (decimal_literal) (double_literal) (lookup_digit) ] @number
[
 (var_ref "$") 
 local_part: (identifier)
 unprefixed: (identifier) 
 ] @variable
[
 ns_builtin: (identifier)
 prefix: (identifier) 
 ] @namespace
; when in the tree context of
; sequence_type/item_type
; then identify as a builtin type
(atomic_or_union_type
  [ 
    local_part: (identifier) @type.builtin
    unprefixed: (identifier) @type.builtin
    ])
(arrow_function 
  [ 
    local_part: (identifier) @function
    unprefixed: (identifier) @function
    ])
(function_call
  [ 
    local_part: (identifier) @function
    unprefixed: (identifier) @function
    ])
; item types 
(any_item "item" @type)
(empty_sequence "empty-sequence" @type)
; kind tests - simple
[ 
  (any_kind_test "node")
  (namespace_node_test "namespace-node")
  (comment_test "comment")
  (text_test "text")
  ] @type
; kind tests - complex
[
 (document_test "document-node")
 (element_test "element")
 (attribute_test "attribute")
 (schema_element_test "schema-element")
 (schema_attribute_test "schema-attribute")
 (pi_test "processing-instruction")
 ] @type
; function tests
[
 (any_function_test "function")
 (typed_function_test "function")
 (any_map_test "map" )
 (typed_map_test"map" )
 (any_array_test "array" )
 (typed_array_test "array")
 ] @type
; direct XML constructors
[(start_tag) (end_tag) (empty_tag)  ] @tag
(direct_attribute 
  attr_name: (identifier) @tag.attribute
  attr_value: (direct_attribute_value) @string
  )
; MISC
; TODO! hightlight annotation  TSAnnotaion %private %updating and maybe restxq
;
[ "%" ";" ":" "," "|" "(:" ":)"] @punctuation.delimiter
[ "/" "//" ] @punctuation.delimiter ; ? TODO xpath path
["{" "}" "(" ")"] @punctuation.bracket ; unless ( ) is used to *constuct* sequences eg ( 1 to 10 )
(interpolation ["`{" "}`"] @punctuation.special )  ; within string constructors
[
 (direct_comment)
 (comment)
 ] @comment
(ERROR) @error
