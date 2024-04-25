class_name AlgebraicProduct
extends AlgebraicExpression


var left_factor: AlgebraicExpression
var right_factor: AlgebraicExpression


func _to_string() -> String:
	return "(%s*%s)" % [left_factor, right_factor]


static func create(
		left: AlgebraicExpression,
		right: AlgebraicExpression,
		p_color: Color = default_color,
		) -> AlgebraicProduct:
	var new = AlgebraicProduct.new()
	new.left_factor = left
	new.right_factor = right
	new.color = p_color
	return new


func copy() -> AlgebraicProduct:
	return AlgebraicProduct.create(left_factor.copy(), right_factor.copy(), color)


func subexpressions() -> Array[AlgebraicExpression]:
	return [left_factor, right_factor]


func replace_subexpression(new: AlgebraicExpression, index: int) -> void:
	match index:
		0:
			left_factor = new
		1:
			right_factor = new
		var n:
			push_error("Index %d out of range" % n)


func to_graphical() -> GraphicalProduct:
	return GraphicalProduct.create(
			left_factor.to_graphical(), right_factor.to_graphical())


func set_color(p_color: Color) -> void:
	color = p_color
	left_factor.set_color(p_color)
	right_factor.set_color(p_color)


func mark() -> void:
	color = marked_color
	left_factor.set_color(_sub_colors[0])
	right_factor.set_color(_sub_colors[1])


func identical_to(other: ManipulableExpression) -> bool:
	if other is AlgebraicProduct:
		return (left_factor.identical_to(other.left_factor)
				and right_factor.identical_to(other.right_factor))
	return false


func pattern_match(expression: ManipulableExpression) -> PatternMatchResult:
	if expression is AlgebraicProduct:
		var left_match := left_factor.pattern_match(expression.left_factor)
		var right_match := right_factor.pattern_match(expression.right_factor)
		return PatternMatchResult.merge(left_match, right_match)
	else:
		return PatternMatchFailure.new()


func substitute(
		substitution: Dictionary, replace_unspecified_variables: bool = false
		) -> AlgebraicProduct:
	var instance_left := left_factor.substitute(
			substitution, replace_unspecified_variables)
	var instance_right := right_factor.substitute(
			substitution, replace_unspecified_variables)
	return AlgebraicProduct.create(instance_left, instance_right)
