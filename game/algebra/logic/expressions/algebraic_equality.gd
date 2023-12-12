class_name AlgebraicEquality
extends AlgebraicObject


var left_expression: AlgebraicExpression
var right_expression: AlgebraicExpression


static func create(
		left: AlgebraicExpression,
		right: AlgebraicExpression,
		p_color: Color = default_color,
		) -> AlgebraicEquality:
	var new = AlgebraicEquality.new()
	new.left_expression = left
	new.right_expression = right
	new.color = p_color
	return new


func copy() -> AlgebraicEquality:
	return AlgebraicEquality.create(
			left_expression.copy(), right_expression.copy())


func subexpressions() -> Array[AlgebraicExpression]:
	return [left_expression, right_expression]


func replace_subexpression(new: AlgebraicExpression, index: int) -> void:
	match index:
		0:
			left_expression = new
		1:
			right_expression = new
		var n:
			push_error("Invalid index: ", n)


func pretty_string() -> String:
	return "%s = %s" % [left_expression.pretty_string(), right_expression.pretty_string()]


func to_graphical() -> GraphicalEquality:
	return GraphicalEquality.create(
			left_expression.to_graphical(), right_expression.to_graphical())


func set_color(p_color: Color) -> void:
	color = p_color
	left_expression.set_color(p_color)
	right_expression.set_color(p_color)


func mark() -> void:
	color = marked_color
	left_expression.set_color(_sub_colors[0])
	right_expression.set_color(_sub_colors[1])
