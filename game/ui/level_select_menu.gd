class_name LevelSelectMenu
extends VBoxContainer


signal selected(level_creator: Resource)


func _ready() -> void:
	for button in get_tree().get_nodes_in_group("level_buttons"):
		button.pressed.connect(
				func(): _on_level_button_pressed(button.level_creator))


func _on_level_button_pressed(level_creator: Resource) -> void:
	selected.emit(level_creator)
