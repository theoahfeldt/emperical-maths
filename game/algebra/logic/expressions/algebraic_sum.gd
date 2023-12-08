class_name AlgebraicSum
extends AlgebraicExpression


@export var left_term: AlgebraicExpression
@export var right_term: AlgebraicExpression


static func create(
		a: AlgebraicExpression,
		b: AlgebraicExpression,
		p_color: Color = default_color,
		) -> AlgebraicSum:
	var sum = AlgebraicSum.new()
	sum.add_child(a)
	sum.add_child(b)
	sum.left_term = a
	sum.right_term = b
	sum.color = p_color
	return sum


func identical_to(other: AlgebraicExpression) -> bool:
	if other is AlgebraicSum:
		return (left_term.identical_to(other.left_term)
				and right_term.identical_to(other.right_term))
	return false


func copy() -> AlgebraicSum:
	return AlgebraicSum.create(left_term.copy(), right_term.copy(), color)


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


func pretty_string() -> String:
	return "(%s + %s)" % [left_term.pretty_string(), right_term.pretty_string()]


func set_color(p_color: Color) -> void:
	color = p_color
	left_term.set_color(p_color)
	right_term.set_color(p_color)


func mark() -> void:
	color = marked_color
	left_term.set_color(_sub_colors[0])
	right_term.set_color(_sub_colors[1])
