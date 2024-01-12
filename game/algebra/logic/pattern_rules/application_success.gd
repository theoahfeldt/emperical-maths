class_name ApplicationSuccess
extends ApplicationResult


var result: AlgebraicExpression


static func create(expression: AlgebraicExpression) -> ApplicationSuccess:
	var new := ApplicationSuccess.new()
	new.result = expression
	return new
