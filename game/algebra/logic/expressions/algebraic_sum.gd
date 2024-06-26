class_name AlgebraicSum
extends AlgebraicExpression


var left_term: AlgebraicExpression
var right_term: AlgebraicExpression


func _to_string() -> String:
	return "(%s+%s)" % [left_term, right_term]


static func create(
		left: AlgebraicExpression,
		right: AlgebraicExpression,
		p_color: Color = default_color,
		) -> AlgebraicSum:
	var new = AlgebraicSum.new()
	new.left_term = left
	new.right_term = right
	new.color = p_color
	return new


func copy() -> AlgebraicSum:
	return AlgebraicSum.create(left_term.copy(), right_term.copy(), color)


func subexpressions() -> Array[AlgebraicExpression]:
	return [left_term, right_term]


func replace_subexpression(new: AlgebraicExpression, index: int) -> void:
	match index:
		0:
			left_term = new
		1:
			right_term = new
		var n:
			push_error("Index %d out of range" % n)


func to_graphical() -> GraphicalSum:
	return GraphicalSum.create(
			left_term.to_graphical(), right_term.to_graphical())


func set_color(p_color: Color) -> void:
	color = p_color
	left_term.set_color(p_color)
	right_term.set_color(p_color)


func mark() -> void:
	color = marked_color
	left_term.set_color(_sub_colors[0])
	right_term.set_color(_sub_colors[1])


func identical_to(other: ManipulableExpression) -> bool:
	if other is AlgebraicSum:
		return (left_term.identical_to(other.left_term)
				and right_term.identical_to(other.right_term))
	return false


func pattern_match(expression: ManipulableExpression) -> PatternMatchResult:
	if expression is AlgebraicSum:
		var left_match := left_term.pattern_match(expression.left_term)
		var right_match := right_term.pattern_match(expression.right_term)
		return PatternMatchResult.merge(left_match, right_match)
	else:
		return PatternMatchFailure.new()


func substitute(
		substitution: Dictionary, replace_unspecified_variables: bool = false
		) -> AlgebraicSum:
	var instance_left := left_term.substitute(
			substitution, replace_unspecified_variables)
	var instance_right := right_term.substitute(
			substitution, replace_unspecified_variables)
	return AlgebraicSum.create(instance_left, instance_right)
