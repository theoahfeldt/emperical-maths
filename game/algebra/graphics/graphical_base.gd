class_name GraphicalBase
extends Node2D


const movement_duration: float = 0.05

var expression: GraphicalExpressionOrMenu
var _movement: Movement


func _process(delta: float) -> void:
	if _movement != null and _movement.has_update(delta):
		position = _movement.current_position()


func initialize(p_expression: GraphicalExpressionOrMenu) -> void:
	add_child(p_expression)
	expression = p_expression
	center()


func replace_expression(new: GraphicalExpressionOrMenu) -> void:
	remove_child(expression)
	expression.queue_free()
	new.position = Vector2.ZERO
	add_child(new)
	expression = new
	center()


func reset() -> void:
	expression.initialize()


func center() -> void:
	position = _get_center()


func center_smooth() -> void:
	_movement = Movement.create(position, _get_center(), movement_duration)


func _get_center() -> Vector2:
	return (get_viewport_rect().size - Vector2(expression.get_size())) / 2.0
