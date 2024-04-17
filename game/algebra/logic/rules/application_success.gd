class_name ApplicationSuccess
extends ApplicationResult


var result: ManipulableExpression


static func create(expression: ManipulableExpression) -> ApplicationSuccess:
	var new := ApplicationSuccess.new()
	new.result = expression
	return new
