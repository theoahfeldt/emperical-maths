extends AlgebraicRule


func applicable(expression: AlgebraicExpression) -> bool:
	return expression is Sum


func apply(expression: AlgebraicExpression) -> void:
	var a = expression.a
	expression.a = expression.b
	expression.b = a
