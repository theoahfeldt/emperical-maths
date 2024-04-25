class_name AlgebraicExponentiation
extends AlgebraicExpression


var base: AlgebraicExpression
var exponent: AlgebraicExpression


func _to_string() -> String:
	return "(%s^%s)" % [base, exponent]


static func create(
		p_base: AlgebraicExpression,
		p_exponent: AlgebraicExpression,
		p_color: Color = default_color,
		) -> AlgebraicExponentiation:
	var new = AlgebraicExponentiation.new()
	new.base = p_base
	new.exponent = p_exponent
	new.color = p_color
	return new


func copy() -> AlgebraicExponentiation:
	return AlgebraicExponentiation.create(base.copy(), exponent.copy(), color)


func subexpressions() -> Array[AlgebraicExpression]:
	return [base, exponent]


func replace_subexpression(new: AlgebraicExpression, index: int) -> void:
	match index:
		0:
			base = new
		1:
			exponent = new
		var n:
			push_error("Index %d out of range" % n)


func to_graphical() -> GraphicalExponentiation:
	return GraphicalExponentiation.create(
			base.to_graphical(), exponent.to_graphical())


func set_color(p_color: Color) -> void:
	color = p_color
	base.set_color(p_color)
	exponent.set_color(p_color)


func mark() -> void:
	color = marked_color
	base.set_color(_sub_colors[0])
	exponent.set_color(_sub_colors[1])


func identical_to(other: ManipulableExpression) -> bool:
	if other is AlgebraicExponentiation:
		return (base.identical_to(other.base)
				and exponent.identical_to(other.exponent))
	return false


func pattern_match(expression: ManipulableExpression) -> PatternMatchResult:
	if expression is AlgebraicExponentiation:
		var base_match := base.pattern_match(expression.base)
		var exponent_match := exponent.pattern_match(expression.exponent)
		return PatternMatchResult.merge(base_match, exponent_match)
	else:
		return PatternMatchFailure.new()


func substitute(
		substitution: Dictionary, replace_unspecified_variables: bool = false
		) -> AlgebraicExponentiation:
	var instance_base := base.substitute(
			substitution, replace_unspecified_variables)
	var instance_exponent := exponent.substitute(
			substitution, replace_unspecified_variables)
	return AlgebraicExponentiation.create(instance_base, instance_exponent)
