class_name ExpressionCreator
extends GraphicalComponent


enum Action {SELECT_EXPRESSION, CREATE_EXPRESSION, SELECT_ALTERNATIVE}

var _algebraic_base: AlgebraicBase
var _graphical_base: GraphicalBase
var _mark: Array[int]
var _current_action := Action.SELECT_EXPRESSION


func _ready() -> void:
	initialize(get_viewport_rect().size / 2.0)


func _process(_delta: float) -> void:
	process_input()


func get_size() -> Vector2i:
	return _graphical_base.get_size()


func initialize(center_position: Vector2) -> void:
	_mark = []
	_algebraic_base = AlgebraicBase.create(AlgebraicVariable.create("_"))
	add_child(_algebraic_base)
	var graphical_expression := GraphicalConversion.algebraic_to_graphical(
			_algebraic_base.expression)
	_graphical_base = GraphicalBase.create(
			graphical_expression, center_position)
	add_child(_graphical_base)
	_graphical_base.center()
	$ExpressionSelector.initialize(_algebraic_base, _graphical_base)
	$ExpressionSelector.update_marked()


func process_input() -> void:
	match _current_action:
		Action.SELECT_EXPRESSION:
			$ExpressionSelector.process_input()
		Action.CREATE_EXPRESSION:
			$CreationMenuSelector.process_input()
		Action.SELECT_ALTERNATIVE:
			$AlternativesMenuSelector.process_input()


func _new_variable_menu(mark: Array[int]) -> SelectionMenu:
	var expressions: Array[AlgebraicExpression] = [
		AlgebraicVariable.create("a"),
		AlgebraicVariable.create("b"),
		AlgebraicVariable.create("c"),
		AlgebraicVariable.create("d"),
	]
	return $AlternativesMenuSelector.initialize_from_expressions(mark, expressions)


func _new_integer_menu(mark: Array[int]) -> SelectionMenu:
	var expressions: Array[AlgebraicExpression] = [
		AlgebraicInteger.create(0),
		AlgebraicInteger.create(1),
		AlgebraicInteger.create(2),
		AlgebraicInteger.create(3),
	]
	return $AlternativesMenuSelector.initialize_from_expressions(mark, expressions)


func _enter_menu(menu: SelectionMenu, mark: Array[int]) -> void:
	ExpressionIndexer.replace_graphical_subexpression(
			_graphical_base, menu, mark)
	_current_action = Action.SELECT_ALTERNATIVE


func _replace_subexpression(
		algebraic: AlgebraicExpression,
		graphical: GraphicalExpression,
		mark: Array[int],
		) -> void:
	ExpressionIndexer.replace_algebraic_subexpression(
			_algebraic_base, algebraic, mark)
	ExpressionIndexer.replace_graphical_subexpression(
			_graphical_base, graphical, mark)
	_current_action = Action.SELECT_EXPRESSION


func _on_expression_selector_selected(selected_expression, mark) -> void:
	var menu: SelectionMenu = $CreationMenuSelector.initialize(
			selected_expression, mark)
	ExpressionIndexer.replace_graphical_subexpression(
			_graphical_base, menu, mark)
	_current_action = Action.CREATE_EXPRESSION


func _on_creation_menu_selector_selected_original(algebraic, graphical, mark) -> void:
	_replace_subexpression(algebraic, graphical, mark)


func _on_creation_menu_selector_selected_new(option, mark) -> void:
	match option:
		CreationMenuSelector.Option.VARIABLE:
			_enter_menu(_new_variable_menu(mark), mark)
		CreationMenuSelector.Option.INTEGER:
			_enter_menu(_new_integer_menu(mark), mark)
		CreationMenuSelector.Option.NEGATION:
			var algebraic := AlgebraicNegation.create(AlgebraicVariable.create("_"))
			var graphical := GraphicalConversion.algebraic_to_graphical(algebraic)
			graphical.set_color_from_algebraic(algebraic)
			_replace_subexpression(algebraic, graphical, mark)
			$ExpressionSelector.mark_inner()
		CreationMenuSelector.Option.SUM:
			var algebraic := AlgebraicSum.create(
					AlgebraicVariable.create("_"), AlgebraicVariable.create("_"))
			var graphical := GraphicalConversion.algebraic_to_graphical(algebraic)
			graphical.set_color_from_algebraic(algebraic)
			_replace_subexpression(algebraic, graphical, mark)
			$ExpressionSelector.mark_inner()
			$ExpressionSelector.push_mark_right()


func _on_alternatives_menu_selector_selected_expression(algebraic, graphical, mark) -> void:
	_replace_subexpression(algebraic, graphical, mark)
	$ExpressionSelector.pop_mark()
