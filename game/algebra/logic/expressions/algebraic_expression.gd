class_name AlgebraicExpression
extends AlgebraicObject
# Abstract class


static func from_string(string: String) -> AlgebraicExpression:
	return AlgebraicParser.parse_expression(string)


func identical_to(_other: AlgebraicExpression) -> bool:
	push_error("Function not implemented")
	return false


func pattern_match(_expression: AlgebraicExpression) -> PatternMatchResult:
	push_error("Function not implemented")
	return PatternMatchFailure.new()


func substitute(_substitution: Dictionary) -> AlgebraicExpression:
	push_error("Function not implemented")
	return AlgebraicExpression.new()
