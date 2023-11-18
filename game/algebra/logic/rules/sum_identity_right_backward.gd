extends AlgebraicRule
## a -> a + 0


func applicable(expression: AlgebraicExpression) -> bool:
	return true


func apply(expression: AlgebraicExpression) -> AlgebraicExpression:
	return AlgebraicSum.create(expression.copy(), AlgebraicInteger.zero())
