class_name Level


var equality: AlgebraicEquality
var algebraic_rules: Array[AlgebraicRule]


static func create(
		p_equality: AlgebraicEquality,
		p_algebraic_rules: Array[AlgebraicRule],
		) -> Level:
	var new := Level.new()
	new.equality = p_equality
	new.algebraic_rules = p_algebraic_rules
	return new


func is_cleared() -> bool:
	return equality.left_expression.identical_to(equality.right_expression)
