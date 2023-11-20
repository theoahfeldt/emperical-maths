class_name Glyph
extends GraphicalComponent


const glyph_label_scene := preload("res://algebra/graphics/glyph_label.tscn")

var _label: Label


func get_width() -> int:
	return get_size().x


func set_color(color: Color) -> void:
	_label.add_theme_color_override("font_color", color)


func set_color_by_depth(depth: int) -> void:
	set_color(color_by_depth(depth))


static func create(text: String) -> Glyph:
	var glyph := Glyph.new()
	var label := glyph_label_scene.instantiate()
	label.set_text(text)
	glyph.add_child(label)
	glyph._label = label
	return glyph


func get_size() -> Vector2i:
	var font = _label.get_theme_font("")
	return font.get_string_size(
		_label.text,
		HORIZONTAL_ALIGNMENT_LEFT,
		-1,
		_label.get_theme_font_size("")
	)


func set_text(text) -> void:
	_label.set_text(text)
