class_name AlgebraicBase
extends Node


@export var object: AlgebraicObject


static func create(p_object: AlgebraicObject) -> AlgebraicBase:
	var new := AlgebraicBase.new()
	new.add_child(p_object)
	new.object = p_object
	return new


func copy() -> AlgebraicBase:
	return AlgebraicBase.create(object.copy())


func subexpression(index: Array[int]) -> AlgebraicObject:
	return ExpressionIndexer.algebraic_subexpression(object, index)


func replace_subexpression(
		new: AlgebraicObject, index: Array[int]) -> void:
	if index.is_empty():
		replace_object(new)
	else:
		ExpressionIndexer.replace_algebraic_subexpression(object, new, index)


func replace_object(new: AlgebraicObject) -> void:
	remove_child(object)
	object.queue_free()
	add_child(new)
	object = new


func pretty_string() -> String:
	return object.pretty_string()


func to_graphical() -> GraphicalExpression:
	return object.to_graphical()
