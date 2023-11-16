extends Component
class_name GraphicalExpression


const margin: int = 1

@export var default_color := Color.WHITE
@export var selected_color := Color.AQUA

var _is_selected := false
var _just_selected := false


func _process(delta: float) -> void:
	if _just_selected:
		set_color(selected_color)
		_just_selected = false


func select() -> void:
	_is_selected = true
	_just_selected = true
