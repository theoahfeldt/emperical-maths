class_name Axiom
extends Assertion


func get_rules() -> Array[AlgebraicRule]:
	var expressions := equality.split("=")
	return [
		AlgebraicRule.parse(expressions[0], expressions[1]),
		AlgebraicRule.parse(expressions[1], expressions[0]),
	]
