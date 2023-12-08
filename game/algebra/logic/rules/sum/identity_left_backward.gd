extends AlgebraicRule
## a -> 0 + a


func applicable(_expression: AlgebraicExpression) -> bool:
	return true


func apply(expression: AlgebraicExpression) -> AlgebraicSum:
	return AlgebraicSum.create(AlgebraicInteger.zero(), expression.copy())
