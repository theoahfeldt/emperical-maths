extends Node


func _ready() -> void:
	test_match()
	test_no_match()


func test_match() -> void:
	var pattern := AlgebraicParser.parse_expression("(a+b)")
	var expression := AlgebraicParser.parse_expression("((a+b)+2)")
	var result := pattern.pattern_match(expression)
	assert(result is PatternMatchSuccess)
	print(result.assignments["a"].pretty_string())
	print(result.assignments["b"].pretty_string())


func test_no_match() -> void:
	var pattern := AlgebraicParser.parse_expression("(a+a)")
	var expression := AlgebraicParser.parse_expression("(1+2)")
	var result := pattern.pattern_match(expression)
	assert(result is PatternMatchFailure)
