class_name IdentityRule
extends AlgebraicRule


var _before: AlgebraicObject
var _after: AlgebraicObject


static func create(
		before: AlgebraicObject, after: AlgebraicObject) -> IdentityRule:
	var new := IdentityRule.new()
	new._before = before
	new._after = after
	return new


static func from_equality(equality: AlgebraicEquality) -> Array[IdentityRule]:
	return [
		IdentityRule.create(equality.left_expression, equality.right_expression),
		IdentityRule.create(equality.right_expression, equality.left_expression),
	]


static func parse(before: String, after: String) -> IdentityRule:
	return IdentityRule.create(AlgebraicParser.parse_expression(before),
			AlgebraicParser.parse_expression(after))


func apply(object: AlgebraicObject) -> ApplicationResult:
	var match_result := _before.pattern_match(object)
	if match_result is PatternMatchFailure:
		return ApplicationFailure.new()
	var instance := _after.substitute(match_result.assignments)
	return ApplicationSuccess.create(instance)
