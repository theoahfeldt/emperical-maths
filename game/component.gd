# Abstract class
extends Node2D
class_name Component


@export var deep_color: Color = Color.INDIGO
@export var shallow_color: Color = Color.AQUA


func get_width() -> int:
	push_error("Function not implemented")
	return 0


func set_color(color: Color) -> void:
	push_error("Function not implemented")
	return


func color_by_depth(depth: int) -> Color:
	var shallowness = exp(-(depth - 1)/3.0)
	return deep_color.lerp(shallow_color, shallowness)


func set_color_by_depth(depth: int) -> void:
	push_error("Function not implemented")
	return


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	pass
