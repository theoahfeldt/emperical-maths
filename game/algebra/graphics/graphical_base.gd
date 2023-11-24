class_name GraphicalBase
extends GraphicalComponent


var expression: GraphicalExpressionOrMenu


func _process(delta: float) -> void:
	update_position(delta)


static func create(p_expression: GraphicalExpressionOrMenu) -> GraphicalBase:
	var new := GraphicalBase.new()
	new.initialize(p_expression)
	return new


func initialize(p_expression: GraphicalExpressionOrMenu) -> void:
	add_child(p_expression)
	expression = p_expression


func replace_expression(new: GraphicalExpressionOrMenu) -> void:
	remove_child(expression)
	expression.queue_free()
	new.position = Vector2.ZERO
	add_child(new)
	expression = new
	center()


func clear_color() -> void:
	expression.clear_color()


func center() -> void:
	position = _get_center()


func center_smooth() -> void:
	_movement = Movement.create(position, _get_center(), movement_duration)


func _get_center() -> Vector2:
	return (get_viewport_rect().size - Vector2(expression.get_size())) / 2.0
