extends AlgebraicRule
## (a + b) + c -> a + (b + c)

func applicable(expression: AlgebraicExpression) -> bool:
	if expression is AlgebraicSum:
		return expression.left_term is AlgebraicSum
	return false


func apply(sum: AlgebraicSum) -> AlgebraicExpression:
	var a = sum.left_term.left_term.copy()
	var b = sum.left_term.right_term.copy()
	var c = sum.right_term.copy()
	return AlgebraicSum.create(a, AlgebraicSum.create(b, c))
