class_name AlgebraicExpression
extends AlgebraicObject
# Abstract class


static func from_string(string: String) -> AlgebraicExpression:
	return AlgebraicParser.parse_expression(string)
