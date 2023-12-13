class_name Identity
extends ConcreteRule
## a -> a


func applicable(_expression: AlgebraicExpression) -> bool:
	return true


func apply(expression: AlgebraicExpression) -> AlgebraicExpression:
	return expression.copy()
