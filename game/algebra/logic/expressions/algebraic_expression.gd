class_name AlgebraicExpression
extends ManipulableExpression
# Abstract class


static func from_string(string: String) -> AlgebraicExpression:
	return AlgebraicParser.parse_algebraic(string)
