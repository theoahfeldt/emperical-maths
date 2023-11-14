# Abstract class.
extends Component
class_name AlgebraicExpression


const margin: int = 1
@export var default_color: Color = Color.WHITE
@export var selected_color: Color = Color.AQUA


func selected():
	set_color(selected_color)


func deselected():
	set_color(default_color)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
