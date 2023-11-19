extends Component
class_name GraphicalExpression


@export var default_color := Color.WHITE
@export var marked_color := Color.AQUA


func mark() -> void:
	set_color(marked_color)


func initialize() -> void:
	set_color(default_color)
