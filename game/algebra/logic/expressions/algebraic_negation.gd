class_name AlgebraicNegation
extends AlgebraicExpression


@export var expression: AlgebraicExpression


static func create(
		a: AlgebraicExpression, p_color: Color = default_color
		) -> AlgebraicNegation:
	var negation = AlgebraicNegation.new()
	negation.add_child(a)
	negation.expression = a
	negation.color = p_color
	return negation


func identical_to(other: AlgebraicExpression) -> bool:
	if other is AlgebraicNegation:
		return expression.identical_to(other.expression)
	return false


func copy() -> AlgebraicNegation:
	return AlgebraicNegation.create(expression.copy(), color)


func replace_expression(new: AlgebraicExpression) -> void:
	remove_child(expression)
	expression.queue_free()
	add_child(new)
	expression = new


func pretty_string() -> String:
	return "-%s" % expression.pretty_string()


func mark() -> void:
	color = _sub_colors[0]
