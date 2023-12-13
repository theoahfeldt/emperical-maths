class_name AbstractZeroSumLeft
extends AbstractExpression


func substitute(expression: AlgebraicExpression) -> AlgebraicSum:
	return AlgebraicSum.create(
			AlgebraicNegation.create(expression), expression.copy())


func graphical_expression() -> GraphicalSum:
	return GraphicalSum.create(
			GraphicalNegation.create(GraphicalVariable.create("?")),
			GraphicalVariable.create("?"))
