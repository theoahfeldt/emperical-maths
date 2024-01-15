class_name ApplicationSuccess
extends ApplicationResult


var result: AlgebraicObject


static func create(object: AlgebraicObject) -> ApplicationSuccess:
	var new := ApplicationSuccess.new()
	new.result = object
	return new
