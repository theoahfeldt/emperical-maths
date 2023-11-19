class_name Component
extends Node2D
## Abstract class


@export var deep_color: Color = Color.INDIGO
@export var shallow_color: Color = Color.AQUA


func get_width() -> int:
	push_error("Function not implemented")
	return 0


func set_color(_color: Color) -> void:
	push_error("Function not implemented")
	return


func color_by_depth(depth: int) -> Color:
	var shallowness = exp(-(depth - 1)/3.0)
	return deep_color.lerp(shallow_color, shallowness)


func set_color_by_depth(_depth: int) -> void:
	push_error("Function not implemented")
	return
