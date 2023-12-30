class_name Axiom
extends Assertion


@export var rules: Array[Script]


func get_rules() -> Array[AlgebraicRule]:
	var p_rules: Array[AlgebraicRule] = []
	for rule in rules:
		p_rules.append(rule.new())
	return p_rules
