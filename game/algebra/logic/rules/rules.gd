const Identity = preload("res://algebra/logic/rules/identity.gd")
const AssociativityForwardSum = preload("res://algebra/logic/rules/associaticity_forward_sum.gd")
const AssociativityBackwardSum = preload("res://algebra/logic/rules/associaticity_backward_sum.gd")
const CommutativitySum = preload("res://algebra/logic/rules/commutativity_sum.gd")


static func rules() -> Array:
	return [
		Identity.new(),
		AssociativityForwardSum.new(),
		AssociativityBackwardSum.new(),
		CommutativitySum.new(),
	]
