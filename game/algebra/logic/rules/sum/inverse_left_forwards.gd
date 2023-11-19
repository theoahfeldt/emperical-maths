extends AlgebraicRule
## -a + a -> 0


func applicable(expression: AlgebraicExpression) -> bool:
	if expression is AlgebraicSum:
		if expression.left_term is AlgebraicNegation:
			return expression.left_term.expression.identical_to(expression.right_term)
	return false


func apply(_expression: AlgebraicExpression) -> AlgebraicExpression:
	return AlgebraicInteger.zero()
