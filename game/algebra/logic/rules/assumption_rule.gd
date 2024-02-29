class_name AssumptionRule
extends AlgebraicRule


var _before: AlgebraicExpression
var _after: AlgebraicExpression


static func create(before: AlgebraicExpression, after: AlgebraicExpression
		) -> AssumptionRule:
	var new := AssumptionRule.new()
	new._before = before
	new._after = after
	return new


static func from_equality(equality: AlgebraicEquality) -> Array[AssumptionRule]:
	return [
		AssumptionRule.create(equality.left_expression, equality.right_expression),
		AssumptionRule.create(equality.right_expression, equality.left_expression),
	]


static func parse(before: String, after: String) -> AssumptionRule:
	return AssumptionRule.create(AlgebraicParser.parse_expression(before),
			AlgebraicParser.parse_expression(after))


func apply(object: AlgebraicObject) -> ApplicationResult:
	if object.identical_to(_before):
		return ApplicationSuccess.create(_after)
	return ApplicationFailure.new()
