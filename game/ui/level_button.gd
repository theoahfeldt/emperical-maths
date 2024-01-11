@tool
class_name LevelButton
extends Button


@export var assertion: Assertion:
	set(value):
		assertion = value
		if Engine.is_editor_hint():
			text = value.equality
			_find_dependencies()
@export var dependencies: Array[LevelButton]


func _find_dependencies() -> void:
	dependencies = []
	if assertion is Consequence:
		for button: LevelButton in get_tree().get_nodes_in_group("level_buttons"):
			if button.assertion.equality in assertion.premises.map(func(a): return a.equality):
				dependencies.append(button)
