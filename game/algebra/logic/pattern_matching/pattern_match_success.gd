class_name PatternMatchSuccess
extends PatternMatchResult


# Maps variable name (String) to AlgebraicExpression
var assignments: Dictionary


static func create(p_assignments: Dictionary) -> PatternMatchSuccess:
	var new := PatternMatchSuccess.new()
	new.assignments = p_assignments
	return new
