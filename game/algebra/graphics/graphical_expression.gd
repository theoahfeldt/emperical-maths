extends Component
class_name GraphicalExpression


const margin: int = 1

@export var default_color := Color.WHITE
@export var selected_color := Color.AQUA


func select() -> void:
	set_color(selected_color)


func initialize() -> void:
	set_color(default_color)
