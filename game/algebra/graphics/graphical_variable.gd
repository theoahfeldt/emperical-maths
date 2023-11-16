class_name GraphicalVariable
extends GraphicalExpression


@export var variable_name: String


func _ready() -> void:
	set_label_position()
	set_label_text()


func get_width() -> int:
	return $Glyph.get_width()


func set_color(color: Color) -> void:
	$Glyph.set_color(color)


func set_color_by_depth(depth: int) -> void:
	set_color(color_by_depth(depth))


func set_label_position() -> void:
	$Glyph.set_position(Vector2(0, 0))


func set_label_text() -> void:
	$Glyph.set_text(variable_name)
