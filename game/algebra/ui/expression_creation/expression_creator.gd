class_name ExpressionCreator
extends GraphicalComponent


signal created_expression(
		algebraic: AlgebraicExpression, graphical: GraphicalExpression)

var _manipulable_base: ManipulableBase
var _graphical_base: GraphicalBase
var _index_stack = []

# The following will be null when not in use:
var _expression_selector: ExpressionSelector
var _menu: SelectionMenu
var _menu_selector: MenuSelector
var _current_index: Array[int] = []


func _ready() -> void:
	_start_expression_selector()


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("expression_confirm"):
		_create_expression()


func get_size() -> Vector2i:
	return _graphical_base.get_size()


static func create(center_position: Vector2) -> ExpressionCreator:
	var new := ExpressionCreator.new()
	new._manipulable_base = ManipulableBase.create(AlgebraicVariable.create("_"))
	var graphical_expression := new._manipulable_base.to_graphical()
	new._graphical_base = GraphicalBase.create(
			graphical_expression, center_position)
	new.add_child(new._graphical_base)
	new._graphical_base.center()
	return new


func _start_expression_selector() -> void:
	_expression_selector = ExpressionSelector.create(
			_manipulable_base, _graphical_base, _current_index)
	add_child(_expression_selector)
	_expression_selector.update_marked()
	_expression_selector.selected.connect(_on_expression_selector_selected)


func _create_expression() -> void:
#	TODO: Check that expression does not contain _
	var algebraic := _manipulable_base.expression
	var graphical := _graphical_base.expression
	_graphical_base.remove_child(graphical)
	_graphical_base.queue_free()
	created_expression.emit(algebraic, graphical)


func _variable_menu() -> SelectionMenu:
	var expressions: Array[AlgebraicExpression] = [
		AlgebraicVariable.create("a"),
		AlgebraicVariable.create("b"),
		AlgebraicVariable.create("c"),
		AlgebraicVariable.create("d"),
	]
	return SelectionMenu.create_from_expressions(expressions)


func _integer_menu() -> SelectionMenu:
	var expressions: Array[AlgebraicExpression] = [
		AlgebraicInteger.create(0),
		AlgebraicInteger.create(1),
		AlgebraicInteger.create(2),
		AlgebraicInteger.create(3),
	]
	return SelectionMenu.create_from_expressions(expressions)


func _start_creation_menu(menu: SelectionMenu, index: Array[int]) -> void:
	_start_menu(menu, _on_creation_menu_selected, index)


func _start_alternative_expressions_menu(
		menu: SelectionMenu, index: Array[int]) -> void:
	_start_menu(menu, _on_alternative_expressions_menu_selected, index)


func _start_menu(
		menu: SelectionMenu, on_selected: Callable, index: Array[int]) -> void:
	_menu = menu
	_menu_selector = MenuSelector.create(_menu)
	add_child(_menu_selector)
	_menu_selector.selected.connect(on_selected)
	ExpressionIndexer.replace_graphical_subexpression(
			_graphical_base, _menu, index)


func _replace_subexpression(
		algebraic: AlgebraicExpression, graphical: GraphicalExpression) -> void:
	_manipulable_base.replace_subexpression(algebraic, _current_index)
	ExpressionIndexer.replace_graphical_subexpression(
			_graphical_base, graphical, _current_index)
	_start_expression_selector()


func _on_expression_selector_selected(
		selected_expression: AlgebraicExpression, index: Array[int]
		) -> void:
	_current_index = index
	remove_child(_expression_selector)
	_expression_selector.queue_free()
	var menu: SelectionMenu = CreationMenu.create(selected_expression)
	_start_creation_menu(menu, index)


func _on_creation_menu_selected(
		option, graphical: GraphicalExpression) -> void:
	remove_child(_menu_selector)
	_menu_selector.queue_free()
	if option is AlgebraicExpression:
		_replace_subexpression(option, graphical)
		return
	match option:
		CreationMenu.Option.VARIABLE:
			graphical.queue_free()
			_start_alternative_expressions_menu(
					_variable_menu(), _current_index)
		CreationMenu.Option.INTEGER:
			graphical.queue_free()
			_start_alternative_expressions_menu(
					_integer_menu(), _current_index)
		CreationMenu.Option.NEGATION:
			var algebraic := AlgebraicNegation.create(AlgebraicVariable.create("_"))
			graphical.set_color_from_expression(algebraic)
			_replace_subexpression(algebraic, graphical)
			_expression_selector.mark_inner()
		CreationMenu.Option.SUM:
			var algebraic := AlgebraicSum.create(
					AlgebraicVariable.create("_"), AlgebraicVariable.create("_"))
			graphical.set_color_from_expression(algebraic)
			_replace_subexpression(algebraic, graphical)
			_expression_selector.mark_inner()
			_index_stack.append(_expression_selector.get_mark_right())


func _on_alternative_expressions_menu_selected(
		option, graphical: GraphicalExpression) -> void:
	remove_child(_menu_selector)
	_menu_selector.queue_free()
	_replace_subexpression(option, graphical)
	if _index_stack:
		_expression_selector.set_mark(_index_stack.pop_back())
