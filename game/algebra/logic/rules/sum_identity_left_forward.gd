extends AlgebraicRule
## 0 + a -> a


func applicable(expression: AlgebraicExpression) -> bool:
	if expression is AlgebraicSum:
		if expression.left_term is AlgebraicInteger:
			return expression.left_term.is_zero()
	return false


func apply(sum: AlgebraicSum) -> AlgebraicExpression:
	return sum.right_term.copy()
