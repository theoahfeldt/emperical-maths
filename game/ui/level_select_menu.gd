class_name LevelSelectMenu
extends VBoxContainer


signal selected(level_path: String)

var levels: Array[String] = [
	"res://levels/level1.gd",
	"res://levels/level2.gd",
	"res://levels/level3.gd",
	]
var _buttons: Array[Button]


func _ready() -> void:
	for i in range(levels.size()):
		add_level_button(i)
	_buttons[0].grab_focus()


func add_level_button(number: int) -> void:
	var button := Button.new()
	button.text = "level %d" % number
	_buttons.append(button)
	add_child(button)
	button.pressed.connect(func(): _on_button_pressed(number))


func _on_button_pressed(id: int) -> void:
	selected.emit(levels[id])
