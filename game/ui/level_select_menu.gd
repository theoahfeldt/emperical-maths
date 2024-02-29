@tool
class_name LevelSelectMenu
extends ScrollContainer


signal selected(button: LevelButton)


func _ready() -> void:
	for button: LevelButton in get_tree().get_nodes_in_group("level_buttons"):
		button.pressed.connect(
				func(): _on_level_button_pressed(button))


func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		queue_redraw()


func _draw() -> void:
	for button: LevelButton in get_tree().get_nodes_in_group("level_buttons"):
		if button is LevelButton:
			_draw_dependencies(button)


func _draw_dependencies(button: LevelButton) -> void:
	var button_center: Vector2 = button.get_global_rect().get_center()
	for dependency in button.dependencies:
		var dependency_center: Vector2 = dependency.get_global_rect().get_center()
		draw_line(dependency_center, button_center, Color.WHITE, 5)


func _on_level_button_pressed(button: LevelButton) -> void:
	selected.emit(button)
