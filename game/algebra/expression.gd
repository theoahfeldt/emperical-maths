extends Node2D


const ExpressionIndexer := preload("res://algebra/expression_indexer.gd")
const GraphicalConversion := preload("res://algebra/graphics/graphical_conversion.gd")

@export var algebraic_expression: AlgebraicExpression

var graphical_expression: GraphicalExpression


func _ready() -> void:
	$ExpressionController.base_expression = algebraic_expression
	_set_graphics()
	_update_selected([])


func _set_graphics() -> void:
	graphical_expression = GraphicalConversion.algebraic_to_graphical(
			algebraic_expression)
	graphical_expression.initialize()
	add_child(graphical_expression)


func _update_selected(selected_expression_index: Array) -> void:
	graphical_expression.initialize()
	var selected_expression: GraphicalExpression = ExpressionIndexer.graphical_subexpression(
			graphical_expression, selected_expression_index)
	selected_expression.select()


func _update_graphics() -> void:
	graphical_expression.queue_free()
	_set_graphics()


func _on_expression_controller_expression_updated(selected_expression_index) -> void:
	_update_graphics()
	_update_selected(selected_expression_index)


func _on_expression_controller_selection_updated(selected_expression_index) -> void:
	_update_selected(selected_expression_index)
