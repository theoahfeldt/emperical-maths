class_name GraphicalExponentiation
extends GraphicalExpression


func get_width() -> float:
	return get_base().get_width() + get_exponent().get_width()


func get_height() -> float:
	return get_base().get_height() + get_exponent().get_height()


func set_positions() -> void:
	get_base().set_position(Vector2.ZERO)
	get_exponent().set_position(Vector2(get_base().get_width(), -get_base().get_height()))


func set_positions_smooth() -> void:
	get_base().move_smooth_to(Vector2.ZERO)
	get_exponent().move_smooth_to(Vector2(get_base().get_width(), -get_base().get_height()))


static func create(
		p_base: GraphicalExpressionOrMenu,
		p_exponent: GraphicalExpressionOrMenu,
		) -> GraphicalExponentiation:
	var new := GraphicalExponentiation.new()
	new.subexpressions = [p_base, p_exponent]
	new._add_components_as_children()
	new.set_positions()
	return new


func get_base() -> GraphicalExpressionOrMenu:
	return subexpressions[0]


func get_exponent() -> GraphicalExpressionOrMenu:
	return subexpressions[1]
