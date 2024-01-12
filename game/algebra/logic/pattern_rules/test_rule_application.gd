extends Node


func _ready() -> void:
	var rule := Rule.parse("(a+0)", "a")
	var expression := AlgebraicParser.parse_expression("(b+0)")
	var result := rule.apply(expression)
	assert(result is ApplicationSuccess)
	assert(result.result.identical_to(AlgebraicVariable.create("b")))
	var expression2 := AlgebraicParser.parse_expression("(0+b)")
	var result2 := rule.apply(expression2)
	assert(result2 is ApplicationFailure)
