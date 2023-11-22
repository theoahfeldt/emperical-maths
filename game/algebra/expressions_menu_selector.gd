class_name ExpressionsMenuSelector
extends Node


signal selected(algebraic, graphical, mark)


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
		_select_expression()


func _update_marked() -> void:
	_menu.update_marked(_marked_index)


func _select_expression() -> void:
	var selected_algebraic: AlgebraicExpression = _menu.algebraic_expressions[
			_marked_index]
	_menu.remove_child(selected_algebraic)
	var selected_graphical: GraphicalExpression = _menu.selection_menu.options[
			_marked_index]
	_menu.selection_menu.remove_child(selected_graphical)
	selected_algebraic.mark()
	selected_graphical.set_color_from_algebraic(selected_algebraic)
	selected.emit(selected_algebraic, selected_graphical, _mark)


func _move_up() -> void:
	_marked_index = max(0, _marked_index - 1)
	_update_marked()


func _move_down() -> void:
	_marked_index = min(_marked_index + 1, _menu.num_options() - 1)
	_update_marked()
