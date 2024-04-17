class_name ManipulableBase


var expression: ManipulableExpression


static func create(p_expression: ManipulableExpression) -> ManipulableBase:
	var new := ManipulableBase.new()
	new.expression = p_expression
	return new


func copy() -> ManipulableBase:
	return ManipulableBase.create(expression.copy())


func subexpression(index: Array[int]) -> ManipulableExpression:
	return ExpressionIndexer.algebraic_subexpression(expression, index)


func replace_subexpression(
		new: ManipulableExpression, index: Array[int]) -> void:
	if index.is_empty():
		expression = new
	else:
		ExpressionIndexer.replace_algebraic_subexpression(expression, new, index)


func to_graphical() -> GraphicalExpression:
	return expression.to_graphical()
