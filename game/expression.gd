extends Node2D


const GraphicalConversion := preload("res://algebra/graphics/graphical_conversion.gd")

@export var algebraic_expression: AlgebraicExpression

var graphical_expression: GraphicalExpression


func _ready() -> void:
	$ExpressionController.selected_expression = algebraic_expression
	_set_graphics()


func _set_graphics() -> void:
	graphical_expression = GraphicalConversion.algebraic_to_graphical(
			algebraic_expression)
	add_child(graphical_expression)


func _update_graphics() -> void:
	graphical_expression.queue_free()
	_set_graphics()


func _on_expression_controller_expression_updated() -> void:
	_update_graphics()
