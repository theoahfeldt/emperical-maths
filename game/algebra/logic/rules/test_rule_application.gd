extends Node


func _ready() -> void:
	var rule := ManipulationRule.parse("(a+0)", "a")
	var expression := AlgebraicExpression.from_string("(b+0)")
	var result := rule.apply(expression)
	assert(result is ApplicationSuccess)
	assert(result.result.identical_to(AlgebraicVariable.create("b")))
	var expression2 := AlgebraicExpression.from_string("(0+b)")
	var result2 := rule.apply(expression2)
	assert(result2 is ApplicationFailure)
	var rule2 := ManipulationRule.parse("0", "(a+-a)")
	var expression3 := AlgebraicExpression.from_string("0")
	var result3 := rule2.apply(expression3)
	assert(result3 is ApplicationSuccess)
	print(result3.result)
	test_equality()


func test_equality() -> void:
	var rule := ManipulationRule.create(AlgebraicEquality.from_string("a=b"),
			AlgebraicEquality.from_string("(a+r)=(b+r)"))
	var equality := AlgebraicEquality.from_string("x=y")
	var result := rule.apply(equality)
	assert(result is ApplicationSuccess)
	print(result.result)
