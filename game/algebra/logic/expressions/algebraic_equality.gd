class_name AlgebraicEquality
extends AlgebraicObject


@export var left_expression: AlgebraicExpression
@export var right_expression: AlgebraicExpression


static func create(
		a: AlgebraicExpression,
		b: AlgebraicExpression,
		) -> AlgebraicEquality:
	var new = AlgebraicEquality.new()
	new.add_child(a)
	new.add_child(b)
	new.left_expression = a
	new.right_expression = b
	return new


func copy() -> AlgebraicEquality:
	return AlgebraicEquality.create(
			left_expression.copy(), right_expression.copy())


func subexpressions() -> Array[AlgebraicExpression]:
	return [left_expression, right_expression]


func replace_subexpression(new: AlgebraicExpression, index: int) -> void:
	match index:
		0:
			replace_left_expression(new)
		1:
			replace_right_expression(new)
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


func replace_left_expression(new: AlgebraicExpression) -> void:
	remove_child(left_expression)
	left_expression.queue_free()
	add_child(new)
	left_expression = new


func replace_right_expression(new: AlgebraicExpression) -> void:
	remove_child(right_expression)
	right_expression.queue_free()
	add_child(new)
	right_expression = new
