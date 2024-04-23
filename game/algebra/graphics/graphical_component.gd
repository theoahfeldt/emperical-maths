class_name GraphicalComponent
extends Node2D
## Abstract class


var movement_duration: float = 0.08
var _movement: Movement


func get_size() -> Vector2:
	return Vector2(get_width(), get_height())


func get_width() -> float:
	return get_size().x


func get_height() -> float:
	return get_size().y


func set_color(_color: Color) -> void:
	push_error("Function not implemented")


func set_opacity(_alpha: float) -> void:
	push_error("Function not implemented")


func center_at(p_position: Vector2) -> void:
	position = p_position + Vector2(-get_width(), get_height()) / 2.0


func center_at_smooth(target: Vector2) -> void:
	var compensated: Vector2 = target + Vector2(-get_width(), get_height()) / 2.0
	_movement = Movement.create(position, compensated, movement_duration)


func center_in_viewport() -> void:
	center_at(get_viewport_rect().size / 2.0)


func center_in_viewport_smooth() -> void:
	center_at_smooth(get_viewport_rect().size / 2.0)


func update_position(delta: float) -> void:
	if _movement != null and _movement.has_update(delta):
		position = _movement.current_position()
	for child in get_children():
		if child is GraphicalComponent:
			child.update_position(delta)


func move_smooth_to(target: Vector2) -> void:
	_movement = Movement.create(position, target, movement_duration)
