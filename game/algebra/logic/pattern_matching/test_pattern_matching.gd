extends Node


func _ready() -> void:
	test_match()
	test_no_match()
	test_equality()


func test_match() -> void:
	var pattern := AlgebraicExpression.from_string("(a+b)")
	var expression := AlgebraicExpression.from_string("((a+b)+2)")
	var result := pattern.pattern_match(expression)
	assert(result is PatternMatchSuccess)
	print(result.assignments["a"])
	print(result.assignments["b"])


func test_no_match() -> void:
	var pattern := AlgebraicExpression.from_string("(a+a)")
	var expression := AlgebraicExpression.from_string("(1+2)")
	var result := pattern.pattern_match(expression)
	assert(result is PatternMatchFailure)


func test_equality() -> void:
	var pattern := AlgebraicEquality.from_string("a=b")
	var expression := AlgebraicEquality.from_string("x=y")
	var result := pattern.pattern_match(expression)
	assert(result is PatternMatchSuccess)
	print(result.assignments["a"])
	print(result.assignments["b"])
