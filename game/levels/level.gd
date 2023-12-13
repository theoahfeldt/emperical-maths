class_name Level


var equality: AlgebraicEquality
var algebraic_rules: Array[AlgebraicRule]
var substitution_rules: Array[SubstitutionRule]


static func create(
		p_equality: AlgebraicEquality,
		p_algebraic_rules: Array[AlgebraicRule],
		p_substitution_rules: Array[SubstitutionRule],
		) -> Level:
	var new := Level.new()
	new.equality = p_equality
	new.algebraic_rules = p_algebraic_rules
	new.substitution_rules = p_substitution_rules
	return new


func is_cleared() -> bool:
	return equality.left_expression.identical_to(equality.right_expression)
