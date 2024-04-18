class_name MenuSelector
extends Node


signal selected(option, graphical: GraphicalExpression)

var _menu: SelectionMenu


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("expression_up"):
		_menu.move_up()
	if Input.is_action_just_pressed("expression_down"):
		_menu.move_down()
	if Input.is_action_just_pressed("expression_select"):
		_select()


static func create(menu: SelectionMenu) -> MenuSelector:
	var new := MenuSelector.new()
	new._menu = menu
	return new


func _select() -> void:
	var option = _menu.adopt_marked_option()
	var graphical: GraphicalExpression = _menu.adopt_marked_graphical_option()
	print("Selected menu option %s" % [option])
	selected.emit(option, graphical)
