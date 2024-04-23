class_name GraphicalExpressionOrMenu
extends GraphicalComponent


const default_color := Color(Color.WHITE, 0.5)


func clear_color() -> void:
	set_color(default_color)


func min_y() -> float:
	return -get_height()


func max_y() -> float:
	return min_y() + get_height()
