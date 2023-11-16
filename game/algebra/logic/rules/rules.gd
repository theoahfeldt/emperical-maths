const CommutativitySum = preload("res://algebra/logic/rules/commutativity_sum.gd")
const AssociativityForwardSum = preload("res://algebra/logic/rules/associaticity_forward_sum.gd")


static func rules() -> Array:
	return [
		CommutativitySum.new(),
		AssociativityForwardSum.new(),
	]
