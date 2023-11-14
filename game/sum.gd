extends AlgebraicExpression
class_name Sum


@export var a: AlgebraicExpression
@export var b: AlgebraicExpression


func get_components():
	return [
		$LeftParenthesis,
		a,
		$Sign,
		b,
		$RightParenthesis,
	]


func get_width() -> float:
	var width = 0
	for component in get_components():
		width += component.get_width()
	return width


func set_color(color: Color):
	for component in get_components():
		component.set_color(color)


func set_color_by_depth(depth: int):
	for component in get_components():
		component.set_color_by_depth(depth + 1)


func set_term_positions():
	var width = 0
	for component in get_components():
		component.position = Vector2(width, 0)
		width += component.get_width()


# Called when the node enters the scene tree for the first time.
func _ready():
	set_term_positions()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
