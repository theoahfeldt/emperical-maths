class_name GraphicalBase
extends Node2D


var expression: GraphicalExpressionOrMenu


func initialize(p_expression: GraphicalExpressionOrMenu) -> void:
	add_child(p_expression)
	expression = p_expression
	_center()


func replace_expression(new: GraphicalExpressionOrMenu) -> void:
	remove_child(expression)
	expression.queue_free()
	add_child(new)
	expression = new
	_center()


func reset() -> void:
	expression.initialize()


func _center() -> void:
	position = (get_viewport_rect().size - Vector2(expression.get_size())) / 2.0