class_name ExpressionMenuSelector
extends Node


signal selected_expression(algebraic, graphical, mark)
signal selected_substitution(substitution, graphical, mark)


var _menu: ExpressionMenu
var _mark: Array[int]
var _marked_index := 0


func initialize(menu: ExpressionMenu, mark: Array[int]) -> void:
	_menu = menu
	_mark = mark
	_marked_index = 0
	_update_marked()


func process_input() -> void:
	if Input.is_action_just_pressed("expression_up"):
		_move_up()
	if Input.is_action_just_pressed("expression_down"):
		_move_down()
	if Input.is_action_just_pressed("expression_select"):
		_select_option()


func _update_marked() -> void:
	_menu.update_marked(_marked_index)


func _select_option() -> void:
	var selected = _menu.get_option(_marked_index)
	if selected is AlgebraicExpression:
		_select_expression(selected)
	else:
		_select_substitution(selected)


func _select_expression(selected: AlgebraicExpression) -> void:
	_menu.remove_child(selected)
	var graphical: GraphicalExpression = _menu.selection_menu.options[_marked_index]
	_menu.selection_menu.remove_child(graphical)
	selected.mark()
	graphical.set_color_from_algebraic(selected)
	selected_expression.emit(selected, graphical, _mark)


func _select_substitution(selected: Substitution) -> void:
	var graphical: GraphicalExpression = _menu.selection_menu.options[_marked_index]
	_menu.selection_menu.remove_child(graphical)
	selected_substitution.emit(selected, graphical, _mark)


func _move_up() -> void:
	_marked_index = max(0, _marked_index - 1)
	_update_marked()


func _move_down() -> void:
	_marked_index = min(_marked_index + 1, _menu.num_options() - 1)
	_update_marked()
