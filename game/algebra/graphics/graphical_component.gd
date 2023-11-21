class_name GraphicalComponent
extends Node2D
## Abstract class


@export var deep_color: Color = Color.INDIGO
@export var shallow_color: Color = Color.AQUA


func get_size() -> Vector2i:
	return Vector2i(get_width(), get_height())


func get_width() -> int:
	return get_size().x


func get_height() -> int:
	return get_size().y


func set_color(_color: Color) -> void:
	push_error("Function not implemented")


func set_color_by_depth(_depth: int) -> void:
	push_error("Function not implemented")


func color_by_depth(depth: int) -> Color:
	var shallowness = exp(-(depth - 1)/3.0)
	return deep_color.lerp(shallow_color, shallowness)
