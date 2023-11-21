class_name GraphicalExpressionOrMenu
extends GraphicalComponent


const default_color := Color.WHITE
const marked_color := Color.AQUA


func initialize() -> void:
	set_color(default_color)


func center() -> void:
	position = (get_viewport_rect().size - Vector2(get_size())) / 2.0
