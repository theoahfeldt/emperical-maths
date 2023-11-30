class_name SubstitutionSelector
extends Node


signal substituted(new_expression, mark)

var _substitution: Substitution
var _mark: Array[int]


func initialize(
		substitution: Substitution, center_position: Vector2, mark: Array[int]
		) -> void:
	_substitution = substitution
	_mark = mark
	$ExpressionCreator.initialize(center_position)


func process_input() -> void:
	$ExpressionCreator.process_input()


func _on_expression_creator_created_expression(algebraic, graphical) -> void:
	graphical.queue_free()
	var new_expression := _substitution.substitute(algebraic)
	substituted.emit(new_expression, _mark)
