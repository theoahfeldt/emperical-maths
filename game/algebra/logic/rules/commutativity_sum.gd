extends AlgebraicRule
## a + b -> b + a


func applicable(expression: AlgebraicExpression) -> bool:
	return expression is AlgebraicSum


func apply(sum: AlgebraicSum) -> AlgebraicExpression:
	return AlgebraicSum.create(sum.right_term, sum.left_term)
