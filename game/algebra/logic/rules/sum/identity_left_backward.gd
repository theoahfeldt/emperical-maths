extends AlgebraicRule
## a -> 0 + a


func applicable(expression: AlgebraicExpression) -> bool:
	return true


func apply(expression: AlgebraicExpression) -> AlgebraicExpression:
	return AlgebraicSum.create(AlgebraicInteger.zero(), expression.copy())
