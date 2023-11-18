const Identity = preload("res://algebra/logic/rules/identity.gd")
const SumAssociativityForward = preload("res://algebra/logic/rules/sum_associaticity_forward.gd")
const SumAssociativityBackward = preload("res://algebra/logic/rules/sum_associaticity_backward.gd")
const SumCommutativity = preload("res://algebra/logic/rules/sum_commutativity.gd")
const SumIdentityLeftForward = preload("res://algebra/logic/rules/sum_identity_left_forward.gd")
const SumIdentityLeftBackward = preload("res://algebra/logic/rules/sum_identity_left_backward.gd")
const SumIdentityRightForward = preload("res://algebra/logic/rules/sum_identity_right_forward.gd")
const SumIdentityRightBackward = preload("res://algebra/logic/rules/sum_identity_right_backward.gd")


static func rules() -> Array:
	return [
		Identity.new(),
		SumAssociativityForward.new(),
		SumAssociativityBackward.new(),
		SumCommutativity.new(),
		SumIdentityLeftForward.new(),
		SumIdentityRightForward.new(),
		SumIdentityLeftBackward.new(),
		SumIdentityRightBackward.new(),
	]
