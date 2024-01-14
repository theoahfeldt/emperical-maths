class_name Consequence
extends Assertion


@export var premises: Array[Assertion]


func get_rules() -> Array[AlgebraicRule]:
	var rules: Array[AlgebraicRule] = []
	for premise in premises:
		rules += premise.get_rules()
	return rules
