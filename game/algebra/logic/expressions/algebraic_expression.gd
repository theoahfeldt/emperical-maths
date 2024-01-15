class_name AlgebraicExpression
extends AlgebraicObject
# Abstract class


func identical_to(_other: AlgebraicExpression) -> bool:
	push_error("Function not implemented")
	return false


func pattern_match(_expression: AlgebraicExpression) -> PatternMatchResult:
	push_error("Function not implemented")
	return PatternMatchFailure.new()


func substitute(_substitution: Dictionary) -> AlgebraicExpression:
	push_error("Function not implemented")
	return AlgebraicExpression.new()
