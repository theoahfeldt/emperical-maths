const Identity = preload("res://algebra/logic/rules/identity.gd")
const SumAssociativityForward = preload("res://algebra/logic/rules/sum_associaticity_forward.gd")
const SumAssociativityBackward = preload("res://algebra/logic/rules/sum_associaticity_backward.gd")
const SumCommutativity = preload("res://algebra/logic/rules/sum_commutativity.gd")


static func rules() -> Array:
	return [
		Identity.new(),
		SumAssociativityForward.new(),
		SumAssociativityBackward.new(),
		SumCommutativity.new(),
	]
