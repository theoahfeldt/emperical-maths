class_name PatternMatchSuccess
extends PatternMatchResult


var bindings: Dictionary


static func create(p_bindings: Dictionary) -> PatternMatchSuccess:
	var new := PatternMatchSuccess.new()
	new.bindings = p_bindings
	return new
