class_name GraphicalBase
extends GraphicalComponent


var expression: GraphicalExpressionOrMenu
var center_bottom_position: Vector2


func _process(delta: float) -> void:
	update_position(delta)


func get_size() -> Vector2:
	return expression.get_size()


static func create(
		p_expression: GraphicalExpressionOrMenu,
		p_center_bottom_position := Vector2.ZERO,
		) -> GraphicalBase:
	var new := GraphicalBase.new()
	new.add_child(p_expression)
	new.expression = p_expression
	new.center_bottom_position = p_center_bottom_position
	return new


func replace_expression(new: GraphicalExpressionOrMenu) -> void:
	remove_child(expression)
	expression.queue_free()
	new.position = Vector2.ZERO
	add_child(new)
	expression = new
	center()


func center() -> void:
	center_bottom_at(center_bottom_position)


func center_smooth() -> void:
	center_bottom_at_smooth(center_bottom_position)


func clear_color() -> void:
	expression.clear_color()
