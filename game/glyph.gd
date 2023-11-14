extends Component


@export var text: String


func get_size():
	var font = $Label.get_theme_font("font")
	return font.get_string_size(
		$Label.text,
		HORIZONTAL_ALIGNMENT_LEFT,
		-1,
		$Label.get_theme_font_size("font_size")
	)


func get_width():
	return get_size().x


func set_text(text):
	$Label.set_text(text)


func set_color(color: Color):
	$Label.add_theme_color_override("font_color", color)


func set_color_by_depth(depth: int):
	set_color(color_by_depth(depth))


# Called when the node enters the scene tree for the first time.
func _ready():
	set_text(text)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
