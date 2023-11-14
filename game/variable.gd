extends AlgebraicExpression


@export var variable_name: String


func get_width():
	return $Glyph.get_width()


func set_color(color: Color):
	$Glyph.set_color(color)


func set_color_by_depth(depth: int):
	set_color(color_by_depth(depth))


func set_label_position():
	$Glyph.set_position(Vector2(0, 0))


func set_label_text():
	$Glyph.set_text(variable_name)


# Called when the node enters the scene tree for the first time.
func _ready():
	set_label_position()
	set_label_text()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
