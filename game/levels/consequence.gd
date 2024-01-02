class_name Consequence
extends Assertion


@export var premises: Array[Assertion]

var rule_ordering: Resource = preload("res://algebra/logic/rules/rule_ordering.tres")


func get_rules() -> Array[AlgebraicRule]:
	var rules: Array[AlgebraicRule] = []
	for premise in premises:
		rules += premise.get_rules()
	rule_ordering.initialize()
	return rule_ordering.sorted_unique(rules)
