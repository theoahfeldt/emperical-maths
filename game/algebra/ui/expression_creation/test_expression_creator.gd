extends Node2D


func _ready() -> void:
	var center: Vector2 = get_viewport_rect().size / 2.0
	var expression_creator := ExpressionCreator.create(center)
	add_child(expression_creator)
