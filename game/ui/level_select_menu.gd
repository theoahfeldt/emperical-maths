class_name LevelSelectMenu
extends ScrollContainer


signal selected(assertion: Resource)


func _ready() -> void:
	for button: LevelButton in get_tree().get_nodes_in_group("level_buttons"):
		button.pressed.connect(
				func(): _on_level_button_pressed(button.assertion))


func _on_level_button_pressed(assertion: Resource) -> void:
	selected.emit(assertion)
