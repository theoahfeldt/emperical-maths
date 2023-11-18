extends AlgebraicRule
## a -> a


func applicable(expression: AlgebraicExpression) -> bool:
	return true


func apply(expression: AlgebraicExpression) -> AlgebraicExpression:
	return expression.copy()
