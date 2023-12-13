extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var level: Level = load("res://levels/level1.gd").create()
	var expression_controller := ExpressionController.create(
			level.equality, level.algebraic_rules, level.substitution_rules)
	add_child(expression_controller)
