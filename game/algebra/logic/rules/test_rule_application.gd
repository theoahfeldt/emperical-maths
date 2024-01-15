extends Node


func _ready() -> void:
	var rule := AlgebraicRule.parse("(a+0)", "a")
	var expression := AlgebraicParser.parse_expression("(b+0)")
	var result := rule.apply(expression)
	assert(result is ApplicationSuccess)
	assert(result.result.identical_to(AlgebraicVariable.create("b")))
	var expression2 := AlgebraicParser.parse_expression("(0+b)")
	var result2 := rule.apply(expression2)
	assert(result2 is ApplicationFailure)
	var rule2 := AlgebraicRule.parse("0", "(a+-a)")
	var expression3 := AlgebraicParser.parse_expression("0")
	var result3 := rule2.apply(expression3)
	assert(result3 is ApplicationSuccess)
	print(result3.result)
