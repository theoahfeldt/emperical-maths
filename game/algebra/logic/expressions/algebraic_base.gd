class_name AlgebraicBase


var object: AlgebraicObject


static func create(p_object: AlgebraicObject) -> AlgebraicBase:
	var new := AlgebraicBase.new()
	new.object = p_object
	return new


func copy() -> AlgebraicBase:
	return AlgebraicBase.create(object.copy())


func subexpression(index: Array[int]) -> AlgebraicObject:
	return ExpressionIndexer.algebraic_subexpression(object, index)


func replace_subexpression(
		new: AlgebraicObject, index: Array[int]) -> void:
	if index.is_empty():
		object = new
	else:
		ExpressionIndexer.replace_algebraic_subexpression(object, new, index)


func to_graphical() -> GraphicalExpression:
	return object.to_graphical()
