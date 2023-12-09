class_name AlgebraicSum
extends AlgebraicExpression


@export var left_term: AlgebraicExpression
@export var right_term: AlgebraicExpression


static func create(
		a: AlgebraicExpression,
		b: AlgebraicExpression,
		p_color: Color = default_color,
		) -> AlgebraicSum:
	var new = AlgebraicSum.new()
	new.add_child(a)
	new.add_child(b)
	new.left_term = a
	new.right_term = b
	new.color = p_color
	return new


func identical_to(other: AlgebraicExpression) -> bool:
	if other is AlgebraicSum:
		return (left_term.identical_to(other.left_term)
				and right_term.identical_to(other.right_term))
	return false


func copy() -> AlgebraicSum:
	return AlgebraicSum.create(left_term.copy(), right_term.copy(), color)


func subexpressions() -> Array[AlgebraicExpression]:
	return [left_term, right_term]


func replace_subexpression(new: AlgebraicExpression, index: int) -> void:
	match index:
		0:
			replace_left_term(new)
		1:
			replace_right_term(new)
		var n:
			push_error("Index %d out of range" % n)


func pretty_string() -> String:
	return "(%s + %s)" % [left_term.pretty_string(), right_term.pretty_string()]


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


func replace_left_term(new: AlgebraicExpression) -> void:
	remove_child(left_term)
	left_term.queue_free()
	add_child(new)
	left_term = new


func replace_right_term(new: AlgebraicExpression) -> void:
	remove_child(right_term)
	right_term.queue_free()
	add_child(new)
	right_term = new
