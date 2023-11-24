class_name SubstitutionSumLeft
extends Substitution


func substitute(expression: AlgebraicExpression) -> AlgebraicExpression:
	return AlgebraicSum.create(
			AlgebraicNegation.create(expression.copy()), expression.copy())


func graphical_expression() -> GraphicalExpression:
	return GraphicalSum.create(
			GraphicalNegation.create(GraphicalVariable.create("?")),
			GraphicalVariable.create("?"))
