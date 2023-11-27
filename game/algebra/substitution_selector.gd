class_name SubstitutionSelector
extends Node


signal substituted(new_expression, mark)

var _algebraic_base: AlgebraicBase
var _graphical_base: GraphicalBase
var _substitution: Substitution
var _mark: Array[int]


func initialize(
		base: AlgebraicBase, substitution: Substitution, mark: Array[int]
		) -> void:
	_substitution = substitution
	_mark = mark
	add_child(base)
	_algebraic_base = base
	$ExpressionSelector.base = base
	var graphical_expression := GraphicalConversion.algebraic_to_graphical(
			base.expression)
	_graphical_base = GraphicalBase.create(graphical_expression)
	add_child(_graphical_base)
	_graphical_base.center_in_viewport()
	_graphical_base.position.y += 100


func deinitialize() -> void:
	remove_child(_algebraic_base)
	remove_child(_graphical_base)
	_algebraic_base.queue_free()
	_graphical_base.queue_free()


func process_input() -> void:
	$ExpressionSelector.process_input()


func _update_mark(marked: AlgebraicExpression, mark: Array[int]) -> void:
	_graphical_base.clear_color()
	var graphical: GraphicalExpression = ExpressionIndexer.graphical_subexpression(
			_graphical_base, mark)
	graphical.set_color_from_algebraic(marked)


func _on_expression_selector_mark_updated(marked_expression, mark) -> void:
	_update_mark(marked_expression, mark)


func _on_expression_selector_selected(selected_expression, __mark) -> void:
	var new_expression := _substitution.substitute(selected_expression)
	substituted.emit(new_expression, _mark)
