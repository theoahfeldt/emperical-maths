class_name SumIdentityRightBackward
extends AlgebraicRule
## a -> a + 0


func applicable(_expression: AlgebraicExpression) -> bool:
	return true


func apply(expression: AlgebraicExpression) -> AlgebraicSum:
	return AlgebraicSum.create(expression.copy(), AlgebraicInteger.zero())
