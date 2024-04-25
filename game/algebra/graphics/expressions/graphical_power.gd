class_name GraphicalPower
extends GraphicalExpression


const HORIZONTAL_OVERLAP: int = 50
const EXPONENT_SCALE: float = 0.7


func get_width() -> float:
	return get_base().get_width() + EXPONENT_SCALE * get_exponent().get_width()


func get_height() -> float:
	return get_base().get_height() + EXPONENT_SCALE * get_exponent().get_height() - HORIZONTAL_OVERLAP


func set_scales() -> void:
	get_exponent().set_scale(EXPONENT_SCALE * Vector2.ONE)


func set_positions() -> void:
	var base := get_base()
	base.set_position(Vector2.ZERO)
	get_exponent().set_position(
			Vector2(base.get_width(), HORIZONTAL_OVERLAP - base.get_height()))


func set_positions_smooth() -> void:
	var base := get_base()
	base.move_smooth_to(Vector2.ZERO)
	get_exponent().move_smooth_to(
			Vector2(base.get_width(), HORIZONTAL_OVERLAP - base.get_height()))


static func create(
		p_base: GraphicalExpressionOrMenu,
		p_exponent: GraphicalExpressionOrMenu,
		) -> GraphicalPower:
	var new := GraphicalPower.new()
	new.subexpressions = [p_base, p_exponent]
	new._add_components_as_children()
	new.set_scales()
	new.set_positions()
	return new


func get_base() -> GraphicalExpressionOrMenu:
	return subexpressions[0]


func get_exponent() -> GraphicalExpressionOrMenu:
	return subexpressions[1]
