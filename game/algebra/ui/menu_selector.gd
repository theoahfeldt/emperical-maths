class_name MenuSelector
extends Node
# Abstract class


var _menu: SelectionMenu


func _select() -> void:
	push_error("Function not implemented")


func process_input() -> void:
	if Input.is_action_just_pressed("expression_up"):
		_menu.move_up()
	if Input.is_action_just_pressed("expression_down"):
		_menu.move_down()
	if Input.is_action_just_pressed("expression_select"):
		_select()
